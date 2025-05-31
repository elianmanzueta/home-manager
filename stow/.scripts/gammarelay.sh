#!/usr/bin/env sh

if pgrep -xf "wl-gammarelay-rs" > /dev/null; then
    busctl --user set-property rs.wl-gammarelay / rs.wl.gammarelay Temperature q 5300
fi
