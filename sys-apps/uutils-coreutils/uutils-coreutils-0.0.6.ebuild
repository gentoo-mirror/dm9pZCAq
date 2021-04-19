# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

CRATES="
advapi32-sys-0.2.0
aho-corasick-0.7.15
ansi_term-0.11.0
arrayvec-0.4.12
atty-0.2.14
autocfg-1.0.1
bit-set-0.5.2
bit-vec-0.6.3
bitflags-1.2.1
blake2-rfc-0.2.18
block-buffer-0.2.0
bstr-0.2.15
bumpalo-3.6.1
byte-tools-0.2.0
byteorder-1.4.3
cast-0.2.3
cc-1.0.67
cfg-if-0.1.10
cfg-if-1.0.0
chrono-0.4.11
clap-2.33.3
cloudabi-0.0.3
constant_time_eq-0.1.5
conv-0.3.3
cpp-0.5.6
cpp_build-0.4.0
cpp_common-0.4.0
cpp_common-0.5.6
cpp_macros-0.5.6
cpp_syn-0.12.0
cpp_synmap-0.3.0
cpp_synom-0.12.0
criterion-0.3.4
criterion-plot-0.4.3
crossbeam-channel-0.5.0
crossbeam-deque-0.8.0
crossbeam-epoch-0.9.3
crossbeam-utils-0.8.3
csv-1.1.6
csv-core-0.1.10
custom_derive-0.1.7
data-encoding-2.1.2
digest-0.6.2
dunce-1.0.1
either-1.6.1
env_logger-0.7.1
fake-simd-0.1.2
file_diff-1.0.0
filetime-0.2.14
fnv-1.0.7
fs_extra-1.2.0
fuchsia-cprng-0.1.1
generic-array-0.8.4
getopts-0.2.21
getrandom-0.1.16
glob-0.2.11
glob-0.3.0
half-1.7.1
hermit-abi-0.1.18
hex-0.2.0
hostname-0.3.1
if_rust_version-1.0.0
ioctl-sys-0.5.2
itertools-0.10.0
itertools-0.8.2
itertools-0.9.0
itoa-0.4.7
js-sys-0.3.50
kernel32-sys-0.2.2
lazy_static-1.4.0
libc-0.2.85
log-0.4.14
match_cfg-0.1.0
maybe-uninit-2.0.0
md5-0.3.8
memchr-1.0.2
memchr-2.3.4
memoffset-0.6.3
nix-0.13.1
nix-0.20.0
nodrop-0.1.14
num-integer-0.1.44
num-traits-0.2.14
num_cpus-1.13.0
number_prefix-0.4.0
numtoa-0.1.0
onig-4.3.3
onig_sys-69.1.0
oorandom-11.1.3
paste-0.1.18
paste-impl-0.1.18
pkg-config-0.3.19
platform-info-0.1.0
plotters-0.3.0
plotters-backend-0.3.0
plotters-svg-0.3.0
ppv-lite86-0.2.10
proc-macro-hack-0.5.19
proc-macro2-1.0.26
quick-error-1.2.3
quickcheck-0.9.2
quote-0.3.15
quote-1.0.9
rand-0.4.6
rand-0.5.6
rand-0.7.3
rand_chacha-0.2.2
rand_core-0.3.1
rand_core-0.4.2
rand_core-0.5.1
rand_hc-0.2.0
rand_pcg-0.2.1
rayon-1.5.0
rayon-core-1.9.0
rdrand-0.4.0
redox_syscall-0.1.57
redox_syscall-0.2.5
redox_termios-0.1.2
regex-1.4.5
regex-automata-0.1.9
regex-syntax-0.6.23
remove_dir_all-0.5.3
retain_mut-0.1.2
rust-ini-0.13.0
rustc_version-0.2.3
ryu-1.0.5
same-file-1.0.6
scopeguard-1.1.0
semver-0.9.0
semver-parser-0.7.0
serde-1.0.125
serde_cbor-0.11.1
serde_derive-1.0.125
serde_json-1.0.64
sha1-0.6.0
sha2-0.6.0
sha3-0.6.0
smallvec-0.6.14
static_assertions-1.1.0
strsim-0.8.0
syn-1.0.68
tempdir-0.3.7
tempfile-3.1.0
term_grid-0.1.7
term_size-0.3.2
termion-1.5.6
termsize-0.1.6
textwrap-0.11.0
thiserror-1.0.24
thiserror-impl-1.0.24
time-0.1.42
tinytemplate-1.2.1
twox-hash-1.6.0
typenum-1.13.0
unicode-width-0.1.8
unicode-xid-0.0.4
unicode-xid-0.2.1
unindent-0.1.7
unix_socket-0.5.0
users-0.10.0
vec_map-0.8.2
void-1.0.2
walkdir-2.3.2
wasi-0.9.0+wasi-snapshot-preview1
wasm-bindgen-0.2.73
wasm-bindgen-backend-0.2.73
wasm-bindgen-macro-0.2.73
wasm-bindgen-macro-support-0.2.73
wasm-bindgen-shared-0.2.73
web-sys-0.3.50
wild-2.0.4
winapi-0.2.8
winapi-0.3.9
winapi-build-0.1.1
winapi-i686-pc-windows-gnu-0.4.0
winapi-util-0.1.5
winapi-x86_64-pc-windows-gnu-0.4.0
xattr-0.2.2
"

