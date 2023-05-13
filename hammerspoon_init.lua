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
end


function finder(appObject)
   log('Finder auto')
   appObject:selectMenuItem({"Window", "Merge All Windows"})
   appObject:selectMenuItem({"Window", "Bring All to Front"})
end

function excel(appObject)
   log('Excel auto')
   ticks = {{"Data", "Auto-filter"}, {"Edit", "Select All"}, {"Format", "Column", "Auto-fit Selection"}}

   for key, value in pairs(ticks) do
      menuItem = appObject:findMenuItem(value)
      if (not menuItem.ticked) then
         appObject:selectMenuItem(value)
      end
   end
end


function applicationWatcher(appName, eventType, appObject)
   local w = hs.application.watcher
   if (appName == 'Microsoft AutoUpdate' or appName == 'Raycast' or appName == 'Stats' or appName == 'Microsoft Teams') then
      log('Ignoring ' .. appName)
      return
   end

   if (eventType == w.activated or eventType == w.launched) then
      log(appName .. ' -> Auto maximising window')
      resize(1, 1, 1, 1)

      local w = hs.application.watcher
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


mappings = {
   B = 'Brave Browser',
   C = 'Google Chrome',
   E = 'Emacs',
   F = 'Finder',
   K = 'KDiff3',
   M = 'Microsoft Teams',
   O = 'Microsoft Outlook',
   P = 'PyCharm',
   T = 'iTerm',
   V = 'Visual Studio Code'
}

for key, app in pairs(mappings) do
   hs.hotkey.bind({"cmd", "ctrl"}, key, function()
         --   hs.alert.show("Focusing " .. app)
         log("Focusing " .. app)
         hs.application.launchOrFocus(app)
   end)
end



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

hs.hotkey.bind({"ctrl", "alt", "cmd"}, "Left", function()
      resize(1, 1, 0.5, 1)
end)
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "Right", function()
      resize(0.5, 1, 0.5, 1)
end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "Up", function()
      resize(1, 1, 1, 1)
end)


-- long press cmd to activate ksheet and disable it on key down
-- local ksheet = hs.loadSpoon("KSheet")
-- ksheet:bindHotkeys({
-- toggle = {{"alt"}, "space"}
-- })


-- bind key to automator script
hs.hotkey.bind({"cmd", "ctrl"}, "k", function()

end)


-- open url in brave
function BraveOpenURL(url)
   log("opening" .. url)
   hs.application.launchOrFocus("Brave Browser")
   -- hs.application:selectMenuItem({"File", "New Tab"})
   hs.eventtap.keyStroke({"cmd"}, "l")
   hs.eventtap.keyStrokes(url)
   hs.eventtap.keyStroke({}, "return")


   -- hs.osascript.javascript([[
   -- (function() {
   --   var brave = Application('Brave');
   --   brave.activate();

   --   for (win of brave.windows()) {
   --     var tabIndex =
   --       win.tabs().findIndex(tab => tab.url().match(/]] .. url .. [[/));

   --     if (tabIndex != -1) {
   --       win.activeTabIndex = (tabIndex + 1);
   --       win.index = 1;
   --     }
   --   }
   -- })()
   -- ]])

end
