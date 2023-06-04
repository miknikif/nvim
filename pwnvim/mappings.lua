-- We use which-key in mappings, which is loaded before plugins, so set up here
local which_key = require("which-key")
which_key.setup({
  plugins = {
    marks = true,      -- shows a list of your marks on ' and `
    registers = true,  -- shows your registers on " in NORMAL or <C-r> in INSERT mode
    spelling = {
      enabled = true,  -- enabling this will show WhichKey when pressing z= to select spelling suggestions
      suggestions = 20 -- how many suggestions should be shown in the list?
    },
    -- the presets plugin, adds help for a bunch of default keybindings in Neovim
    -- No actual key bindings are created
    presets = {
      operators = true,    -- adds help for operators like d, y, ... and registers them for motion / text object completion
      motions = false,     -- adds help for motions
      text_objects = true, -- help for text objects triggered after entering an operator
      windows = true,      -- default bindings on <c-w>
      nav = true,          -- misc bindings to work with windows
      z = true,            -- bindings for folds, spelling and others prefixed with z
      g = true             -- bindings for prefixed with g
    }
  },
  icons = {
    breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
    separator = "➜", -- symbol used between a key and it's label
    group = "+"       -- symbol prepended to a group
  },
  popup_mappings = {
    scroll_down = "<c-d>", -- binding to scroll down inside the popup
    scroll_up = "<c-u>"    -- binding to scroll up inside the popup
  },
  window = {
    border = "rounded",       -- none, single, double, shadow
    position = "bottom",      -- bottom, top
    margin = { 1, 0, 1, 0 },  -- extra window margin [top, right, bottom, left]
    padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
    winblend = 0
  },
  layout = {
    height = { min = 4, max = 25 }, -- min and max height of the columns
    width = { min = 20, max = 50 }, -- min and max width of the columns
    spacing = 3,                    -- spacing between columns
    align = "left"                  -- align columns left, center or right
  },
  ignore_missing = true,            -- enable this to hide mappings for which you didn't specify a label
  hidden = {
    "<silent>", "<CMD>", "<cmd>", "<Cmd>", "<cr>", "<CR>", "call", "lua",
    "^:", "^ "
  },                -- hide mapping boilerplate
  show_help = true, -- show help message on the command line when the popup is visible
  triggers = "auto" -- automatically setup triggers
  -- triggers = {"<leader>"} -- or specify a list manually
})
-- This file is for mappings that will work regardless of filetype. Always available.
local options = { noremap = true, silent = true }

-- Make F1 act like escape for accidental hits
vim.api.nvim_set_keymap('', '#1', '<Esc>', options)
vim.api.nvim_set_keymap('!', '#1', '<Esc>', options)

-- TODO: try using the WinNew and WinClosed autocmd events with CHADtree filetype
-- to remap #2 to either open or close commands. Or BufDelete, BufAdd, BufWinLeave, BufWinEnter
-- Make F2 bring up a file browser
vim.api.nvim_set_keymap('', '#2', '<cmd>NvimTreeToggle<CR>', options)
vim.api.nvim_set_keymap('!', '#2', '<cmd>NvimTreeToggle<CR>', options)
vim.api.nvim_set_keymap('', '-', '<cmd>NvimTreeFindFile<CR>', options)

-- Make ctrl-p open a file finder
-- When using ctrl-p, screen out media files that we probably don't want
-- to open in vim. And if we really want, then we can use ,ff
vim.api
    .nvim_set_keymap('', '<c-p>', ':silent Telescope find_files<CR>', options)
vim.api.nvim_set_keymap('!', '<c-p>', '<ESC>:silent Telescope find_files<CR>',
  options)

-- Make F4 toggle showing invisible characters
vim.api
    .nvim_set_keymap('', '_z', ':set list<CR>:map #4 _Z<CR>', { silent = true })
vim.api.nvim_set_keymap('', '_Z', ':set nolist<CR>:map #4 _z<CR>',
  { silent = true })
vim.api.nvim_set_keymap('', '#4', '_Z', {})

-- Enter the date on F8
vim.api.nvim_set_keymap('', '#8', '"=strftime("%Y-%m-%d")<CR>P', options)
vim.api.nvim_set_keymap('!', '#8', '<C-R>=strftime("%Y-%m-%d")<CR>', options)

-- Make F9 toggle distraction-free writing setup
vim.api.nvim_set_keymap('', '#9', ':TZAtaraxis<CR>', options)
vim.api.nvim_set_keymap('!', '#9', '<ESC>:TZAtaraxis<CR>', options)

