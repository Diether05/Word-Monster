
function GenerateTileQuads(atlas)
    local tiles = {}

    local x = 0
    local y = 0

    tiles = {}
    
    -- 4 rows of tiles
    for row = 1, 4 do
        
       
        -- 7 cols of tiles
        for i = 1, 7 do

            table.insert(tiles, love.graphics.newQuad(
                x, y, 152, 152, atlas:getDimensions()
            ))
            x = x + 152
         
        end
        y = y + 152
        x = 0
    end

    return tiles
end

function GenerateFrames(atlas, lx, ly, sx, sy, sp)
    local tiles = {}

    local x = 0
    local y = 0
    local lx = lx
    local ly = ly
    local sx = sx
    local sy = sy

    tiles = {}
    
    for row = 1, lx do
        
        for i = 1, ly do

            table.insert(tiles, love.graphics.newQuad(
                x, y, sx, sy, atlas:getDimensions()
            ))
            y = y + sy
         
        end
        x = x + sx + sp
        y = 0
    end

    return tiles
end

function DontaskFrames(atlas, lx, ly, sx, sy, sp)
    local tiles = {}

    local x = 0
    local y = 0
    local lx = lx
    local ly = ly
    local sx = sx
    local sy = sy

    tiles = {}
    
    for row = 1, ly do
        
        for i = 1, lx do

            table.insert(tiles, love.graphics.newQuad(
                x, y, sx, sy, atlas:getDimensions()
            ))
            y = y + sy
         
        end
        x = x + sx + sp
        y = 0
    end

    return tiles
end

function love.mousereleased(x, y, button)
    if button == 1 then
       moused = 0
    end
end

function disabledarray()
    
    tabletemp = {}

    for ty = 1, 4 do

        table.insert(tabletemp, {})

        for tX = 1, 15 do
            table.insert(tabletemp[ty], 0)
        end
    end
    
    return tabletemp
end

function choosearray()
    
    tabletemp = {}

    for ty = 1, 15 do

        table.insert(tabletemp, {})

        for tx = 1, 3 do
            table.insert(tabletemp[ty], 0)
        end
    end
    
    return tabletemp
end

function emptyarray(array)
    tabletemp = array

    for ty = 1, #tabletemp do
        for tx = 1, #tabletemp[1] do
            tabletemp[ty][tx] = 0
        end
    end
    return tabletemp
end

function delete(ctr,temp1,temp2)
    for ctr1 = (ctr-1), 1, -1 do   
        HLtempx = temp2[ctr1][1]
        HLtempy = temp2[ctr1][2]
        temp1[HLtempy][HLtempx] = 0
    end

    return temp1
end


function loadwords()
    love.filesystem.setIdentity('WordMonster')   

    words = {}
    lin = {}
    for w = 1, 26 do
        table.insert(words, {})
        lin[w] = 0
        for line in love.filesystem.lines('words/'..w..'.lst') do
            table.insert(words[w], line)
            lin[w] = lin[w] + 1
        end
    end

    return words
    
end

function checkword(temp1,temp2,ctr0)

    str = ''
    wrth = 0

    for ctr = 1, (ctr0-1) do
        if temp2[ctr][3] == 1 then
            str = str..'A'
            wrth = wrth + 1
        elseif temp2[ctr][3] == 2 then
            str = str..'B'
            wrth = wrth + 3
        elseif temp2[ctr][3] == 3 then
            str = str..'C'
            wrth = wrth + 3
        elseif temp2[ctr][3] == 4 then
            str = str..'D'
            wrth = wrth + 2
        elseif temp2[ctr][3] == 5 then
            str = str..'E'
            wrth = wrth + 1
        elseif temp2[ctr][3] == 6 then
            str = str..'F'
            wrth = wrth + 4
        elseif temp2[ctr][3] == 7 then
            str = str..'G'
            wrth = wrth + 2
        elseif temp2[ctr][3] == 8 then
            str = str..'H'
            wrth = wrth + 4
        elseif temp2[ctr][3] == 9 then
            str = str..'I'
            wrth = wrth + 1
        elseif temp2[ctr][3] == 10 then
            str = str..'J'
            wrth = wrth + 8
        elseif temp2[ctr][3] == 11 then
            str = str..'K'
            wrth = wrth + 5
        elseif temp2[ctr][3] == 12 then
            str = str..'L'
            wrth = wrth + 1
        elseif temp2[ctr][3] == 13 then
            str = str..'M'
            wrth = wrth + 3
        elseif temp2[ctr][3] == 14 then
            str = str..'N'
            wrth = wrth + 1
        elseif temp2[ctr][3] == 15 then
            str = str..'O'
            wrth = wrth + 1
        elseif temp2[ctr][3] == 16 then
            str = str..'P'
            wrth = wrth + 1
        elseif temp2[ctr][3] == 17 then
            str = str..'Q'
            wrth = wrth + 10
        elseif temp2[ctr][3] == 18 then
            str = str..'R'
            wrth = wrth + 1
        elseif temp2[ctr][3] == 19 then
            str = str..'S'
            wrth = wrth + 1
        elseif temp2[ctr][3] == 20 then
            str = str..'T'
            wrth = wrth + 1
        elseif temp2[ctr][3] == 21 then
            str = str..'U'
            wrth = wrth + 1
        elseif temp2[ctr][3] == 22 then
            str = str..'V'
            wrth = wrth + 4
        elseif temp2[ctr][3] == 23 then
            str = str..'W'
            wrth = wrth + 4
        elseif temp2[ctr][3] == 24 then
            str = str..'X'
            wrth = wrth + 8
        elseif temp2[ctr][3] == 25 then
            str = str..'Y'
            wrth = wrth + 4
        elseif temp2[ctr][3] == 26 then
            str = str..'Z'
            wrth = wrth + 10
        end

    end

    tmplth = #temp1[temp2[1][3]]
    isword = false
   
    for ctr1 = 1, tmplth do
        if temp1[temp2[1][3]][ctr1] == str then
            isword = true
        end
    end
    if  isword == true then
        return wrth
    else
        return 0
    end
end

