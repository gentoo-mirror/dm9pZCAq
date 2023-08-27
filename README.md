<!-- vim: sw=2:
-->

# dm9pZCAq overlay

packages in overlay: `53`

<!--
```bash
list_pkgs() {
    dirname $(cd "$(git rev-parse --show-toplevel)" && git ls-files) | sort | uniq | sed '/\//!d;/^acct-/d;/\/files$/d;/^profiles\//d'
}

# copy number of packages
list_pkgs | wc -l | xclip -sel c -r

# compare actual and README
diff -du \
  <(sed -n 's/^\s\+-\s\[[^]]\+\](\([^)]\+\)).*/\1/p' < README.md | grep -v ^https | sort) \
  <(list_pkgs | sort)
```
-->

### detailed information about packages

- [app-admin/](app-admin/)

  - [aslstatus](app-admin/aslstatus) - **\[my, uniq\]** Async suckless status monitor

- [app-crypt/](app-crypt/)

  - [gpg-tui](app-crypt/gpg-tui) - **\[uniq\]** Terminal User Interface for GnuPG
  - [veracrypt](app-crypt/veracrypt) - **\[[difference](#veracrypt)\]** Disk encryption with strong security based on TrueCrypt

- [app-editors/](app-editors/)

  - [vim](app-editors/vim) - **\[symlinks to use neovim as vim\]**

- [app-eselect/](app-eselect/)

  - [eselect-repository](app-eselect/eselect-repository) - **\[you can use curl instead of wget\]** Manage repos.conf via eselect

- [app-misc/](app-misc/)

  - [draw](app-misc/draw) - **\[uniq\]** Draw in your terminal

- [app-shells/](app-shells/)

  - [gitstatus](app-shells/gitstatus) - **\[uniq\]** Git status for Bash and Zsh prompt
  - [zoxide](app-shells/zoxide) - **\[uniq\]** A smarter cd command
  - [zsh-powerlevel10k](app-shells/zsh-powerlevel10k) - **\[uniq\]** Theme for Zsh that emphasizes speed, flexibility and out-of-the-box experience
  - [zsh-vi-mode](app-shells/zsh-vi-mode) - **\[uniq\]** A better and friendly vi(vim) mode plugin for ZSH.
  - [zsh-you-should-use](app-shells/zsh-you-should-use) - **\[uniq\]** ZSH plugin that reminds you to use existing aliases for commands you just typed

- [app-text/](app-text/)

  - [epy](app-text/epy) - **\[uniq\]** CLI Ebook Reader
  - [smu](app-text/smu) - **\[uniq\]** Simple markup - markdown like syntax

- [dev-lang/](dev-lang/)

  - [ghc](dev-lang/ghc) - **\[[ghc](#ghc)\]** The Glasgow Haskell Compiler from voidlinux (for ghcbootstrap on musl libc)
  - [metalang99](dev-lang/metalang99) - **\[uniq\]** Full-blown preprocessor metaprogramming
  - [moonscript](dev-lang/moonscript) - **\[uniq\]** A programmer friendly language that compiles into Lua
  - [wren](dev-lang/wren) - **\[maintained\]** Wren is a small, fast, class-based concurrent scripting language

- [dev-libs/](dev-libs/)

  - [datatype99](dev-libs/datatype99) - **\[uniq\]** Algebraic data types for C99
  - [interface99](dev-libs/interface99) - **\[uniq\]** Zero-boilerplate interfaces for C99
  - [libexecinfo](dev-libs/libexecinfo) - **\[uniq\]** BSD licensed clone of the GNU libc backtrace facility (for musl libc)

- [dev-lua/](dev-lua/)

  - [alt-getopt](dev-lua/alt-getopt) - **\[other ebuild\]** Lua bindings to getopt_long
  - [fnlfmt](dev-lua/fnlfmt) - **\[uniq\]** A formatter for Fennel code
  - [readline](dev-lua/readline) - **\[uniq\]** Interface to the readline library

- [dev-python/](dev-python/)

  - [mobi](dev-python/mobi) - **\[uniq\]** Library for unpacking unencrypted mobi files

- [dev-vcs/](dev-vcs/)

  - [gitui](dev-vcs/gitui) - **\[uniq\]** Blazing fast terminal-ui for git

- [media-fonts/](media-fonts/)

  - [nerd-fonts](media-fonts/nerd-fonts) - **\[better ebuild\]** Collection of fonts that are patched to include a high number of glyphs (icons)

- [media-video/](media-video/)

  - [gifski](media-video/gifski) - **\[uniq\]** Highest-quality GIF encoder based on pngquant

- [net-dns/](net-dns/)

  - [alfis](net-dns/alfis) - **\[uniq\]** Alternative Free Identity System
  - [meshname](net-dns/meshname) - **\[uniq\]** A universal naming system for all IPv6-based mesh networks

- [net-libs/](net-libs/)

  - [telebot](net-libs/telebot) - **\[uniq\]** Telegram Bot API in C

- [net-misc/](net-misc/)

  - [gping](net-misc/gping) - **\[uniq\]** Ping, but with a graph

- [net-news/](net-news/)

  - [newsboat](net-news/newsboat) - **\[asciidoctor is optional\]** RSS/Atom feed reader for terminals

- [net-p2p/](net-p2p/)

  - [stig](net-p2p/stig) - **\[better ebuild\]** TUI and CLI for the BitTorrent client Transmission
  - [yggdrasil-go](net-p2p/yggdrasil-go) - **\[maintained, better ebuild, can run as non-root user\]** An experiment in scalable routing as an encrypted IPv6 overlay network

- [net-wireless/](net-wireless/)

  - [eiwd](net-wireless/eiwd) - **\[maintained, better ebuild, clang patches\]** iwd without dbus

- [sys-apps/](sys-apps/)

  - [dm9pZCAq-coreutils](sys-apps/dm9pZCAq-coreutils) - **\[my, uniq\]** GNU compatible suckless coreutils
  - [hexyl](sys-apps/hexyl) - **\[uniq\]** A command-line hex viewer
  - [huxdemp](sys-apps/huxdemp) - **\[uniq\]** A better hexdump

- [sys-devel/](sys-devel/)

  - [just](sys-devel/just) - **\[uniq\]** Just a command runner (with syntax inspired by `make`)

- [sys-fs/](sys-fs/)

  - [duf](sys-fs/duf) - **\[uniq\]** Disk Usage/Free Utility - a better 'df' alternative
  - [mdevd](sys-fs/mdevd) - **\[uniq, [udev](#udev)\]** A kernel event manager compatible with mdev.conf

- [sys-libs/](sys-libs/)

  - [libudev-zero](sys-libs/libudev-zero) - **\[uniq, [udev](#udev)\]** Daemonless replacement for libudev

- [sys-process/](sys-process/)

  - [extrace](sys-process/extrace) - **\[uniq\]** Trace exec() calls system-wide
  - [snooze](sys-process/snooze) - **\[uniq\]** Run a command at a particular time

- [virtual/](virtual/)

  - [libudev](virtual/libudev) - **\[[udev](#udev)\]** Virtual for libudev providers
  - [udev](virtual/udev) - **\[[udev](#udev)\]** Virtual to select between different udev daemon providers

- [x11-misc/](x11-misc/)

  - [clayout](x11-misc/clayout) - **\[my, uniq\]** Save own keyboard layout for each window
  - [herbe](x11-misc/herbe) - **\[uniq\]** Daemon-less notifications without D-Bus
  - [lemonbar](x11-misc/lemonbar) - **\[better ebuild\]** A featherweight, lemon-scented, bar based on xcb
  - [qt5ct](x11-misc/qt5ct) - **\[dbus is optional\]** Qt5 configuration tool, similar to qtconfig for Qt4
  - [screenkey](x11-misc/screenkey) - **\[dbus is optional\]** Screencast your keys
  - [xcolor](x11-misc/xcolor) - **\[uniq\]** Lightweight color picker for X11
  - [xinput-gui](x11-misc/xinput-gui) - **\[maintained\]** Simple GUI for `xinput`

### misc

in **\[ square brackets \]** info about difference with other overlays

[some sed script for generating dependencies](profiles/bin)

### veracrypt

`app-crypt/veracrypt` difference:

- `app-admin/sudo` needed only if `X` used
- with musl support

### ghc

`dev-lang/ghc::dm9pZCAq` package is here for `ghcbootstrap`
to build `dev-lang/ghc::haskell` on musl libc

```sh
echo 'dev-lang/ghc ghcbootstrap' >> /etc/portage/package.use/ghc
ACCEPT_KEYWORDS='**' emerge -1 dev-lang/ghc::dm9pZCAq \
  && emerge dev-lang/ghc
```

### udev

here is instruction on how to manage devices totally without systemd
(with `sys-fs/mdevd` and `sys-libs/libudev-zero`)

you need version `>= 0.1.5.0` of `sys-fs/mdevd` (for `-O` flag)
(see: [NEWS](https://github.com/skarnet/mdevd/raw/master/NEWS) and [NOTE](https://github.com/illiliti/libudev-zero/blob/8044ed8fd6568a31cece25673b0cb00a54468be0/contrib/mdev.conf#L3-L7))

______________________________________________________________________

and to use all of this you need:

- add `virtual/udev::dm9pZCAq` and `virtual/libudev::dm9pZCAq` to **package.accept_keywords**:

```
~virtual/udev-9999::dm9pZCAq    **
~virtual/libudev-9999::dm9pZCAq **
```

- reemerge some packages:

```sh
emerge -C "${yours_udev}" "${yours_libudev}"  # it may be the same package
emerge -1 \
  sys-fs/mdevd::dm9pZCAq \
  virtual/udev::dm9pZCAq  \
  virtual/libudev::dm9pZCAq \
  sys-libs/libudev-zero::dm9pZCAq

# or if you already using busybox, you can use mdev from there
# add `sys-apps/busybox mdev` to `package.use`
#   and maybe change some busybox configs
emerge -1 \
  sys-apps/busybox \
  virtual/udev::dm9pZCAq  \
  virtual/libudev::dm9pZCAq \
  sys-libs/libudev-zero::dm9pZCAq \
```

- change yours init scripts
  - [runit](https://notabug.org/dm9pZCAq/etcfiles/src/master/sv/mdevd)
  - openrc: you can add yours through PR, issue or directly contact me (see contact info at my website)

#### some useful links

- https://github.com/illiliti/libudev-zero
  - [closed issues](https://github.com/illiliti/libudev-zero/issues?q=is%3Aissue+is%3Aclosed)
- https://kisslinux.org/wiki/device-management
- https://github.com/slashbeast/mdev-like-a-boss
