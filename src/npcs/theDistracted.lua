---@diagnostic disable: duplicate-set-field
local Template = require "src.npcs.template"
local Config = require "config.config"

local TheDistracted = setmetatable({}, {__index = Template})
TheDistracted.__index = TheDistracted


function TheDistracted:new(o)
    -- inherit Template
    o = o or Template:new()
    setmetatable(o, TheDistracted)
    
    -- Overrride
    o.name = "The Distracted"
    o.image = love.graphics.newImage("assets/npc/placeholder.png")
    o.lane = o.lane or 1
    o.laneSwitchTimer = 0
    o.laneSwitchInterval = math.random(1, 3) -- switch lanes every 2-5 seconds
    o.hasChangedLane = false
    return o
end

function TheDistracted:walk(dt)
    self.x = self.x - self.walkSpeed * dt
    
    
    -- only lane change if the NPC is 2 chunks from the player
    -- we don't want the NPC to lane change into the player
    local playerWidth = Config.ChunkSize * 2
    local playerSafeZone = playerWidth + (Config.ChunkSize * 2)
    if self.x >  playerSafeZone then
        self:switchLaneTimer(dt)
    end

    self:moveToLane(self.lane, dt)
    
    if self.x + self.width < 0 then
        self.remove = true
    end
end

-- create a timer, if dt exceeds timer, switch lanes and reset timer
function TheDistracted:switchLaneTimer(dt)
    self.laneSwitchTimer = self.laneSwitchTimer + dt
    if self.laneSwitchTimer >= self.laneSwitchInterval then
        self.laneSwitchTimer = 0
        
        if self.lane == 0 then
            self.lane = 1
        else
            self.lane = 0
        end

        self.laneSwitchInterval = math.random(1, 3)
    end
end

return TheDistracted
