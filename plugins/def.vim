function! InstallYCM(info)
  if a:info.status == 'installed' || a:info.force
    !./install.py
    !cd ./third_party/ycmd/third_party/tern_runtime && npm install
  endif
endfunction

" Start plugins definition
call plug#begin($HOME.'/.vim/plugins/plugged')

Plug 'scrooloose/nerdcommenter',
Plug 'goatslacker/mango.vim',
Plug 'bling/vim-airline',                  { 'do' : $HOME.'/.vim/fonts/install' }
Plug 'vim-dist/PaperColor.vim',
Plug 'tpope/vim-fugitive',
Plug 'airblade/vim-gitgutter',
Plug 'editorconfig/editorconfig-vim',
Plug 'bronson/vim-trailing-whitespace',
"Plug 'scrooloose/syntastic',
Plug 'junegunn/vim-easy-align',
Plug 'maksimr/vim-jsbeautify',                    { 'do' : 'git submodule update --init --recursive && npm install' }
Plug 'maxbrunsfeld/vim-yankstack',
Plug 'tpope/vim-surround',
Plug 'othree/yajs.vim',
Plug 'othree/javascript-libraries-syntax.vim',
Plug 'Valloric/YouCompleteMe',             { 'do': function('InstallYCM') }
Plug 'syngan/vim-vimlint',
Plug 'ynkdir/vim-vimlparser',
Plug 'mattn/emmet-vim',
Plug 'honza/vim-snippets'
Plug 'SirVer/ultisnips'
Plug 'Raimondi/delimitMate'
Plug 'python-mode/python-mode', { 'branch': 'develop' }
"Plug 'terryma/vim-multiple-cursors'
Plug 'janko-m/vim-test'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-repeat'
Plug 'ervandew/supertab'
Plug 'Shougo/denite.nvim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'sheerun/vim-polyglot'
Plug 'w0rp/ale'
Plug 'francoiscabrol/ranger.vim'
Plug 'rbgrouleff/bclose.vim'
Plug 'majutsushi/tagbar'
Plug 'ludovicchabant/vim-gutentags'
Plug 'vimwiki/vimwiki',         { 'branch': 'dev' }
Plug 'tbabej/taskwiki'
Plug 'suan/vim-instant-markdown'
Plug 'powerman/vim-plugin-AnsiEsc'
Plug 'blindFS/vim-taskwarrior'
Plug 'scrooloose/vim-slumlord'
Plug 'aklt/plantuml-syntax'

call plug#end()
