#!/bin/sh
#
# Copyright (C) 2014 OpenWrt.org
#

REALTEK_BOARD_NAME=
REALTEK_MODEL=

realtek_board_detect() {
	local machine
	local name

	machine=$(awk 'BEGIN{FS="[ \t]+:[ \t]"} /machine/ {print $2}' /proc/cpuinfo)

	case "$machine" in
	*"Nprove")
		name="nprove"
		;;
	*)
		name="generic"
		;;
	esac

	[ -z "$REALTEK_BOARD_NAME" ] && REALTEK_BOARD_NAME="$name"
	[ -z "$REALTEK_MODEL" ] && REALTEK_MODEL="$machine"

	[ -e "/tmp/sysinfo/" ] || mkdir -p "/tmp/sysinfo/"

	echo "$REALTEK_BOARD_NAME" > /tmp/sysinfo/board_name
	echo "$REALTEK_MODEL" > /tmp/sysinfo/model
}

realtek_board_name() {
	local name

	[ -f /tmp/sysinfo/board_name ] && name=$(cat /tmp/sysinfo/board_name)
	[ -z "$name" ] && name="unknown"

	echo "$name"
}
