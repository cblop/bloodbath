
-- Fight class handles interactions between players
Fight = {}
-- Fight constructor
function Fight.new(player1, player2, messages)
    local o = {}
    o.player1 = player1
    o.player2 = player2
    o.prep = true
    o.timer = 0
    o.messages = messages
    setmetatable(o, { __index = Fight })
    return o
end

-- works out if an attack hits, then takes health away
function Fight:applyDamage()
    -- work out distance between players
    local distance = self.player1.x - self.player2.x
    local reach = 120
    if distance < 0 then
        distance = distance * -1
    end

    -- if the players are close enough, someone gets hit
    if distance < reach then
        if self.player1.status == "punch" then
            self.player2:getHit("high", "punch")
        elseif self.player1.status == "kick" then
            self.player2:getHit("high", "kick")
        end
        if self.player2.status == "punch" then
            self.player1:getHit("high", "punch")
        elseif self.player2.status == "kick" then
            self.player1:getHit("high", "kick")
        end
    end
end

-- called when a player wins
function Fight:victory(winplayer)
    -- one player wins, the other loses
    if winplayer == self.player1 then
        self.player2:die()
        self.messages:announceWinner(self.player1.name)
    else
        self.player1:die()
        self.messages:announceWinner(self.player2.name)
    end
end

-- called at the start of a fight
-- says "get ready!" and temporarily disables players
function Fight:getReady(dt)
    -- "ready..."
    if self.timer <= 2 then
        self.messages:ready() 
    -- "fight!"
    elseif self.timer > 2 and self.timer < 4 then
        self.messages:fight()
        self.player1.disabled = false
        self.player2.disabled = false
    -- then clear the screen and enable players
    else
        self.messages.message = ""
        self.prep = false
    end
    self.timer = self.timer + dt
end

-- continuously update the fight
function Fight:update(dt)
    -- if it's the start, show "get ready" text
    if self.prep then
        self:getReady(dt)

    -- check if any damage has been done, or if a player has won
    else
        self:applyDamage()
        if self.player1.health <= 0 then
            self:victory(self.player2)
        end
        if self.player2.health <= 0 then
            self:victory(self.player1)
        end
        if self.player1.anims["fall"][2].status == "finished" then
            self.player2:celebrate()
        end
        if self.player2.anims["fall"][2].status == "finished" then
            self.player1:celebrate()
        end
    end
end
