# Copyright 2017-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

CRATES="
	aho-corasick-0.7.18
	ansi_term-0.11.0
	ansi_term-0.12.1
	atty-0.2.14
	autocfg-1.0.1
	bitflags-1.3.2
	bstr-0.2.17
	camino-1.0.5
	cc-1.0.72
	cfg-if-1.0.0
	clap-2.33.3
	cradle-0.2.0
	ctor-0.1.21
	ctrlc-3.2.1
	derivative-2.2.0
	diff-0.1.12
	doc-comment-0.3.3
	dotenv-0.15.0
	edit-distance-2.1.0
	either-1.6.1
	env_logger-0.9.0
	executable-path-1.0.0
	getrandom-0.2.3
	heck-0.3.3
	hermit-abi-0.1.19
	humantime-2.1.0
	itoa-0.4.8
	lazy_static-1.4.0
	lexiclean-0.0.1
	libc-0.2.108
	linked-hash-map-0.5.4
	log-0.4.14
	memchr-2.4.1
	memoffset-0.6.4
	nix-0.23.0
	output_vt100-0.1.2
	ppv-lite86-0.2.15
	pretty_assertions-1.0.0
	proc-macro2-1.0.32
	quote-1.0.10
	rand-0.8.4
	rand_chacha-0.3.1
	rand_core-0.6.3
	rand_hc-0.3.1
	redox_syscall-0.2.10
	regex-1.5.4
	regex-automata-0.1.10
	regex-syntax-0.6.25
	remove_dir_all-0.5.3
	rustversion-1.0.5
	ryu-1.0.5
	serde-1.0.130
	serde_derive-1.0.130
	serde_json-1.0.71
	similar-2.1.0
	snafu-0.6.10
	snafu-derive-0.6.10
	strsim-0.8.0
	strum-0.23.0
	strum_macros-0.23.1
	syn-1.0.81
	target-2.0.0
	tempfile-3.2.0
	temptree-0.2.0
	term_size-0.3.2
	termcolor-1.1.2
	textwrap-0.11.0
	typed-arena-2.0.1
	unicode-segmentation-1.8.0
	unicode-width-0.1.9
	unicode-xid-0.2.2
	vec_map-0.8.2
	wasi-0.10.2+wasi-snapshot-preview1
	which-4.2.2
	winapi-0.3.9
	winapi-i686-pc-windows-gnu-0.4.0
	winapi-util-0.1.5
	winapi-x86_64-pc-windows-gnu-0.4.0
	yaml-rust-0.4.5
	${P}
"

inherit bash-completion-r1 cargo

DESCRIPTION="Just a command runner (with syntax inspired by 'make')"
HOMEPAGE="
	https://just.systems/
	https://crates.io/crates/just
	https://github.com/casey/just
"
SRC_URI="$(cargo_crate_uris ${CRATES})"

LICENSE="Apache-2.0 CC0-1.0 MIT"
SLOT="0"
KEYWORDS="amd64 ~arm64 ~x86"
RESTRICT="mirror"

src_install() {
	local DOCS=( README.adoc )

	dobin "target/release/${PN}"

	doman man/*

	einstalldocs

	# bash-completion
	newbashcomp "completions/${PN}.bash" "${PN}"

	# zsh-completion
	insinto /usr/share/zsh/site-functions
	newins "completions/${PN}.zsh" "_${PN}"

	# fish-completion
	insinto /usr/share/fish/vendor_completions.d
	doins "completions/${PN}.fish"
}
