#!/bin/sh --
set -ue

self="$(readlink -m "${0}")"
. "${self%/*}/functions.sh.lib"

CURRENT_EAPI=8
check_EAPI() {
	sed -n "/^EAPI=/{/=${CURRENT_EAPI}\$/!q1}" <"${EBUILD_FILE}" || {
		echo "${EBUILD_FILE}: ERROR: should use 'EAPI=${CURRENT_EAPI}'" 1>&2
		exit 1
	}
}

for_each_ebuild check_EAPI
