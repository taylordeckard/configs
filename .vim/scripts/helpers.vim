" IndentLevel {{{
function! IndentLevel (delimiter)
	let preserve_reg = @@
	" add carriage returns after first char and before last char
	" send text in between to register to manipulate
	execute "normal! vi" . a:delimiter . "\<esc>`<i\<cr>\<esc>k$%i\<cr>\<esc>k0"
	" let line = @@
	let line_num = line('.')
	let keep_looping = 1
	while keep_looping == 1
		normal! vy
		let char = getreg('@')
		if char == '(' || char == '{' || char == '['
			execute "normal! %"
		elseif char == ','
			execute "normal! li\<cr>\<esc>"
			let line_num = line_num + 1
		else
			normal! l
		endif
		if line_num < line('.')
			let keep_looping = 0
		endif
	endwhile
	" move up and check for trailing whitespace
	normal! kVy
	let lastline = getreg('@')
	if lastline =~? '\s\n$'
		" replace traling whitespace with comma
		execute "normal! :s/\\v\\s+$/,/\<cr>"
	else
		execute "normal! A,\<esc>"
	endif
	let @@ = preserve_reg
endfunction

augroup expand_object
	" expands javascript objects from singleline to multiline
	autocmd!
	autocmd Filetype typescript,javascript nnoremap <leader>e{ :call IndentLevel('{')<cr>
	autocmd Filetype typescript,javascript nnoremap <leader>e[ :call IndentLevel('[')<cr>
	autocmd Filetype typescript,javascript nnoremap <leader>e( :call IndentLevel('(')<cr>
augroup END
" maps for testing
" nnoremap <leader>e{ :call IndentLevel('{')<cr>
" nnoremap <leader>e[ :call IndentLevel('[')<cr>
" nnoremap <leader>e( :call IndentLevel('(')<cr>
" }}}
" ExpandObject {{{
function! ExpandObject()
	let preserve_reg = @@
	let line = getline(".")
	let split1 = split(line, "{")
	let import_part = split1[0]
	let split2 = split(split1[1], "}")
	let path_part = split2[1]
	let import_list = split(split2[0], ",")
	normal! dd
	put! =import_part . \"{\"
	for i in import_list
		let item = substitute(i, '\v\s+$', "", "vg")
		put =item
		execute "normal! I\<tab>\<esc>A,\<esc>"
	endfor
	put =\"}\" . path_part
	let @@ = preserve_reg
endfunction
" }}}

