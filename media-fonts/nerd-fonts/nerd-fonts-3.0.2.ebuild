# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit font

DESCRIPTION="Collection of fonts that are patched to include a high number of glyphs (icons)."
HOMEPAGE="https://nerdfonts.com"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 x86"

# curl -s https://api.github.com/repos/ryanoasis/nerd-fonts/releases/latest \
#   | jq -r '.assets[].name | select(endswith(".tar.xz")) | split(".") | .[0] | select(test("(?i)symbolsonly") | not)'
FONTS=(
	3270
	Agave
	AnonymousPro
	Arimo
	AurulentSansMono
	BigBlueTerminal
	BitstreamVeraSansMono
	CascadiaCode
	CodeNewRoman
	ComicShannsMono
	Cousine
	DaddyTimeMono
	DejaVuSansMono
	DroidSansMono
	FantasqueSansMono
	FiraCode
	FiraMono
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
	Iosevka
	IosevkaTerm
	JetBrainsMono
	Lekton
	LiberationMono
	Lilex
	Meslo
	Monofur
	Monoid
	Mononoki
	MPlus
	Noto
	OpenDyslexic
	Overpass
	ProFont
	ProggyClean
	RobotoMono
	ShareTechMono
	SourceCodePro
	SpaceMono
	Terminus
	Tinos
	Ubuntu
	UbuntuMono
	VictorMono
)

IUSE_FLAGS=(${FONTS[*],,})
IUSE="symbols-only ${IUSE_FLAGS[*]}"
REQUIRED_USE="X || ( ${IUSE_FLAGS[*]} )"

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
	$(iuse_src_uri symbols-only  NerdFontsSymbolsOnly)
	symbols-only? (
		https://github.com/ryanoasis/${PN}/raw/v${PV}/10-nerd-font-symbols.conf
			-> 10-nerd-font-symbols-${PV}.conf
	)

	$(nerd_src_uri "${FONTS[@]}")
"

RDEPEND="media-libs/fontconfig"

S="${WORKDIR}"
# FONT_CONF=(
# 	"${FILESDIR}"/10-nerd-font-symbols.conf
# )
FONT_S="${S}"

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
	local suffixes=( ttf otf ) suf=''

	for suf in "${suffixes[@]}"; do
		check_suffix "${S}" "${suf}" && FONT_SUFFIX+=" ${suf} "
	done

	font_src_install
}
