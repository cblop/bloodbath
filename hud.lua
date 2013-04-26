StatusBar = {}

function StatusBar.new(player)
    local o = {}
    o.player = player
    o.value = 100
    o.font = love.graphics.newFont("fonts/visitor1.ttf", 35)
    setmetatable(o, { __index = StatusBar })
    return o
end

function StatusBar:draw()
    self.value = self.player.health
    if self.value < 0 then
        self.value = 0
    end
    local x_start = 15
    local y_start = 40
    local y_length = 3
    if self.player.number == 2 then
        x_start = 480
    end
    love.graphics.setColor(0, 0, 0)
    love.graphics.setFont(self.font)
    printBorder(self.player.name, x_start, 5, 2)
    love.graphics.setColor(0, 0, 0)
    love.graphics.rectangle("fill", x_start - 2, y_start - 2, 304, 39)
    if self.value >= 66 then
        love.graphics.setColor(0, 255, 0)
        love.graphics.rectangle("fill", x_start, y_start, self.value * y_length, 33)
        love.graphics.setColor(0, 150, 0)
        love.graphics.rectangle("fill", x_start, y_start + 18, self.value * y_length, 17)
    elseif self.value < 66 and self.value >= 33 then
        love.graphics.setColor(255, 100, 0)
        love.graphics.rectangle("fill", x_start, y_start, self.value * y_length, 33)
        love.graphics.setColor(170, 100, 0)
        love.graphics.rectangle("fill", x_start, y_start + 18, self.value * y_length, 17)
    else
        love.graphics.setColor(255, 0, 0)
        love.graphics.rectangle("fill", x_start, y_start, self.value * y_length, 33)
        love.graphics.setColor(150, 0, 0)
        love.graphics.rectangle("fill", x_start, y_start + 18, self.value * y_length, 17)
    end
end


Messages = {}

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

function Messages:announceWinner(winner)
    self.message = string.format("%s wins!", winner)
    self.x = 100
    self.y = 150
end

function Messages:ready()
    self.message = "Get ready!"
    self.x = 130
    self.y = 150
end

function Messages:fight()
    self.message = "Fight!"
    self.x = 270
    self.y = 150
end

function Messages:show()
    love.graphics.setFont(self.font)
    --love.graphics.setColor(self.color[1], self.color[2], self.color[3])
    printBorder(self.message,self.x,self.y, 5)
end

function printBorder(string, x, y, pixels)
    love.graphics.setColor(0,0,0)
    love.graphics.print(string, x - pixels, y - pixels)
    love.graphics.print(string, x - pixels, y + pixels)
    love.graphics.print(string, x + pixels, y - pixels)
    love.graphics.print(string, x + pixels, y + pixels)
    love.graphics.setColor(255,255,255)
    love.graphics.print(string, x, y)
end
