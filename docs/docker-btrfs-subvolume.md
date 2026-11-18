# Docker on its own btrfs subvolume

Omarchy installs with the standard archinstall btrfs layout (`@`, `@home`,
`@log`, `@pkg`). With that layout `/var/lib/docker` lives inside `@`, which
causes two problems:

- **Snapper snapshots of root include every Docker image, container and
  volume.** Old layers stay pinned on disk until the snapshot is deleted.
- **Cleaning up is extremely slow.** `docker system prune` or removing
  `/var/lib/docker` means deleting millions of small files one by one, which
  btrfs does slowly. It also inflates metadata chunks; in my case 93 GiB were
  allocated for metadata with only ~45 GiB in use.

## The fix

Make `/var/lib/docker` a nested subvolume. Snapper does not descend into nested
subvolumes, so Docker drops out of root snapshots. A full wipe also becomes a
single `btrfs subvolume delete`.

The storage driver stays the default (overlay2 / containerd overlayfs
snapshotter). Docker's `btrfs` storage driver is **not** used on purpose:

- Docker treats it as second-tier and recommends overlay2.
- It creates one subvolume per layer, and thousands of them bloat metadata
  and can cause ENOSPC.
- Deleting subvolumes still happens in the background, so it isn't actually faster.
- Containers don't share the page cache the way they do with overlay2.

## Setup (one-time, destroys all existing Docker data)

```bash
sudo systemctl stop docker.socket docker.service containerd
sudo rm -rf /var/lib/docker          # or: sudo mv /var/lib/docker /var/lib/docker.old
sudo btrfs subvolume create /var/lib/docker
sudo chattr +C /var/lib/docker       # optional: no CoW, better for DBs in volumes
sudo systemctl start docker
```

If the containerd image store is enabled, `/var/lib/containerd` can grow large
too. Give it the same treatment.

Verify:

```bash
sudo btrfs subvolume show /var/lib/docker
docker info | grep -i 'storage driver'
```

## Nuking everything quickly

```bash
sudo systemctl stop docker.socket docker.service containerd
sudo btrfs subvolume delete /var/lib/docker
sudo btrfs subvolume create /var/lib/docker
sudo chattr +C /var/lib/docker       # if you used it originally
sudo systemctl start docker
```

The space is freed in the background. To wait for it, run `sudo btrfs subvolume sync /`.

## Reclaiming half-empty chunks

After big deletions, give the space in partly empty chunks back to the
unallocated pool:

```bash
sudo btrfs filesystem usage -T /
sudo btrfs balance start -dusage=50 -musage=50 /
```
