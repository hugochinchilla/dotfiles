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

> **Note** — On these machines omarchy sets the prefix to `C-Space`, keeping `C-b` as a
> second prefix. Both work everywhere below; `C-b` is written where it's the stock binding
> and `C-Space` where the key comes from omarchy's config.

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

Re-joining a *named* session is the common case, and `tmux ls` is how you find the name:

```
work: 3 windows (created Mon Aug  3 09:12:41 2026)
scratch: 1 windows (created Mon Aug  3 11:02:07 2026) (attached)
```

| You want | Command |
| --- | --- |
| Attach to `work` | `tmux a -t work` |
| Attach, or create it if it's gone | `tmux new -A -s work` |
| Attach and kick off any other client | `tmux a -d -t work` |
| Attach read-only (watch, don't type) | `tmux a -r -t work` |
| Hop to another session from inside tmux | `C-b (` / `C-b )`, or `C-b s` for the picker |
| Rename the session you're in | `C-b $` |

Prefix matching works, so `tmux a -t wo` finds `work` as long as it's unambiguous.

> **Note** — Attaching without `-d` leaves the old client connected too, and both clients get
> squeezed to the size of the smallest screen. If a session comes back cramped, some forgotten
> ssh window is still attached — `tmux a -d -t work` evicts it.

> **Warning** — Sessions live in the tmux server on *that* machine, so `tmux ls` over ssh only
> lists sessions on the remote host. Detached sessions survive a dropped connection or logout,
> but not a reboot.

### Switching sessions without detaching

Detaching (`C-b` `d`, or `F6`) tears down the *client*. To go from one session to another,
**switch** the client instead — same connection, different session, nothing torn down:

| Key | Does |
| --- | --- |
| `C-Space` `s` | session picker — tree of all sessions, Enter to jump. The one to use. |
| `Alt-Up` / `Alt-Down` | previous / next session, no prefix needed |
| `C-Space` `(` / `)` | previous / next session |
| `C-Space` `P` / `N` | same, omarchy's letter aliases |
| `C-Space` `C` | create a new session and switch to it |
| `C-Space` `$` | rename the current session |

`C-Space` `w` is often better still: it picks a *window* across every session, skipping the
question of which session it lives in.

> **Warning** — This matters on archer, where `.bashrc` runs `exec tmux new -A -s main`, so
> tmux *is* the login shell. Detaching there ends the ssh connection — there's no shell left
> behind to return to. Switch, don't detach. (Drop the `exec` if you'd rather land back in a
> remote shell, at the cost of a stray login shell per connection.)

> **Note** — `detach-on-destroy` is `off`, so killing a session drops you into another one
> instead of disconnecting.

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

# theme per host (gold|redwine|moon|forest|violet|snow|coral|sky|everforest, or a hex colour)
set -g @tmux_power_theme 'moon'
if-shell -F '#{==:#{host_short},archer}'   "set -g @tmux_power_theme 'coral'"
if-shell -F '#{==:#{host_short},thinkpad}' "set -g @tmux_power_theme 'everforest'"
set -g @tmux_power_left_a ' #h'   # hostname only, no username
set -g @tmux_power_right_y ''      # no time
set -g @tmux_power_right_z ''      # no date
run-shell ~/.tmux/plugins/tmux-power/tmux-power.tmux
```

Apply it to an already-running tmux with `tmux source-file ~/.tmux.conf` — or just press `F5`
next time.

> **Warning** — tmux reads `~/.tmux.conf` *first* and `~/.config/tmux/tmux.conf` *second*, and
> omarchy seeds that second path with its own status bar. Anything you set here loses to it on
> every new server. Hence [`dotfiles/tmux/.config/tmux/tmux.conf`](../dotfiles/tmux/.config/tmux/tmux.conf),
> which sources omarchy's defaults from omarchy's own source and then re-sources `~/.tmux.conf`
> so it lands last. If the theme ever looks stock again on a fresh server, that ordering is the
> first thing to check.

> **Warning** — `bind -n` means "no prefix needed" — tmux grabs the key globally, so apps
> running inside (vim, htop, midnight commander) will no longer see F2–F8. Byobu made the
> exact same trade. If some app needs an F-key, delete that line and use the prefix binding
> from the tables above.

> **Note** — The `@tmux_power_*` block drives [tmux-power](https://github.com/wfxr/tmux-power),
> which lives in this repo as a submodule at `dotfiles/tmux/.tmux/plugins/tmux-power` and is
> checked out by `bootstrap.sh`. Drop the block and the `run-shell` line to get tmux's plain
> default status bar back.

The status bar is built from named sections — `left_a`, `left_b` on the left, `right_w`
through `right_z` on the right — and **an empty section disappears entirely**, separator
included. That's the whole hide mechanism; there are no separate show/hide toggles.

| Section | Default | Shows |
| --- | --- | --- |
| `left_a` | `#{USER}@#h` | user @ hostname |
| `left_b` | `#S` | session name |
| `right_y` | `%T` | time |
| `right_z` | `%F` | date |

So `set -g @tmux_power_left_a ' #h'` keeps the hostname and drops the username, and setting
`right_y`/`right_z` to `''` clears the right side. After changing any of them, reload with
`F5` — the plugin only rebuilds the bar when the config is sourced.

### Per-host theming

This config is shared across machines, so the theme is picked by hostname — handy for telling
at a glance which box a session is on:

| Host | Theme |
| --- | --- |
| `archer` | coral |
| `thinkpad` | everforest |
| anything else | moon |

`if-shell -F` evaluates a tmux *format* instead of forking a shell, and `#{host_short}` is
tmux's own short hostname, so this doesn't depend on a `hostname` binary being present. Set
the default first and let a matching host override it. To add a machine, copy a line and
change the two names.
