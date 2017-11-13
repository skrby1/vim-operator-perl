function! operator#perl#do(motion_wise)
	let l:opt = input('Option(ex:-F''\s'' -al): ', '-pe')
	let l:rex = input('Cmd or File: ', '', 'custom,LSLIB')
	let l:aug = input('ARGV: ')

	let l:v = operator#user#visual_command_from_wise_name(a:motion_wise)
	execute 'normal!' '`[' . l:v . '`]y'
	let l:reg = escape(@0, '!"$\')
  let l:test = "echo -n \"". l:reg. "\" | perl -ne 'BEGIN{$a=0}; tr/\t\n/ /; $a=1 if m/[^[:ascii:][:punct:]]/g; END{print\"$a\"}'"
  if system(l:test)
    let l:opt = '-CIO '. l:opt
  endif
  if l:opt[-1:] != 'e'
    let l:rex = g:opeperllib. l:rex
    if l:rex[-3:] != '.pl'
      let l:rex .= '.pl'
    endif
  else
    let l:aug = '-- '. l:aug
  endif
	let l:rex = escape(l:rex, '!"$\')
  if match(l:rex, 'dict.pl') != -1
    let l:opt = substitute(l:opt, "-CIO ", '', '')
  endif

	let l:sys = "echo -n \"". l:reg. "\" | perl ". l:opt. " \"". l:rex. "\" ". l:aug
	call setreg('0', system(l:sys))
	let l:ai = &autoindent
	let l:si = &smartindent
	set noautoindent nosmartindent
  if match(getreg('0'), '\n') != -1
  	execute 'normal' '`['. l:v. '`]"0p\p=`]'
  else
  	execute 'normal' '`['. l:v. '`]"0gp'
  endif
	let &autoindent = l:ai
	let &smartindent = l:si
endfunction

function! LSLIB(A,L,P)
  return system('ls '. g:opeperllib)
endfunction
