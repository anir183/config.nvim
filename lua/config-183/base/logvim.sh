#!/bin/bash

__nvim_logfile="/home/anir183/.local/state/nvim/config-183.log"
__opt=$1

function __grep {
	if type "bat" > /dev/null; then
		if type "rg" > /dev/null; then
			rg $1 | bat -l log
		else
			grep $1 | bat -l log
		fi
	else
		if type "rg" > /dev/null; then
			rg $1
		else
			grep $1 --color
		fi
	fi
}

function __rev_grep {
	if type "bat" > /dev/null; then
		if type "rg" > /dev/null; then
			rg -v $1 | bat -l log
		else
			grep -v $1 | bat -l log
		fi
	else
		if type "rg" > /dev/null; then
			rg -v $1
		else
			grep $1 -v --color
		fi
	fi
}

function print_logs {
	if type "bat" > /dev/null; then
		bat $__nvim_logfile
	else
		cat $__nvim_logfile
	fi
}

if [ $# -eq 0 ]; then
	print_logs
else
	if [ $# -ne 1 ]; then
		echo "too many arguments"
		echo "only using first"
		echo ""
	fi

	case ${__opt// } in
		trace|t)
			print_logs | __grep " \[trace\] "
			;;
		debug|d)
			print_logs | __grep " \[debug\] "
			;;
		info|i)
			print_logs | __grep " \[info\] "
			;;
		warn|w)
			print_logs | __grep " \[warn\] "
			;;
		error|e)
			print_logs | __grep " \[error\] "
			;;
		notrace|no-trace|nt|one|1)
			print_logs | __rev_grep " \[trace\] "
			;;
		nodebug|no-debug|nd)
			print_logs | __rev_grep " \[debug\] "
			;;
		noinfo|no-info|ni)
			print_logs | __rev_grep " \[info\] "
			;;
		nowarn|no-warn|nw)
			print_logs | __rev_grep " \[warn\] "
			;;
		noerror|no-error|ne)
			print_logs | __rev_grep " \[error\] "
			;;
		zero|0)
			print_logs
			;;
		two|2)
			print_logs | __rev_grep " \[trace\] " | __rev_grep " \[debug\] "
			;;
		three|3)
			print_logs | __rev_grep " \[trace\] " | __rev_grep " \[debug\] " | __rev_grep " \[info\] "
			;;
		four|4)
			print_logs | __rev_grep " \[trace\] " | __rev_grep " \[debug\] " | __rev_grep " \[info\] " | __rev_grep " \[error\] "
			;;
		help|h|--help)
			echo -e "valid options:\n(no)trace\n(no)debug\n(no)info\n(no)warn\n(no)error\nzero\none\ntwo\nthree\nfour"
			;;
		* )
			print_logs | __grep "$__opt"
			;;
	esac
fi
