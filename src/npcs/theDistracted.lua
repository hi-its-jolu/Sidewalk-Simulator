---@diagnostic disable: duplicate-set-field
local AvgJoe = require "src.npcs.avgJoe"
local Config = require "config.config"

local TheDistracted = setmetatable({}, {__index = AvgJoe})
TheDistracted.__index = TheDistracted


function TheDistracted:new(o)
    -- inherit AvgJoe
    o = o or AvgJoe:new()
    setmetatable(o, TheDistracted)
    
    -- Overrride
    o.name = "The Distracted"
    o.image = love.graphics.newImage("assets/npc/placeholder.png")
    -- Lane switching config
    o.laneSwitchInterval = o.laneSwitchInterval or 1.5 -- seconds
    o.laneSwitchTimer = 0
    o.laneSwitchRandomness = o.laneSwitchRandomness or 0.5 -- seconds
    o.targetLane = o.lane or 1
    o.hasSwitchedLane = false
    return o
end

function TheDistracted:walk(dt)
    self.x = self.x - self.walkSpeed * dt
    -- Lane switching logic
    self.laneSwitchTimer = self.laneSwitchTimer + dt
    local switchTime = self.laneSwitchInterval + math.random() * self.laneSwitchRandomness
    if not self.hasSwitchedLane and self.laneSwitchTimer >= switchTime then
        self.laneSwitchTimer = 0
        -- Pick a new target lane (not current)
        local newLane = math.random(0, 1)
        if newLane == self.targetLane then
            newLane = 1 - self.targetLane
        end
        self.targetLane = newLane
        self.hasSwitchedLane = true
    end
    -- Smooth transition to target lane
    self:moveToLane(self.targetLane, dt)
    -- Only update self.lane when transition is complete
    local targetY = ScreenHeight/2 - self.height/2 - self.offset
    if self.targetLane == 1 then
        targetY = ScreenHeight/2 + self.height/2 - self.offset
    end
    if math.abs(self.y - targetY) < 1 then
        self.lane = self.targetLane
    end
    if self.x + self.width < 0 then
        self.remove = true
    end
end

return TheDistracted
