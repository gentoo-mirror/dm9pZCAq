# Copyright 2023-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit font

DESCRIPTION="Collection of fonts that are patched to include a high number of glyphs (icons)."
HOMEPAGE="https://www.nerdfonts.com/"

# curl -s https://api.github.com/repos/ryanoasis/nerd-fonts/releases/latest \
#   | jq -r '.assets[].name | select(endswith(".tar.xz")) | split(".") | .[0] | select(test("(?i)symbolsonly") | not)'
FONTS=(
	0xProto
	3270
	Agave
	AnonymousPro
	Arimo
	AurulentSansMono
	BigBlueTerminal
	BitstreamVeraSansMono
	CascadiaCode
	CascadiaMono
	CodeNewRoman
	ComicShannsMono
	CommitMono
	Cousine
	D2Coding
	DaddyTimeMono
	DejaVuSansMono
	DroidSansMono
	EnvyCodeR
	FantasqueSansMono
	FiraCode
	FiraMono
	GeistMono
	Go-Mono
	Gohu
	Hack
	Hasklig
	HeavyData
	Hermit
	iA-Writer
	IBMPlexMono
	Inconsolata
	InconsolataGo
	InconsolataLGC
	IntelOneMono
	Iosevka
	IosevkaTerm
	IosevkaTermSlab
	JetBrainsMono
	Lekton
	LiberationMono
	Lilex
	MartianMono
	Meslo
	Monaspace
	Monofur
	Monoid
	Mononoki
	MPlus
	Noto
	OpenDyslexic
	Overpass
	ProFont
	ProggyClean
	Recursive
	RobotoMono
	ShareTechMono
	SourceCodePro
	SpaceMono
	Terminus
	Tinos
	Ubuntu
	UbuntuMono
	UbuntuSans
	VictorMono
	ZedMono
)

iuse_src_uri() {
	local iuse="${1:?}"
	local name="${2:?}"

	local uri_prefix="https://github.com/ryanoasis/${PN}/releases/download/v${PV}"
	local ext=tar.xz

	echo "${iuse,,}? (
		${uri_prefix}/${name}.${ext}
			-> ${PN}-${name}-${PV}.${ext}
	)"
}

nerd_src_uri() {
	for name; do
		iuse_src_uri "${name,,}" "${name}"
	done
}

SRC_URI="
	$(iuse_src_uri symbols-only NerdFontsSymbolsOnly)
	symbols-only? (
		https://github.com/ryanoasis/${PN}/raw/v${PV}/10-nerd-font-symbols.conf
			-> 10-nerd-font-symbols-${PV}.conf
	)

	$(nerd_src_uri "${FONTS[@]}")
"

S="${WORKDIR}"
FONT_S="${S}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 x86"

IUSE_FLAGS=(${FONTS[*],,})
# FIXME: `+hack` is workaround for: https://pkgcore.github.io/pkgcheck/man/pkgcheck.html#requiredusedefaults
IUSE="symbols-only +hack ${IUSE_FLAGS[*]}"
REQUIRED_USE="X? ( || ( ${IUSE_FLAGS[*]} ) )"

RDEPEND="media-libs/fontconfig"

src_unpack() {
	default

	use symbols-only && {
		cp -v "${DISTDIR}/10-nerd-font-symbols-${PV}.conf" \
			"${S}/10-nerd-font-symbols.conf"

		FONT_CONF=(
			"${S}/10-nerd-font-symbols.conf"
		)
	}
}

check_suffix() {
	local dir="${1:?}" suffix="${2:?}" f=''

	for f in "${dir}"/*."${suffix}"; do
		[ -e "${f}" ] && return 0
	done

	return 1
}

src_install() {
	FONT_SUFFIX=''
	local suffixes=(ttf otf) suf=''

	for suf in "${suffixes[@]}"; do
		check_suffix "${S}" "${suf}" && FONT_SUFFIX+=" ${suf} "
	done

	font_src_install
}
