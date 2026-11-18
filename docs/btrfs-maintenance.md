# btrfs maintenance

## Why

btrfs splits the disk into chunks: data, metadata and system. After big
deletions, chunks are often left mostly empty but still allocated. When
unallocated space runs low, the allocator has to hunt for gaps inside
fragmented chunks and force flushes, so writes slow down. You can even hit
ENOSPC while `df` still shows plenty of free space.

After a Docker cleanup I had 62 GiB of metadata allocated with only 3 GiB used.

## What's set up

| Task | How | When |
|---|---|---|
| TRIM | `discard=async` mount option (queued, background) | continuous |
| TRIM fallback | `fstrim.timer` (systemd, enabled by Omarchy) | weekly |
| Balance | `btrfs-balance.timer` from `btrfsmaintenance` | weekly |
| Scrub | `btrfs-scrub.timer` from `btrfsmaintenance` | monthly |
| Defrag | disabled, because it breaks reflinks and snapshot sharing | — |

TRIM reaches the NVMe through LUKS because the kernel cmdline sets
`cryptdevice=...:root:allow-discards`. To check, run `lsblk --discard`:
`root` should show a non-zero `DISC-MAX`.

## Config

[`system/etc/default/btrfsmaintenance`](../system/etc/default/btrfsmaintenance),
copied to `/etc/default/` by `bootstrap.sh`. The package ships
`btrfsmaintenance-refresh.path`, which watches that file and rewrites the timer
schedules (`/etc/systemd/system/btrfs-*.timer.d/schedule.conf`) whenever it changes.

Balance runs one pass per value in `BTRFS_BALANCE_DUSAGE` / `MUSAGE`, starting
with chunks under 5% full. The early passes are cheap and the later ones
compact more.

## Manual commands

```bash
# Allocation overview: watch "Device unallocated" and Size vs Used per type
sudo btrfs filesystem usage -T /

# One-off balance, increasing the filter as needed
sudo btrfs balance start -musage=10 -dusage=10 /
sudo btrfs balance start -musage=50 -dusage=50 /
sudo btrfs balance status /

# Immediate TRIM of all free space
sudo fstrim -v /

# Pending async discard bytes
cat /sys/fs/btrfs/*/discard/discardable_bytes

# Timer status and logs
systemctl list-timers 'btrfs-*' fstrim.timer
journalctl -u btrfs-balance -u btrfs-scrub
```

## Rules of thumb

- Keep 10–15% of the disk free. A very full SSD slows down regardless of
  filesystem, because its SLC cache and garbage collection have little room
  to work with.
- Keep big churny stuff like Docker out of snapper snapshots. See
  [docker-btrfs-subvolume.md](docker-btrfs-subvolume.md).
