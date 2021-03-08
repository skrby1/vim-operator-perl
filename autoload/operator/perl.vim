function! operator#perl#do(motion_wise)
	let l:opt = input('Option(ex:-F''\s'' -al): ', '-pe')
	let l:rex = input('Cmd or File: ', '', 'custom,LSLIB')
	let l:aug = input('ARGV: ')

  if l:rex != ''
    "echoerr a:motion_wise
    let @0 = ''
    let l:v = operator#user#visual_command_from_wise_name(a:motion_wise)
    execute 'normal! ' . '`[' . l:v . '`]y'
    let l:reg = @0
    if l:aug == 'D'
      let l:opt = '-C3 -Mutf8 -Dtls '. l:opt
    else
      let l:opt = '-C3 -Mutf8 '. l:opt
    endif

    if l:opt[-1:] != 'e'
      let l:rex = g:opeperllib. l:rex
      if l:rex[-3:] != '.pl'
        let l:rex .= '.pl'
      endif
    else
      let l:aug = '-- '. l:aug
    endif

"    let l:rex = escape(l:rex, '"!$#')
    let l:sys = "echo -n ". shellescape(l:reg). " | perl ". l:opt. " '". l:rex. "' ". l:aug
"    echoerr l:sys
    call setreg('0', system(l:sys))
    let l:ai = &autoindent
    let l:si = &smartindent
    set noautoindent nosmartindent
    if match(getreg('0'), '\n') != -1
      execute 'normal' '`['. l:v. '`]"0p`]'
    else
      execute 'normal' '`['. l:v. '`]"0gp'
    endif
    let &autoindent = l:ai
    let &smartindent = l:si
  endif
endfunction

function! LSLIB(A,L,P)
  return system('ls '. g:opeperllib)
endfunction
