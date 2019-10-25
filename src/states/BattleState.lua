
local positions = {}

BattleState = Class{__includes = BaseState}



function BattleState:init()
    self.transitionAlpha = 255
    characterhp = 500
    chp = 0
    charactermp = 0
    cmana = 0

    enemyhp = 200
    ehp = 0

    chp = 0
    cmana = 0
    ehp = 0
    rfrsh = 0  

    mousex = 0
    mousey = 0
    moused = 0
    HLtempx = 0
    HLtempy = 0

    choicectr = 1
    poisonctr = 0
    manup = 0
    attack = 0
    isviva = 0

    randx = 0
    randy = 0
    ntdis = 0

    phtexttimer = 0
    pdtexttimer = 0
    edtexttimer = 0
    edamage = 0
    pdamage = 0
    pheal = 0

    refreshcooldown = 0

    HLshad = {}

    HLchoice = choosearray()
    disabled = disabledarray()
    poisoned = disabledarray()
    frozen = disabledarray()

    words = loadwords()
    f2d = 0
    gg = 0

    timer = 0

end

function BattleState:enter()

    gameboard = Board(10, 500, 15, 4, 0)
    choiceboard = Board(50,420, 15, 1, 1)

    monster = Entity(math.random(1,5),'idle', 1300, 100)
    player = Entity(6,'idle', 100, 100)
    

    Timer.tween(1, {
        [self] = {transitionAlpha = 0}
    })

end

