local hud = require "hud"
local fight = require "fight"

Game = {}
function Game.new(keymaps, allPlayers)
    local o = {}
    o.background = love.graphics.newImage("images/bg2.png")
    o.menuoptions = allPlayers
    o.players = {nil, nil}
    o.statusBars = {nil, nil}
    o.keymap = keymaps
    o.fight = nil
    o.font = love.graphics.newFont("fonts/visitor1.ttf", 35)
    o.smallfont = love.graphics.newFont("fonts/visitor1.ttf", 18)
    o.fighting = false
    o.menuSelected = {1,1}
    setmetatable(o, { __index = Game })
    return o
end

function Game:keypressed(key)
    if self.fighting == false then
        for i=1,2 do
            if self.players[i] == nil then
                if self.keymap[i]["left"] == key then
                    self.menuSelected[i] = (((self.menuSelected[i] - 1) - 1) % #self.menuoptions) + 1
                elseif self.keymap[i]["right"] == key then
                    self.menuSelected[i] = (((self.menuSelected[i] - 1) + 1) % #self.menuoptions) + 1
                elseif (self.keymap[i]["punch"] == key) or (self.keymap[i]["kick"] == key) then
                    self.players[i] = self.menuoptions[self.menuSelected[i]]
                end
            end
        end
        if self.players[1] ~= nil and self.players[2] ~= nil then
            self:startFight()
        end
    end
end

function Game:startFight()
    self.players[2]:flip()
    self.players[2].x = 550
    self.players[2].number = 2
    self.players[2].keymap = self.keymap[2]
    self.statusBars = {StatusBar.new(self.players[1]), StatusBar.new(self.players[2])}
    self.messageObject = Messages.new()
    self.fight = Fight.new(self.players[1], self.players[2], self.messageObject)
    self.background = love.graphics.newImage("images/bg1.png")
    self.fighting = true
end

function Game:showMenu()
    love.graphics.setFont(self.font)
    printBorder("Select a character:",200,100, 3)
    love.graphics.setFont(self.smallfont)

    love.graphics.print("Player 1:",125,200)
    love.graphics.print("WASD: move",108,230)
    love.graphics.print("Left shift: punch",38,250)
    love.graphics.print("Left ctrl: kick",60,270)

    love.graphics.print("Player 2:",550,410)
    love.graphics.print("Arrow keys: move",550,440)
    love.graphics.print("Right shift: punch",550,460)
    love.graphics.print("Right ctrl: kick",550,480)

    local grid1 = {{220,200},{330, 200},{440,200}}
    local grid2 = {{220,400},{330, 400},{440,400}}
    local grid = {grid1, grid2}
    for i=1,2 do
        for j=1,#self.menuoptions do
            if j == self.menuSelected[i] then
                love.graphics.draw(self.menuoptions[j].face[1], grid[i][j][1], grid[i][j][2])
            else
                if self.players[i] == nil then
                    love.graphics.draw(self.menuoptions[j].face[2], grid[i][j][1], grid[i][j][2])
                end
            end
        end
    end
end

function Game:update(dt)
    if self.fighting then
        for i=1,#self.players do
            self.players[i]:update(dt)
        end
        self.fight:update(dt)
    end
end

function Game:draw()
    if self.fighting == false then
        self:showMenu()
    else
        for i=1,#self.players do
            self.players[i]:render()
        end
        self.statusBars[1]:draw()
        self.statusBars[2]:draw()
        self.messageObject:show()
    end
end

