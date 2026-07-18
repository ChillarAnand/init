require "string"

local debug = false

hs.console.clearConsole()

local log = hs.logger.new('init', 'debug')

function log(message)
   if debug then
      hs.alert.show(message)
   end
   print(message)
end


function resize(a, b, c, d)
   local win = hs.window.focusedWindow()
   if (not win) then
      return
   end
   local f = win:frame()
   local screen = win:screen()
   local max = screen:frame()
   f.x = max.x * a
   f.y = max.y * b
   f.w = max.w * c
   f.h = max.h * d
   win:setFrame(f)
   -- win:setFullScreen(true)
end


function finder(appObject)
   log('Finder Automation')
   appObject:selectMenuItem({"Window", "Merge All Windows"})
   appObject:selectMenuItem({"Window", "Bring All to Front"})
end


function excel(appObject)
   log('Excel Automation')
   ticks = {
      {"Data", "Auto-filter"},
      {"Edit", "Select All"},
      {"Format", "Column", "Auto-fit Selection"},
      {"Window", "Freeze Panes"}
   }

   for key, value in pairs(ticks) do
      menuItem = appObject:findMenuItem(value)
      if (not menuItem.ticked) then
         appObject:selectMenuItem(value)
      end
   end
end


function applicationWatcher(appName, eventType, appObject)
   local w = hs.application.watcher
   if (appName == 'Microsoft AutoUpdate' or appName == 'Raycast' or appName =='Alfred' or appName == 'Stats' or appName == 'Microsoft Teams' or appName == 'Windows' or appName == 'Windows App') then
      log('Ignoring ' .. appName)
      return
   end

   if (appName == 'Clocker') then
      log('Ignoring' .. appName)
      return
   end


   -- if (eventType == w.launched) then
   if (eventType == w.activated or eventType == w.launched) then
      log(appName .. ' -> Auto maximising window')
      resize(1, 1, 1, 1)

      -- local w = hs.application.watcher
      if (appName == "Microsoft Excel") then
         excel(appObject)
         resize(1, 1, 1, 1)
      end

      if (appName == "Finder") then
         finder(appObject)
      end

   end
end

appWatcher = hs.application.watcher.new(applicationWatcher)
appWatcher:start()


-- bluetooth sleep
function checkBluetoothResult(rc, stderr, stdout)
   if rc ~= 0 then
      print(string.format("Unexpected result executing `blueutil`: rc=%d stderr=%s stdout=%s", rc, stderr, stdout))
   end
end

function bluetooth(power)
   log("Setting bluetooth to " .. power)
   local t = hs.task.new("/Users/chillaranand/homebrew/bin/blueutil", checkBluetoothResult, {"--power", power})
   t:start()
end

function f(event)
   if event == hs.caffeinate.watcher.systemWillSleep then
      bluetooth("off")
   elseif event == hs.caffeinate.watcher.screensDidWake then
      bluetooth("on")
   end
end

watcher = hs.caffeinate.watcher.new(f)
watcher:start()

-- hs.hotkey.bind({"cmd", "ctrl"}, "R", function()
--    hs.application.launchOrFocus("Raycast")
-- end)

hs.alert.show("HammerSpoon User Config Loaded")

hs.hotkey.bind({"ctrl"}, "2", function()
   hs.eventtap.keyStroke({}, "down")
   hs.eventtap.keyStroke({}, "down")
   hs.eventtap.keyStroke({}, "return")
end)


-- on pressing ctrl+3, send down arrow key 3 times and enter
hs.hotkey.bind({"ctrl"}, "3", function()
   hs.eventtap.keyStroke({}, "down")
   hs.eventtap.keyStroke({}, "down")
   hs.eventtap.keyStroke({}, "down")
   hs.eventtap.keyStroke({}, "return")
end)


hs.hotkey.bind({"ctrl"}, "4", function()
   hs.eventtap.keyStroke({}, "down")
   hs.eventtap.keyStroke({}, "down")
   hs.eventtap.keyStroke({}, "down")
   hs.eventtap.keyStroke({}, "down")
   hs.eventtap.keyStroke({}, "return")
end)


-- Push-to-talk dictation DISABLED: using VoiceInk (local Whisper) which brings
-- its own hold-to-talk hotkey. Re-enable this block only if reverting to macOS
-- dictation. Set the dictation shortcut to Cmd+Ctrl+Alt+D (NOT Cmd+Alt+D — that
-- is macOS "Turn Dock Hiding On/Off"). Fn has no keycode, watch the `fn` flag.
-- local DICT_MODS = {"cmd", "ctrl", "alt"}
-- local DICT_KEY = "d"
-- local pttDown = false
--
-- pttWatcher = hs.eventtap.new({hs.eventtap.event.types.flagsChanged}, function(e)
--    local fn = e:getFlags().fn
--    if fn and not pttDown then
--       pttDown = true
--       hs.eventtap.keyStroke(DICT_MODS, DICT_KEY, 0)   -- start
--    elseif not fn and pttDown then
--       pttDown = false
--       hs.eventtap.keyStroke(DICT_MODS, DICT_KEY, 0)   -- stop
--    end
--    return false
-- end)
-- pttWatcher:start()


-- Define a callback function to be called when application events happen
-- function applicationWatcherCallback(appName, eventType, appObject)
--   if (appName == "Windows App") then
--     if (eventType == hs.application.watcher.activated) then
--       -- Windows App just got focus, disable our hotkeys
--       hotkeys:exit()
--     elseif (eventType == hs.application.watcher.deactivated) then
--       -- Windows App just lost focus, enable our hotkeys
--       hotkeys:enter()
--     end
--   end
-- end