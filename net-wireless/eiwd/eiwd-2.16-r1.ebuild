# Copyright 2021-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit flag-o-matic linux-info systemd

DESCRIPTION="iwd without dbus"
HOMEPAGE="https://github.com/illiliti/eiwd"
SRC_URI="${HOMEPAGE}/releases/download/${PVR/r/}/${P##e}.tar.xz -> ${PF}.tar.xz"

KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~ia64 ~loong ~ppc ~ppc64 ~riscv ~sparc ~x86"

LICENSE="LGPL-2.1"
SLOT="0"
IUSE="cpu_flags_x86_aes cpu_flags_x86_ssse3 monitor ofono selinux systemd wired"

DEPEND=">=dev-libs/ell-0.63"

RDEPEND="
	${DEPEND}
	!net-wireless/iwd
	acct-group/netdev
	net-wireless/wireless-regdb
	selinux? ( sec-policy/selinux-networkmanager )
	systemd? ( sys-apps/systemd )
	!systemd? ( virtual/resolvconf )
"

BDEPEND="virtual/pkgconfig"

S="${WORKDIR}/${P#e}"

pkg_setup() {
	CONFIG_CHECK="
		~ASYMMETRIC_KEY_TYPE
		~ASYMMETRIC_PUBLIC_KEY_SUBTYPE
		~CFG80211
		~CRYPTO_AES
		~CRYPTO_CBC
		~CRYPTO_CMAC
		~CRYPTO_DES
		~CRYPTO_ECB
		~CRYPTO_HMAC
		~CRYPTO_MD4
		~CRYPTO_MD5
		~CRYPTO_RSA
		~CRYPTO_SHA1
		~CRYPTO_SHA256
		~CRYPTO_SHA512
		~CRYPTO_USER_API_HASH
		~CRYPTO_USER_API_SKCIPHER
		~KEY_DH_OPERATIONS
		~PKCS7_MESSAGE_PARSER
		~RFKILL
		~X509_CERTIFICATE_PARSER
	"

	if use amd64;then
		CONFIG_CHECK="${CONFIG_CHECK} ~CRYPTO_DES3_EDE_X86_64"
		WARNING_CRYPTO_DES3_EDE_X86_64="CRYPTO_DES3_EDE_X86_64: enable for increased performance"
	fi

	if use cpu_flags_x86_aes;then
		CONFIG_CHECK="${CONFIG_CHECK} ~CRYPTO_AES_NI_INTEL"
		WARNING_CRYPTO_AES_NI_INTEL="CRYPTO_AES_NI_INTEL: enable for increased performance"
	fi

	if use cpu_flags_x86_ssse3 && use amd64; then
		CONFIG_CHECK="${CONFIG_CHECK} ~CRYPTO_SHA1_SSSE3 ~CRYPTO_SHA256_SSSE3 ~CRYPTO_SHA512_SSSE3"
		WARNING_CRYPTO_SHA1_SSSE3="CRYPTO_SHA1_SSSE3: enable for increased performance"
		WARNING_CRYPTO_SHA256_SSSE3="CRYPTO_SHA256_SSSE3: enable for increased performance"
		WARNING_CRYPTO_SHA512_SSSE3="CRYPTO_SHA512_SSSE3: enable for increased performance"
	fi

	if use kernel_linux && kernel_is -ge 4 20; then
		CONFIG_CHECK="${CONFIG_CHECK} ~PKCS8_PRIVATE_KEY_PARSER"
	fi

	check_extra_config
}

src_prepare() {
	default

	sed -e "s:Exec=/bin/false:Exec=${EPREFIX}/usr/libexec/iwd:g" -i src/net.connman.iwd.service || die
}

src_configure() {
	append-cflags "-fsigned-char"
	local myeconfargs=(
		--sysconfdir="${EPREFIX}"/etc/iwd --localstatedir="${EPREFIX}"/var

		--disable-client
		--disable-dbus
		--enable-external-ell

		"$(use_enable monitor)"
		"$(use_enable ofono)"
		"$(use_enable wired)"
		--enable-systemd-service
		--with-systemd-unitdir="$(systemd_get_systemunitdir)"
		--with-systemd-modloaddir="${EPREFIX}/usr/lib/modules-load.d"
		--with-systemd-networkdir="$(systemd_get_utildir)/network"
	)

	econf "${myeconfargs[@]}"
}

src_compile() {
	emake RST2MAN=:
}

src_install() {
	emake RST2MAN=: DESTDIR="${D}" install
	keepdir "/var/lib/${PN}"

	newinitd "${FILESDIR}/iwd.initd" iwd

	if use wired;then
		newinitd "${FILESDIR}/ead.initd" ead
	fi

	local iwdconf="${ED}/etc/iwd/main.conf"
	insinto /etc/iwd/
	cat << EOF > newins - main.conf
[General]
EnableNetworkConfiguration=true

[Network]
NameResolvingService=$(usex systemd systemd resolvconf)
EOF

	echo 'rc_provide="net"' | newconfd - iwd
}
