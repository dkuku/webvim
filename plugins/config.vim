"
" WebVim Configuration : Plugins configuration
"
" author: Bertrand Chevrier <chevrier.bertrand@gmail.com>
" source: https://github.com/krampstudio/dotvim
" year  : 2015


" TODO split by plugin ?


" [> NERDTree <]

" on vim enter opens nerd tree
function! OpenNerdTree()
    let s:exclude = ['COMMIT_EDITMSG', 'MERGE_MSG']
    if index(s:exclude, expand('%:t')) < 0
        NERDTreeFind
        exec "normal! \<c-w>\<c-w>"
    endif
endfunction
"autocmd VimEnter * call OpenNerdTree()


" nerdtree window resize
let g:NERDTreeWinSize = 35

" show hidden files
let g:NERDTreeShowHidden=1

" single click to open nodes
" let g:NERDTreeMouseMode=3

" ignored files
let g:NERDTreeIgnore=['\.swp$', '\~$']
nnoremap <c-n> :NERDTreeToggle<cr>

" helps quiting when there's no buffers left but NerdTree
function! CheckLeftBuffers()
  if tabpagenr('$') == 1
    let i = 1
    while i <= winnr('$')
      if getbufvar(winbufnr(i), '&buftype') == 'help' ||
          \ getbufvar(winbufnr(i), '&buftype') == 'quickfix' ||
          \ exists('t:NERDTreeBufName') &&
          \   bufname(winbufnr(i)) == t:NERDTreeBufName ||
          \ bufname(winbufnr(i)) == '__Tag_List__'
        let i += 1
      else
        break
      endif
    endwhile
    if i == winnr('$') + 1
      qall
    endif
    unlet i
  endif
endfunction
autocmd BufEnter * call CheckLeftBuffers()


" [> NERDCommenter <]

noremap <c-_> :call NERDComment(0, "Toggle")<cr>


" [> Airline <]

" status line always opened
set laststatus=2

let g:airline#extensions#tabline#enabled = 1

"  powerline font
let g:airline_powerline_fonts=1

let g:airline_theme='PaperColor'

" [> EditorConfig <]

" to avoid issues with fugitive
let g:EditorConfig_exclude_patterns = ['fugitive://.*']


" [> Syntastic <]

"" Syntax checkers

let g:syntastic_check_on_open=1
let g:syntastic_enable_signs=1
let g:syntastic_php_checkers=['php', 'phpcs', 'phpmd']
let g:syntastic_html_checkers=['tidy']
let g:syntastic_vim_checkers=['vimlint']
let g:syntastic_json_checkers=['jsonlint']
let g:syntastic_yaml_checkers=['js-yaml']
let g:syntastic_scss_checkers=['scss-lint']
let g:syntastic_css_checkers=['csslint']
let g:syntastic_handlebars_checkers=['handlebars']
let g:syntastic_tpl_checkers=['handlebars']

" get available js linters
" it returns the mapping between a linter and the config files
function! GetJslinters()
    return {
    \    'eslint' : [ '.eslintrc',  '.eslintrc.json',  '.eslintrc.js', '.eslint.yml' ],
    \    'jshint' : [ '.jshintrc']
    \ }
endfunction

" check if the path to see if a linter config is present
function! Jslinter(path, linters)
    let l:dir = fnamemodify(a:path, ':p:h')

    if(l:dir == '/')
        return ['']
    endif

    for l:linter in keys(a:linters)
        for l:linterConfig in a:linters[l:linter]
            if filereadable(l:dir . '/' . l:linterConfig)
                let l:localLinter = l:dir . '/node_modules/.bin/' . l:linter
                if executable(l:localLinter)
                    return [l:linter, l:localLinter]
                endif
                return [l:linter, l:linter]
            endif
        endfor
    endfor

    return Jslinter(fnamemodify(l:dir, ':h'), a:linters)
endfunction

" set the jslinter into Syntastic
function! SyntasticSetJsLinter()

    let l:availableLinters = GetJslinters()

    " look for linter config in the current folder
    let l:jslinter = Jslinter(expand('%:p'), l:availableLinters)
    if l:jslinter[0] == ''
        " otherwise look into the home dir
        let l:jslinter = Jslinter($HOME, l:availableLinters)
    endif

    " configure the linter
    if l:jslinter[0] != ''
        let g:syntastic_javascript_checkers=[l:jslinter[0]]
        if l:jslinter[0] != l:jslinter[1]
            exec 'let g:syntastic_javascript_' . l:jslinter[0] . '_exec = "' . l:jslinter[1] . '"'
        endif
        let g:syntastic_javascript_checkers=[l:jslinter[0]]
    endif
endfunction

call SyntasticSetJsLinter()

" [> EasyAlign <]

" select paragraph and start easyalign on the left
nnoremap <leader>a vip<Plug>(EasyAlign)<cr>

" Start interactive align to the right
vmap <leader>a <Plug>(EasyAlign)<cr><right>

let g:easy_align_ignore_groups = ['Comment']

" [> multiple cursor <]

let g:multi_cursor_use_default_mapping=0
let g:multi_cursor_next_key='<C-m>'
let g:multi_cursor_prev_key='<C-p>'
let g:multi_cursor_skip_key='<C-x>'
let g:multi_cursor_quit_key='<esc>'

