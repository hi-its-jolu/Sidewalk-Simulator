---@diagnostic disable: duplicate-set-field
local Template = require "src.npcs.template"
local Config = require "config.config"

local SpeedWalker = setmetatable({}, {__index = Template})
SpeedWalker.__index = SpeedWalker


function SpeedWalker:new(o)
    -- inherit Template
    o = o or Template:new()
    setmetatable(o, SpeedWalker)
    
    -- Overrride
    o.name = "Speed Walker"
    o.image = love.graphics.newImage("assets/npc/placeholder.png")
    o.walkSpeed = 800
    return o
end

return SpeedWalker
