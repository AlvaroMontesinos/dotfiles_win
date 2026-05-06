" =============================================================================
" VsVim Configuration - Organized (Inspired by IdeaVim Setup)
" =============================================================================

" Reload config
" :vsc VsVim.ReloadVimRc

" =============================================================================
" Basic Settings
" =============================================================================
set number
set relativenumber
set scrolloff=5

set ignorecase
set smartcase
set incsearch

let mapleader = " "

" =============================================================================
" Insert Mode
" =============================================================================
imap jk <Esc>
imap kj <Esc>

" Smart tab (tab out)
inoremap <expr> <Tab> search('\%#[]>)}''"`]', 'n') ? '<Right>' : '<Tab>'

" =============================================================================
" Clipboard Operations
" =============================================================================
set clipboard=unnamed

" Yank to system clipboard
nnoremap yy "+yy
vnoremap y "+ygv<esc>

" =============================================================================
" Navigation & Scrolling
" =============================================================================
" Centered scrolling
nnoremap D <C-d>zz
nnoremap S <C-u>zz
vnoremap D <C-d>zz
vnoremap S <C-u>zz

" Delete to end of line
nnoremap Z d$

" Tabs navigation (like IdeaVim)
nnoremap L :vsc Window.NextDocumentWindow<CR>
nnoremap H :vsc Window.PreviousDocumentWindow<CR>

" =============================================================================
" Editing Behavior
" =============================================================================
" Change without yanking
nnoremap c "_c
vnoremap c "_c
nnoremap C "_C
vnoremap C "_C

" =============================================================================
" Search & Find
" =============================================================================
nnoremap // :vsc Edit.Find<CR>
nnoremap <leader>fp :vsc Edit.FindInFiles<CR>

" References
nnoremap U :vsc Edit.FindAllReferences<CR>

" =============================================================================
" Code Navigation (Core IDE Actions)
" =============================================================================
nnoremap gd :vsc Edit.GoToDefinition<CR>
nnoremap gi :vsc Edit.GoToImplementation<CR>
nnoremap gr :vsc Edit.FindAllReferences<CR>

" =============================================================================
" Formatting & Execution
" =============================================================================
nnoremap <leader>f :vsc Edit.FormatDocument<CR>

" Debug
nnoremap <leader>d :vsc Debug.Start<CR>
nnoremap <leader>s :vsc Debug.StopDebugging<CR>

" Run (sin debug)
nnoremap <leader>r :vsc Debug.StartWithoutDebugging<CR>

" =============================================================================
" File & Explorer
" =============================================================================
nnoremap <leader>e :vsc View.SolutionExplorer<CR>

" =============================================================================
" Window Management
" =============================================================================
" Close all
nnoremap <C-S-a> :vsc Window.CloseAllDocuments<CR>

" Close current
nnoremap <S-x> :vsc Window.CloseDocumentWindow<CR>

" Toggle UI
nnoremap zz :vsc Window.HideAllToolWindows<CR>
nnoremap zZ :vsc Window.ShowAllToolWindows<CR>

" =============================================================================
" Terminal
" =============================================================================
nnoremap T :vsc View.Terminal<CR>

" =============================================================================
" Comments (VsVim replacement of vim-commentary)
" =============================================================================
nnoremap gcc :vsc Edit.ToggleLineComment<CR>
vnoremap gcc :vsc Edit.ToggleLineComment<CR>

