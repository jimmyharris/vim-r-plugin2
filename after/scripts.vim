if did_filetype()
  finish
endif

" Line continuation is used here, remove 'C' from 'cpoptions'
let s:cpo_save = &cpo
set cpo&vim

let s:line1 = getline(1)

if s:line1 =~ "^#!"
	" A script that starts with "#!".

	" Check for a line like "#!/usr/bin/env VAR=val bash".  Turn it into
	" "#!/usr/bin/bash" to make matching easier.
	if s:line1 =~ '^#!\s*\S*\<env\s'
		let s:line1 = substitute(s:line1, '\S\+=\S\+', '', 'g')
		let s:line1 = substitute(s:line1, '\<env\s\+', '', '')
	endif

	" Get the program name.
	" Only accept spaces in PC style paths: "#!c:/program files/perl [args]".
	" If the word env is used, use the first word after the space:
	" "#!/usr/bin/env perl [path/args]"
	" If there is no path use the first word: "#!perl [path/args]".
	" Otherwise get the last word after a slash: "#!/usr/bin/perl [path/args]".
	if s:line1 =~ '^#!\s*\a:[/\\]'
		let s:name = substitute(s:line1, '^#!.*[/\\]\(\i\+\).*', '\1', '')
	elseif s:line1 =~ '^#!.*\<env\>'
		let s:name = substitute(s:line1, '^#!.*\<env\>\s\+\(\i\+\).*', '\1', '')
	elseif s:line1 =~ '^#!\s*[^/\\ ]*\>\([^/\\]\|$\)'
		let s:name = substitute(s:line1, '^#!\s*\([^/\\ ]*\>\).*', '\1', '')
	else
		let s:name = substitute(s:line1, '^#!\s*\S*[/\\]\(\i\+\).*', '\1', '')
	endif

	if s:name =~ 'Rscript'
		set ft=r
	endif

	if s:name =~ 'r'
		set ft=r
	endif

	unlet s:name
endif

" Restore 'cpoptions'
let &cpo = s:cpo_save

unlet s:cpo_save s:line1
