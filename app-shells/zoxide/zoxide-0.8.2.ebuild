# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	anyhow-1.0.58
	askama-0.11.1
	askama_derive-0.11.2
	askama_escape-0.10.3
	askama_shared-0.12.2
	assert_cmd-2.0.4
	async-attributes-1.1.2
	async-channel-1.6.1
	async-executor-1.4.1
	async-global-executor-2.2.0
	async-io-1.7.0
	async-lock-2.5.0
	async-std-1.12.0
	async-task-4.2.0
	atomic-waker-1.0.0
	atty-0.2.14
	autocfg-1.1.0
	bincode-1.3.3
	bitflags-1.3.2
	blocking-1.2.0
	bstr-0.2.17
	bumpalo-3.10.0
	cache-padded-1.2.0
	cc-1.0.73
	cfg-if-1.0.0
	clap-3.2.6
	clap_complete-3.2.2
	clap_complete_fig-3.2.2
	clap_derive-3.2.6
	clap_lex-0.2.3
	concurrent-queue-1.2.2
	crossbeam-utils-0.8.10
	ctor-0.1.22
	difflib-0.4.0
	dirs-4.0.0
	dirs-sys-0.3.7
	doc-comment-0.3.3
	dunce-1.0.2
	either-1.6.1
	event-listener-2.5.2
	fastrand-1.7.0
	futures-0.3.21
	futures-channel-0.3.21
	futures-core-0.3.21
	futures-executor-0.3.21
	futures-io-0.3.21
	futures-lite-1.12.0
	futures-macro-0.3.21
	futures-sink-0.3.21
	futures-task-0.3.21
	futures-timer-3.0.2
	futures-util-0.3.21
	getrandom-0.2.7
	glob-0.3.0
	gloo-timers-0.2.4
	hashbrown-0.12.1
	heck-0.4.0
	hermit-abi-0.1.19
	indexmap-1.9.1
	instant-0.1.12
	itertools-0.10.3
	js-sys-0.3.58
	kv-log-macro-1.0.7
	lazy_static-1.4.0
	libc-0.2.126
	log-0.4.17
	memchr-2.5.0
	mime-0.3.16
	mime_guess-2.0.4
	minimal-lexical-0.2.1
	nix-0.24.1
	nom-7.1.1
	num-traits-0.2.15
	num_cpus-1.13.1
	once_cell-1.12.0
	ordered-float-3.0.0
	os_str_bytes-6.1.0
	parking-2.0.0
	pin-project-lite-0.2.9
	pin-utils-0.1.0
	polling-2.2.0
	predicates-2.1.1
	predicates-core-1.0.3
	predicates-tree-1.0.5
	proc-macro-error-1.0.4
	proc-macro-error-attr-1.0.4
	proc-macro2-1.0.40
	quote-1.0.20
	redox_syscall-0.2.13
	redox_users-0.4.3
	regex-automata-0.1.10
	remove_dir_all-0.5.3
	rstest-0.13.0
	rstest_macros-0.13.0
	rstest_reuse-0.3.0
	rustc_version-0.4.0
	semver-1.0.10
	serde-1.0.137
	serde_derive-1.0.137
	slab-0.4.6
	socket2-0.4.4
	strsim-0.10.0
	syn-1.0.98
	tempfile-3.3.0
	termcolor-1.1.3
	termtree-0.2.4
	textwrap-0.15.0
	thiserror-1.0.31
	thiserror-impl-1.0.31
	unicase-2.6.0
	unicode-ident-1.0.1
	value-bag-1.0.0-alpha.9
	version_check-0.9.4
	wait-timeout-0.2.0
	waker-fn-1.1.0
	wasi-0.11.0+wasi-snapshot-preview1
	wasm-bindgen-0.2.81
	wasm-bindgen-backend-0.2.81
	wasm-bindgen-futures-0.4.31
	wasm-bindgen-macro-0.2.81
	wasm-bindgen-macro-support-0.2.81
	wasm-bindgen-shared-0.2.81
	web-sys-0.3.58
	wepoll-ffi-0.1.2
	which-4.2.5
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