-- Make F10 quicklook. Not sure how to do this best in linux so mac only for now
vim.api.nvim_set_keymap('', '<F10>', ':silent !qlmanage -p "%"<CR>', options)
vim.api.nvim_set_keymap('!', '<F10>', '<ESC>:silent !qlmanage -p "%"<CR>', options)

-- Make F12 restart highlighting
vim.api.nvim_set_keymap('', '<F12>', ':syntax sync fromstart<CR>', options)
vim.api
    .nvim_set_keymap('!', '<F12>', '<C-o>:syntax sync fromstart<CR>', options)

-- Have ctrl-l continue to do what it did, but also temp clear search match highlighting
vim.api.nvim_set_keymap('', '<C-l>', ':<C-u>nohlsearch<CR><C-l>',
  { silent = true })
-- Yank to end of line using more familiar method
vim.api.nvim_set_keymap('', 'Y', 'y$', options)

-- Center screen vertically when navigating by half screens
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Center search hits vertically on screen
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Move visually selected lines up and down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

local global_leader_opts = {
  mode = "n",     -- NORMAL mode
  prefix = "<leader>",
  buffer = nil,   -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true,  -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true   -- use `nowait` when creating keymaps
}
local global_leader_opts_visual = {
  mode = "v",     -- VISUAL mode
  prefix = "<leader>",
  buffer = nil,   -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true,  -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true   -- use `nowait` when creating keymaps
}

