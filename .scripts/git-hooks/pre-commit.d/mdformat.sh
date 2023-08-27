#!/bin/sh --
set -ue

self="$(readlink -m "${0}")"
. "${self%/*}/functions.sh.lib"

for f in $(git_modified); do
	case "${f}" in
	*.md) mdformat --check "${f}";;
	esac
done
