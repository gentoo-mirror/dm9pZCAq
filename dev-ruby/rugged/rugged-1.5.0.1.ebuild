# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
USE_RUBY="ruby26 ruby27 ruby30"

RUBY_FAKEGEM_EXTENSIONS="ext/${PN}/extconf.rb"

inherit ruby-fakegem

DESCRIPTION="Ruby bindings to libgit2"
HOMEPAGE="
	https://rubygems.org/gems/rugged
	https://github.com/libgit2/rugged
"

LICENSE="MIT"
SLOT="$(ver_cut 1-2)"
KEYWORDS="~amd64 ~arm ~arm64 ~ppc ~ppc64 ~riscv ~x86 ~ppc-macos"

LIBGIT_DEPEND="dev-libs/libgit2:0/${SLOT}"
DEPEND+=" ${LIBGIT_DEPEND} "
RDEPEND+=" ${LIBGIT_DEPEND} "

each_ruby_configure() {
	export RUGGED_USE_SYSTEM_LIBRARIES=true

	sed -i "${RUBY_FAKEGEM_EXTENSIONS}" \
		-e '/line.match/s/\(LIBGIT2_VER_[^ ]\+\) /\1\\s+/'

	each_fakegem_configure
}
