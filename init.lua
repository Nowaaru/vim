--[[ rmdr: vim.opt/vim.o is for `set`, vim.g is for `let` ]] --

-- Globals
local dir_config = vim.fn.stdpath('config')
local initLua    = dir_config .. "/init.lua";
local initVim    = dir_config .. "/nv.vim";
local initCoc    = dir_config .. "/coc.vim";

math.randomseed(os.time())

-- General QOL Vim things [set]
vim.o.tabstop        = 8;
vim.o.shiftwidth     = 4;
vim.o.softtabstop    = 4;
vim.o.splitright     = true;
vim.o.splitbelow     = true;
vim.o.expandtab      = true;
vim.o.fileformat     = "unix";
vim.o.clipboard      = "unnamed";
vim.o.mouse          = "a";

-- General QOL Vim things [let]
vim.g.mapleader   = " ";

-- COC Compatibility
vim.o.updatetime  = 100;
vim.o.signcolumn  = "yes";

-- Timeout length
vim.o.timeoutlen  = 250

require('packer').startup(function(Plug)
    do
        Plug('wbthomason/packer.nvim');

        do -- Neotree
            Plug('nvim-lua/plenary.nvim');

            Plug('kyazdani42/nvim-web-devicons', {
                ["do"] = function()
                    require('nvim-web-devicons').setup({
                        default = true
                    });
                end
            });

            Plug('MunifTanjim/nui.nvim');

            Plug('nvim-neo-tree/neo-tree.nvim', {
                branch = 'v2.x',
                config = function()
                    require("neo-tree").setup({
                        close_if_last_window = false,
                        filesystem = {
                            hijack_netrw_behavior = "open_default",
                            follow_current_file = true,
                        }
                    })
                end
            });
        end

        do -- Treesitter
            Plug('nvim-treesitter/nvim-treesitter', {
                ["do"] = ":TSUpdate"
            });

            Plug("windwp/nvim-ts-autotag");
            Plug("ZhiyuanLck/smart-pairs");
            Plug("JoosepAlviste/nvim-ts-context-commentstring");
            Plug("ethanholz/nvim-lastplace");
        end

        do -- WakaTime
            Plug('wakatime/vim-wakatime');
        end

        do -- WhichKey
            Plug('b0o/mapx.nvim');
            Plug('folke/which-key.nvim');
        end

        do -- Cursorline
            Plug('RRethy/vim-illuminate');
        end

        do -- Dashboard
            Plug('glepnir/dashboard-nvim');
            Plug('nvim-telescope/telescope.nvim');
        end

        do -- Lualine and Tabline
            Plug('feline-nvim/feline.nvim');
            Plug('nanozuki/tabby.nvim');
        end

        do -- vim-focus
            Plug("beauwilliams/focus.nvim");
            Plug("folke/twilight.nvim");
        end

        do -- Themes
            Plug("EdenEast/nightfox.nvim");
        end

        do -- Autocomplete
            Plug("neoclide/coc.nvim", {
                branch = "release",
            });
        end

        do -- Notifications
            Plug('rcarriga/nvim-notify')
        end

        do -- LazyGit
            Plug('lewis6991/gitsigns.nvim');
            Plug("kdheepak/lazygit.nvim");
        end

        do -- Plugins from the Pope of Tea
            Plug('tpope/vim-surround');
            Plug('tpope/vim-commentary');
            Plug('tpope/vim-sensible');
        end

        do -- Discord Integration
            Plug("andweeb/presence.nvim");
        end

        do -- Scrolling
            Plug("petertriho/nvim-scrollbar");
            Plug("declancm/cinnamon.nvim");
        end

        do -- Terminals
            Plug("akinsho/toggleterm.nvim", {
                tag = "v2.*";
            });
        end

        do -- Formatting
            Plug("mcauley-penney/tidy.nvim");
        end
    end
end)
-- Setup Modules
local succ, err = pcall(function()
    -- This must be first for plugin error handling.
    do -- WhichKey
        local whichKey = require("which-key");
        require("mapx").setup({
            global = "force"
        });

        -- General utility mappings
        local mappings = {
            ["<C-Up>"] = "<C-w>k",
            ["<C-Down>"] = "<C-w>j",
            ["<C-Left>"] = "<C-w>h",
            ["<C-Right>"] = "<C-w>l",
            ["<S-l>"] = ":tabnext<cr>",
            ["<S-h>"] = ":tabprev<cr>",
            ["<S-k>"] = "<Nop>",
            ["<S-j>"] = "<Nop>",
            ["<F12>"] = ":call CocActionAsync(\"jumpDefinition\")<cr>",
            ["q:"] = "<Nop>",
        }

        for i, v in pairs(mappings) do
            nnoremap(i, v, "silent");
            vnoremap(i, v, "silent");
        end

        whichKey.setup({
            key_labels = {
                ["<space>"] = "SPC",
                ["<leader>"] = "SPC",
                ["<cr>"] = "ETR",
                ["<tab>"] = "TAB",
            },
            window = {
                border = "single",
            }
        });

        whichKey.register({
            Q = { ":qa!<cr>", "Close Vim", },
            q = { ":q<cr>", "Close Window" },
            d = {
                name = "Dashboard",
                d = { ":Dashboard<cr>", "Open Dashboard" },
                f = { ":Telescope find_files find_command=rg,--hidden,--files<cr>", "Open File Finder" },
                b = { ":Telescope file_browser <cr>", "Open File Browser" },
                w = { ":Telescope live_grep<cr>", "Find file via word" },
            },
            o = { ":Neotree focus<cr>", "Focus Neotree" },
            h = { ":noh<cr>", "Remove Highlight" },
            c = { ":tabclose<cr>", "Close Tab" },
            g = {
                name = "GitHub",
                g = { ":LazyGit<cr>", "Open LazyGit" },
                c = { ":LazyGitConfig<cr>", "Open LazyGit Config" },
            },
            n = {
                name = "NVim",
                u = { ":PackerUpdate<cr>", "Update Packer" },
                C = { ":PackerClean<cr>y<cr>", "Cleanup Packer" },
                i = { ":PackerInstall<cr>", "Install Plugins" },
                c = { ":tabnew " .. initLua .. "<cr>", "Open init.lua" },
                v = { ":tabnew " .. initVim .. "<cr>", "Open nv.vim" },
                r = {
                    function()
                        vim.cmd("source " .. initLua);
                        print("Reloaded!")
                    end, "Reload NoireVim"
                },
            },
            s = {
                name = "Splits",
                l = { ":FocusSplitLeft<cr>", "Split Left" },
                r = { ":FocusSplitRight<cr>", "Split Right" },
                j = { ":FocusSplitDown<cr>", "Split Down" },
                k = { ":FocusSplitUp<cr>", "Split Up" },
                e = { ":FocusEqualise<cr>", "Equalize" },
                m = { ":FocusMaxOrEqual<cr>", "Maximize / Minimize" },
                c = { ":FocusSplitNicely<cr>", "Create New Split" },
                ["<Right>"] = { ":FocusSplitCycle<cr>", "Cycle Split" },
                ["<Left>"] = { ":FocusSplitCycle reverse<cr>", "Cycle Split (counter-clockwise)" },
            },
            w = { ":w!<cr>", "Save File", },
            b = {
                name = "Buffer",
                d = { ":bd!<cr>", "Close Buffer" },
            },
            f = {
                name = "File",
                s = { ":w!<cr>", "Save File", },
                n = { ":enew<cr>", "New File", },
                c = { ":bd<cr>", "Close File", },
                t = { ":tabnew<cr>", "New Tab" },
            },
            t = {
                f = { ":ToggleTerm direction=float<cr>", "Toggle Floating Terminal" },
                h = { ":ToggleTerm direction=horizontal<cr>", "Open Horizontal Terminal" },
                v = { ":ToggleTerm direction=vertical<cr>", "Open Vertical Terminal" },
                t = { ":ToggleTerm direction=tab<cr>", "Open Terminal Tab" },
            },
            l = {
                name = "Language Server Protocol",
                h = { ":call CocActionAsync('doHover')<cr>", "Trigger Symbol Hover", silent = true },
                f = { ":call CocAction('format')<cr>", "Format", silent = true },
                o = { ":call CocAction('organizeImport')<cr>:call CocAction('format')<cr>", "Organize Imports",
                    silent = true },
                r = { ":CocRestart<cr>", "Restart CoC", silent = true },
                d = { ":CocDiagnostics<cr>", "Open Diagnostics", silent = true },
                c = { ":tabnew +CocConfig<cr>", "Open CoC Config", silent = true },
                u = { ":CocUpdate<cr>", "Update CoC Plugins", silent = true },
            }
        }, {
            prefix = "<leader>"
        });
    end

    do -- vim-focus
        require("focus").setup();
        require("twilight").setup();
    end

    do -- TreeSitter
        require("nvim-lastplace");
        require("nvim-treesitter.configs").setup({
            autotag = {
                enable = true
            },
            context_commentstring = {
                enable = true
            },
            auto_install = true,
        });
    end

    do -- Dashboard
        local dashboard = require('dashboard');
        local dashboardIcons = dofile(dir_config .. "/dashboard/dashboard.lua");
        local dashboardPhrases = dofile(dir_config .. "/dashboard/flavor.lua");

        local randomIcon = true;
        local randomPhrase = true;

        local selectedIcon = "kyoko";
        local selectedPhrase = 1;

        if (randomIcon) then
            local allIcons = {};
            for i, _ in pairs(dashboardIcons) do
                allIcons[#allIcons + 1] = i;
            end

            selectedIcon = allIcons[math.random(1, #allIcons)];
        end

        if (randomPhrase) then
            selectedPhrase = math.random(1, #dashboardPhrases)
        end

        local dashboardIcon = { (table.unpack or unpack)(dashboardIcons[selectedIcon]) };
        table.insert(dashboardIcon, 1, " ");
        table.insert(dashboardIcon, 1, "[" .. selectedIcon .. "]")
        table.insert(dashboardIcon, #dashboardIcon + 1, " ")
        table.insert(dashboardIcon, #dashboardIcon + 1, dashboardPhrases[selectedPhrase]);

        dashboard.custom_header = dashboardIcon;
        dashboard.session_directory = dir_config .. "/dashboard/sessions"
        dashboard.custom_center = {
            {
                icon = '  ',
                desc = 'New File                                ',
                shortcut = 'SPC f n',
                action = "DashboardNewFile",
            },
            {
                icon = '  ',
                desc = 'Find File                               ',
                action = 'Telescope find_files find_command=rg,--hidden,--files',
                shortcut = 'SPC d f'
            },
            {
                icon = '  ',
                desc = 'File Browser                            ',
                action = 'Telescope file_browser',
                shortcut = 'SPC d b'
            },
            {
                icon = '  ',
                desc = 'Find Word                               ',
                action = 'Telescope live_grep',
                shortcut = 'SPC d w'
            },
            {
                desc = '------'
            },
            {
                icon = '  ',
                desc = 'Edit NoireVim Config                    ',
                action = function()
                    vim.cmd("DashboardNewFile");
                    vim.cmd("e " .. initLua);
                end,
                shortcut = 'SPC n o'
            }
        }

        local function getTime()
            return { os.date("It is currently %B %d, %Y @ %I:%M %p.", os.time()) }
        end

        -- update footer
        local timer = vim.loop.new_timer()
        dashboard.custom_footer = getTime()
        timer:start(1000, 1000, function()
            dashboard.custom_footer = getTime()
        end)
    end

    do -- Cursorline
        require("illuminate").configure();
    end

    do -- Themes
        require('nightfox').setup({
            dim_inactive = true,
        });

        vim.cmd("colorscheme carbonfox");
    end

    do -- Lualine
        dofile(dir_config .. "/nightfox/feline.lua");
        dofile(dir_config .. "/nightfox/tabby.lua");
    end

    do -- Vim Notify
        vim.notify = require("notify")
    end

    do -- CoC
        vim.cmd("source " .. initCoc);
    end

    do -- NV Config
        vim.cmd("source " .. initVim);
    end

    do -- LazyGit
        require("telescope").load_extension("lazygit");
    end

    do -- Presence
        require("presence"):setup({
            neovim_image_text = "All Hail NVim",
            enable_line_number = true,
        })
    end

    do -- Scrolling
        local cinnamonEnabled = false;
        if (cinnamonEnabled) then
            require("cinnamon").setup({
                extra_keymaps = true,
                extended_keymaps = true,
                horizontal_scroll = true,

                default_delay = 0.5,
                always_scroll = false,
            });
        end

        require("scrollbar").setup();
    end

    do -- Terminals
        require("toggleterm").setup();
    end

    do -- Formatting
        require("tidy").setup();
    end

    do
        local enableReminders = false;
        if (enableReminders) then
            local allReminders = dofile(dir_config .. "/reminders.lua");
            for _, v in pairs(allReminders) do
                local timerLength = v.time * 1000;
                local timerMessages = v.messages;
                local timerTitles = v.title;
                local timer = vim.loop.new_timer();

                timer:start(timerLength, timerLength, function()
                    vim.notify(timerMessages[math.random(1, #timerMessages)], "warn", {
                        title = timerTitles[math.random(1, #timerTitles)]
                    });
                end)
            end
        end
    end
end)

if (not succ) then
    -- print([[
-- An error occured when setting up NVim's plugins.

-- This usually is due to PlugInstall not being called.
-- Please press <SPC>ni to install plugins.


    -- ]])

    print("If this does not help, then here is your error message:\n\n");
    print(err .. "\n\n");
end
