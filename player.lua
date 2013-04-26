local anim8 = require "anim8"

-- Player class
Player = {}

-- Player constructor
function Player.new(name,anims,keymap,face)
    local o = {}
    o.name = name
    o.number = 1
    o.x = 10
    o.y = 230
    o.anims = anims
    o.keymap = keymap
    o.face = face
    o.direction = "right"
    o.status = "rest"
    o.anim = "rest"
    o.sizex = 3
    o.sizey = 3
    o.health = 100
    o.lock = false
    o.disabled = true
    o.timer = 0
    setmetatable(o, { __index = Player })
    return o
end

-- called when hit by other player
function Player:getHit(height, attack)
    local pdamage = 5
    local kdamage = 7
    local damage = 5

    -- determine attack type, take health away
    if attack == "punch" then
        damage = pdamage
    elseif attack == "kick" then
        damage = kdamage
    end
    self:takeDamage(damage)
    -- adjust for height
    self.status = "hit_high"
end

-- decreases health value
function Player:takeDamage(amount)
    -- player needs to be locked while taking damage,
    -- otherwise health goes down too quickly
    
    -- if not currently immune to damage, decrease health
    if self.lock == false then
        self.health = self.health - amount
    end
    -- make player vulnerable again after health is reduced
    self.lock = true
end

-- handles key events,
-- mostly to determine if keyboard or joystick
function Player:keyevent(key)
    if self.disabled == false then
        if self.keymap["joy"] == false then
            return love.keyboard.isDown(self.keymap[key])
        else
            return love.joystick.isDown(self.keymap[key])
        end
    end
end

-- draws an animation
function Player:animate()
    self.anims[self.status][2]:draw(self.anims[self.status][1], self.x, self.y, 0, self.sizex, self.sizey)
end

-- resets animation to first frame
function Player:resetAnim(action)
    self.anims[action][2]:gotoFrame(1)
    self.anims[action][2]:resume()
end

-- moves the player
function Player:move(x, y)
	self.x = self.x + x
	self.y = self.y + y
end

-- flips all player animations horizontally
-- (for when they turn)
function Player:flip()
    for img, anim in pairs(self.anims) do
        anim[2]:flipH()
    end
    if self.direction == "right" then
        self.direction = "left"
    else
        self.direction = "right"
    end
end

-- called when a player loses
function Player:die()
    self.status = "fall"
end

-- called when a player wins
function Player:celebrate()
    self.status = "win"
end

-- continuously update the player
function Player:update(dt)
    -- get screen width and height
    local width = love.graphics.getWidth()
    local height = love.graphics.getHeight()

    -- if the player is taking damage, make them
    -- temporarily immune
    if self.lock == true then
        self.timer = self.timer + dt
    end
    if self.timer > 0.7 then
        self.lock = false
        self.timer = 0
    end

    -- check to see if an important key was pressed
    local keyevents = {"punch","kick","left","right","up","down"}
    for i=1,#keyevents do
        kev = keyevents[i]
        if self:keyevent(kev) then
            -- change status to punch/kick
            if kev == "punch" or kev == "kick" then
                self.status = kev
            end
            -- make the player walk left/right
            if kev == "left" or kev == "right" then
                -- flip animation direction
                if self.direction ~= kev then
                    self:flip()
                end
                self.status = 'walk'
            end
            if kev == "left" then
                -- stop the player going off the screen edge
                if self.x > (0 - 100) then
                    self:move(-100 * dt, 0)
                end
            end
            if kev == "right" then
                -- stop the player going off the screen edge
                if self.x < (width - 150) then
                    self:move(100 * dt, 0)
                end
            end
            -- make the player jump
            if kev == "up" then
                self.status = "jump"
            end
            -- make the player crouch while down is held
            if kev == "down" then
                -- if down and left/right are held, walk and crouch
                if self:keyevent("left") or self:keyevent("right") then
                    self.status = "crouchwalk"
                else
                    self.status = "crouch"
                end
                -- pause animation at bottom of crouch
                if self.anims["crouch"][2].position == 25 then
                    self.anims["crouch"][2]:pause()
                end
            end
        end
    end

    -- update the animation frame
    self.anims[self.status][2]:update(dt)

    -- when jumping, move up and down in a sinusoidal fashion
    if self.status == "jump" then
        self.y = (230 - (100 * math.sin((self.anims["jump"][2].position / #self.anims["jump"][2].frames) * math.pi)))
    end

    -- some anims don't loop, reset these when done
    local onceAnims = {"punch", "kick", "jump", "hit_high"}
    for i=1, #onceAnims do
        oa = onceAnims[i]
        if self.anims[oa][2].status == "finished" then
            self.status = 'rest'
            self:resetAnim(oa)
        end
    end

    -- return to resting when done crouching
    if self.status == "crouch" and self.anims["crouch"][2].position == 1 then
        self.status = 'rest'
        self:resetAnim("crouch")
    end

end

-- called when any key is released
function Player:keyreleased(key, unicode)
    -- if it's a key we care about
    if key == self.keymap["up"] or key == self.keymap["down"] or key == self.keymap["left"] or key == self.keymap["right"] or key == self.keymap["punch"] or key == self.keymap["kick"] then
        -- stop walking and rest
        if key == self.keymap["left"] or key == self.keymap["right"] then
            self.status = "rest"
        -- get up from crouching
        elseif key == self.keymap["down"] then
            self.anims["crouch"][2]:resume()
        end
    end
end
