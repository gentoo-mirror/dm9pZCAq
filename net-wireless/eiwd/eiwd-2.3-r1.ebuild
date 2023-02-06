# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit linux-info

DESCRIPTION="iwd without dbus"
HOMEPAGE="https://github.com/illiliti/eiwd"
SRC_URI="
	${HOMEPAGE}/releases/download/${PVR/r/}/${P##e}.tar.xz
		-> ${PF}.tar.xz
"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="
	+builtin-dns crda monitor ofono wired
	cpu_flags_x86_aes cpu_flags_x86_ssse3
"

DEPEND=">=dev-libs/ell-0.56"
RDEPEND="
	${DEPEND}
	!net-wireless/iwd
	net-wireless/wireless-regdb
	crda? ( net-wireless/crda )
	builtin-dns? ( net-dns/openresolv )
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
	if use crda; then
		CONFIG_CHECK="${CONFIG_CHECK} ~CFG80211_CRDA_SUPPORT"
		WARNING_CFG80211_CRDA_SUPPORT="REGULATORY DOMAIN PROBLEM: please enable CFG80211_CRDA_SUPPORT for proper regulatory domain support"
	fi

	if use amd64; then
		CONFIG_CHECK="${CONFIG_CHECK} ~CRYPTO_DES3_EDE_X86_64"
		WARNING_CRYPTO_DES3_EDE_X86_64="CRYPTO_DES3_EDE_X86_64: enable for increased performance"
	fi

	if use cpu_flags_x86_aes; then
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

	if ! use crda; then
		if use kernel_linux && kernel_is -lt 4 15; then
			ewarn "POSSIBLE REGULATORY DOMAIN PROBLEM:"
			ewarn "Regulatory domain support for kernels older than 4.15 requires crda."
		fi
		if linux_config_exists && linux_chkconfig_builtin CFG80211 &&
			[[ $(linux_chkconfig_string EXTRA_FIRMWARE) != *regulatory.db* ]]
		then
			ewarn ""
			ewarn "REGULATORY DOMAIN PROBLEM:"
			ewarn "With CONFIG_CFG80211=y (built-in), the driver won't be able to load regulatory.db from"
			ewarn " /lib/firmware, resulting in broken regulatory domain support.  Please set CONFIG_CFG80211=m"
			ewarn " or add regulatory.db and regulatory.db.p7s to CONFIG_EXTRA_FIRMWARE."
			ewarn ""
		fi
	fi
}

src_configure() {
	local myeconfargs=(
		--localstatedir="${EPREFIX}/var"
		--sysconfdir="${EPREFIX}/etc/iwd"

		--disable-dbus
		--enable-external-ell

		$(use_enable monitor)
		$(use_enable ofono)
		$(use_enable wired)
	)
	econf "${myeconfargs[@]}"
}

src_install() {
	default

	keepdir /var/lib/iwd
	newinitd "${FILESDIR}/iwd.initd" iwd

	insinto /etc/iwd/
	doins "${FILESDIR}/main.conf"

	echo 'rc_provide="net"' > "${ED}/etc/conf.d/iwd"
}
