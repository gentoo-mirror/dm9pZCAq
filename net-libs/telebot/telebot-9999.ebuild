# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake git-r3

DESCRIPTION="Telegram Bot API in C"
HOMEPAGE="
	https://elmurod.net/telebot
	https://github.com/smartnode/telebot
"
EGIT_REPO_URI="https://github.com/smartnode/${PN}.git"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS=""

DEPEND="
	net-misc/curl
	dev-libs/json-c
"
RDEPEND="${DEPEND}"

CMAKE_USE_DIR="${S}"
BUILD_DIR="${CMAKE_USE_DIR}"
