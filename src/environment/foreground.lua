local config = require "config.config"
local helper = require "utils.helper"

local Foreground = {}
Foreground.__index = Foreground

function Foreground:new(lanes)
    local o = {}
    setmetatable(o, Foreground)
    o.lanes = lanes
    return o
end

function Foreground:draw()

    local x, y, width, height = self:calculateSize()

    love.graphics.setColor(config.ForegroundColor)
    love.graphics.rectangle("fill", 
    x,
    y,
    width,
    height)
end

function Foreground:calculateSize()
    local bottomLane = self.lanes.lane2
    local foregroundX = 0
    local foregroundY = bottomLane.y + bottomLane.height
    local foregroundWidth = bottomLane.width
    local foregroundHeight = ScreenHeight - foregroundY

    if(config.DebugToggle) then
        print("Foreground X: " .. foregroundX .. " Y: " .. foregroundY .. " Width: " .. foregroundWidth .. " Height: " .. foregroundHeight)
    end    

    return foregroundX, foregroundY, foregroundWidth, foregroundHeight
end

return Foreground