function BattleState:update(dt)
    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end

    if f2d > 0 then
        gg = gg + dt
    end

    --timed variables
    refreshcooldown = refreshcooldown + dt*2
    timer = timer + dt

    -- put virtual (x,y) game screen coordinates to variables 
    mousex, mousey = push:toGame(love.mouse.getPosition())

    if mousex == nil or mousey == nil then
        mousex = 0
        mousey = 0
    end

    if characterhp > 0 and enemyhp > 0 then
        -- mouse board
        if  mousex <= 10 or mousex >= 1020 or mousey <= 500 or mousey >= 750 then
            HLtempx = 0
            HLtempy = 0

        elseif mousex >= 10 and mousex <= 1020 then
            if mousey >= 500 and mousey <= 750 then
                HLtempx = (math.floor((mousex - 10)/67.28)) + 1
                HLtempy = (math.floor((mousey - 500)/62.5)) + 1

                if love.mouse.isDown(1) and moused == 0 then
                    if choicectr < 16 then
                        if disabled[HLtempy][HLtempx] == 0 then
                            HLchoice[choicectr][1] =  HLtempx
                            HLchoice[choicectr][2] =  HLtempy
                            HLchoice[choicectr][3] = gameboard.tiles[HLtempy][HLtempx]:retword()
                            disabled[HLtempy][HLtempx] = 1
                            choiceboard:chooseTiles(choicectr, gameboard.tiles[HLtempy][HLtempx]:retword())
                            if poisoned[HLtempy][HLtempx] == 1 then
                                poisonctr = poisonctr + 1
                            end
                            choicectr = choicectr + 1
                        end
                    end
                    moused = 1
                end
            end
        end    

        -- mouse choicetiles
        if mousex >= 50 and mousex <= 782 then
            if mousey >= 420 and mousey <= 469 then
                if love.mouse.isDown(1) and moused == 0 then
                    if choicectr > 1 then
                        gSounds['select']:play()
                        choicectr = choicectr - 1
                        HLtempx = HLchoice[choicectr][1]
                        HLtempy = HLchoice[choicectr][2]
                        disabled[HLtempy][HLtempx] = 0
                        choiceboard:chooseTiles(choicectr, 27)
                        HLchoice[choicectr][1] =  0
                        HLchoice[choicectr][2] =  0
                        HLchoice[choicectr][3] =  0
                        if poisoned[HLtempy][HLtempx] == 1 then
                            poisonctr = poisonctr - 1
                        end
                    end
                    moused = 1
                end
            end
        end

        -- mouse delete
        if mousex >= 815 and mousex <= 866 then
            if mousey >= 417 and mousey <= 471 then
                if love.mouse.isDown(1) and moused == 0 then
                    disabled = delete(choicectr,disabled,HLchoice)
                    HLchoice = emptyarray(HLchoice)
                    poisonctr = 0
                    choicectr = 1
                    choiceboard:ReTile()
                    moused = 1
                    
                end
            end
        end

        -- mouse enter
        if mousex >= 880 and mousex <= 1071 then
            if mousey >= 425 and mousey <= 465 then
                if love.mouse.isDown(1) and moused == 0 then
                    if charactermp < 100 and choicectr > 1 then
                        manup = checkword(words,HLchoice,choicectr)
                        
                        if manup > 0 then
                            charactermp = charactermp + math.min(100 - charactermp, manup + choicectr - 1)
                            edamage = poisonctr*10
                            edtexttimer = 0
                            characterhp = characterhp - math.min(characterhp, edamage)
                            HLchoice = emptyarray(HLchoice)
                            choicectr = 1
                            poisonctr = 0
                            choiceboard:ReTile()
                            gSounds['tiding']:play()
                        else
                            gSounds['eeeng']:play()
                        end
                    end
                    moused = 1
                end
            end
        end

        -- mouse attack
        if mousex >= 1044 and mousex <= 1348 then
            if mousey >= 529 and mousey <= 592 then
                if love.mouse.isDown(1) and moused == 0 then
                    if charactermp >= 10 then
                        gSounds['as6']:play()
                        charactermp = charactermp - 10
                        pdamage = math.random(15,30)
                        pdtexttimer = 0
                        enemyhp = enemyhp - math.min(enemyhp, pdamage)
                        player.state = 'attack'
                        f2d = 0
                        player.f2d = 0
                        gg = 0
                    end
                    moused = 1
                end
            end
        end

        -- mouse regen
        if mousex >= 1044 and mousex <= 1348 then
            if mousey >= 599 and mousey <= 662 then
                if love.mouse.isDown(1) and moused == 0 then
                    if charactermp >= 20 then
                        gSounds['as6']:play()
                        charactermp = charactermp - 20
                        pheal = math.random(80,150)
                        phtexttimer = 0
                        characterhp = characterhp + math.min(500 - characterhp, math.random(80,150))
                    end
                    moused = 1
                end
            end
        end

        -- mouse refresh
        if mousex >= 1044 and mousex <= 1348 then
            if mousey >= 669 and mousey <= 732 then
                if love.mouse.isDown(1) and moused == 0 then
                    if refreshcooldown >= 100 then
                        gSounds['as6']:play()
                        disabled = emptyarray(disabled)
                        poisoned = emptyarray(poisoned)
                        frozen = emptyarray(frozen)
                        HLchoice = emptyarray(HLchoice)
                        choicectr = 1
                        poisonctr = 0
                        choiceboard:ReTile()
                        gameboard:ReTile()
                        moused = 1
                        refreshcooldown = 0
                    end
                end
            end
        end

        if attack == 1 then
            edamage = math.random(30,40)
            edtexttimer = 0
            characterhp = characterhp - math.min(characterhp, edamage)
            gSounds['as1']:play()
            monster.attack = 0
            monster.timer = 0
        elseif attack == 2 then
            edamage = math.random(40,80)
            edtexttimer = 0
            characterhp = characterhp - math.min(characterhp, edamage)
            disabled = delete(choicectr,disabled,HLchoice)
            HLchoice = emptyarray(HLchoice)
            choicectr = 1
            choiceboard:ReTile()
            gSounds['as2']:play()
            monster.attack = 0
            monster.timer = 0
        elseif attack == 3 then
            edamage = math.random(30,60)
            edtexttimer = 0
            characterhp = characterhp - math.min(characterhp, edamage)
            for ctr = 1, 10 do
                randx = math.random(1,15)
                randy = math.random(1,4)
                if disabled[randy][randx] == 0 then
                    poisoned[randy][randx] = 1             
                end 
            end
            gSounds['as3']:play()
            monster.attack = 0
            monster.timer = 0
        elseif attack == 4 then
            edamage = math.random(30,60)
            edtexttimer = 0
            characterhp = characterhp - math.min(characterhp, edamage)
            randy = math.random(1,4)
            for ctr = 1, 15 do
                if disabled[randy][ctr] == 0 then
                    frozen[randy][ctr] = 1  
                    disabled[randy][ctr] = 1           
                end 
            end
            gSounds['as4']:play()
            monster.attack = 0
            monster.timer = 0
        elseif attack == 5 then
            edamage = math.random(10,20)
            edtexttimer = 0
            characterhp = characterhp - math.min(characterhp, edamage)
            if choicectr > 1 then
                choicectr = choicectr - 1
                HLtempx = HLchoice[choicectr][1]
                HLtempy = HLchoice[choicectr][2]
                disabled[HLtempy][HLtempx] = 0
                choiceboard:chooseTiles(choicectr, 27)
                HLchoice[choicectr][1] =  0
                HLchoice[choicectr][2] =  0
                HLchoice[choicectr][3] =  0
                if poisoned[HLtempy][HLtempx] == 1 then
                    poisonctr = poisonctr - 1
                end
            end
            gSounds['as5']:play()
            monster.attack = 0
            monster.timer = 0
        end

    elseif characterhp <= 0 then
        gSounds['batle']:stop()
        gSounds['sgg']:play()
        isviva = 2
        Timer.tween(10, {
            [self] = {transitionAlpha = 255}
        }):finish(function()
            gStateMachine:change('start')
            gSounds['sgg']:stop()
            gSounds['main']:play()
        end)
    elseif enemyhp <= 0 then
        gSounds['batle']:stop()
        gSounds['sviva']:play()
        isviva = 1
        Timer.tween(10, {
            [self] = {transitionAlpha = 255}
        }):finish(function()
            gStateMachine:change('start')
            gSounds['sviva']:stop()
            gSounds['main']:play()
        end)
    end

    --render update
    chp = characterhp * (500/500)
    cmana = charactermp * (450/100)
    ehp = enemyhp * (500/200)
    rfrsh = math.min(100, refreshcooldown) * (290/100)   

    f2d = player:update(dt)
    attack = monster:update(dt)

    if pdamage > 0 then
        pdtexttimer = pdtexttimer + dt
        if pdtexttimer > 3 then
            pdtexttimer = 0
            pdamage = 0
        end
    end

    if pheal > 0 then
        phtexttimer = phtexttimer + dt
        if phtexttimer > 3 then
            phtexttimer = 0
            pheal = 0
        end
    end

    if edamage > 0 then
        edtexttimer = edtexttimer + dt
        if edtexttimer > 3 then
            edtexttimer = 0
            edamage = 0
        end
    end
    

    Timer.update(dt)

   
