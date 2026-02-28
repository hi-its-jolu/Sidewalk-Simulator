local CollisionManager = {}
CollisionManager.__index = CollisionManager

function CollisionManager:new(player, npcs)
    local self = setmetatable({}, CollisionManager)
    self.player = player
    self.npcs = npcs or {}
    self.collisionDetected = false
    return self
end

function CollisionManager:update(dt)
    -- Update all NPCs
    for _, npc in ipairs(self.npcs) do
        if npc.update then
            npc:update(dt)
        end
    end
    -- Check collisions
    self:checkCollisions()
end

function CollisionManager:checkCollisions()
    local playerHitbox = self.player:hitbox()
    self.collisionMessage = nil
    for _, npc in ipairs(self.npcs) do
        local npcHitbox = npc:hitbox()
        if self:hitboxCollision(playerHitbox, npcHitbox) then
            self.collisionDetected = true
        end
    end
end

function CollisionManager:hitboxCollision(a, b)
    return a.x < b.x + b.width and
           b.x < a.x + a.width and
           a.y < b.y + b.height and
           b.y < a.y + a.height
end


function CollisionManager:draw()
    if self.collisionDetected then
        love.graphics.setColor(1, 0, 0)
        love.graphics.print("Collision detected with NPC!", 20, 20)
    end
end

return CollisionManager
