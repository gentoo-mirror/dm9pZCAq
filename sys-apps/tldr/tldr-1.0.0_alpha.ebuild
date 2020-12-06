# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGO_SUM=(
	"github.com/alcortesm/tgz v0.0.0-20161220082320-9c5fe88206d7"
	"github.com/alcortesm/tgz v0.0.0-20161220082320-9c5fe88206d7/go.mod"
	"github.com/alecthomas/template v0.0.0-20190718012654-fb15b899a751"
	"github.com/alecthomas/template v0.0.0-20190718012654-fb15b899a751/go.mod"
	"github.com/alecthomas/units v0.0.0-20190924025748-f65c72e2690d"
	"github.com/alecthomas/units v0.0.0-20190924025748-f65c72e2690d/go.mod"
	"github.com/anmitsu/go-shlex v0.0.0-20161002113705-648efa622239"
	"github.com/anmitsu/go-shlex v0.0.0-20161002113705-648efa622239/go.mod"
	"github.com/armon/go-socks5 v0.0.0-20160902184237-e75332964ef5"
	"github.com/armon/go-socks5 v0.0.0-20160902184237-e75332964ef5/go.mod"
	"github.com/c-bata/go-prompt v0.2.3"
	"github.com/c-bata/go-prompt v0.2.3/go.mod"
	"github.com/creack/pty v1.1.7/go.mod"
	"github.com/creack/pty v1.1.9/go.mod"
	"github.com/davecgh/go-spew v1.1.0/go.mod"
	"github.com/davecgh/go-spew v1.1.1"
	"github.com/davecgh/go-spew v1.1.1/go.mod"
	"github.com/emirpasic/gods v1.12.0"
	"github.com/emirpasic/gods v1.12.0/go.mod"
	"github.com/fatih/color v1.7.0"
	"github.com/fatih/color v1.7.0/go.mod"
	"github.com/fatih/color v1.9.0"
	"github.com/fatih/color v1.9.0/go.mod"
	"github.com/flynn/go-shlex v0.0.0-20150515145356-3f9db97f8568"
	"github.com/flynn/go-shlex v0.0.0-20150515145356-3f9db97f8568/go.mod"
	"github.com/gliderlabs/ssh v0.2.2"
	"github.com/gliderlabs/ssh v0.2.2/go.mod"
	"github.com/go-git/gcfg v1.5.0"
	"github.com/go-git/gcfg v1.5.0/go.mod"
	"github.com/go-git/go-billy/v5 v5.0.0"
	"github.com/go-git/go-billy/v5 v5.0.0/go.mod"
	"github.com/go-git/go-git-fixtures/v4 v4.0.1"
	"github.com/go-git/go-git-fixtures/v4 v4.0.1/go.mod"
	"github.com/go-git/go-git/v5 v5.1.0"
	"github.com/go-git/go-git/v5 v5.1.0/go.mod"
	"github.com/google/go-cmp v0.3.0"
	"github.com/google/go-cmp v0.3.0/go.mod"
	"github.com/imdario/mergo v0.3.9"
	"github.com/imdario/mergo v0.3.9/go.mod"
	"github.com/isacikgoz/gia v0.2.0/go.mod"
	"github.com/isacikgoz/gitin v0.2.4-0.20200912114409-236a7ef883ae"
	"github.com/isacikgoz/gitin v0.2.4-0.20200912114409-236a7ef883ae/go.mod"
	"github.com/isacikgoz/gitin v0.2.5"
	"github.com/isacikgoz/gitin v0.2.5/go.mod"
	"github.com/jbenet/go-context v0.0.0-20150711004518-d14ea06fba99"
	"github.com/jbenet/go-context v0.0.0-20150711004518-d14ea06fba99/go.mod"
	"github.com/jessevdk/go-flags v1.4.0/go.mod"
	"github.com/jroimartin/gocui v0.4.0/go.mod"
	"github.com/juju/errors v0.0.0-20150916125642-1b5e39b83d18/go.mod"
	"github.com/juju/loggo v0.0.0-20160511211902-0e0537f18a29/go.mod"
	"github.com/juju/testing v0.0.0-20160203233110-321edad6b2d1/go.mod"
	"github.com/juju/utils v0.0.0-20160815113839-bdb77b07e7e3/go.mod"
	"github.com/justincampbell/bigduration v0.0.0-20160531141349-e45bf03c0666/go.mod"
	"github.com/justincampbell/timeago v0.0.0-20160528003754-027f40306f1d/go.mod"
	"github.com/kelseyhightower/envconfig v1.4.0"
	"github.com/kelseyhightower/envconfig v1.4.0/go.mod"
	"github.com/kevinburke/ssh_config v0.0.0-20190725054713-01f96b0aa0cd"
	"github.com/kevinburke/ssh_config v0.0.0-20190725054713-01f96b0aa0cd/go.mod"
	"github.com/kr/pretty v0.1.0/go.mod"
	"github.com/kr/pty v1.1.1/go.mod"
	"github.com/kr/pty v1.1.8/go.mod"
	"github.com/kr/text v0.1.0/go.mod"
	"github.com/kr/text v0.2.0"
	"github.com/kr/text v0.2.0/go.mod"
	"github.com/kylelemons/godebug v1.1.0"
	"github.com/kylelemons/godebug v1.1.0/go.mod"
	"github.com/libgit2/git2go/v30 v30.0.9/go.mod"
	"github.com/mattn/go-colorable v0.1.2"
	"github.com/mattn/go-colorable v0.1.2/go.mod"
	"github.com/mattn/go-colorable v0.1.4"
	"github.com/mattn/go-colorable v0.1.4/go.mod"
	"github.com/mattn/go-isatty v0.0.8/go.mod"
	"github.com/mattn/go-isatty v0.0.10/go.mod"
	"github.com/mattn/go-isatty v0.0.11"
	"github.com/mattn/go-isatty v0.0.11/go.mod"
	"github.com/mattn/go-runewidth v0.0.4"
	"github.com/mattn/go-runewidth v0.0.4/go.mod"
	"github.com/mattn/go-runewidth v0.0.6"
	"github.com/mattn/go-runewidth v0.0.6/go.mod"
	"github.com/mattn/go-tty v0.0.3"
	"github.com/mattn/go-tty v0.0.3/go.mod"
	"github.com/mitchellh/go-homedir v1.1.0"
	"github.com/mitchellh/go-homedir v1.1.0/go.mod"
	"github.com/niemeyer/pretty v0.0.0-20200227124842-a10e7caefd8e"
	"github.com/niemeyer/pretty v0.0.0-20200227124842-a10e7caefd8e/go.mod"
	"github.com/nsf/termbox-go v0.0.0-20190325093121-288510b9734e/go.mod"
	"github.com/pelletier/go-buffruneio v0.2.0/go.mod"
	"github.com/pkg/errors v0.8.1"
	"github.com/pkg/errors v0.8.1/go.mod"
	"github.com/pkg/term v0.0.0-20200520122047-c3ffed290a03"
	"github.com/pkg/term v0.0.0-20200520122047-c3ffed290a03/go.mod"
	"github.com/pmezard/go-difflib v1.0.0"
	"github.com/pmezard/go-difflib v1.0.0/go.mod"
	"github.com/sahilm/fuzzy v0.1.0"
	"github.com/sahilm/fuzzy v0.1.0/go.mod"
	"github.com/sergi/go-diff v1.0.0/go.mod"
	"github.com/sergi/go-diff v1.1.0"
	"github.com/sergi/go-diff v1.1.0/go.mod"
	"github.com/src-d/gcfg v1.4.0"
	"github.com/src-d/gcfg v1.4.0/go.mod"
	"github.com/stretchr/objx v0.1.0/go.mod"
	"github.com/stretchr/objx v0.2.0/go.mod"
	"github.com/stretchr/testify v1.3.0/go.mod"
	"github.com/stretchr/testify v1.4.0"
	"github.com/stretchr/testify v1.4.0/go.mod"
	"github.com/waigani/diffparser v0.0.0-20190426062500-1f7065f429b5/go.mod"
	"github.com/waigani/diffparser v0.0.0-20190828052634-7391f219313d/go.mod"
	"github.com/xanzy/ssh-agent v0.2.1"
	"github.com/xanzy/ssh-agent v0.2.1/go.mod"
	"golang.org/x/crypto v0.0.0-20160824173033-351dc6a5bf92/go.mod"
	"golang.org/x/crypto v0.0.0-20190219172222-a4c6cb3142f2/go.mod"
	"golang.org/x/crypto v0.0.0-20190308221718-c2843e01d9a2/go.mod"
	"golang.org/x/crypto v0.0.0-20190701094942-4def268fd1a4/go.mod"
	"golang.org/x/crypto v0.0.0-20200302210943-78000ba7a073"
	"golang.org/x/crypto v0.0.0-20200302210943-78000ba7a073/go.mod"
	"golang.org/x/crypto v0.0.0-20200728195943-123391ffb6de"
	"golang.org/x/crypto v0.0.0-20200728195943-123391ffb6de/go.mod"
	"golang.org/x/net v0.0.0-20190404232315-eb5bcb51f2a3/go.mod"
	"golang.org/x/net v0.0.0-20190620200207-3b0461eec859/go.mod"
	"golang.org/x/net v0.0.0-20190724013045-ca1201d0de80/go.mod"
	"golang.org/x/net v0.0.0-20200301022130-244492dfa37a"
	"golang.org/x/net v0.0.0-20200301022130-244492dfa37a/go.mod"
	"golang.org/x/sync v0.0.0-20190423024810-112230192c58/go.mod"
	"golang.org/x/sync v0.0.0-20190911185100-cd5d95a43a6e/go.mod"
	"golang.org/x/sys v0.0.0-20190215142949-d0b11bdaac8a/go.mod"
	"golang.org/x/sys v0.0.0-20190221075227-b4e8571b14e0/go.mod"
	"golang.org/x/sys v0.0.0-20190222072716-a9d3bda3a223/go.mod"
	"golang.org/x/sys v0.0.0-20190412213103-97732733099d/go.mod"
	"golang.org/x/sys v0.0.0-20190726091711-fc99dfbffb4e/go.mod"
	"golang.org/x/sys v0.0.0-20191008105621-543471e840be/go.mod"
	"golang.org/x/sys v0.0.0-20191026070338-33540a1f6037/go.mod"
	"golang.org/x/sys v0.0.0-20191120155948-bd437916bb0e/go.mod"
	"golang.org/x/sys v0.0.0-20200302150141-5c8b2ff67527"
	"golang.org/x/sys v0.0.0-20200302150141-5c8b2ff67527/go.mod"
	"golang.org/x/text v0.3.0/go.mod"
	"golang.org/x/text v0.3.2"
	"golang.org/x/text v0.3.2/go.mod"
	"golang.org/x/tools v0.0.0-20180917221912-90fa682c2a6e/go.mod"
	"golang.org/x/tools v0.0.0-20190729092621-ff9f1409240a/go.mod"
	"gopkg.in/alecthomas/kingpin.v2 v2.2.6"
	"gopkg.in/alecthomas/kingpin.v2 v2.2.6/go.mod"
	"gopkg.in/check.v1 v0.0.0-20161208181325-20d25e280405/go.mod"
	"gopkg.in/check.v1 v1.0.0-20160105164936-4f90aeace3a2/go.mod"
	"gopkg.in/check.v1 v1.0.0-20180628173108-788fd7840127/go.mod"
	"gopkg.in/check.v1 v1.0.0-20190902080502-41f04d3bba15/go.mod"
	"gopkg.in/check.v1 v1.0.0-20200227125254-8fa46927fb4f"
	"gopkg.in/check.v1 v1.0.0-20200227125254-8fa46927fb4f/go.mod"
	"gopkg.in/mgo.v2 v2.0.0-20150529124711-01ee097136da/go.mod"
	"gopkg.in/src-d/go-billy.v4 v4.3.2"
	"gopkg.in/src-d/go-billy.v4 v4.3.2/go.mod"
	"gopkg.in/src-d/go-git-fixtures.v3 v3.5.0"
	"gopkg.in/src-d/go-git-fixtures.v3 v3.5.0/go.mod"
	"gopkg.in/src-d/go-git.v4 v4.13.1"
	"gopkg.in/src-d/go-git.v4 v4.13.1/go.mod"
	"gopkg.in/warnings.v0 v0.1.2"
	"gopkg.in/warnings.v0 v0.1.2/go.mod"
	"gopkg.in/yaml.v2 v2.0.0-20160715033755-e4d366fc3c79/go.mod"
	"gopkg.in/yaml.v2 v2.2.2/go.mod"
	"gopkg.in/yaml.v2 v2.2.4"
	"gopkg.in/yaml.v2 v2.2.4/go.mod"
)

inherit go-module

go-module_set_globals

DESCRIPTION="fast and interactive tldr client written with go"
HOMEPAGE="
	https://isacikgoz.me/tldr/
	https://github.com/isacikgoz/tldr
"
SRC_URI="
	https://github.com/isacikgoz/${PN}/archive/v${PV/_/-}.tar.gz
		-> ${P}.tar.gz
	${EGO_SUM_SRC_URI}
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"
IUSE="+static"

DEPEND="!sys-apps/tealdeer"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}-${PV/_/-}"

src_compile() {
	local goflags=( -ldflags='-s -w' )
	use static && goflags+=( -ldflags='-w -extldflags "-static"' )

	CGO_ENABLED=0 GO111MODULE=on go build "${goflags[@]}" ./cmd/tldr \
		|| die 'failed to build go module'
}

src_install() {
	exeinto /usr/bin
	doexe "${PN}"
}
