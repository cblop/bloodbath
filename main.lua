local game = require("game")
local player = require "player"
local gfx = require "gfx"

-- this is called when a key is released
function love.keyreleased(key, unicode)
    -- if not on menu screen
    if this_game.fighting then
        -- tell player objects what key was released
        for i=1,#this_game.players do
            this_game.players[i]:keyreleased(key, unicode)
        end
    end
end

-- this is called when a key is pressed
function love.keypressed(key, unicode)
    -- tell game object which key was pressed
    this_game:keypressed(key)

    -- escape key quits the game
    if key == "escape" then
        love.event.push("quit")
    end
end

-- this is called once when the game loads
function love.load()
    -- prevents anti-aliasing
    love.graphics.setDefaultImageFilter("nearest", "nearest")
    love.graphics.setMode(800,600,true) --fullscreen
    
    --love.graphics.setMode(800,600,false) --windowed
    love.graphics.setCaption("BloodBath")

    -- key maps for controlling players
    local keymap1 = {joy=false,up="w",down="s",left="a",right="d",punch="lshift",kick="lctrl"}
    --local keymap1 = {joy=false,up=",",down="o",left="a",right="e",punch="lshift",kick="lctrl"} --for dvorak
    local keymap2 = {joy=false,up="up",down="down",left="left",right="right",punch="return",kick="rshift"}
    local keymaps = {keymap1,keymap2}

    -- face images for menu
    local hashface = {love.graphics.newImage("images/hash1.png"), love.graphics.newImage("images/hash2.png")}
    local wenkaiface = {love.graphics.newImage("images/wenkai1.png"), love.graphics.newImage("images/wenkai2.png")}
    local mattface = {love.graphics.newImage("images/matt1.png"), love.graphics.newImage("images/matt2.png")}

    -- load the animation sprite sheets
    local hashAnims = loadPlayerGfx("hash")
    local wenkaiAnims = loadPlayerGfx("wenkai")
    local mattAnims = loadPlayerGfx("matt")

    -- create the player objects
    hash = Player.new("Hashim",hashAnims,keymaps[1],hashface)
    wenkai = Player.new("Wen Kai",wenkaiAnims,keymaps[1],wenkaiface)
    matt = Player.new("Matt",mattAnims,keymaps[1],mattface)
    allPlayers = {hash,wenkai,matt}

    -- create a game object
    this_game = Game.new(keymaps,allPlayers)
end

-- this continuously updates the screen
function love.draw()
    -- clears the screen
    love.graphics.reset()
    -- draws background
    love.graphics.draw(this_game.background, 0, 0)
    -- tells game object to draw its stuff
    this_game:draw()
end

-- this continuously updates the game logic
function love.update(dt)
    -- tells the game object to update
    this_game:update(dt)
end

