local anim8 = require "anim8"

Player = {}

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

function Player:getHit(height, attack)
    local pdamage = 5
    local kdamage = 7
    local damage = 5
    if attack == "punch" then
        damage = pdamage
    elseif attack == "kick" then
        damage = kdamage
    end
    self:takeDamage(damage)
    -- adjust for height
    self.status = "hit_high"
end

function Player:takeDamage(amount)
    if self.lock == false then
        self.health = self.health - amount
    end
    self.lock = true
end

function Player:keyevent(key)
    if self.disabled == false then
        if self.keymap["joy"] == false then
            return love.keyboard.isDown(self.keymap[key])
        else
            return love.joystick.isDown(self.keymap[key])
        end
    end
end

function Player:animate(action)
    self.anims[action][2]:draw(self.anims[action][1], self.x, self.y, 0, self.sizex, self.sizey)
end

function Player:resetAnim(action)
    self.anims[action][2]:gotoFrame(1)
    self.anims[action][2]:resume()
end

function Player:render()
    self:animate(self.status)
end

function Player:move(x, y)
	self.x = self.x + x
	self.y = self.y + y
end

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

function Player:die()
    self.status = "fall"
end

function Player:celebrate()
    self.status = "win"
end

function Player:update(dt)
    local width = love.graphics.getWidth()
    local height = love.graphics.getHeight()
    if self.lock == true then
        self.timer = self.timer + dt
    end
    -- alternatively, unlock when in rest state
    -- this makes it hard to keep kicking/punching, though
    if self.timer > 0.7 then
        self.lock = false
        self.timer = 0
    end

    local keyevents = {"punch","kick","left","right","up","down"}
    for i=1,#keyevents do
        kev = keyevents[i]
        if self:keyevent(kev) then
            if kev == "punch" or kev == "kick" then
                self.status = kev
            end
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
                if self.x < (width - 150) then
                    self:move(100 * dt, 0)
                end
            end

            if kev == "up" then
                self.status = "jump"
            end
            if kev == "down" then
                if self:keyevent("left") or self:keyevent("right") then
                    self.status = "crouchwalk"
                else
                    self.status = "crouch"
                end
                if self.anims["crouch"][2].position == 25 then
                    self.anims["crouch"][2]:pause()
                end
            end
        end
    end

    self.anims[self.status][2]:update(dt)

    if self.status == "jump" then
        self.y = (230 - (100 * math.sin((self.anims["jump"][2].position / #self.anims["jump"][2].frames) * math.pi)))
    end

    local onceAnims = {"punch", "kick", "jump", "hit_high"}
    for i=1, #onceAnims do
        oa = onceAnims[i]
        if self.anims[oa][2].status == "finished" then
            self.status = 'rest'
            self:resetAnim(oa)
        end
    end

    if self.status == "crouch" and self.anims["crouch"][2].position == 1 then
        self.status = 'rest'
        self:resetAnim("crouch")
    end

end

function Player:keyreleased(key, unicode)
    if key == self.keymap["up"] or key == self.keymap["down"] or key == self.keymap["left"] or key == self.keymap["right"] or key == self.keymap["punch"] or key == self.keymap["kick"] then

        if key == self.keymap["left"] or key == self.keymap["right"] then
            self.status = "rest"
        elseif key == self.keymap["down"] then
            self.anims["crouch"][2]:resume()
        end
    end
end
