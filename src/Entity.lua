Entity = Class{}

function Entity:init(char, state, x, y)
    self.chari = '1'
    self.chara = '1'
    self.chard = '1'
    self.state = state
    self.dt = 0
    self.currentFrame = 1
    self.x = x
    self.y = y
    self.o = -1
    self.timer = 0
    self.attack = 0
    self.stat = ''
    self.f2d = 0
    self.rf2d = 0
    cstat = 0
    self.c1 = 1
    self.c2 = 0

    if char == 1 then
        self.char = '1'
        self.y = self.y + 30
        self.ax = self.x - 1050 
        self.ay = self.y - 50
        self.ox = 1.4
        self.oy = 1.3
    elseif char == 2 then
        self.char = '2'
        self.y = self.y + 60
        self.ax = 150 
        self.ay = 50 
        self.ox = 1.3
        self.oy = 1.3
    elseif char == 3 then
        self.char = '3'
        self.y = self.y + 40
        self.ax = 100 
        self.ay = 50 
        self.ox = 1.7
        self.oy = 1.7
    elseif char == 4 then
        self.char = '4'
        self.ax = 100 
        self.ay = 50 
        self.ox = 1.7
        self.oy = 1.7
    elseif char == 5 then
        self.char = '5'
        self.ax = 100 
        self.ay = 50 
        self.ox = 1.35
        self.oy = 1.35
    elseif char == 6 then
        self.char = '6'
        self.ax = self.x - 45
        self.ay = self.y - 45
        self.o = 1
        self.ox = 1.3
        self.oy = 1.3
    end

end

function Entity:update(dt)  
    self.timer = self.timer + dt
    if self.f2d == 1 then
        self.rf2d = self.rf2d + dt
    end

    if self.state == 'idle' then
        self.dt = self.dt + dt*25
        if self.dt <= 25 then
            self.currentframe = math.floor(self.dt/5 + 1)
            self.f2d = 1
        else 
            self.dt = 0
        end
    elseif self.state == 'attack' then
        if self.char == '1' then
            self.dt = self.dt + dt*190
            if self.dt <= 190 then
                self.currentframe = math.floor(self.dt/10 + 1)
                self.f2d = 1
            else 
                self.dt = 0
                self.f2d = 0
                self.rf2d = 0
                self.state = 'idle' 
            end
        elseif self.char == '2' then
            self.dt = self.dt + dt*150
            if self.dt <= 150 then
                self.currentframe = math.floor(self.dt/10 + 1)
                self.f2d = 1
            else 
                self.dt = 0
                self.f2d = 0
                self.rf2d = 0
                self.state = 'idle'
                
            end
        elseif self.char == '3' then
            self.dt = self.dt + dt*200
            if self.dt <= 200 then
                self.currentframe = math.floor(self.dt/10 + 1)
                self.f2d = 1
            else 
                self.dt = 0
                self.f2d = 0
                self.rf2d = 0
                self.state = 'idle'
                
            end
        elseif self.char == '4' then
            self.dt = self.dt + dt*200
            if self.dt <= 200 then
                self.currentframe = math.floor(self.dt/10 + 1)
                self.f2d = 1
            else 
                self.dt = 0
                self.f2d = 0
                self.rf2d = 0
                self.state = 'idle'
                
            end
        elseif self.char == '5' then
            self.dt = self.dt + dt*150
            if self.dt <= 150 then
                self.currentframe = math.floor(self.dt/10 + 1)
                self.f2d = 1
            else 
                self.dt = 0
                self.f2d = 0
                self.rf2d = 0
                self.state = 'idle'
                
            end
        elseif self.char == '6' then
            self.dt = self.dt + dt*150
            if self.dt <= 150 then
                self.currentframe = math.floor(self.dt/10 + 1)
                self.f2d = 1
            else 
                self.dt = 0
                self.f2d = 0
                self.rf2d = 0
                self.state = 'idle'
                
            end
        end
    end

    if self.char == '6' then
    else
        if self.c1 == 1 then
            self.stat = 'normal'
        elseif self.c1 == 2 then
            if self.char == '2' then
                self.stat = 'strong'
            elseif self.char == '4' then
                self.stat = 'ice'
            elseif self.char == '3' then
                self.stat = 'poison'
            elseif self.char == '5' then
                self.stat = 'quick'
            else
                self.stat = 'normal'
            end
        elseif self.c1 == 3 then
            if self.c2 == 2 then
                if self.char == '2' then
                    self.stat = 'strong'
                elseif self.char == '3' then
                    self.stat = 'poison'
                elseif self.char == '4' then
                    self.stat = 'ice'
                elseif self.char == '5' then
                    self.stat = 'quick'
                else
                    self.stat = 'normal'
                end
            else
                self.stat = 'normal'
            end
        elseif self.c1 == 4 then
            if self.char == '2' then
                self.stat = 'strong'
            elseif self.char == '5' then
                self.stat = 'quick'
            else
                self.stat = 'normal'
            end
        elseif self.c1 == 5 then
            if self.char == '3' then
                self.stat = 'poison'
            elseif self.char == '5' then
                self.stat = 'quick'
            else
                self.stat = 'normal'
            end
        elseif self.c1 == 6 then
            if self.c2 == 2 then
                if self.char == '2' then
                    self.stat = 'strong'
                elseif self.char == '3' then
                    self.stat = 'poison'
                elseif self.char == '4' then
                    self.stat = 'ice'
                elseif self.char == '5' then
                    self.stat = 'quick'
                else
                    self.stat = 'normal'
                end
            else
                self.stat = 'normal'
            end
        elseif self.c1 == 7 then
            if self.char == '2' then
                self.stat = 'strong'
            elseif self.char == '3' then
                self.stat = 'poison'
            elseif self.char == '5' then
                self.stat = 'quick'
            else
                self.stat = 'normal'
            end
        elseif self.c1 == 8 then
            if self.char == '2' then
                self.stat = 'strong'
            elseif self.char == '4' then
                self.stat = 'ice'
            elseif self.char == '5' then
                self.stat = 'quick'
            else
                self.stat = 'normal'
            end
        elseif self.c1 == 9 then
            if self.c2 == 2 then
                if self.char == '2' then
                    self.stat = 'strong'
                elseif self.char == '3' then
                    self.stat = 'poison'
                elseif self.char == '4' then
                    self.stat = 'ice'
                elseif self.char == '5' then
                    self.stat = 'quick'
                else
                    self.stat = 'normal'
                end
            else
                self.stat = 'normal'
            end
        elseif self.c1 == 10 then
            if self.char == '5' then
                self.stat = 'quick'
            else
                self.stat = 'normal'
            end
        end
    end

    if self.stat == 'normal' then 
        cstat = self.timer * (450/6)
        if self.timer >= 6 then
            self.attack = 1
            self.c1 = self.c1 + 1
            self.c2 = math.random(1,2)
            self.dt = 0
            self.state = 'attack'
            self.f2d = 0
            self.rf2d = 0
        end
    elseif self.stat == 'strong' then
        cstat = self.timer * (450/12)
        if self.timer >= 12 then
            self.attack = 2
            self.c1 = self.c1 + 1
            self.c2 = math.random(1,2)
            self.dt = 0
            self.state = 'attack'
            self.f2d = 0
            self.rf2d = 0
        end
    elseif self.stat == 'poison' then
        cstat = self.timer * (450/15)
        if self.timer >= 15 then
            self.attack = 3
            self.c1 = self.c1 + 1
            self.c2 = math.random(1,2)
            self.dt = 0
            self.state = 'attack'
            self.f2d = 0
            self.rf2d = 0
        end
    elseif self.stat == 'ice' then
        cstat = self.timer * (450/20)
        if self.timer >= 20 then
            self.attack = 4
            self.c1 = self.c1 + 1
            self.c2 = math.random(1,2)
            self.dt = 0
            self.state = 'attack'
            self.f2d = 0
            self.rf2d = 0
        end
    elseif self.stat == 'quick' then
        cstat = self.timer * (450/2)
        if self.timer >= 2 then
            self.attack = 5
            self.c1 = self.c1 + 1
            self.c2 = math.random(1,2)
            self.dt = 0
            self.state = 'attack'
            self.f2d = 0
            self.rf2d = 0
        end
    end
    
    if self.c1 == 11 then
        self.c1 = 1
    end

    if self.char == '6' then
        return self.f2d
    else
        return self.attack
    end
