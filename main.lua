local game = require("game")
local player = require "player"
local gfx = require "gfx"

function love.update(dt)
    this_game:update(dt)
end

function love.keyreleased(key, unicode)
    if this_game.fighting then
        for i=1,#this_game.players do
            this_game.players[i]:keyreleased(key, unicode)
        end
    end
end

function love.keypressed(key, unicode)
    this_game:keypressed(key)
    if key == "escape" then
        love.event.push("quit")
    end
end


function love.load()
    love.graphics.setDefaultImageFilter("nearest", "nearest")
    --love.graphics.setMode(800,600,true)
    
    love.graphics.setMode(800,600,false) --windowed
    love.graphics.setCaption("BloodBath")

    local keymap1 = {joy=false,up="w",down="s",left="a",right="d",punch="lshift",kick="lctrl"}
    --local keymap1 = {joy=false,up=",",down="o",left="a",right="e",punch="lshift",kick="lctrl"} --for dvorak
    local keymap2 = {joy=false,up="up",down="down",left="left",right="right",punch="rshift",kick="rctrl"}
    local keymaps = {keymap1,keymap2}

    local hashface = {love.graphics.newImage("images/hash1.png"), love.graphics.newImage("images/hash2.png")}
    local wenkaiface = {love.graphics.newImage("images/wenkai1.png"), love.graphics.newImage("images/wenkai2.png")}
    local mattface = {love.graphics.newImage("images/matt1.png"), love.graphics.newImage("images/matt2.png")}

    local hashAnims = loadPlayerGfx("hash")
    local wenkaiAnims = loadPlayerGfx("wenkai")
    local mattAnims = loadPlayerGfx("matt")

    hash = Player.new("Hashim",hashAnims,keymaps[1],hashface)
    wenkai = Player.new("Wen Kai",wenkaiAnims,keymaps[1],wenkaiface)
    matt = Player.new("Matt",mattAnims,keymaps[1],mattface)
    allPlayers = {hash,wenkai,matt}

    this_game = Game.new(keymaps,allPlayers)
end

function love.draw()
    love.graphics.reset()
    love.graphics.draw(this_game.background, 0, 0)
    this_game:draw()
end

