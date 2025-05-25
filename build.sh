#!/bin/sh

REVJP="214ba9292d5de52d29a6e2ad3a0162caf95b94caa14b0b167915aa8fb8c3dec6"

compareHash() {
	echo $1 $2 | sha256sum --check > /dev/null 2>&1
}

build() {
	# note the asm6f_zp here
	tools/asm6fzp atlantis-no-nazo.asm -n "$@"
	if [ $? -ne 0 ] ; then
		echo 'Build failed!'
		exit 1
	fi
}


build bin/atlantis-no-nazo.nes "$@"
if compareHash $REVJP 'bin/atlantis-no-nazo.nes' -eq 0 ; then
	echo 'Matched JP ROM.'
fi

