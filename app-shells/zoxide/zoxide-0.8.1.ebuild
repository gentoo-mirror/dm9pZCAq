# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	anyhow-1.0.57
	askama-0.11.1
	askama_derive-0.11.2
	askama_escape-0.10.3
	askama_shared-0.12.2
	assert_cmd-2.0.4
	atty-0.2.14
	autocfg-1.1.0
	bincode-1.3.3
	bitflags-1.3.2
	bstr-0.2.17
	cfg-if-1.0.0
	clap-3.1.12
	clap_complete-3.1.2
	clap_complete_fig-3.1.5
	clap_derive-3.1.7
	clap_lex-0.1.1
	difflib-0.4.0
	dirs-4.0.0
	dirs-sys-0.3.7
	doc-comment-0.3.3
	dunce-1.0.2
	either-1.6.1
	fastrand-1.7.0
	getrandom-0.2.6
	glob-0.3.0
	hashbrown-0.11.2
	heck-0.4.0
	hermit-abi-0.1.19
	indexmap-1.8.1
	instant-0.1.12
	itertools-0.10.3
	lazy_static-1.4.0
	libc-0.2.124
	memchr-2.4.1
	memoffset-0.6.5
	mime-0.3.16
	mime_guess-2.0.4
	minimal-lexical-0.2.1
	nix-0.24.1
	nom-7.1.1
	num-traits-0.2.14
	ordered-float-2.10.0
	os_str_bytes-6.0.0
	predicates-2.1.1
	predicates-core-1.0.3
	predicates-tree-1.0.5
	proc-macro-error-1.0.4
	proc-macro-error-attr-1.0.4
	proc-macro2-1.0.37
	quote-1.0.18
	redox_syscall-0.2.13
	redox_users-0.4.3
	regex-automata-0.1.10
	remove_dir_all-0.5.3
	rstest-0.12.0
	rstest_reuse-0.3.0
	rustc_version-0.4.0
	semver-1.0.7
	serde-1.0.136
	serde_derive-1.0.136
	strsim-0.10.0
	syn-1.0.91
	tempfile-3.3.0
	termcolor-1.1.3
	termtree-0.2.4
	textwrap-0.15.0
	thiserror-1.0.30
	thiserror-impl-1.0.30
	unicase-2.6.0
	unicode-xid-0.2.2
	version_check-0.9.4
	wait-timeout-0.2.0
	wasi-0.10.2+wasi-snapshot-preview1
	winapi-0.3.9
	winapi-i686-pc-windows-gnu-0.4.0
	winapi-util-0.1.5
	winapi-x86_64-pc-windows-gnu-0.4.0
	${P}
"

inherit bash-completion-r1 cargo

DESCRIPTION="A smarter cd command"
HOMEPAGE="
	https://crates.io/crates/zoxide
	https://github.com/ajeetdsouza/zoxide
"
SRC_URI="$(cargo_crate_uris ${CRATES})"
RESTRICT="mirror"

LICENSE="Apache-2.0 CC0-1.0 MIT"
SLOT="0"
KEYWORDS="amd64 x86"

BDEPEND=">=virtual/rust-1.54.0" # for clap

src_install() {
	doman man/man[0-9]/*

	einstalldocs

	dobin "target/release/${PN}"

	# bash-completion
	newbashcomp "contrib/completions/${PN}.bash" "${PN}"

	# zsh-completion
	insinto /usr/share/zsh/site-functions
	doins "contrib/completions/_${PN}"

	# fish-completion
	insinto /usr/share/fish/vendor_completions.d
	doins "contrib/completions/${PN}.fish"
}