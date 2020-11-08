# dm9pZCAq overlay

### detailed information about packages

* [app-crypt/](app-crypt/)
  * [veracrypt](app-crypt/veracrypt) - **[[difference](#veracrypt)]** Disk encryption with strong security based on TrueCrypt

* [app-eselect/](app-eselect/)
  * [eselect-repository](app-eselect/eselect-repository) - **[you can use curl instead of wget]** Manage repos.conf via eselect

* [app-misc/](app-misc/)
  * [cpufetch](app-misc/cpufetch) - **[uniq]** Simplistic yet fancy CPU architecture fetching tool
  * [lf](app-misc/lf) - **[More USE flags]** Terminal file manager

* [dev-python/](dev-python/)
  * [Telethon](dev-python/Telethon) - **[uniq]** Pure Python 3 MTProto API Telegram client library, for bots too!
  * [fake-useragent](dev-python/fake-useragent) - **[uniq]** dependency for instalooter
  * [pygame_sdl2](dev-python/pygame_sdl2) - **[with python3 support]** dependency for renpy

* [games-engines/](games-engines/)
  * [renpy](games-engines/renpy) - **[with python3 support]** Visual novel engine

* [games-misc/](games-misc/)
  * [fortune-mod](games-misc/fortune-mod) - **[with musl support]** The notorious fortune program

* [net-misc/](net-misc/)
  * [instalooter](net-misc/instalooter) - **[uniq]** Instagram pictures and videos downloader
  * [youtube-dlc](net-misc/youtube-dlc) - **[uniq]** Continuation of [youtube-dl](https://notabug.org/dm9pZCAq/youtube-dl) life

### misc
in **[ square brackets ]** info about difference with other overlays

- [youtube-dlc](https://notabug.org/dm9pZCAq/youtube-dlc) mirror just in case

#### veracrypt
`app-crypt/veracrypt` difference:
 * `app-admin/sudo` needed only if `X` used
 * with musl support
