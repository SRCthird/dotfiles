local wezterm = require 'wezterm'
local utf8 = require 'utf8'

local system_os = (function()
  local BinaryFormat = package.cpath:match("%p[\\|/]?%p(%a+)")
  if BinaryFormat == "dll" then
    function os.name()
      return "Windows"
    end
  elseif BinaryFormat == "so" then
    function os.name()
      return "Linux"
    end
  elseif BinaryFormat == "dylib" then
    function os.name()
      return "MacOS"
    end
  end
end)()

wezterm.on('gui-startup', function()
  local tab, pane, window = wezterm.mux.spawn_window({})
  window:gui_window():maximize()
end)

local colors = {
  '#3c1361',
  '#52307c',
  '#663a82',
  '#7c5295',
}
local text_fg = '#c0c0c0'

wezterm.on('update-right-status', function(window, pane)
  local cwd_uri = pane:get_current_working_dir()
  local cwd = ''
  local hostname = wezterm.hostname()

  if cwd_uri then
    if type(cwd_uri) == 'userdata' then
      cwd = cwd_uri.file_path
      hostname = cwd_uri.host or wezterm.hostname()
    else
      cwd_uri = cwd_uri:sub(8)
      local slash = cwd_uri:find '/'
      if slash then
        hostname = cwd_uri:sub(1, slash - 1)
        cwd = cwd_uri:sub(slash):gsub('%%(%x%x)', function(hex)
          return string.char(tonumber(hex, 16))
        end)
      end
    end

    local dot = hostname:find('[.]')
    if dot then
      hostname = hostname:sub(1, dot - 1)
    end
    if hostname == '' then
      hostname = wezterm.hostname()
    end
  end

  local date = wezterm.strftime '%a %-d-%b %H:%M'

  local battery_power = ''
  local battery_icon = ''
  for _, b in ipairs(wezterm.battery_info()) do
    battery_power = string.format('%.0f%%', b.state_of_charge * 100)
    if b.state_of_charge == 1 then
      battery_icon = '  '
    elseif b.state_of_charge > .75 then
      battery_icon = '  '
    elseif b.state_of_charge > 50 then
      battery_icon = '  '
    elseif b.state_of_charge > 25 then
      battery_icon = '  '
    else
      battery_icon = '  '
    end
  end

  local SOLID_LEFT_ARROW = utf8.char(0xe0b2)

  window:set_right_status(wezterm.format({
    { Foreground = { Color = colors[1] } },
    { Background = { Color = colors[4] } },
    { Text = SOLID_LEFT_ARROW },
    { Foreground = { Color = text_fg } },
    { Background = { Color = colors[1] } },
    { Text = "  " .. cwd .. " " },
    { Foreground = { Color = colors[2] } },
    { Text = SOLID_LEFT_ARROW },
    { Foreground = { Color = text_fg } },
    { Background = { Color = colors[2] } },
    { Text = " 󰃭 " .. date .. " " },
    { Foreground = { Color = colors[3] } },
    { Text = SOLID_LEFT_ARROW },
    { Foreground = { Color = text_fg } },
    { Background = { Color = colors[3] } },
    { Text = "  " .. hostname .. " " },
    { Foreground = { Color = colors[4] } },
    { Text = SOLID_LEFT_ARROW },
    { Foreground = { Color = text_fg } },
    { Background = { Color = colors[4] } },
    { Text = battery_icon .. battery_power .. " " },
  }))
end)

local config                          = wezterm.config_builder()
if system_os == "Windows" then
  config.win32_system_backdrop        = 'Acrylic'
  config.default_prog                 = {
                                          "pwsh",
                                          "-NoExit",
                                        }
elseif system_os == "MacOS" then
  config.macos_window_background_blur = '20'
elseif system_os == "Linux" then
  -- Use blur-my-shell for Gnome
end
config.color_scheme                   = 'Atelierforest (dark) (terminal.sexy)'
config.font                           = wezterm.font('FiraCode Nerd Font', { weight = "Regular" })
config.font_size                      = 11
config.line_height                    = 1
config.window_decorations             = "INTEGRATED_BUTTONS|RESIZE"
config.window_background_opacity      = 0.3
config.use_fancy_tab_bar              = false
config.colors                         = {
                                          tab_bar = {
                                            active_tab = {
                                              bg_color = colors[1],
                                              fg_color = text_fg,
                                            },
                                            inactive_tab = {
                                              bg_color = colors[2],
                                              fg_color = text_fg,
                                            },
                                            inactive_tab_hover = {
                                              bg_color = colors[3],
                                              fg_color = text_fg,
                                              italic = true,
                                            },
                                            new_tab = {
                                              bg_color = colors[4],
                                              fg_color = text_fg,
                                            },
                                            new_tab_hover = {
                                              bg_color = colors[3],
                                              fg_color = text_fg,
                                              italic = true,
                                            },
                                            background = colors[4],
                                          },
                                        }
config.keys                      = {
                                      {
                                        key = 'R',
                                        mods = "CTRL|SHIFT",
                                        action = wezterm.action.ReloadConfiguration
                                      },
                                      -- Split panes
                                      {
                                        key = "L",
                                        mods = "CTRL|SHIFT",
                                        action = wezterm.action { SplitHorizontal = { domain = "CurrentPaneDomain" } }
                                      },
                                      {
                                        key = "K",
                                        mods = "CTRL|SHIFT",
                                        action = wezterm.action { SplitVertical = { domain = "CurrentPaneDomain" } }
                                      },

                                      -- Pane navigation
                                      {
                                        key = "LeftArrow",
                                        mods = "ALT",
                                        action = wezterm.action { ActivatePaneDirection = "Left" }
                                      },
                                      {
                                        key = "RightArrow",
                                        mods = "ALT",
                                        action = wezterm.action { ActivatePaneDirection = "Right" }
                                      },
                                      {
                                        key = "UpArrow",
                                        mods = "ALT",
                                        action = wezterm.action { ActivatePaneDirection = "Up" }
                                      },
                                      {
                                        key = "DownArrow",
                                        mods = "ALT",
                                        action = wezterm.action { ActivatePaneDirection = "Down" }
                                      },

                                      -- New tab
                                      {
                                        key = "T",
                                        mods = "CTRL|SHIFT",
                                        action = wezterm.action { SpawnTab = "CurrentPaneDomain" }
                                      },

                                      -- Tab navigation
                                      {
                                        key = "Tab",
                                        mods = "CTRL",
                                        action = wezterm.action { ActivateTabRelative = 1 }
                                      },
                                      {
                                        key = "Tab",
                                        mods = "CTRL|SHIFT",
                                        action = wezterm.action { ActivateTabRelative = -1 }
                                      },
                                    }

return config