end

function Entity:render()
    if self.f2d == 1 or self.rf2d > 0 then
        if self.state == 'idle' then
            love.graphics.draw(gTextures['i'..self.char], iFrames[self.char][self.currentframe], self.x,self.y, 0, self.o, 1)
        elseif self.state == 'attack' then
            love.graphics.draw(gTextures['a'..self.char], aFrames[self.char][self.currentframe], self.ax,self.ay, 0, self.ox, self.oy)
        end
    end
    

    if self.char == '6' then else
        nstat = love.graphics.newQuad(0, 0, cstat, 30, gTextures['normal']:getDimensions())
        sstat = love.graphics.newQuad(0, 0, cstat, 30, gTextures['strong']:getDimensions())
        pstat = love.graphics.newQuad(0, 0, cstat, 30, gTextures['poison']:getDimensions())
        istat = love.graphics.newQuad(0, 0, cstat, 30, gTextures['ice']:getDimensions())
        qstat = love.graphics.newQuad(0, 0, cstat, 30, gTextures['quick']:getDimensions())

        if self.stat == 'normal' then 
            love.graphics.draw(gTextures['normal'], nstat, 1340, 48, 0, -1, .7)
        elseif self.stat == 'strong' then       
            love.graphics.draw(gTextures['strong'], sstat, 1340, 48, 0, -1, .7)
        elseif self.stat == 'poison' then     
            love.graphics.draw(gTextures['poison'], pstat, 1340, 48, 0, -1, .7)
        elseif self.stat == 'ice' then   
            love.graphics.draw(gTextures['ice'], istat, 1340, 48, 0, -1, .7)
        elseif self.stat == 'quick' then    
            love.graphics.draw(gTextures['quick'], qstat, 1340, 48, 0, -1, .7)
        end
    end
end



