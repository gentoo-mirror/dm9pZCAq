# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	aho-corasick-1.0.2
	aliasable-0.1.3
	anstream-0.3.2
	anstyle-1.0.1
	anstyle-parse-0.2.1
	anstyle-query-1.0.0
	anstyle-wincon-1.0.1
	anyhow-1.0.72
	askama-0.12.0
	askama_derive-0.12.1
	askama_escape-0.10.3
	assert_cmd-2.0.12
	bincode-1.3.3
	bitflags-1.3.2
	bitflags-2.3.3
	bstr-1.6.0
	cc-1.0.81
	cfg-if-1.0.0
	clap-4.3.19
	clap_builder-4.3.19
	clap_complete-4.3.2
	clap_complete_fig-4.3.1
	clap_derive-4.3.12
	clap_lex-0.5.0
	color-print-0.3.4
	color-print-proc-macro-0.3.4
	colorchoice-1.0.0
	difflib-0.4.0
	dirs-5.0.1
	dirs-sys-0.4.1
	doc-comment-0.3.3
	dunce-1.0.4
	either-1.9.0
	errno-0.3.2
	errno-dragonfly-0.1.2
	fastrand-2.0.0
	getrandom-0.2.10
	glob-0.3.1
	heck-0.4.1
	hermit-abi-0.3.2
	is-terminal-0.4.9
	itertools-0.10.5
	libc-0.2.147
	linux-raw-sys-0.4.5
	memchr-2.5.0
	mime-0.3.17
	mime_guess-2.0.4
	minimal-lexical-0.2.1
	nix-0.26.2
	nom-7.1.3
	once_cell-1.18.0
	option-ext-0.2.0
	ouroboros-0.17.2
	ouroboros_macro-0.17.2
	ppv-lite86-0.2.17
	predicates-3.0.3
	predicates-core-1.0.6
	predicates-tree-1.0.9
	proc-macro-error-1.0.4
	proc-macro-error-attr-1.0.4
	proc-macro2-1.0.66
	quote-1.0.32
	rand-0.8.5
	rand_chacha-0.3.1
	rand_core-0.6.4
	redox_syscall-0.2.16
	redox_syscall-0.3.5
	redox_users-0.4.3
	regex-1.9.1
	regex-automata-0.3.4
	regex-syntax-0.7.4
	relative-path-1.8.0
	rstest-0.18.1
	rstest_macros-0.18.1
	rstest_reuse-0.6.0
	rustc_version-0.4.0
	rustix-0.38.6
	semver-1.0.18
	serde-1.0.181
	serde_derive-1.0.181
	static_assertions-1.1.0
	strsim-0.10.0
	syn-1.0.109
	syn-2.0.28
	tempfile-3.7.0
	termtree-0.4.1
	thiserror-1.0.44
	thiserror-impl-1.0.44
	unicase-2.6.0
	unicode-ident-1.0.11
	utf8parse-0.2.1
	version_check-0.9.4
	wait-timeout-0.2.0
	wasi-0.11.0+wasi-snapshot-preview1
	which-4.4.0
	windows-sys-0.48.0
	windows-targets-0.48.1
	windows_aarch64_gnullvm-0.48.0
	windows_aarch64_msvc-0.48.0
	windows_i686_gnu-0.48.0
	windows_i686_msvc-0.48.0
	windows_x86_64_gnu-0.48.0
	windows_x86_64_gnullvm-0.48.0
	windows_x86_64_msvc-0.48.0
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