inherit cargo flag-o-matic

DESCRIPTION="Cross-platform Rust rewrite of the GNU coreutils"
HOMEPAGE="
	https://crates.io/crates/coreutils
	https://github.com/uutils/coreutils
"
SRC_URI="
	$(cargo_crate_uris ${CRATES})
	https://github.com/${PN%%-*}/${PN##*-}/archive/refs/tags/${PV}.tar.gz
		-> ${P}.tar.gz
"

LICENSE="Apache-2.0 BSD BSD-2 CC0-1.0 ISC MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"

UU_PROGS=(
	base32 base64 basename cat cksum comm csplit cut dircolors dirname echo env
	expand factor false fmt fold hashsum head link ln mkdir mktemp mv nl numfmt
	nproc paste printenv ptx pwd readlink realpath relpath rm rmdir seq shred
	shuf sleep sum sync tee tr true truncate tsort unexpand uniq wc whoami yes
)
UU_PROGS_UNSTABLE=(
	cp expr ls more od printf sort split tail test date join df tac
)
UU_UNIX_PROGS=(
	arch chgrp chmod chown chroot du groups hostid hostname id kill
	logname mkfifo mknod nice nohup pathchk stat stdbuf timeout touch tty
	uname unlink
)
UU_UNIX_PROGS_UNSTABLE=( install )
UU_MUSL=( pinky uptime users who )  # failed to build on musl

if [ "${ELIBC}" = musl ]; then
	UU_UNIX_PROGS_UNSTABLE+=( "${UU_MUSL[@]}" )
else
	UU_UNIX_PROGS+=( "${UU_MUSL[@]}" )
fi

IUSE="
	doc -path
	${UU_PROGS[@]/#/+uu_progs_}
	${UU_PROGS_UNSTABLE[@]/#/-uu_progs_}

	${UU_UNIX_PROGS[@]/#/+uu_unix_progs_}
	${UU_UNIX_PROGS_UNSTABLE[@]/#/-uu_unix_progs_}
"

REQUIRED_USE="
	elibc_musl? ( ${UU_MUSL[@]/#/!uu_unix_progs_} )
	|| (
		${UU_PROGS[@]/#/uu_progs_}
		${UU_PROGS_UNSTABLE[@]/#/uu_progs_}

		${UU_UNIX_PROGS[@]/#/uu_unix_progs_}
		${UU_UNIX_PROGS_UNSTABLE[@]/#/uu_unix_progs_}
	)
"

BDEPEND="doc? ( dev-python/sphinx )"

S="${WORKDIR}/${P#uutils-}"

UUTILS=/opt/uutils
UU_ENABLED=()
UU_UNSTABLE_ENABLED=()

_uu_append() {
	local prefix="${1:?}" prog="${2:?}"

	if use "${prefix}_${prog}"; then
		UU_ENABLED+=( "${prog}" )
		return 0
	else
		return 1
	fi
}

src_prepare() {
	default

	local prog
	for prog in "${UU_PROGS[@]}"; do
		_uu_append uu_progs "${prog}"
	done
	for prog in "${UU_PROGS_UNSTABLE[@]}"; do
		_uu_append uu_progs "${prog}" && UU_UNSTABLE_ENABLED+=( "${prog}" )
	done

	# unix progs
	for prog in "${UU_UNIX_PROGS[@]}"; do
		_uu_append uu_unix_progs "${prog}"
	done
	for prog in "${UU_UNIX_PROGS_UNSTABLE[@]}"; do
		_uu_append uu_unix_progs "${prog}" \
			&& UU_UNSTABLE_ENABLED+=( "${prog}" )
	done

	UU_MAKE_FLAGS=(
		PROFILE=release MULTICALL=y UTILS="${UU_ENABLED[*]}" PREFIX="${UUTILS}"
	)

	filter-flags -flto*  # building fails when compiling with LTO

	use doc || {
		sed -i ./GNUmakefile \
			-e '/\/man\//d' \
			-e '/^build:/s/build-manpages//' \
		|| die
	}
}

src_compile() {
	emake "${UU_MAKE_FLAGS[@]}" build
}

src_install() {
	emake "${UU_MAKE_FLAGS[@]}" DESTDIR="${ED}" install

	local envd=(
		'UUTILS="'"${UUTILS}"'"'
		'PATH="'"${UUTILS}"'/bin"'
		'ROOTPATH="'"${UUTILS}"'/bin"'
	)
	use doc && envd+=( 'MANPATH="'"${UUTILS}"'/man"' )

	local prefix=60
	use path && prefix=40
	# original PATH seted from 50baselayout
	# if we want to use uutils insetad of coreutils
	# we need to set our path first

	printf '%s\n' "${envd[@]}" | newenvd - "${prefix}uutils"
}

pkg_postinst() {
	[ "${#UU_UNSTABLE_ENABLED[@]}" -gt 0 ] && {

		ewarn "Warning: Semi-Done utils installed: ${UU_UNSTABLE_ENABLED[*]}"

		local homepage
		while read -r homepage; do
			[ "${homepage}" ] || continue
			ewarn "see: ${homepage}#utilities"
			return
		done <<< "${HOMEPAGE}"
	}
}