local leader_mappings = {
  ["e"] = { "<cmd>NvimTreeToggle<cr>", "Explorer" },
  ["/"] = { "<cmd>nohlsearch<CR>", "No Highlight" },
  ["x"] = { "<cmd>Bdelete!<CR>", "Close Buffer" },
  ["q"] = {
    [["<cmd>".(get(getqflist({"winid": 1}), "winid") != 0? "cclose" : "botright copen")."<cr>"]],
    "Toggle Quicklist"
  },
  f = {
    name = "Find",
    f = { "<cmd>lua require('telescope.builtin').find_files()<CR>", "Files" },
    g = { "<cmd>lua require('telescope.builtin').live_grep()<CR>", "Grep" },
    b = {
      "<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = false})<cr>",
      "Buffers"
    },
    h = { "<cmd>lua require('telescope.builtin').oldfiles()<cr>", "History" },
    q = { "<cmd>lua require('telescope.builtin').quickfix()<cr>", "Quickfix" },
    l = { "<cmd>lua require('telescope.builtin').loclist()<cr>", "Loclist" },
    p = { "<cmd>Telescope projects<cr>", "Projects" },
    k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
    t = {
      "<cmd>lua require('telescope.builtin').grep_string{search = \"^\\\\s*[*-] \\\\[ \\\\]\", previewer = false, glob_pattern = \"*.md\", use_regex = true, disable_coordinates=true}<cr>",
      "Todos" },
    n = { "<Cmd>ZkNotes { match = {vim.fn.input('Search: ')} }<CR>", "Find" },
  },
  -- Quickly change indent defaults in a file
  i = {
    name = "Indent",
    ["1"] = { "<cmd>lua require('pwnvim.options').tabindent()<CR>", "Tab" },
    ["2"] = {
      "<cmd>lua require('pwnvim.options').twospaceindent()<CR>", "Two Space"
    },
    ["4"] = {
      "<cmd>lua require('pwnvim.options').fourspaceindent()<CR>",
      "Four Space"
    },
    r = { "<cmd>%retab!<cr>", "Change existing indent to current with retab" }
  },
  g = {
    name = "Git",
    s = { "<cmd>lua require('telescope.builtin').git_status()<cr>", "Status" },
    b = {
      "<cmd>lua require('telescope.builtin').git_branches()<cr>",
      "Branches"
    },
    c = {
      "<cmd>lua require('telescope.builtin').git_commits()<cr>", "Commits"
    },
    h = { "<cmd>lua require 'gitsigns'.toggle_current_line_blame<cr>", "Toggle Blame" },
    ["-"] = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
    ["+"] = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" }
  },
  n = {
    name = "Notes",
    d = {
      "<cmd>ZkNew { dir = vim.env.ZK_NOTEBOOK_DIR .. '/Calendar', title = os.date('%Y%m%d') }<CR>",
      "New diary"
    },
    e = { "<cmd>!mv \"<cfile>\" \"<c-r>=expand('%:p:h')<cr>/\"<cr>", "Embed file moving to current file's folder" },
    f = { "<Cmd>ZkNotes { match = {vim.fn.input('Search: ') }}<CR>", "Find" },
    g = {
      "<cmd>lua require('pwnvim.plugins').grammar_check()<cr>",
      "Check Grammar"
    },
    h = { "<cmd>edit ~/Notes/Notes/HotSheet.md<CR>", "Open HotSheet" },
    i = {
      c = {
        "<cmd>r!/opt/homebrew/bin/icalBuddy --bullet '* ' --timeFormat '\\%H:\\%M' --dateFormat '' --noPropNames --noCalendarNames --excludeAllDayEvents --includeCals 'IC - Work' --includeEventProps datetime,title,attendees,location --propertyOrder datetime,title,attendees,location --propertySeparators '| |\\n    * |\\n    * | |' eventsToday<cr>",
        "Insert today's calendar" },
      o = { "<cmd>r!gtm-okr goals<cr>", "Insert OKRs" },
      j = {
        "<cmd>r!( (curl -s https://icanhazdadjoke.com/ | grep '\\\"subtitle\\\"') || curl -s https://icanhazdadjoke.com/ ) | sed 's/<[^>]*>//g' | sed -z 's/\\n/ /'<cr>",
        "Insert joke" },
    },
    m = {
      "<cmd>lua require('zk.commands').get('ZkNew')({ dir = vim.fn.input({prompt='Folder: ',default=vim.env.ZK_NOTEBOOK_DIR .. '/Notes/meetings',completion='dir'}), title = vim.fn.input('Title: ') })<CR>",
      "New meeting"
    },
    n = {
      "<Cmd>ZkNew { dir = vim.fn.input({prompt='Folder: ',default=vim.env.ZK_NOTEBOOK_DIR .. '/Notes',completion='dir'}), title = vim.fn.input('Title: ') }<CR>",
      "New"
    },
    o = { "<cmd>ZkNotes<CR>", "Open" },
    t = { "<cmd>ZkTags<CR>", "Open by tag" },
    -- in open note (defined in plugins.lua as local-only shortcuts):
    -- p: new peer note
    -- l: show outbound links
    -- r: show outbound links
    -- i: info preview
  },
  t = {
    name = "Tasks",
    --d = { "<cmd>lua require('pwnvim.tasks').completeTask()<cr>", "Done" },
    d = { function() require('pwnvim.tasks').completeTaskDirect() end, "Done" },
    c = { function() require('pwnvim.tasks').createTaskDirect() end, "Create" },
    s = { function() require('pwnvim.tasks').scheduleTaskPrompt() end, "Schedule" },
    t = { function() require('pwnvim.tasks').scheduleTaskTodayDirect() end, "Today" },
  }
}
local leader_visual_mappings = {
  t = {
    name = "Tasks",
    a = { ':grep "^\\s*[*-] \\[ \\] "<cr>:Trouble quickfix<cr>', "All tasks quickfix" },
    --d = { function() require("pwnvim.tasks").eachSelectedLine(require("pwnvim.tasks").completeTask) end, "Done" },
    d = { ":luado return require('pwnvim.tasks').completeTask(line)<cr>", "Done" },
    s = { require("pwnvim.tasks").scheduleTaskBulk, "Schedule" },
    -- s needs a way to call the prompt then reuse the value
    --t = { function() require("pwnvim.tasks").eachSelectedLine(require("pwnvim.tasks").scheduleTaskToday) end, "Today" },
    t = { ":luado return require('pwnvim.tasks').scheduleTaskToday(line)<cr>", "Today" },
  },
  n = {
    e = { "\"0y:!mv \"<c-r>0\" \"<c-r>=expand('%:p:h')<cr>/\"<cr>", "Embed file moving to current file's folder" },
    f = { ":'<,'>ZkMatch<CR>", "Find Selected" }
  },
  i = leader_mappings.i,
  f = leader_mappings.f,
  e = leader_mappings.e,
  q = leader_mappings.q,
  x = leader_mappings.x
}

which_key.register(leader_mappings, global_leader_opts)
which_key.register(leader_visual_mappings, global_leader_opts_visual)

vim.api.nvim_set_keymap('', '<leader>fd',
  ':silent Telescope lsp_document_symbols<CR>', options)

