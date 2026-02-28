
-- Configuration and constants
local config = require "config.config"

-- Utility functions
local helper = require "utils.helper"

-- Game objects
local player = require "src.player.player"
local lanes = require "src.environment.lanes"

-- Game state management
local collisionManager = require "src.controllers.collisionManager"

-- TEMP NPCs - remove when spawner is implemented
local avgJoe = require "src.npcs.avgJoe"

function love.load()
    ScreenWidth, ScreenHeight = config.ScreenWidth, config.ScreenHeight
    love.window.setTitle("Sidewalk Simulator")
    love.window.setMode(ScreenWidth, ScreenHeight)

    Player = player:new()
    Lanes = lanes:new()
    AvgJoe = avgJoe:new()

    NPCs = {AvgJoe}
    CollisionManager = collisionManager:new(Player, NPCs)
end

function love.draw()
    love.graphics.setColor(config.BackgroundColor)
    love.graphics.rectangle("fill", 0, 0, ScreenWidth, ScreenHeight)
    Lanes:drawLanes()
    Player:draw()
    AvgJoe:draw()
    CollisionManager:draw()
end

function love.update(dt)
    Player:update(dt)
    for _, npc in ipairs(NPCs) do
        if npc.walk then npc:walk(dt) end
    end
    CollisionManager:update(dt)
end


function love.keypressed(key)
    local controls = config.Controls

    -- TODO: fix this pause implementation. [BUG]
    if helper.arrayContains(controls.pause, key) then
        love.update = love.update and nil or Update
    end

    if helper.arrayContains(controls.reset, key) then
        love.load()
        return
    end
    Player:debug(key)
    Player:controller(key)
    AvgJoe:debug(key)

    
end

