#!/bin/sh --
set -ue

[ -n "${GIT_HOOK_SKIP_PKGCHECK:-}" ] ||
	[ -z "$(
		pkgcheck scan --staged --net \
			${PKGCHECK_USER_AGENT:+--user-agent="${PKGCHECK_USER_AGENT}"} \
			--color=true | tee /proc/self/fd/2
	)" ]
