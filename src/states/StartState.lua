
local positions = {}

StartState = Class{__includes = BaseState}

mousex = 0
mousey = 0

function StartState:init()
    self.currentMenuItem = 1
    self.transitionAlpha = 0
end

function StartState:update(dt)
    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end



    -- as long as can still input, i.e., we're not in a transition...
    if not self.pauseInput then
        -- change menu selection
        if love.keyboard.wasPressed('up') or love.keyboard.wasPressed('down') then
            self.currentMenuItem = self.currentMenuItem == 1 and 2 or 1
        end
        -- put virtual (x,y) game screen coordinates to variables 
        mousex, mousey = push:toGame(love.mouse.getPosition())

        if mousex == nil or mousey == nil then
            mousex = 0
            mousey = 0
        end
            if mousex > 615 and mousex < 744 then
                if mousey > 549 and mousey < 583 then
                    if self.currentMenuItem == 2 then
                        self.currentMenuItem = 1
                        gSounds['select']:play()
                    end
                    if love.mouse.isDown(1) then
                        love.keypressed('return')
                    end
                end
            end

            if mousex > 560 and mousex < 802 then
                if mousey > 616 and mousey < 650 then
                    if self.currentMenuItem == 1 then
                        self.currentMenuItem = 2
                        gSounds['select']:play()
                    end
                    if love.mouse.isDown(1) then
                        love.keypressed('return')
                    end
                end
            end

        -- switch to another state via one of the menu options
        if love.keyboard.wasPressed('return') or love.keyboard.wasPressed('space') then
            if self.currentMenuItem == 1 then
                gSounds['select']:play()
                gSounds['main']:stop()
                gSounds['batle']:play()
                -- tween, using Timer, the transition rect's alpha to 255, then
                -- transition to the BeginGame state after the animation is over
                Timer.tween(1, {
                    [self] = {transitionAlpha = 255}
                }):finish(function()
                    gStateMachine:change('battle')
                end)
            else
                love.event.quit()
            end

            -- turn off input during transition
            self.pauseInput = true
        end
    end

    -- update our Timer, which will be used for our fade transitions
    Timer.update(dt)
end

function StartState:render()

    love.graphics.draw(gTextures['StartMenuBG'], 0, 0)

    self:drawOptions(24)

    love.graphics.setColor(255, 255, 255, self.transitionAlpha)
    love.graphics.rectangle('fill', 0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)

end

--[[
    Draws "Start" and "Quit Game" text over semi-transparent rectangles.
]]
function StartState:drawOptions(y)
    -- draw rect behind start and quit game text
    love.graphics.setColor(255, 255, 255, 100)
    love.graphics.rectangle('fill', VIRTUAL_WIDTH / 2 - 150, VIRTUAL_HEIGHT / (3/2) + y, 300, 150, 6)

    -- draw Start text
    love.graphics.setFont(gFonts['medium'])
    self:drawTextShadow('Start', VIRTUAL_HEIGHT / (3/2) + y + 8)
    
    if self.currentMenuItem == 1 then
        love.graphics.setColor(99, 255, 155, 255)
    else
        love.graphics.setColor(48, 130, 96, 255)
    end
    
    love.graphics.printf('Start', 0, VIRTUAL_HEIGHT / (3/2) + y + 8, VIRTUAL_WIDTH, 'center')

    -- draw Quit Game text
    love.graphics.setFont(gFonts['medium'])
    self:drawTextShadow('Quit Game', VIRTUAL_HEIGHT / (3/2) + y + 75)
    
    if self.currentMenuItem == 2 then
        love.graphics.setColor(99, 255, 155, 255)
    else
        love.graphics.setColor(48, 130, 96, 255)
    end
    
    love.graphics.printf('Quit Game', 0, VIRTUAL_HEIGHT / (3/2) + y + 75, VIRTUAL_WIDTH, 'center')
    
    
end

--[[
    Helper function for drawing just text backgrounds; draws several layers of the same text, in
    black, over top of one another for a thicker shadow.
]]
function StartState:drawTextShadow(text, y)
    love.graphics.setColor(34, 32, 52, 255)
    love.graphics.printf(text, 2, y + 1, VIRTUAL_WIDTH, 'center')
    love.graphics.printf(text, 1, y + 1, VIRTUAL_WIDTH, 'center')
    love.graphics.printf(text, 0, y + 1, VIRTUAL_WIDTH, 'center')
    love.graphics.printf(text, 1, y + 2, VIRTUAL_WIDTH, 'center')
end
