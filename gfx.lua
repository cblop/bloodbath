local anim8 = require "anim8"

function loadPlayerGfx(player)

    local img_rest = love.graphics.newImage("sprites/hashim/rest.png")
    local img_walk = love.graphics.newImage("sprites/hashim/walk.png")
    local img_punchl = love.graphics.newImage("sprites/hashim/punchl.png")
    local img_jump = love.graphics.newImage("sprites/hashim/jump.png")
    local img_crouch = love.graphics.newImage("sprites/hashim/crouch.png")
    local img_crouchwalk = love.graphics.newImage("sprites/hashim/crouchwalk.png")
    local img_kick = love.graphics.newImage("sprites/hashim/kick.png")
    local img_fall = love.graphics.newImage("sprites/hashim/fall.png")
    local img_win = love.graphics.newImage("sprites/hashim/win.png")
    local img_hit_high = love.graphics.newImage("sprites/hashim/hit_high.png")

    local g_rest = anim8.newGrid(100, 100, img_rest:getWidth(), img_rest:getHeight())
    local g_walk = anim8.newGrid(100, 100, img_walk:getWidth(), img_walk:getHeight())
    local g_punchl = anim8.newGrid(100, 100, img_punchl:getWidth(), img_punchl:getHeight())
    local g_jump = anim8.newGrid(100, 100, img_jump:getWidth(), img_jump:getHeight())
    local g_crouch = anim8.newGrid(100, 100, img_crouch:getWidth(), img_crouch:getHeight())
    local g_crouchwalk = anim8.newGrid(100, 100, img_crouchwalk:getWidth(), img_crouchwalk:getHeight())
    local g_kick = anim8.newGrid(100, 100, img_kick:getWidth(), img_kick:getHeight())
    local g_fall = anim8.newGrid(100, 100, img_fall:getWidth(), img_fall:getHeight())
    local g_win = anim8.newGrid(100, 100, img_win:getWidth(), img_win:getHeight())
    local g_hit_high = anim8.newGrid(100, 100, img_hit_high:getWidth(), img_hit_high:getHeight())

    -- these are defaults: hash
    local rest = anim8.newAnimation('bounce', g_rest('1-30,1'), 0.05) 
    local walk = anim8.newAnimation('bounce', g_walk('11-30,1'), 0.03) 
    local punch_left = anim8.newAnimation('once', g_punchl('5-24,1'), 0.03) 
    local jump = anim8.newAnimation('once', g_jump('20-45,1'), 0.03) 
    local crouch = anim8.newAnimation('bounce', g_crouch('1-25,1'), 0.02) 
    local crouchwalk = anim8.newAnimation('bounce', g_crouchwalk('1-11,1'), 0.02) 
    local kick = anim8.newAnimation('once', g_kick('1-30,1'), 0.02) 
    local fall = anim8.newAnimation('once', g_fall('1-35,1'), 0.02) 
    local win = anim8.newAnimation('bounce', g_win('1-17,1'), 0.03) 
    local hit_high = anim8.newAnimation('once', g_hit_high('1-22,1'), 0.02) 

    if player == "wenkai" then
        img_rest = love.graphics.newImage("sprites/wenkai/rest.png")
        img_walk = love.graphics.newImage("sprites/wenkai/walk.png")
        img_punchl = love.graphics.newImage("sprites/wenkai/punchl.png")
        img_jump = love.graphics.newImage("sprites/wenkai/jump.png")
        img_crouch = love.graphics.newImage("sprites/wenkai/crouch.png")
        img_crouchwalk = love.graphics.newImage("sprites/wenkai/crouchwalk.png")
        img_kick = love.graphics.newImage("sprites/wenkai/kick.png")
        img_fall = love.graphics.newImage("sprites/wenkai/fall.png")
        img_win = love.graphics.newImage("sprites/wenkai/win.png")
        img_hit_high = love.graphics.newImage("sprites/wenkai/hit_high.png")

        g_rest = anim8.newGrid(100, 100, img_rest:getWidth(), img_rest:getHeight())
        g_walk = anim8.newGrid(100, 100, img_walk:getWidth(), img_walk:getHeight())
        g_punchl = anim8.newGrid(100, 100, img_punchl:getWidth(), img_punchl:getHeight())
        g_jump = anim8.newGrid(100, 100, img_jump:getWidth(), img_jump:getHeight())
        g_crouch = anim8.newGrid(100, 100, img_crouch:getWidth(), img_crouch:getHeight())
        g_crouchwalk = anim8.newGrid(100, 100, img_crouchwalk:getWidth(), img_crouchwalk:getHeight())
        g_kick = anim8.newGrid(100, 100, img_kick:getWidth(), img_kick:getHeight())
        g_fall = anim8.newGrid(100, 100, img_fall:getWidth(), img_fall:getHeight())
        g_win = anim8.newGrid(100, 100, img_win:getWidth(), img_win:getHeight())
        g_hit_high = anim8.newGrid(100, 100, img_hit_high:getWidth(), img_hit_high:getHeight())

        rest = anim8.newAnimation('bounce', g_rest('1-37,1'), 0.05) 
        walk = anim8.newAnimation('bounce', g_walk('1-40,1'), 0.03) 
        punch_left = anim8.newAnimation('once', g_punchl('19-35,1'), 0.03) 
        jump = anim8.newAnimation('once', g_jump('20-35,1'), 0.03) 
        crouch = anim8.newAnimation('bounce', g_crouch('1-30,1'), 0.02)
        crouchwalk = anim8.newAnimation('bounce', g_crouchwalk('1-35,1'), 0.02) 
        kick = anim8.newAnimation('once', g_kick('1-24,1'), 0.02) 
        fall = anim8.newAnimation('once', g_fall('1-30,1'), 0.02) 
        win = anim8.newAnimation('bounce', g_win('1-30,1'), 0.03) 
        hit_high = anim8.newAnimation('once', g_hit_high('1-30,1'), 0.02) 

    elseif player == "matt" then
        img_rest = love.graphics.newImage("sprites/matt/rest.png")
        img_walk = love.graphics.newImage("sprites/matt/walk.png")
        img_punchl = love.graphics.newImage("sprites/matt/punchl.png")
        img_jump = love.graphics.newImage("sprites/matt/jump.png")
        img_crouch = love.graphics.newImage("sprites/matt/crouch.png")
        img_crouchwalk = love.graphics.newImage("sprites/matt/crouchwalk.png")
        img_kick = love.graphics.newImage("sprites/matt/kick.png")
        img_fall = love.graphics.newImage("sprites/matt/fall.png")
        img_win = love.graphics.newImage("sprites/matt/win.png")
        img_hit_high = love.graphics.newImage("sprites/matt/hit_high.png")

        g_rest = anim8.newGrid(100, 100, img_rest:getWidth(), img_rest:getHeight())
        g_walk = anim8.newGrid(100, 100, img_walk:getWidth(), img_walk:getHeight())
        g_punchl = anim8.newGrid(100, 100, img_punchl:getWidth(), img_punchl:getHeight())
        g_jump = anim8.newGrid(100, 100, img_jump:getWidth(), img_jump:getHeight())
        g_crouch = anim8.newGrid(100, 100, img_crouch:getWidth(), img_crouch:getHeight())
        g_crouchwalk = anim8.newGrid(100, 100, img_crouchwalk:getWidth(), img_crouchwalk:getHeight())
        g_kick = anim8.newGrid(100, 100, img_kick:getWidth(), img_kick:getHeight())
        g_fall = anim8.newGrid(100, 100, img_fall:getWidth(), img_fall:getHeight())
        g_win = anim8.newGrid(100, 100, img_win:getWidth(), img_win:getHeight())
        g_hit_high = anim8.newGrid(100, 100, img_hit_high:getWidth(), img_hit_high:getHeight())

        rest = anim8.newAnimation('bounce', g_rest('1-30,1'), 0.05) 
        walk = anim8.newAnimation('bounce', g_walk('1-24,1'), 0.03) 
        punch_left = anim8.newAnimation('once', g_punchl('1-25,1'), 0.03) 
        jump = anim8.newAnimation('once', g_jump('1-20,1'), 0.03) 
        crouch = anim8.newAnimation('bounce', g_crouch('1-23,1'), 0.02)
        crouchwalk = anim8.newAnimation('bounce', g_crouchwalk('1-5,1'), 0.02) 
        kick = anim8.newAnimation('once', g_kick('1-30,1'), 0.02) 
        fall = anim8.newAnimation('once', g_fall('1-36,1'), 0.02) 
        win = anim8.newAnimation('once', g_win('1-38,1'), 0.03) 
        hit_high = anim8.newAnimation('once', g_hit_high('1-37,1'), 0.02) 

    end

    local anims = {rest={img_rest, rest}, walk={img_walk, walk}, punch={img_punchl, punch_left},
                    jump={img_jump, jump}, crouch={img_crouch, crouch}, crouchwalk={img_crouchwalk, crouchwalk},
                    kick={img_kick, kick}, fall={img_fall, fall}, win={img_win, win}, hit_high={img_hit_high, hit_high}}
    return anims
end