" [> JsBeautify <]

" format selection
autocmd FileType javascript vnoremap <buffer>  <c-f> :call RangeJsBeautify()<cr>
autocmd FileType json vnoremap <buffer>  <c-f> :call RangeJsonBeautify()<cr>
autocmd FileType html vnoremap <buffer> <c-f> :call RangeHtmlBeautify()<cr>
autocmd FileType css vnoremap <buffer> <c-f> :call RangeCSSBeautify()<cr>

" format the whole file
autocmd FileType javascript nnoremap <buffer>  <c-f> :call JsBeautify()<cr>
autocmd FileType json nnoremap <buffer>  <c-f> :call JsonBeautify()<cr>
autocmd FileType html nnoremap <buffer> <c-f> :call HtmlBeautify()<cr>
autocmd FileType css nnoremap <buffer> <c-f> :call CSSBeautify()<cr>

" [> YankStack <]

nmap <leader>p <Plug>yankstack_substitute_older_paste
nmap <leader>P <Plug>yankstack_substitute_newer_paste


" [> Javascript libraries syntax <]

let g:used_javascript_libs = 'jquery,underscore,requirejs,chai,handlebars'



" [> YCM shortcuts <]
"
function! Refactor()
    call inputsave()
    let g:newName = input("Enter the new variable name : ")
    call inputrestore()
    exec ":YcmCompleter RefactorRename " . g:newName
endfunction

nnoremap <leader>gt :YcmCompleter GetType<cr>
nnoremap <leader>gd :YcmCompleter GetDoc<cr>
nnoremap <leader>go :YcmCompleter GoTo<cr>
nnoremap <leader>gf :YcmCompleter GoToDefinition<cr>
nnoremap <leader>gr :YcmCompleter GoToReferences<cr>
nnoremap <leader>r :call Refactor()<cr>

" [> Emmet shortcuts <]
"
au FileType html,css,scss imap <expr>kj  emmet#expandAbbrIntelligent("\<tab>")

nnoremap gm m

"[> Denite <]
" reset 50% winheight on window resize
augroup deniteresize
  autocmd!
  autocmd VimResized,VimEnter * call denite#custom#option('default',
        \'winheight', winheight(0) / 2)
augroup end

call denite#custom#option('default', {
      \ 'prompt': '❯'
      \ })

	" Pt command on grep source
	call denite#custom#var('grep', 'command', ['pt'])
	call denite#custom#var('grep', 'default_opts',
			\ ['--nogroup', '--nocolor', '--smart-case'])
	call denite#custom#var('grep', 'recursive_opts', [])
	call denite#custom#var('grep', 'pattern_opt', [])
	call denite#custom#var('grep', 'separator', ['--'])
	call denite#custom#var('grep', 'final_opts', [])

call denite#custom#map('insert', '<Esc>', '<denite:enter_mode:normal>',
      \'noremap')
call denite#custom#map('normal', '<Esc>', '<NOP>',
      \'noremap')
call denite#custom#map('insert', '<C-v>', '<denite:do_action:vsplit>',
      \'noremap')
call denite#custom#map('normal', '<C-v>', '<denite:do_action:vsplit>',
      \'noremap')
call denite#custom#map('normal', 'dw', '<denite:delete_word_after_caret>',
      \'noremap')

nnoremap <C-p> :<C-u>Denite file_rec<CR>
nnoremap <leader>s :<C-u>Denite buffer<CR>
nnoremap <leader><Space>s :<C-u>DeniteBufferDir buffer<CR>
nnoremap <leader>8 :<C-u>DeniteCursorWord grep:. -mode=normal<CR>
nnoremap <leader>/ :<C-u>Denite grep:. -mode=normal<CR>
nnoremap <leader><Space>/ :<C-u>DeniteBufferDir grep:. -mode=normal<CR>
nnoremap <leader>d :<C-u>DeniteBufferDir file_rec<CR>
nnoremap <leader>r :<C-u>Denite -resume -cursor-pos=+1<CR>
nnoremap <leader>lr :<C-u>Denite references -mode=normal<CR>

hi link deniteMatchedChar Special

" [> vim-test mappings <]
let test#enabled_runners = ["ruby#rspec"]
" make test commands execute using dispatch.vim
let test#strategy = "vimterminal"
nmap <silent> t<C-n> :TestNearest<CR> " t Ctrl+n
nmap <silent> t<C-f> :TestFile<CR>    " t Ctrl+f
nmap <silent> t<C-a> :TestSuite<CR>   " t Ctrl+s
nmap <silent> t<C-l> :TestLast<CR>    " t Ctrl+l
nmap <silent> t<C-g> :TestVisit<CR>   " t Ctrl+g

"[> disable netrw and use ranger <]
let g:ranger_replace_netrw = 1

" vimwiki with markdown support
"let g:vimwiki_ext2syntax = {'.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}
let g:vimwiki_list = [{'path': '~/vimwiki/', 'syntax': 'markdown', 'ext': '.md'}]
" helppage -> :h vimwiki-syntax

" vim-instant-markdown - Instant Markdown previews from Vim
" https://github.com/suan/vim-instant-markdown
let g:instant_markdown_autostart = 0	" disable autostart
map <leader>md :InstantMarkdownPreview<CR>
