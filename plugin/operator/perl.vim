if exists('g:loaded_operator_perl')
	finish
endif

call operator#user#define('perl', 'operator#perl#do')

let g:opeperllib = expand('<sfile>:p:h:h:h') . '/lib/'

let g:loaded_operator_perl = 1
