# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Virtual to select between different udev (mdev) daemon providers"
SLOT="0"

RDEPEND="
	|| (
		sys-fs/mdevd
		sys-apps/busybox[mdev]
	)
"
