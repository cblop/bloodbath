
-- StatusBar object: shows a player's health
StatusBar = {}
-- StatusBar constructor
function StatusBar.new(player)
    local o = {}
    o.player = player
    o.value = 100
    o.font = love.graphics.newFont("fonts/visitor1.ttf", 35)
    setmetatable(o, { __index = StatusBar })
    return o
end

-- draw statusbar graphics
function StatusBar:draw()
    -- value is player's health
    self.value = self.player.health

    -- make sure bar value isn't negative
    if self.value < 0 then
        self.value = 0
    end

    -- set up coords
    local x_start = 15
    local y_start = 40
    local y_length = 3
    -- change position for player 2
    if self.player.number == 2 then
        x_start = 480
    end

    -- setup colours, fonts
    love.graphics.setColor(0, 0, 0)
    love.graphics.setFont(self.font)
    printBorder(self.player.name, x_start, 5, 2)
    love.graphics.setColor(0, 0, 0)
    love.graphics.rectangle("fill", x_start - 2, y_start - 2, 304, 39)

    -- draw a green bar if health over 66
    if self.value >= 66 then
        love.graphics.setColor(0, 255, 0)
        love.graphics.rectangle("fill", x_start, y_start, self.value * y_length, 33)
        love.graphics.setColor(0, 150, 0)
        love.graphics.rectangle("fill", x_start, y_start + 18, self.value * y_length, 17)

    -- draw an orange bar if health under 66 but over 33
    elseif self.value < 66 and self.value >= 33 then
        love.graphics.setColor(255, 100, 0)
        love.graphics.rectangle("fill", x_start, y_start, self.value * y_length, 33)
        love.graphics.setColor(170, 100, 0)
        love.graphics.rectangle("fill", x_start, y_start + 18, self.value * y_length, 17)

    -- draw a red bar if health under 33
    else
        love.graphics.setColor(255, 0, 0)
        love.graphics.rectangle("fill", x_start, y_start, self.value * y_length, 33)
        love.graphics.setColor(150, 0, 0)
        love.graphics.rectangle("fill", x_start, y_start + 18, self.value * y_length, 17)
    end
end

-- Messages object draws text on screen
Messages = {}
-- Messages constructor
function Messages.new()
    local o = {}
    o.message = ""
    o.size = 100
    o.color = { 255, 255, 255 }
    o.font = love.graphics.newFont("fonts/visitor1.ttf", 100)
    o.x = 0
    o.y = 0
    setmetatable(o, { __index = Messages })
    return o
end

-- when a player wins, say so
function Messages:announceWinner(winner)
    self.message = string.format("%s wins!", winner)
    self.x = 100
    self.y = 150
end

-- say "Get ready!"
function Messages:ready()
    self.message = "Get ready!"
    self.x = 130
    self.y = 150
end

-- say "Fight!"
function Messages:fight()
    self.message = "Fight!"
    self.x = 270
    self.y = 150
end

-- draw the message on the screen
function Messages:show()
    love.graphics.setFont(self.font)
    printBorder(self.message,self.x,self.y, 5)
end

-- utility function to add a black border to text
function printBorder(string, x, y, pixels)
    love.graphics.setColor(0,0,0)
    love.graphics.print(string, x - pixels, y - pixels)
    love.graphics.print(string, x - pixels, y + pixels)
    love.graphics.print(string, x + pixels, y - pixels)
    love.graphics.print(string, x + pixels, y + pixels)
    love.graphics.setColor(255,255,255)
    love.graphics.print(string, x, y)
end
