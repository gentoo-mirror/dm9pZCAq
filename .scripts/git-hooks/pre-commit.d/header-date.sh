#!/bin/sh --
set -ue

self="$(readlink -m "${0}")"
. "${self%/*}/functions.sh.lib"

CURRENT_YEAR="$(date '+%Y')"
header_date() {
		sed -n "1{/${CURRENT_YEAR}/!q1}" <"${EBUILD_FILE}" || {
			echo "${EBUILD_FILE}: ERROR: header does not contain current YEAR" 1>&2
			exit 1
		}

}

for_each_ebuild header_date
