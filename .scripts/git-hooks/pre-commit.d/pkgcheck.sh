#!/bin/sh --
set -ue
[ -z "$(pkgcheck scan --staged --color=true | tee /proc/self/fd/2)" ]