-- Set cwd to current file's dir
vim.api.nvim_set_keymap('', '<leader>cd', ':cd %:h<CR>', options)
vim.api.nvim_set_keymap('', '<leader>lcd', ':lcd %:h<CR>', options)
-- Debug syntax files
vim.api.nvim_set_keymap('', '<leader>sd',
  [[:echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')<CR>]],
  options)

-- """"""""" Global Shortcuts """""""""""""

vim.api.nvim_set_keymap('', '<D-j>', 'gj', options)
vim.api.nvim_set_keymap('', '<D-4>', 'g$', options)
vim.api.nvim_set_keymap('', '<D-6>', 'g^', options)
vim.api.nvim_set_keymap('', '<D-0>', 'g^', options)

-- Bubble lines up and down using the unimpaired plugin
vim.api.nvim_set_keymap('n', '<A-Up>', '[e', options)
vim.api.nvim_set_keymap('n', '<A-Down>', ']e', options)
vim.api.nvim_set_keymap('v', '<A-Up>', '[egv', options)
vim.api.nvim_set_keymap('v', '<A-Down>', ']egv', options)

-- Visually select the text that was last edited/pasted
-- Similar to gv but works after paste
vim.api.nvim_set_keymap('', 'gV', '`[v`]', options)

-- What do these do?
-- inoremap <C-U> <C-G>u<C-U>
-- nnoremap & :&&<CR>
-- xnoremap & :&&<CR>

-- Indent/outdent shortcuts
vim.api.nvim_set_keymap('n', '<D-[>', '<<', options)
vim.api.nvim_set_keymap('v', '<D-[>', '<gv', options)
vim.api.nvim_set_keymap('!', '<D-[>', '<C-o><<', options)
vim.api.nvim_set_keymap('n', '<D-]>', '>>', options)
vim.api.nvim_set_keymap('v', '<D-]>', '>gv', options)
vim.api.nvim_set_keymap('!', '<D-]>', '<C-o>>>', options)
-- keep visual block so you can move things repeatedly
vim.api.nvim_set_keymap('v', "<", "<gv", options)
vim.api.nvim_set_keymap('v', ">", ">gv", options)

-- TODO: this should be in programming setup
-- nmap <D-b> :make<CR>
-- imap <D-b> <C-o>:make<CR>

-- easy expansion of the active directory with %% on cmd
local options_nosilent = { noremap = true, silent = false }

vim.api.nvim_set_keymap('c', '%%', "<c-r>=expand('%:p:h')<cr>/", options_nosilent)

-- gx is a built-in to open URLs under the cursor, but when
-- not using netrw, it doesn't work right. Or maybe it's just me
-- but anyway this command works great.
-- /Users/pwalsh/Documents/md2rtf-style.html
-- ../README.md
-- ~/Desktop/Screen Shot 2018-04-06 at 5.19.32 PM.png
-- [abc](https://github.com/adsr/mle/commit/e4dc4314b02a324701d9ae9873461d34cce041e5.patch)
vim.api.nvim_set_keymap('', 'gx',
  ":silent !open \"<c-r><c-f>\" || xdg-open \"<c-r><c-f>\"<cr>",
  options)
vim.api.nvim_set_keymap('v', 'gx',
  "\"0y:silent !open \"<c-r>0\" || xdg-open \"<c-r>0\"<cr>gv",
  options)
vim.api.nvim_set_keymap('', '<CR>',
  ":silent !open \"<c-r><c-f>\" || xdg-open \"<c-r><c-f>\"<cr>",
  options)
vim.api.nvim_set_keymap('v', '<CR>',
  "\"0y:silent !open \"<c-r>0\" || xdg-open \"<c-r>0\"<cr>gv",
  options)

-- open/close folds with space bar
vim.api.nvim_set_keymap('', '<Space>',
  [[@=(foldlevel('.')?'za':"\<Space>")<CR>]], options)

-- Make nvim terminal more sane
vim.api.nvim_set_keymap('t', '<Esc>', [[<C-\><C-n>]], options)
vim.api.nvim_set_keymap('t', '<M-[>', "<Esc>", options)
vim.api.nvim_set_keymap('t', '<C-v><Esc>', "<Esc>", options)

-- gui nvim stuff
-- Adjust font sizes
vim.api.nvim_set_keymap('', '<D-=>', [[:silent! let &guifont = substitute(
  \ &guifont,
  \ ':h\zs\d\+',
  \ '\=eval(submatch(0)+1)',
  \ '')<CR>]], options)
vim.api.nvim_set_keymap('', '<C-=>', [[:silent! let &guifont = substitute(
  \ &guifont,
  \ ':h\zs\d\+',
  \ '\=eval(submatch(0)+1)',
  \ '')<CR>]], options)
vim.api.nvim_set_keymap('', '<D-->', [[:silent! let &guifont = substitute(
  \ &guifont,
  \ ':h\zs\d\+',
  \ '\=eval(submatch(0)-1)',
  \ '')<CR>]], options)
vim.api.nvim_set_keymap('', '<C-->', [[:silent! let &guifont = substitute(
  \ &guifont,
  \ ':h\zs\d\+',
  \ '\=eval(submatch(0)-1)',
  \ '')<CR>]], options)

-- Need to map cmd-c and cmd-v to get natural copy/paste behavior
vim.api.nvim_set_keymap('n', '<D-v>', '"*p', options)
vim.api.nvim_set_keymap('v', '<D-v>', '"*p', options)
vim.api.nvim_set_keymap('!', '<D-v>', '<C-R>*', options)
vim.api.nvim_set_keymap('c', '<D-v>', '<C-R>*', options)
vim.api.nvim_set_keymap('v', '<D-c>', '"*y', options)
-- When pasting over selected text, keep original register value
vim.api.nvim_set_keymap('v', 'p', '"_dP', options)

-- cmd-w to close the current buffer
vim.api.nvim_set_keymap('', '<D-w>', ':bd<CR>', options)
vim.api.nvim_set_keymap('!', '<D-w>', '<ESC>:bd<CR>', options)

-- cmd-t or cmd-n to open a new buffer
vim.api.nvim_set_keymap('', '<D-t>', ':enew<CR>', options)
vim.api.nvim_set_keymap('!', '<D-t>', '<ESC>:enew<CR>', options)
vim.api.nvim_set_keymap('', '<D-n>', ':tabnew<CR>', options)
vim.api.nvim_set_keymap('!', '<D-n>', '<ESC>:tabnew<CR>', options)

-- cmd-s to save
vim.api.nvim_set_keymap('', '<D-s>', ':w<CR>', options)
vim.api.nvim_set_keymap('!', '<D-s>', '<ESC>:w<CR>', options)

-- cmd-q to quit
vim.api.nvim_set_keymap('', '<D-q>', ':q<CR>', options)
vim.api.nvim_set_keymap('!', '<D-q>', '<ESC>:q<CR>', options)

-- cmd-o to open
vim.api.nvim_set_keymap('', '<D-o>', ':Telescope file_browser cmd=%:h<CR>',
  options)
vim.api.nvim_set_keymap('!', '<D-o>',
  '<ESC>:Telescope file_browser cmd=%:h<CR>', options)

-- emacs bindings to jump around in lines
vim.api.nvim_set_keymap("i", "<C-e>", "<C-o>A", options)
vim.api.nvim_set_keymap("i", "<C-a>", "<C-o>I", options)

-- TODO:
-- Use ctrl-x, ctrl-u to complete :emoji: symbols, then use
-- ,e to turn it into a symbol if desired
-- vim.api.nvim_set_keymap('!', '<leader>e',
--                      [[:%s/:\([^:]\+\):/\=emoji#for(submatch(1), submatch(0))/g<CR>]],
--                     options)

-- Setup tpope unimpaired-like forward/backward shortcuts
which_key.register({
  ["[a"] = "Prev file arg",
  ["]a"] = "Next file arg",
  ["[b"] = { '<Cmd>BufferLineCyclePrev<CR>', "Prev buffer" },
  ["]b"] = { '<Cmd>BufferLineCycleNext<CR>', "Next buffer" },
  ["[c"] = "Prev git hunk",
  ["]c"] = "Next git hunk",
  ["[l"] = "Prev loclist item",
  ["]l"] = "Next loclist item",
  ["[q"] = "Prev quicklist item",
  ["]q"] = "Next quicklist item",
  ["[t"] = { '<Cmd>tabprevious<cr>', "Prev tab" },
  ["[T"] = { '<Cmd>tabprevious<cr>', "First tab" },
  ["]t"] = { '<Cmd>tabnext<cr>', "Next tab" },
  ["]T"] = { '<Cmd>tablast<cr>', "Last tab" },
  ["[n"] = "Prev conflict",
  ["]n"] = "Next conflict",
  ["[ "] = "Add blank line before",
  ["] "] = "Add blank line after",
  ["[e"] = "Swap line with previous",
  ["]e"] = "Swap line with next",
  ["[x"] = "XML encode",
  ["]x"] = "XML decode",
  ["[u"] = "URL encode",
  ["]u"] = "URL decode",
  ["[y"] = "C escape",
  ["]y"] = "C unescape",
  ["[d"] = { "<cmd>lua vim.diagnostic.goto_prev()<CR>", "Prev diagnostic" },
  ["]d"] = { "<cmd>lua vim.diagnostic.goto_next()<CR>", "Next diagnostic" },
  ["[1"] = { ':BufferLineGoToBuffer 1<CR>', "Go to buffer 1" },
  ["]1"] = { ':BufferLineGoToBuffer 1<CR>', "Go to buffer 1" },
  ["[2"] = { ':BufferLineGoToBuffer 2<CR>', "Go to buffer 2" },
  ["]2"] = { ':BufferLineGoToBuffer 2<CR>', "Go to buffer 2" },
  ["[3"] = { ':BufferLineGoToBuffer 3<CR>', "Go to buffer 3" },
  ["]3"] = { ':BufferLineGoToBuffer 3<CR>', "Go to buffer 3" },
  ["[4"] = { ':BufferLineGoToBuffer 4<CR>', "Go to buffer 4" },
  ["]4"] = { ':BufferLineGoToBuffer 4<CR>', "Go to buffer 4" },
  ["[5"] = { ':BufferLineGoToBuffer 5<CR>', "Go to buffer 5" },
  ["]5"] = { ':BufferLineGoToBuffer 5<CR>', "Go to buffer 5" },
  ["[6"] = { ':BufferLineGoToBuffer 6<CR>', "Go to buffer 6" },
  ["]6"] = { ':BufferLineGoToBuffer 6<CR>', "Go to buffer 6" },
  ["[7"] = { ':BufferLineGoToBuffer 7<CR>', "Go to buffer 7" },
  ["]7"] = { ':BufferLineGoToBuffer 7<CR>', "Go to buffer 7" },
  ["[8"] = { ':BufferLineGoToBuffer 8<CR>', "Go to buffer 8" },
  ["]8"] = { ':BufferLineGoToBuffer 8<CR>', "Go to buffer 8" },
  ["[9"] = { ':BufferLineGoToBuffer 9<CR>', "Go to buffer 9" },
  ["]9"] = { ':BufferLineGoToBuffer 9<CR>', "Go to buffer 9" },
  ["<S-h>"] = { ':BufferLineCyclePrev<CR>', "Go to next buffer" },
  ["<S-l>"] = { ':BufferLineCycleNext<CR>', "Go to prev buffer" },

}, { mode = 'n', silent = true })

-- Undotree
vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)

-- Close buffer
vim.api.nvim_set_keymap('', '<D-w>', ':Bdelete<CR>', options)
vim.api.nvim_set_keymap('!', '<D-w>', '<ESC>:Bdelete<CR>', options)
vim.api.nvim_set_keymap('', '<A-w>', ':Bdelete<CR>', options)
vim.api.nvim_set_keymap('!', '<A-w>', '<ESC>:Bdelete<CR>', options)
vim.api.nvim_set_keymap('', '<M-w>', ':Bdelete<CR>', options)
vim.api.nvim_set_keymap('!', '<M-w>', '<ESC>:Bdelete<CR>', options)
-- Magic buffer-picking mode
vim.api.nvim_set_keymap('', '<M-b>', ':BufferPick<CR>', options)
vim.api.nvim_set_keymap('!', '<M-b>', '<ESC>:BufferPick<CR>', options)
vim.api.nvim_set_keymap('', '[0', ':BufferPick<CR>', options)
vim.api.nvim_set_keymap('', ']0', ':BufferPick<CR>', options)
vim.api.nvim_set_keymap('', '[\\', ':BufferPick<CR>', options)
vim.api.nvim_set_keymap('', ']\\', ':BufferPick<CR>', options)

-- Pane navigation integrated with tmux
vim.api.nvim_set_keymap('', '<c-h>', ':TmuxNavigateLeft<cr>', { silent = true })
vim.api.nvim_set_keymap('', '<c-j>', ':TmuxNavigateDown<cr>', { silent = true })
vim.api.nvim_set_keymap('', '<c-k>', ':TmuxNavigateUp<cr>', { silent = true })
vim.api.nvim_set_keymap('', '<c-l>', ':TmuxNavigateRight<cr>', { silent = true })
-- add mapping for :TmuxNavigatePrevious ? c-\, the default, used by toggleterm
