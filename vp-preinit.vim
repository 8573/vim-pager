
let g:c74d_vimpager = 1

finish

function PagerEsc()
	setlocal filetype=none conceallevel=2 concealcursor=nvc
	syntax clear
	highlight clear
	let l:csicodes = [
	\	['cterm=bold', 1, 22],
	\	['cterm=underline', 4, 24]
	\ ]
	for [l:type, l:start, l:end] in l:csicodes
		let l:name = substitute(l:type, '[= ]', '_', 'g')
		let l:othercodes = filter(copy(l:csicodes),
			\ 'v:val[0] != ' . string(l:type))
		let l:otherstarts = join(map(copy(l:othercodes),
			\ '''\e\[''.v:val[1].''m'''), '|')
		let l:othernames = join(map(copy(l:othercodes),
			\ 'substitute(v:val[0], ''[= ]'', ''_'', ''g'')'), ',')
		execute 'syntax region' l:name 'matchgroup='.l:name
			\ .'Ends start=/\e\['.l:start
			\ .'m/ end=/\ze\e\[0m/ end=/\ze\v%('.l:otherstarts
			\ .')*\e\['.l:end.'m/ concealends contains=CsiCode,'
			\ .l:othernames
		execute 'highlight' l:name l:type
	endfor
	let l:csicodenames = join(map(copy(l:csicodes),
		\ 'substitute(v:val[0], ''[= ]'', ''_'', ''g'')'), ',')
	execute 'syntax region CsiCode start=/\e\[/ end=/m/ conceal contains='
		\ .l:csicodenames
endfunction
