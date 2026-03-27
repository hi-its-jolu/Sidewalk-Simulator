---@diagnostic disable: duplicate-set-field
local Config = require "config.config"
local Template = require "src.npcs.template"

local Ghost = setmetatable({}, {__index = Template})
Ghost.__index = Ghost

-- Ghost moves slow and sneaks up on the player.
-- Comes in and out of visibility
-- Once it pass 2 chunks from the player, it will disappear.
function Ghost:new()
    local o = Template:new()
    setmetatable(o, Ghost)
    -- defaults
    o.name = o.name or "Ghost"
    o.image = love.graphics.newImage("assets/npc/ghost.png")
    o.walkSpeed = 125 -- slower than average joe
    o.fadeTimer = 0
    o.fadeDuration = 2 -- seconds for full fade in/out
    o.fadeDirection = 1 -- 1 = fade in, -1 = fade out
    return o
end

function Ghost:update(dt)
    self.fadeTimer = self.fadeTimer + dt * self.fadeDirection
    
    if self.fadeTimer >= self.fadeDuration then
        self.fadeDirection = -1
        self.fadeTimer = self.fadeDuration
    elseif self.fadeTimer <= 0 then
        self.fadeDirection = 1
        self.fadeTimer = 0
    end
end

function Ghost:draw()
    local alpha = self.fadeTimer / self.fadeDuration
    love.graphics.setColor(1, 1, 1, alpha)
    love.graphics.draw(self.image, self.x, self.y - self.offset)
    love.graphics.setColor(1, 1, 1, 1) -- reset color
end

return Ghost