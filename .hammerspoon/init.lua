-- https://github.com/ipatch/dotfiles/blob/master/jobs/macos/Users/mr-fancy/hammerspoon/ctrlDoublePress.lua
local timer    = require("hs.timer")
local eventtap = require("hs.eventtap")

local events   = eventtap.event.types
local module   = {}
local spaces = require("hs._asm.undocumented.spaces")

-- double tap の間隔[s]
module.timeFrame = 1

-- デバッグ文字を出力する
-- hs.console.printStyledtext("debug string")

function MoveFullScreenWindow(app)
    local win = app:focusedWindow()
    local mainScreen = hs.screen.find(spaces.mainScreenUUID())
    local winFrame = win:frame()
    local screenFrame = mainScreen:fullFrame()
    winFrame.w = screenFrame.w
    winFrame.h = screenFrame.h * 0.7
    winFrame.y = screenFrame.y
    winFrame.x = screenFrame.x
    win:setFrame(winFrame, 0)

    win:focus()
end

-- double tap で toggle で kitty を表示/非表示する
module.action = function()
    local appName = "kitty"
    local app = hs.application.get(appName)

    -- 一旦動作を止める
    -- if app == nil then
    --     hs.keycodes.setLayout("ABC")
    --     hs.application.launchOrFocus(appName)
    -- elseif app:isFrontmost() then
    --     app:hide()
    -- else -- すでに存在する場合、window を activeSpace に移動させて focus する
    --     hs.keycodes.setLayout("ABC")
    --     MoveFullScreenWindow(app)
    -- end
end


local timeFirstControl, firstDown, secondDown = 0, false, false
local noFlags = function(ev)
    local result = true
    for _, v in pairs(ev:getFlags()) do
        if v then
            result = false
            break
        end
    end
    return result
end

-- control だけ押されているか確認. 例えば shift+control 等は無視するようにする
local onlyCtrl = function(ev)
    local result = ev:getFlags().ctrl
    for k, v in pairs(ev:getFlags()) do
        if k ~= "ctrl" and v then
            result = false
            break
        end
    end
    return result
end


-- module.timeFrame 秒以内に2回 ctrl を押したらダブルタップとみなす
module.eventWatcher = eventtap.new({events.flagsChanged, events.keyDown}, function(ev)
    if (timer.secondsSinceEpoch() - timeFirstControl) > module.timeFrame then
        timeFirstControl, firstDown, secondDown = 0, false, false
    end

    if ev:getType() == events.flagsChanged then
        if noFlags(ev) and firstDown and secondDown then
            if module.action then module.action() end
            timeFirstControl, firstDown, secondDown = 0, false, false
        elseif onlyCtrl(ev) and not firstDown then
            firstDown = true
            timeFirstControl = timer.secondsSinceEpoch()
        elseif onlyCtrl(ev) and firstDown then
            secondDown = true
        elseif not noFlags(ev) then
            timeFirstControl, firstDown, secondDown = 0, false, false
        end
    else
        timeFirstControl, firstDown, secondDown = 0, false, false
    end
    return false
end):start()