end

function BattleState:render()
    love.graphics.draw(gTextures['FieldBG'], 0, 85, 0, 1, 1)
    love.graphics.draw(gTextures['BattleBG'], 0, 471, 0, .25, .25)
    love.graphics.draw(gTextures['ChooseBG'], 36, 405, 0, .25, .25)
    love.graphics.draw(gTextures['StatBarBG'], 0, 0, 0, .25, .25)
    love.graphics.draw(gTextures['WordBoard'], 10,500, 0, 4.26, 1.05)

    --shadowed
    love.graphics.setColor(34, 32, 52, 255)
    love.graphics.draw(gTextures['Refshre'], 1044,669, 0, 1.05, 1.15)


    plyrhealth = love.graphics.newQuad(0, 0, chp, 50, gTextures['Health']:getDimensions())
    mana = love.graphics.newQuad(0, 0, 450, 30, gTextures['Mana']:getDimensions())
    Enmyhealth = love.graphics.newQuad(0, 0, ehp, 50, gTextures['Health']:getDimensions())
    rfrshvisualcd = love.graphics.newQuad(0, 0, rfrsh, 55, gTextures['Refshre']:getDimensions())


    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.draw(gTextures['Deleet'], 815,417, 0, .6, .6)
    love.graphics.draw(gTextures['Entre'], 880,425, 0, 1, 1)
    love.graphics.draw(gTextures['Attak'], 1044,529, 0, 1.05, 1.15)
    love.graphics.draw(gTextures['Regne'], 1044,599, 0, 1.05, 1.15)
    love.graphics.draw(gTextures['Refshre'], rfrshvisualcd,1044,669, 0, 1.05, 1.15)
    love.graphics.draw(gTextures['Health'], plyrhealth, 22,13, 0, 1, .7)
    love.graphics.draw(gTextures['Mana'], mana, 22, 48, 0, 1, .7)
    love.graphics.draw(gTextures['Health'], Enmyhealth, 1340,13, 0, -1, .7)

    love.graphics.setFont(gFonts['small'])
    love.graphics.setColor(255, 0, 0, 255)
    if pdamage > 0 then
        love.graphics.printf('-'..pdamage, 1030, 142, VIRTUAL_WIDTH)
    end
    if edamage > 0 then
        love.graphics.printf('-'..edamage, 283, 142, VIRTUAL_WIDTH)
    end
    if pheal > 0 then
        love.graphics.setColor(0, 255, 0, 255)
        love.graphics.printf('+'..pheal, 283, 112, VIRTUAL_WIDTH)
    end

    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.setFont(gFonts['verysmall'])
    love.graphics.printf(characterhp..'/500', 535, 20, VIRTUAL_WIDTH)
    love.graphics.printf(enemyhp..'/200', 750, 20, VIRTUAL_WIDTH)

    love.graphics.setFont(gFonts['verysmall'])
    love.graphics.printf(mousex, 0, 10, VIRTUAL_WIDTH, 'center')
    love.graphics.printf(mousey, 0, 30, VIRTUAL_WIDTH, 'center')
    love.graphics.printf(math.floor(timer), 0, 50, VIRTUAL_WIDTH, 'center')
    love.graphics.printf(charactermp, 0, 70, VIRTUAL_WIDTH, 'center')
    
    gameboard:render(.45, .4, disabled, poisoned, frozen)
    choiceboard:render(.32, .31, disabled, poisoned, frozen)

    if f2d > 0 or gg > 0 then
        monster:render()
        player:render()
    end

    -- end bg
    if isviva == 1 then
        love.graphics.draw(gTextures['viva'], 244,219, 0, 1.5, 1.5)
    elseif isviva == 2 then
        love.graphics.draw(gTextures['gg'], 244,219, 0, 1.5, 1.5)
    end
    
    love.graphics.setColor(255, 255, 255, self.transitionAlpha)
    love.graphics.rectangle('fill', 0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)

    
end





