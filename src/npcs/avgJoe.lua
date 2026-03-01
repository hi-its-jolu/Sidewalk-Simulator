local Config = require "config.config"

local AvgJoe = {}

AvgJoe.__index = AvgJoe

function AvgJoe:new(o)
    o = o or {}
    setmetatable(o, AvgJoe)
    -- defaults
    o.width = o.width or Config.ChunkSize
    o.height = o.height or Config.ChunkSize * 2
    o.x = o.x or Config.ScreenWidth 
    o.y = o.y or ScreenHeight/2 - o.height/2 - Config.ChunkSize -- offset the Y by a bit to align with lanes
    o.offset = o.offset or 30 -- offset the y position
    o.color = o.color or {1, 1, 1}
    o.walkSpeed = 250
    o.laneChangeSpeed = 100
    o.lane = 1 -- binary lane system, 0 is the top lane, 1 is the bottom lane
    o.drawHitbox = false
    o.image = o.image or love.graphics.newImage("assets/npc/avgJoe-2x.png")
    o.flipImage = o.flipImage or true
    return o
end

function AvgJoe:draw()
    love.graphics.setColor(1, 1, 1)

    if self.lane == 1 then
        self.y = ScreenHeight/2 + self.height/2 - Config.ChunkSize
    end

    love.graphics.draw(
        self.image, -- image
        self.x,
        self.y - self.offset, -- y position with offset
        0, -- rotation
        self.flipImage and 1 or -1, -- scale x (we will flip the image by setting scale x to -1 if flipImage is true) 
        1 -- scale y (we will flip the image by setting scale x to -1 if flipImage is true)
    )
    self:hitbox()
end


-- walk straight until off screen, then remove from game
function AvgJoe:walk(dt)
    self.x = self.x - self.walkSpeed * dt
    if self.x + self.width < 0 then
        -- remove from game 
        self.remove = true
    end 
end

function AvgJoe:moveToLane(targetLane, dt)
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

function AvgJoe:hitbox()

    if self.drawHitbox then
        love.graphics.setColor(0, 1, 0)
        love.graphics.rectangle("line",
        self.x - 1, 
        self.y + self.height/2 - 1 - self.offset,  
        self.width + 2, 
        self.height/2 + 2)
    end

    return {
        x = self.x,
        y = self.y,
        width = self.width,
        height = self.height/2
    }
end

function AvgJoe:debug(key)
    if key == "`" then
        self.drawHitbox = not self.drawHitbox
    end
end


return AvgJoe