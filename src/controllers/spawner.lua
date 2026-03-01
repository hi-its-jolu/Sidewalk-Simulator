local Config = require "config.config"
local Helper = require "utils.helper"

local AvgJoe = require "src.npcs.avgJoe"

local Spawner = {}
Spawner.__index = Spawner

function Spawner:new(npcList)
    local o = {}
    setmetatable(o, Spawner)
    o.npcList = npcList or NPCs or {}
    o.spawnTimer = 0
    o.nextSpawn = o:nextSpawnTime()
    return o
end

-- Call this in love.update(dt)
function Spawner:update(dt, lanes)
    self.spawnTimer = self.spawnTimer + dt
    if self.spawnTimer >= self.nextSpawn then
        self.spawnTimer = 0
        self.nextSpawn = self:nextSpawnTime()
        -- pick a random lane
        local laneNum = math.random(1, 2)
        local lane = laneNum == 1 and lanes.lane1 or lanes.lane2
        -- get a random NPC type
        local npcType = self:getRandomSpawn(1) -- assuming level 1 for now
        local npc
        
        if npcType == "AvgJoe" then
            npc = AvgJoe:new()
        else
            -- default to AvgJoe
            npc = AvgJoe:new() 
        end

        if npc then
            npc.lane = laneNum
                table.insert(NPCs, npc)
        end
    end
end

function Spawner:spawnNPC(npcType)

    local spawn = self:getRandomSpawn(npcType)

    table.insert(self.npcList, spawn)
end


function Spawner:getRandomSpawn(level)
    local easyNpcTypes = {"AvgJoe"}
    local medNPCTypes = {}
    local hardNPCTypes = {}

    local npcPool = {}

    if level == 1 then
        table.insert(npcPool, easyNpcTypes)
    end

    if level == 2 then
        table.insert(npcPool, medNPCTypes)
    end

    if level >= 3 then
        table.insert(npcPool, hardNPCTypes)
    end
    
    local randomIndex = math.random(1, #npcPool)
    return npcPool[randomIndex]
end

function Spawner:nextSpawnTime()
    -- TODO: make this more robust, as level increases, spawn more npcs faster
    local randomInterval = math.random(10, 20) / 10
    return randomInterval
end

return Spawner