

Board = Class{}

function Board:init(x, y, lx, ly, c)
    self.x = x
    self.y = y

    self.lxx = lx 
    self.lyy = ly 
    self.c = c

    self:initializeTiles()
end

function Board:initializeTiles()
    self.tiles = {}

    for tileY = 1, self.lyy do
        table.insert(self.tiles, {})

        for tileX = 1, self.lxx do
            if self.c == 0 then
                table.insert(self.tiles[tileY], Tile(tileX*2.1 - 1.1, tileY*1.95 - .95, math.random(26)))
            elseif self.c == 1 then
                table.insert(self.tiles[tileY], Tile(tileX*1.57 - .57, 1, 27))
            end
        end
    end

end

function Board:ReTile()
    self:initializeTiles()
end

function Board:chooseTiles(pos, word)
    self.tiles[1][pos] = Tile(pos*1.57 - .57, 1, word)
end

function Board:getNewTiles()
    return {}
end

function Board:render(sx, sy, dis, poi, fro)
    for y = 1, #self.tiles do
        for x = 1, #self.tiles[1] do
            if self.c == 0 then
                    self.tiles[y][x]:render(self.x, self.y, sx, sy, dis[y][x], poi[y][x], fro[y][x])
            elseif self.c == 1 then
                self.tiles[y][x]:render(self.x, self.y, sx, sy, 0, 0, 0)
            end
        end
    end
end
