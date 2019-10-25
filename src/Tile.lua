
Tile = Class{}

function Tile:init(x, y, word)
    -- board positions
    self.gridX = x
    self.gridY = y

    -- coordinate positions
    self.x = (self.gridX - 1) * 32
    self.y = (self.gridY - 1) * 32

    -- tile appearance/points
    self.word = word

end

function Tile:retword()
    return self.word
end

function Tile:render(x, y, sx, sy, dis, poi, fro)
    
     -- draw tile itself
     if fro == 1 then
        love.graphics.setColor(99, 155, 255, 255)
     elseif dis == 1 then
        love.graphics.setColor(34, 32, 52, 255)
     elseif poi == 1 then
        love.graphics.setColor(99, 255, 155, 255)
     else
     love.graphics.setColor(255, 255, 255, 255)
     end
     love.graphics.draw(gTextures['WordTiles'], gFrames['tiles'][self.word],
         self.x + x, self.y + y,0, sx, sy)

end