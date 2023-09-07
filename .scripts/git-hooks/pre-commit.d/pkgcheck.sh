#!/bin/sh --
set -ue
[ -n "${GIT_HOOK_SKIP_PKGCHECK:-}" ] ||
	[ -z "$(pkgcheck scan --staged --color=true | tee /proc/self/fd/2)" ]
