# tmux, the byobu way (without byobu)

Byobu is nothing more than tmux with a pre-baked config: the F-keys, the status bar, the
colors. This page shows how to do the same work with *stock* tmux first, then a ten-line
config that gives you back the F-keys — and only the F-keys. No byobu, no byobu colors.

## Basics: the prefix key

Every tmux command starts with the **prefix**: press `Ctrl`+`b`, release, then press one more
key. Written as `C-b c`, that means "Ctrl+b, then c". That's the whole trick — everything
below is just prefix + one key.

```bash
tmux              # start a session
tmux new -s work  # start a named one (nicer for attaching later)
```

> **Note** — Byobu's F2/F3/F4 are literally bindings to the same commands you're about to
> learn. Learn the prefix versions once and any tmux on any server works for you, config or
> not.

## Tabs (tmux calls them windows)

What byobu calls a tab, tmux calls a **window**. The bottom status bar lists them; the current
one is marked with `*`.

| You want | Stock tmux | Byobu had |
| --- | --- | --- |
| New tab | `C-b` `c` | F2 |
| Previous tab | `C-b` `p` | F3 |
| Next tab | `C-b` `n` | F4 |
| Jump to tab N | `C-b` `0`…`9` | Alt+N |
| Last active tab | `C-b` `l` | — |
| Rename tab | `C-b` `,` | F8 |
| Tab picker (interactive list) | `C-b` `w` | — |
| Close tab | exit the shell, or `C-b` `&` | F6-ish |

> **Tip** — `C-b` `w` is the one byobu never taught you: a searchable list of every tab in
> every session, with live previews. Often faster than cycling with next/prev.

## Panes & sessions

### Splits

| You want | Stock tmux |
| --- | --- |
| Split below | `C-b` `"` |
| Split right | `C-b` `%` |
| Move between panes | `C-b` arrow keys |
| Zoom pane to full screen (toggle) | `C-b` `z` |
| Close pane | exit the shell, or `C-b` `x` |

### Detach & reattach

This is the actual killer feature for remote machines: detach, close your laptop, and
everything keeps running on the server.

```bash
# inside tmux:
C-b d              # detach — session keeps running

# later, from a fresh ssh:
tmux ls            # list sessions
tmux attach        # reattach to the last one
tmux a -t work     # reattach to "work" by name
```

### Scrollback

`C-b` `[` enters copy mode — scroll with arrows/PgUp, search with `/`, leave with `q`.
(Byobu bound this to F7.)

## The F-key config

This is what lives in `~/.tmux.conf` (tracked here as
[`dotfiles/tmux/.tmux.conf`](../dotfiles/tmux/.tmux.conf)). It recreates the byobu keys you
used and keeps everything else stock.

```tmux
# ~/.tmux.conf — byobu-style F-keys, stock tmux otherwise

# tabs
bind -n F2 new-window
bind -n F3 previous-window
bind -n F4 next-window

# small helpers
bind -n F5 source-file ~/.tmux.conf \; display-message "config reloaded"
bind -n F6 detach-client
bind -n F7 copy-mode                                    # scrollback; q to leave
bind -n F8 command-prompt -I "#W" "rename-window '%%'"
bind -n S-F2 split-window -v                            # split below
bind -n C-F2 split-window -h                            # split right

# quality of life
set -g mouse on            # click tabs/panes, wheel-scroll history
set -g base-index 1        # first tab is 1, matching the keyboard row
set -g renumber-windows on # no gaps after closing a tab
set -g history-limit 50000

# theme (gold|redwine|moon|forest|violet|snow|coral|sky|everforest, or a hex colour)
set -g @tmux_power_theme 'gold'
run-shell ~/.tmux/plugins/tmux-power/tmux-power.tmux
```

Apply it to an already-running tmux with `tmux source-file ~/.tmux.conf` — or just press `F5`
next time.

> **Warning** — `bind -n` means "no prefix needed" — tmux grabs the key globally, so apps
> running inside (vim, htop, midnight commander) will no longer see F2–F8. Byobu made the
> exact same trade. If some app needs an F-key, delete that line and use the prefix binding
> from the tables above.

> **Note** — The last two lines pull in [tmux-power](https://github.com/wfxr/tmux-power) for
> the status bar — it lives in this repo as a submodule at
> `dotfiles/tmux/.tmux/plugins/tmux-power` and `bootstrap.sh` checks it out. Drop those two
> lines and you get tmux's plain default status bar back.
