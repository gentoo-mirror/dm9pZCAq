#!/bin/sh --
set -ue

# patch to remove dbus dependencie
#
# deps: sed
# usage: ./patch.sh *.ebuild
# TODO: rewrite in pure sed

for ebuild; do
	if [ "$(sed -n '/^IUSE=".*dbus.*"$/p' "${ebuild}")" ]; then
		>&2 echo "${ebuild}: already patched"
		continue
	fi

	>&2 echo "patching ${ebuild}"

	sed -i "${ebuild}" \
		-e 's/^\(IUSE="aqua\s\)\(.*\)$/\1dbus \2/' \
		-e 's/^\(\s\+\)\(.*at-spi2-core.*\)$/\1dbus? ( \2 )/'
done
