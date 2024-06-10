{ pkgs, ... }:
{
  programs.vim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      vim-commentary
      nerdtree
      nerdcommenter
      vim-airline
      vim-airline-themes
      vim-javacomplete2
      tagbar
      vimtex
      vim-code-dark
    ];
    settings = { ignorecase = true; };
    extraConfig = ''
	" Set vim basic
	    :set regexpengine=1
	    :set rnu
	    :set smarttab
	    :set shiftwidth=4
	    :set mouse=a
        :set backspace=2
        :set lazyredraw
        :set spell
        :set modifiable
        :set write
        " Set <Leader> key binding
        :let mapleader=","
        :set timeout timeoutlen=1500
        :set pastetoggle=<F2>

        " Set Key Mapping
        inoremap jj <Esc>

        " Plug import
        call plug#begin()
        Plug 'https://github.com/tpope/vim-commentary'
        Plug 'https://github.com/preservim/nerdtree'
        Plug 'preservim/nerdcommenter'
        Plug 'vim-airline/vim-airline'
        Plug 'vim-airline/vim-airline-themes'
        Plug 'artur-shaik/vim-javacomplete2'
        Plug 'majutsushi/tagbar'
        Plug 'lervag/vimtex'
        Plug 'tomasiser/vim-code-dark'
        Plug 'Valloric/YouCompleteMe'
        Plug 'rust-lang/rust.vim'
        call plug#end()

        " :PlugInstall

        " Require in 'Nerdcommenter'
        filetype plugin on

        " Code Theme Setup
        :colorscheme codedark
        " :colorscheme habamax

        " NERD Tree Setup
        autocmd StdinReadPre * let s:set_in=1
        autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | endif
        nmap <F7> :NERDTreeToggle <CR>
        nmap <F8> :TagbarToggle<CR>
        :let g:NERDTreeWinSize=60
        " :com! -nargs=1 -bar -complete=dir Cd :cd <args> | NERDTreeCWD
        augroup DIRCHANGE
            au!
            autocmd DirChanged global :NERDTreeCWD
        augroup END

        " Go to tab by number
        nnoremap <C-h> :tabprevious<CR>
        nnoremap <C-l> :tabnext<CR>
        nnoremap <C-d> :tabc<CR>

        " Nerdcommenter Setup
        " Create default mappings
        :let g:NERDCreateDefaultMappings = 1
        " Add spaces after comment delimiters by default
        " let g:NERDSpaceDelims = 1
        " Use compact syntax for prettified multi-line comments
        " let g:NERDCompactSexyComs = 1
        " Align line-wise comment delimiters flush left instead of following code indentation
        " let g:NERDDefaultAlign = 'left'
        " Set a language to use its alternate delimiters by default
        " let g:NERDAltDelims_java = 1
        " Add your own custom formats or override the defaults
        " let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }
        " Allow commenting and inverting empty lines (useful when commenting a region)
        " let g:NERDCommentEmptyLines = 1
        " Enable trimming of trailing whitespace when uncommenting
        " let g:NERDTrimTrailingWhitespace = 1
        " Enable NERDCommenterToggle to check all selected lines is commented or not
        " let g:NERDToggleCheckAllLines = 1


        " Airline Theme Setup
        :let g:airline#extensions#tabline#enabled = 1
        :let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
        :set laststatus=2


        " JavaComplete Setup
        autocmd FileType java setlocal omnifunc=javacomplete#Complete
        " inoremap <C-f>  <C-x><C-o>


        " GitGutter Setup
        " autocmd VimEnter * GitGutterLineHighlightsEnable

        " Tagbar   Setup
        set tags=tags
        autocmd VimEnter * Tagbar
        nnoremap <C-n> :tabnew<CR>

        " Disable Copilot at startup
        " :let g:copilot_enabled = 0

        " Compile and Run
        map <F5> :call CompileRunGcc()<CR>
        func! CompileRunGcc()
            exec "w"
            if &filetype == 'c'
	        exec "!gcc -fdiagnostics-color=always % -std=c99 -Wall -o %<"
	        exec "!time ./%<"
            elseif &filetype == 'cpp'
	        exec "!g++ % -o %<"
	        exec "!time ./%<"
            elseif &filetype == 'rust'
	        exec "!cargo build"
	        exec "!time cargo run"
            elseif &filetype == 'java'
	        exec "!javac %"
	        exec "!time java -cp %:p:h %:t:r"
            elseif &filetype == 'sh'
	        exec "!time bash %"
            elseif &filetype == 'python'
	        exec "!time python3 %"
            elseif &filetype == 'racket'
	        exec "!clear"
	        exec "!time racket %"
            elseif &filetype == 'html'
	        exec "!firefox % &"
            elseif &filetype == 'go'
	        exec "!go build %<"
	        exec "!time go run %"
            elseif &filetype == 'mkd'
	        exec "!~/.vim/markdown.pl % > %.html &"
	        exec "!firefox %.html &"
            elseif &filetype == 'haskell'
	        exec "!ghci %"
            elseif &filetype == 'mmix'
	        exec "!mmixal %"
	        exec "!mmix %<.mmo"
	        " exec "!mmix -f% fmt.mmo > temp.mms"
	        " exec "!cat temp.mms > %"
            endif
        endfunc 
    '';
  };
}

