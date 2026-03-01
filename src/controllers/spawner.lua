local Config = require "config.config"
local Helper = require "utils.helper"

local AvgJoe = require "src.npcs.avgJoe"
local TheDistracted = require "src.npcs.theDistracted"

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

    -- If no NPCs exist, spawn one immediately
    if #NPCs == 0 then
        local laneNum = math.random(1, 2)
        
        local npcType = self:getRandomSpawn(1)
        local npc

        if npcType == "AvgJoe" then
            npc = AvgJoe:new()
        elseif npcType == "TheDistracted" then
            npc = TheDistracted:new()
        else
            npc = AvgJoe:new()
        end
        if npc then
            npc.lane = laneNum
            table.insert(NPCs, npc)
        end
        self.spawnTimer = 0
        self.nextSpawn = self:nextSpawnTime()
        return
    end

    -- Spawn NPCs at random intervals
    if self.spawnTimer >= self.nextSpawn then
        self.spawnTimer = 0
        self.nextSpawn = self:nextSpawnTime()
        local laneNum = math.random(1, 2)
        local lane = laneNum == 1 and lanes.lane1 or lanes.lane2
        local npcType = self:getRandomSpawn(1)
        local npc
        if npcType == "AvgJoe" then
            npc = AvgJoe:new()
        elseif npcType == "TheDistracted" then
            npc = TheDistracted:new()
        else
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
    local easyNpcTypes = {
        "AvgJoe",
        "TheDistracted"
    }

    local medNPCTypes = {}
    local hardNPCTypes = {}

    local npcPool = {}

    if level == 1 then
        Helper.arraySpread(npcPool, easyNpcTypes)
    end

    if level == 2 then
        Helper.arraySpread(npcPool, medNPCTypes)
    end

    if level >= 3 then
        Helper.arraySpread(npcPool, hardNPCTypes)
    end
    
    local randomIndex = math.random(1, #npcPool)
    local randomNpc = npcPool[randomIndex]
    
     -- Debug print the NPC type being spawned
     if Config.DebugToggle then
        print("Spawning NPC type: " .. randomNpc)
    end
    return randomNpc
end

function Spawner:nextSpawnTime()
    -- TODO: make this more robust, as level increases, spawn more npcs faster
    local randomInterval = math.random(10, 40) / 10
    return randomInterval
end

return Spawner