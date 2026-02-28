local AvgJoe = {}

AvgJoe.__index = AvgJoe

function AvgJoe:new(o)
    o = o or {}
    setmetatable(o, AvgJoe)
    -- defaults
    o.width = o.width or 32
    o.height = o.height or 64
    o.x = o.x or ScreenWidth 
    o.y = o.y or ScreenHeight/2 - o.height/2 - 15 
    o.color = o.color or {1, 1, 1}
    o.walkSpeed = 250
    o.laneChangeSpeed = 100
    o.drawHitbox = false
    return o
end

function AvgJoe:draw()
    love.graphics.setColor(self.color)
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
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
    local targetY = ScreenHeight/2 - self.height/2 - 15 -- default to lane 0
    if targetLane == 1 then
        targetY = ScreenHeight/2 + self.height/2 - 15
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
        love.graphics.rectangle("line", self.x - 1, self.y + self.height/2 - 1, self.width + 2, self.height/2 + 2)
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