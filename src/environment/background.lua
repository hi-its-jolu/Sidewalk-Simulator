local config = require "config.config"
local helper = require "utils.helper"

local Background = {}
Background.__index = Background

function Background:new(lanes)
    local o = {}
    setmetatable(o, Background)
    o.lanes = lanes
    return o
end

function Background:draw()
    local x, y, width, height = self:calculateSize()
    love.graphics.setColor(config.BackgroundColor)
    love.graphics.rectangle("fill", x, y, width, height)
end

function Background:calculateSize()
    local topLane = self.lanes.lane1
    local backgroundX = 0
    local backgroundY = topLane.y
    local backgroundWidth = topLane.width
    local backgroundHeight = backgroundY

    if config.DebugToggle  then
        print("Background X: " .. backgroundX .. " Y: " .. backgroundY .. " Width: " .. backgroundWidth .. " Height: " .. backgroundHeight)
    end

    return backgroundX,  backgroundY, backgroundWidth, backgroundHeight
end

return Background
