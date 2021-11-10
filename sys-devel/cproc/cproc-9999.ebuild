# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic git-r3

DESCRIPTION="Small C11 compiler based on QBE"
HOMEPAGE="
	https://sr.ht/~mcf/cproc
	https://github.com/michaelforney/cproc
"
EGIT_REPO_URI="https://git.sr.ht/~mcf/${PN}"

LICENSE="ISC"
SLOT="0"
KEYWORDS=""
IUSE="+bootstrap +mcf-qbe clang-cpp default-lld llvm-mc"

DEPEND="
	!mcf-qbe? ( sys-devel/qbe )
	clang-cpp? ( sys-devel/clang:* )
	default-lld? ( sys-devel/lld )
	llvm-mc? ( sys-devel/llvm:* )
"
RDEPEND="${DEPEND}"
BDEPEND="bootstrap? ( ${RDEPEND} )"

src_prepare() {
	default

	# lld cannot automatically found libraries
	local musl_link='"-L", "/usr/lib",'

	sed -i configure \
		`# don't fail on unknown configure flags` \
		-e '/^\s*\*)/s/fail/1>\&2 echo/'  \
		`# add linkflags for musl libc` \
		-e '/linux.*musl.*)$/'"alinkflags='${musl_link}'" \
		`# accept custom asmflags (for llvm)` \
		-e '/assemblecmd/s/\(};\)$/, $asmflags\1/' \
		|| die
}

my_use() {
	local use="${1:?}"
	local name="${2:?}"
	local opt="${3:-${use}}"

	usex "${use}" "--with-${name}=${opt}" ''
}

src_configure() {
	local my_econf_flags=(
		$(my_use clang-cpp cpp)
		$(my_use llvm-mc as)
		$(my_use default-lld ld ld.lld)
		$(my_use mcf-qbe qbe)
	)

	use bootstrap && {
		filter-ldflags -[^W]*  # filter all except -W* flags
		unset CFLAGS
	}

	(
		asmflags=
		use llvm-mc && asmflags='"--filetype=obj"'
		export asmflags

		econf "${my_econf_flags[@]}"
		sed -i config.mk -e '/^CFLAGS/s/-g//' `# disable dubug` || die
	)
}

src_compile() {
	use mcf-qbe && {
		emake -C qbe V=
		install -vDm755 -- ./qbe/obj/qbe ./qbe-bin/mcf-qbe
		export PATH="${PATH}:${PWD:-$(pwd)}/qbe-bin"
	}

	if use bootstrap; then
		QA_PRESTRIPPED="usr/bin/${PN} usr/bin/${PN}-qbe"

		emake bootstrap
		mv -v -- "stage3/${PN}"{,-qbe} .
	else
		default
	fi
}

src_install() {
	local DOCS=( README.md doc/* )

	dobin "${PN}"{,-qbe}

	einstalldocs

	use mcf-qbe && {
		dobin qbe-bin/mcf-qbe

		docinto mcf-qbe
		dodoc qbe/doc/*
	}

}
