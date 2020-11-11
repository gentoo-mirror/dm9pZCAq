# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6..9} )

DISTUTILS_USE_SETUPTOOLS=rdepend

inherit bash-completion-r1 distutils-r1

MY_PVR="${PVR/r/}"

DESCRIPTION="media downloader and libray for various sites"
HOMEPAGE="
	https://pypi.org/project/youtube-dlc
	https://github.com/blackjack4494/yt-dlc
"

SRC_URI="
	https://github.com/blackjack4494/yt-dlc/archive/${MY_PVR}.tar.gz
		-> ${PN}-${MY_PVR}.tar.gz
"

LICENSE="Unlicense"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~hppa ~ppc64 ~x86 ~ppc-macos ~x64-macos ~x86-macos ~x86-solaris"

IUSE="doc bash-completion zsh-completion fish-completion test"
RESTRICT="!test? ( test )"

RDEPEND="
	dev-python/pycryptodome[${PYTHON_USEDEP}]
	dev-python/setuptools[${PYTHON_USEDEP}]
"
DEPEND="
	${RDEPEND}
	doc? ( dev-python/sphinx )
	test? (
		dev-python/nose[${PYTHON_USEDEP}]
		dev-python/flake8[${PYTHON_USEDEP}]
	)
"

S="${WORKDIR}/${PN/youtube/yt}-${MY_PVR}"

distutils_enable_tests nose

src_compile() {
	distutils-r1_src_compile

	use doc && (
		cd -- ./docs && emake man BUILDDIR="${S}" \
			|| die 'failed to build man page'
	)
}

python_test() {
	emake offlinetest
}

python_install_all() {
	rm -r -- "${ED}/usr/etc" && rm -r -- "${ED}/usr/share/doc" \
		|| die 'failed to remove unneeded files'

	dodoc README.md

	use doc && doman "man/${PN}.1"

	use bash-completion && {
		emake "${PN}.bash-completion"
		newbashcomp "${PN}.bash-completion" "${PN}"
	}
	use fish-completion && {
		insinto /usr/share/fish/vendor_completions.d

		emake "${PN}.fish"
		doins "${PN}.fish"
	}
	use zsh-completion && {
		insinto /usr/share/zsh/site-functions

		emake "${PN}.zsh"
		newins "${PN}.zsh" "_${PN}"
	}
}