" =============================================================================
" Bookmarks
" =============================================================================
nnoremap mm :vsc Edit.ToggleBookmark<CR>
nnoremap ]b :vsc Edit.NextBookmark<CR>
nnoremap [b :vsc Edit.PreviousBookmark<CR>
nnoremap Bs :vsc View.BookmarkWindow<CR>

" =============================================================================
" AceJump / EasyMotion (PeasyMotion)
" =============================================================================
" Similar to AceJump / Sneak from IdeaVim

" Global jump
nnoremap f :vsc Tools.InvokePeasyMotion<CR>F

" 1-char / 2-char
" nnoremap FF :vsc Tools.InvokePeasyMotionOneCharJump<CR>
nnoremap F  :vsc Tools.InvokePeasyMotionTwoCharJump<CR>

" Word navigation
nnoremap wf :vsc Tools.InvokePeasyMotionLineJumpToWordBegining<CR>
nnoremap ef :vsc Tools.InvokePeasyMotionLineJumpToWordEnding<CR>

" Line navigation
nnoremap lf :vsc Tools.InvokePeasyMotionJumpToLineBegining<CR>

" Visual selection jump
nnoremap sf :vsc Tools.InvokePeasyMotionTextSelect<CR>

" Tabs jump
nnoremap tf :vsc Tools.InvokePeasyMotionJumpToDocumentTab<CR>

" =============================================================================
" Extra Utilities (Added - Non-breaking Enhancements)
" =============================================================================



" Rename (IdeaVim cr equivalent)
nnoremap cr :vsc Refactor.Rename<CR>
vnoremap cr :vsc Refactor.Rename<CR>

nnoremap cs :vsc Refactor.ChangeSignature<CR>
vnoremap cs :vsc Refactor.ChangeSignature<CR>



" Recent files
" tmp nnoremap fr :vsc File.OpenFile<CR>


"<s-p >
"nmap <S-p> :vsc View.NavigateBackward<CR>
"nmap <S-n> :vsc View.NavigateForward<CR>
nmap <C-o> :vsc View.NavigateBackward<CR>
nmap <C-i> :vsc View.NavigateForward<CR>


nnoremap ]] :vsc Edit.NextMethod<CR>
nnoremap [[ :vsc Edit.PreviousMethod<CR>


" finder fzz
nnoremap na :vsc View.NavigateTo<CR>

" go to last changes g if is vsc
nnoremap ]c :vsc Diff.NextDifference<CR>
nnoremap [c :vsc Diff.PreviousDifference<CR>


nnoremap fs :vsc View.ViewTypeHierarchy<CR>

" Plugin recomendado: ReSharper (JetBrains)
" nnoremap rr :vsc ReSharper.ReSharper_GotoRecentFiles<CR>

nnoremap <leader>pi :vsc Edit.ShowParameterInfo<CR>


" Quick actions (fix + errores)
nnoremap qa :vsc View.QuickActions<CR>




" Docs rápida
nmap qd :vsc Edit.QuickInfo<CR>





" =============================================================================
" Comments (VsVim compatible)
" =============================================================================

" Line comment
nnoremap gcc :vsc Edit.ToggleLineComment<CR>
vnoremap gcc :vsc Edit.ToggleLineComment<CR>

" Block comment
nnoremap gcC :vsc Edit.ToggleBlockComment<CR>
vnoremap gcC :vsc Edit.ToggleBlockComment<CR>

" Comment paragraph
nnoremap gcap vap: vsc Edit.ToggleLineComment<CR>
nnoremap gcip vip: vsc Edit.ToggleLineComment<CR>

	




" Show errors (IdeaVim <leader>d alt)
nnoremap <leader>er :vsc View.ErrorList<CR>

" Navigate errors
nnoremap ]e :vsc View.NextError<CR>
nnoremap [e :vsc View.PreviousError<CR>


" Solution explorer
nnoremap <leader>ew :vsc View.SolutionExplorer<CR>





vnoremap // :vsc Edit.Find<CR>
nnoremap // :vsc Edit.Find<CR>




" =============================================================================
" ESC behavior - Always return focus to editor
" =============================================================================

nnoremap <Esc> :vsc View.ActivateDocumentWindow<CR>
vnoremap <Esc> <Esc>:vsc View.ActivateDocumentWindow<CR> 


" =============================================================================
" Shift+Esc → cerrar terminal + foco editor
" =============================================================================
nnoremap <S-Esc> :vsc Window.CloseToolWindow<CR>

	

" =============================================================================
" Debug / History / Navigation (VsVim compatible)
" =============================================================================

" Breakpoint
nnoremap <leader>db :vsc Debug.ToggleBreakpoint<CR>

" File / Git history
nnoremap <leader>vlc :vsc Team.ViewHistory<CR>

" Navegación tipo cambios recientes
nmap <leader>vc :vsc View.NavigateBackward<CR>

" Call hierarchy
nnoremap <leader>ch :vsc View.CallHierarchy<CR>

" Hide all panels
nnoremap zz :vsc Window.HideAllToolWindows<CR>



sethandler <S-Esc> a:vim

