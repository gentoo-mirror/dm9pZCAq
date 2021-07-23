# dm9pZCAq overlay

### detailed information about packages

* [app-benchmarks/](app-benchmarks/)
  * [hyperfine](app-benchmarks/hyperfine) - **[more USE flags]** A command-line benchmarking tool

* [app-crypt/](app-crypt/)
  * [gpg-tui](app-crypt/gpg-tui) - **[uniq]** Terminal User Interface for GnuPG
  * [veracrypt](app-crypt/veracrypt) - **[[difference](#veracrypt)]** Disk encryption with strong security based on TrueCrypt

* [app-editors/](app-editors/)
  * [vim](app-editors/vim) - **[symlinks to use neovim as vim]**

* [app-eselect/](app-eselect/)
  * [eselect-repository](app-eselect/eselect-repository) - **[you can use curl instead of wget]** Manage repos.conf via eselect

* [app-misc/](app-misc/)
  * [cpufetch](app-misc/cpufetch) - **[uniq]** Simplistic yet fancy CPU architecture fetching tool
  * [lf](app-misc/lf) - **[more USE flags]** Terminal file manager
  * [onefetch](app-misc/onefetch) - **[better ebuild]** Git repository summary on your terminal
  * [xplr](app-misc/xplr) - **[uniq]** A hackable, minimal, fast TUI file explorer

* [app-shells/](app-shells/)
  * [gitstatus](app-shells/gitstatus) - **[uniq]** Git status for Bash and Zsh prompt
  * [zoxide](app-shells/zoxide) - **[uniq]** A smarter cd command
  * [zsh-powerlevel10k](app-shells/zsh-powerlevel10k) - **[uniq]** Theme for Zsh that emphasizes speed, flexibility and out-of-the-box experience
  * [zsh-you-should-use](app-shells/zsh-you-should-use) - **[uniq]** ZSH plugin that reminds you to use existing aliases for commands you just typed

* [app-text/](app-text/)
  * [pandoc-bin](app-text/pandoc-bin) - **[better ebuild]** Universal markup converter

* [dev-lang/](dev-lang/)
  * [ghc](dev-lang/ghc) - **[[ghc](#ghc)]** The Glasgow Haskell Compiler from voidlinux (for ghcbootstrap on musl libc)

* [dev-libs/](dev-libs/)
  * [libexecinfo](dev-libs/libexecinfo) - **[uniq]** BSD licensed clone of the GNU libc backtrace facility (for musl libc)

* [dev-lua/](dev-lua/)
  * [alt-getopt](dev-lua/alt-getopt) - **[other ebuild]** Lua bindings to getopt_long
  * [moonscript](dev-lua/moonscript) - **[uniq]** A programmer friendly language that compiles into Lua

* [dev-python/](dev-python/)
  * [fake-useragent](dev-python/fake-useragent) - **[uniq]** Dependency for instalooter
  * [Telethon](dev-python/Telethon) - **[uniq]** Pure Python 3 MTProto API Telegram client library, for bots too!
  * [TgCrypto](dev-python/TgCrypto) - **[uniq]** Fast and Portable Telegram Crypto Library for Python

* [dev-vcs/](dev-vcs/)
  * [gitui](dev-vcs/gitui) - **[uniq]** Blazing fast terminal-ui for git

* [games-misc/](games-misc/)
  * [fortune-mod](games-misc/fortune-mod) - **[with musl support]** The notorious fortune program

* [net-dns/](net-dns/)
  * [alfis](net-dns/alfis) - **[uniq]** Alternative Free Identity System

* [net-libs/](net-libs/)
  * [telebot](net-libs/telebot) - **[uniq]** Telegram Bot API in C
  * [webkit-gtk](net-libs/webkit-gtk) - **[dbus is optional, musl support]** Open source web browser engine

* [net-misc/](net-misc/)
  * [gping](net-misc/gping) - **[uniq]** Ping, but with a graph
  * [instalooter](net-misc/instalooter) - **[uniq]** Instagram pictures and videos downloader
  * [youtube-dlc](net-misc/youtube-dlc) - **[uniq]** ?better? [youtube-dl](https://notabug.org/dm9pZCAq/youtube-dl)

* [net-news/](net-news/)
  * [newsboat](net-news/newsboat) - **[asciidoctor is optional]** RSS/Atom feed reader for terminals

* [net-p2p/](net-p2p/)
  * [stig](net-p2p/stig) - **[better ebuild]** TUI and CLI for the BitTorrent client Transmission

* [net-wireless/](net-wireless/)
  * [eiwd](net-wireless/eiwd) - **[newer version, better ebuild, clang patches]** iwd without dbus

* [sys-apps/](sys-apps/)
  * [hexyl](sys-apps/hexyl) - **[uniq]** A command-line hex viewer
  * [huxdemp](sys-apps/huxdemp) - **[uniq]** A better hexdump
  * [tealdeer](sys-apps/tealdeer) - **[more USE flags]** Very fast implementation of tldr in Rust
  * [tldr](sys-apps/tldr) - **[using go-module inherit, misc ebuild changes]** Fast and interactive tldr client written with go
  * [uutils-coreutils](sys-apps/uutils-coreutils) - **[uniq]** Cross-platform Rust rewrite of the GNU coreutils

* [sys-fs/](sys-fs/)
  * [duf](sys-fs/duf) - **[uniq]** Disk Usage/Free Utility - a better 'df' alternative

* [sys-process/](sys-process/)
  * [bottom](sys-process/bottom) - **[uniq]** TUI process/system monitor with multitude of features
  * [ytop](sys-process/ytop) - **[uniq]** [gotop](https://github.com/xxxserxxx/gotop) RIIR (Rewrite It in Rust)

* [www-client/](www-client/)
  * [firefox-musl-bin](www-client/firefox-musl-bin) - **[uniq]** `firefox-bin` for musl libc

* [www-plugins/](www-plugins/)
  * [LegacyFox](www-plugins/LegacyFox) - **[uniq]** Firefox legacy plugins support (for example [VimFx](https://git.gir.st/VimFx.git))

* [x11-misc/](x11-misc/)
  * [herbe](x11-misc/herbe) - **[uniq]** Daemon-less notifications without D-Bus
  * [lemonbar](x11-misc/lemonbar) - **[better ebuild]** A featherweight, lemon-scented, bar based on xcb
  * [screenkey](x11-misc/screenkey) - **[better ebuild]** Screencast your keys
  * [xinput-gui](x11-misc/xinput-gui) - **[newer version]** Simple GUI for `xinput`

### misc
in **[ square brackets ]** info about difference with other overlays

### veracrypt
`app-crypt/veracrypt` difference:
 * `app-admin/sudo` needed only if `X` used
 * with musl support

### ghc
`dev-lang/ghc::dm9pZCAq` package is here for `ghcbootstrap`
to build `dev-lang/ghc::haskell` on musl libc

```sh
echo ghcbootstrap >> /etc/portage/package.use/ghc
ACCEPT_KEYWORDS='**' emerge -1 dev-lang/ghc::dm9pZCAq \
  && emerge dev-lang/ghc
```
