
local config = require "config.config"
local player = require "src.player"
local lanes = require "src.lanes"
local avgJoe = require "src.npcs.avgJoe"
local collisionManager = require "src.controllers.collisionManager"


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


function love.update(dt)
    Player:update(dt)
    for _, npc in ipairs(NPCs) do
        if npc.walk then npc:walk(dt) end
    end
    CollisionManager:update(dt)
end

function love.draw()
    Lanes:drawLanes()
    Player:draw()
    AvgJoe:draw()
    CollisionManager:draw()
end


function love.keypressed(key)
    if key == "r" then
        love.load()
        return
    end
    Player:debug(key)
    Player:controller(key)
    AvgJoe:debug(key)

    
end

