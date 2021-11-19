# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	aho-corasick-0.7.10
	ansi_term-0.11.0
	askama-0.9.0
	askama_derive-0.9.0
	askama_escape-0.3.0
	askama_shared-0.9.1
	atty-0.2.14
	autocfg-1.0.0
	backtrace-0.3.46
	backtrace-sys-0.1.37
	bitflags-1.2.1
	block-buffer-0.7.3
	block-padding-0.1.5
	byte-tools-0.3.1
	byteorder-1.3.4
	cc-1.0.52
	cfg-if-0.1.10
	clap-2.33.0
	crossbeam-deque-0.7.3
	crossbeam-epoch-0.8.2
	crossbeam-queue-0.2.1
	crossbeam-utils-0.7.2
	digest-0.8.1
	either-1.5.3
	env_logger-0.6.2
	error-chain-0.12.2
	failure-0.1.8
	fake-simd-0.1.2
	fuchsia-cprng-0.1.1
	generic-array-0.12.3
	getrandom-0.1.14
	hermit-abi-0.1.12
	humansize-1.1.0
	humantime-1.3.0
	idna-0.2.0
	itoa-0.4.5
	lazy_static-1.4.0
	libc-0.2.69
	log-0.4.8
	maplit-1.0.2
	matches-0.1.8
	maybe-uninit-2.0.0
	memchr-2.3.3
	memoffset-0.5.4
	metrohash-1.0.6
	nom-5.1.1
	num-traits-0.2.11
	num_cpus-1.13.0
	numtoa-0.1.0
	opaque-debug-0.2.3
	pathdiff-0.2.0
	pbr-1.0.2
	percent-encoding-2.1.0
	pest-2.1.3
	pest_derive-2.1.0
	pest_generator-2.1.3
	pest_meta-2.1.3
	proc-macro2-1.0.12
	quick-error-1.2.3
	quote-1.0.4
	rand-0.4.6
	rand_core-0.3.1
	rand_core-0.4.2
	rayon-1.3.0
	rayon-core-1.7.0
	rdrand-0.4.0
	redox_syscall-0.1.56
	redox_termios-0.1.1
	regex-1.3.7
	regex-syntax-0.6.17
	remove_dir_all-0.5.2
	rmp-0.8.9
	rmp-serde-0.14.3
	rsmt2-0.14.1
	rustc-demangle-0.1.16
	ryu-1.0.4
	scopeguard-1.1.0
	serde-1.0.106
	serde_derive-1.0.106
	serde_json-1.0.52
	sha-1-0.8.2
	sha2-0.8.1
	smallvec-1.4.0
	strsim-0.8.0
	syn-1.0.18
	tempdir-0.3.7
	termcolor-1.1.0
	termion-1.5.5
	textwrap-0.11.0
	thread_local-1.0.1
	time-0.1.43
	toml-0.5.6
	typenum-1.12.0
	ucd-trie-0.1.3
	unicode-bidi-0.3.4
	unicode-normalization-0.1.12
	unicode-width-0.1.7
	unicode-xid-0.2.0
	url-2.1.1
	vec_map-0.8.1
	version_check-0.9.1
	wasi-0.9.0+wasi-snapshot-preview1
	which-3.1.1
	winapi-0.3.8
	winapi-i686-pc-windows-gnu-0.4.0
	winapi-util-0.1.5
	winapi-x86_64-pc-windows-gnu-0.4.0
"

inherit cargo

MY_PN="${PN::1}${PN: -1}"
GIT_HASH=5a86bbd0a5676cc4644942174bb5b29cae58a2c8

DESCRIPTION="ZetZ a zymbolic verifier and tranzpiler to bare metal C"
HOMEPAGE="
	https://zetz.it
	https://github.com/zetzit/zz
"
SRC_URI="
	$(cargo_crate_uris ${CRATES})
	https://github.com/zetzit/${MY_PN}/archive/${GIT_HASH}.tar.gz
		-> ${PF}.tar.gz
"

LICENSE="Apache-2.0 ISC MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~ppc ~ppc64 ~riscv ~x86"

DEPEND="sci-mathematics/z3"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_PN}-${GIT_HASH}"

remove_gitignore() {
	local dir="${1:?}"
	[ -d "${dir}" ] || die

	[ -f "${dir}/.gitignore" ] && {
		rm -- "${dir}/.gitignore" || die
	}

	local d=''
	for d in "${dir}"/*; do
		[ -d "${d}" ] && remove_gitignore "${d}"
	done
}

src_install() {
	local ZZ_MODULE_PATHS="/usr/share/${MY_PN}/modules"

	dobin "target/release/${MY_PN}"

	remove_gitignore ./modules
	insinto "${ZZ_MODULE_PATHS}"
	doins -r modules/*

	printf 'ZZ_MODULE_PATHS="%s"\n' "${ZZ_MODULE_PATHS}" | newenvd - "60${PN}"
}
