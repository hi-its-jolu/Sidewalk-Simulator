local Player = {}
local config = require "config.config"
local helper = require "utils.helper"

local controls = config.Controls

-- Player class definition
Player.__index = Player

-- Constructor for creating a new player instance
function Player:new(o)
    o = o or {}
    setmetatable(o, Player)
    -- defaults
    o.width = o.width or 32
    o.height = o.height or 64
    o.x = o.x or o.width * 4
    o.y = o.y or ScreenHeight/2 - o.height/2
    o.offset = o.offset or 15 -- offset the y position
    o.color = o.color or {1, 1, 1}
    o.lane = 0 -- binary lane system, 0 is the top lane, 1 is the bottom lane
    o.laneChangeSpeed = 200
    o.drawHitbox = false
    return o
end

function Player:update(dt)
    self:moveToLane(self.lane, dt)
    self:debug()
end

function Player:draw()
    love.graphics.setColor(self.color)
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
    self:hitbox()
end

function Player:hitbox()

    if self.drawHitbox then
        love.graphics.setColor(0, 1, 0)
        love.graphics.rectangle("line", self.x - 1, self.y + self.height/2 - 1, self.width + 2, self.height/2 + 2)
    end

    return {
        x = self.x,
        y = self.y,
        width = self.width,
        height = self.height/2
    }
end

function Player:moveToLane(targetLane, dt)
    local targetY = ScreenHeight/2 - self.height/2 - self.offset -- default to lane 0
    if targetLane == 1 then
        targetY = ScreenHeight/2 + self.height/2 - self.offset
    end

    if self.y < targetY then
        self.y = math.min(self.y + self.laneChangeSpeed * dt, targetY)
    elseif self.y > targetY then
        self.y = math.max(self.y - self.laneChangeSpeed * dt, targetY)
    end
end

function Player:controller(key)
        if helper.arrayContains(controls.down, key) then
        self.lane = 1
    elseif helper.arrayContains(controls.up, key) and self.lane > 0 then
        self.lane = 0
    end
end

function Player:debug(key)
    if helper.arrayContains(controls.debug, key) then
        self.drawHitbox = not self.drawHitbox
    end
end

return Player