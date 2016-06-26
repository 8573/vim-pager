scriptencoding utf-8

" Specifically not the standard `man` filetype.
setlocal filetype=manpage concealcursor=nvc conceallevel=2 nolist nowrap

syntax clear

syntax region CSICodeBold
	\ matchgroup=CSICodeBoldEnds
	\ start='\e\[1m' end='\ze\e\[0m' end='\ze\v%(\e\[4m)*\e\[22m'
	\ display concealends contains=CSICodeEtc,CSICodeUnderline
syntax region CSICodeUnderline
	\ matchgroup=CSICodeUnderlineEnds
	\ start='\e\[4m' end='\ze\e\[0m' end='\ze\v%(\e\[1m)*\e\[24m'
	\ display concealends contains=CSICodeEtc,CSICodeBold
syntax match CSICode /\e\[[^m]*m/
	\ display conceal
syntax match CSICodeEtc /\e\[[^m]*m/
	\ display conceal contains=CSICodeBold,CSICodeUnderline

syntax region OverstrikeBold
	\ matchgroup=OverstrikeBoldEnds
	\ start='\(.\)\b\ze\1' end='.\zs'
	\ display concealends
syntax region OverstrikeUnderline
	\ matchgroup=OverstrikeUnderlineEnds
	\ start='_\b' end='.\zs'
	\ display concealends
syntax match OverstrikeBullet '+\bo'
	\ display conceal cchar=•

syntax match manHeading '^\s\{,3}\S.*'
	\ display contains=CSICode,manHeadingOverstrike
syntax match manHeadingOverstrike '.\b'
	\ display conceal contained

highlight LineNr ctermfg=darkgray
highlight Conceal ctermfg=none ctermbg=none cterm=bold

if &t_Co > 16
	highlight manHeading ctermfg=magenta cterm=bold
else
	highlight manHeading ctermfg=magenta
endif

highlight manBold cterm=bold
highlight manUnderline cterm=underline

highlight link CSICodeBold manBold
highlight link CSICodeUnderline manUnderline

highlight link OverstrikeBold manBold
highlight link OverstrikeUnderline manUnderline
