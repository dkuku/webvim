
function! InstallYCM(info)
  if a:info.status == 'installed' || a:info.force
    !./install.py
    !cd ./third_party/ycmd/third_party/tern_runtime && npm install
  endif
endfunction

" Start plugins definition
call plug#begin($HOME.'/.vim/plugins/plugged')

Plug 'scrooloose/nerdtree',                        | Plug 'https://gist.github.com/1f40e70e615f2fa2212bf5423662277d.git', { 'dir' : g:vimDir . '/nerdtree_plugin' }

Plug 'scrooloose/nerdcommenter',
Plug 'goatslacker/mango.vim',
Plug 'bling/vim-airline',                         { 'do' : $HOME.'/.vim/fonts/install' }
Plug 'vim-dist/PaperColor.vim',
Plug 'tpope/vim-fugitive',
Plug 'airblade/vim-gitgutter',
Plug 'editorconfig/editorconfig-vim',
Plug 'bronson/vim-trailing-whitespace',
Plug 'scrooloose/syntastic',
Plug 'junegunn/vim-easy-align',
"Plug 'terryma/vim-multiple-cursors',
Plug 'maksimr/vim-jsbeautify',                    { 'do' : 'git submodule update --init --recursive && npm install' }
Plug 'maxbrunsfeld/vim-yankstack',
Plug 'tpope/vim-surround',
Plug 'elzr/vim-json',
Plug 'othree/yajs.vim',
Plug 'othree/javascript-libraries-syntax.vim',
Plug 'hail2u/vim-css3-syntax',
Plug 'cakebaker/scss-syntax.vim',
Plug 'othree/html5.vim',
Plug 'Valloric/YouCompleteMe',                    { 'do': function('InstallYCM') }
Plug 'moll/vim-node',
Plug 'syngan/vim-vimlint',
Plug 'ynkdir/vim-vimlparser',
Plug 'mattn/emmet-vim',
Plug 'leafgarland/typescript-vim'
Plug 'thaerkh/vim-indentguides'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'othree/javascript-libraries-syntax.vim'
Plug 'claco/jasmine.vim'
Plug 'scrooloose/syntastic'
Plug 'honza/vim-snippets'
Plug 'matthewsimo/angular-vim-snippets'
Plug 'SirVer/ultisnips'
Plug 'Raimondi/delimitMate'
Plug 'python-mode/python-mode', { 'branch': 'develop' }
Plug 'vimwiki/vimwiki'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-haml'
Plug 'tpope/vim-endwise'
Plug 'ervandew/supertab'
Plug 'ctrlpvim/ctrlp.vim'
"Dictionaries
Plug 'ryuzee/vim-ruby-dict'
Plug 'guileen/vim-node-dict'
Plug 'rkulla/pydiction'

call plug#end()
