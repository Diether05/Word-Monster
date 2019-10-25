--libraries
Class = require 'lib/class'
push = require 'lib/push'
Timer = require 'lib/knife.timer'
Chain = require 'lib/knife.chain'

-- utility
require 'src/StateMachine'
require 'src/Util'

-- game pieces
require 'src/Board'
require 'src/Tile'
require 'src/Entity'


-- game states
require 'src/states/BaseState'
require 'src/states/StartState'
require 'src/states/BattleState'

gFonts = {
    ['verysmall'] = love.graphics.newFont('fonts/font.ttf', 16),
    ['small'] = love.graphics.newFont('fonts/font.ttf', 32),
    ['medium'] = love.graphics.newFont('fonts/font.ttf', 48),
    ['large'] = love.graphics.newFont('fonts/font.ttf', 64),
    ['XL'] = love.graphics.newFont('fonts/font.ttf', 96)
}

gSounds = {
    ['tiding'] = love.audio.newSource('assets/sound/correct.wav'),
    ['eeeng'] = love.audio.newSource('assets/sound/Wrong.wav'),
    ['batle'] = love.audio.newSource('assets/sound/battlebg.wav'),
    ['main'] = love.audio.newSource('assets/sound/mainsfx.wav'),
    ['as1'] = love.audio.newSource('assets/sound/punchkick.wav'),
    ['as2'] = love.audio.newSource('assets/sound/light.wav'),
    ['as3'] = love.audio.newSource('assets/sound/slash.wav'),
    ['as4'] = love.audio.newSource('assets/sound/ice.wav'),
    ['as5'] = love.audio.newSource('assets/sound/echo.wav'),
    ['as6'] = love.audio.newSource('assets/sound/heal.wav'),
    ['sviva'] = love.audio.newSource('assets/sound/victory.wav'),
    ['sgg'] = love.audio.newSource('assets/sound/defeat.wav'),
    ['select'] = love.audio.newSource('assets/sound/select.wav')
    
}

gTextures = {
    ['StartMenuBG'] = love.graphics.newImage('assets/graphics/StartMenuBG.png'),
    ['FieldBG'] = love.graphics.newImage('assets/graphics/bg/fieldbg.png'),
    ['BattleBG'] = love.graphics.newImage('assets/graphics/bg/BattleBG.png'),
    ['ChooseBG'] = love.graphics.newImage('assets/graphics/bg/choosebg.png'),
    ['StatBarBG'] = love.graphics.newImage('assets/graphics/bg/statbarbg.png'),
    ['WordTiles'] =  love.graphics.newImage('assets/graphics/Tile.png'),
    ['WordBoard'] =  love.graphics.newImage('assets/graphics/tilesboard.png'),
    ['Entre'] =  love.graphics.newImage('assets/graphics/button/Enter.png'),
    ['Deleet'] =  love.graphics.newImage('assets/graphics/button/Delete.png'),
    ['Attak'] =  love.graphics.newImage('assets/graphics/button/Attack.png'),
    ['Regne'] =  love.graphics.newImage('assets/graphics/button/regen.png'),
    ['Refshre'] =  love.graphics.newImage('assets/graphics/button/refresh.png'),
    ['Health'] =  love.graphics.newImage('assets/graphics/stats/life.png'),
    ['Mana'] =  love.graphics.newImage('assets/graphics/stats/mana.png'),
    ['shad'] =  love.graphics.newImage('assets/graphics/stats/shadowml.png'),
    ['normal'] =  love.graphics.newImage('assets/graphics/enemystat/normal.png'),
    ['strong'] =  love.graphics.newImage('assets/graphics/enemystat/strong.png'),
    ['poison'] =  love.graphics.newImage('assets/graphics/enemystat/poison.png'),
    ['ice'] =  love.graphics.newImage('assets/graphics/enemystat/ice.png'),
    ['quick'] =  love.graphics.newImage('assets/graphics/enemystat/quick.png'),
    ['viva'] =  love.graphics.newImage('assets/graphics/Victory.png'),
    ['gg'] =  love.graphics.newImage('assets/graphics/Lost.png'),
    ['i1'] =  love.graphics.newImage('assets/graphics/idle/1.png'),
    ['i2'] =  love.graphics.newImage('assets/graphics/idle/2.png'),
    ['i3'] =  love.graphics.newImage('assets/graphics/idle/3.png'),
    ['i4'] =  love.graphics.newImage('assets/graphics/idle/4.png'),
    ['i5'] =  love.graphics.newImage('assets/graphics/idle/5.png'),
    ['i6'] =  love.graphics.newImage('assets/graphics/idle/l.png'),
    ['a1'] =  love.graphics.newImage('assets/graphics/attack/1.png'),
    ['a2'] =  love.graphics.newImage('assets/graphics/attack/2.png'),
    ['a3'] =  love.graphics.newImage('assets/graphics/attack/3.png'),
    ['a4'] =  love.graphics.newImage('assets/graphics/attack/4.png'),
    ['a5'] =  love.graphics.newImage('assets/graphics/attack/5.png'),
    ['a6'] =  love.graphics.newImage('assets/graphics/attack/love.png')

}

gFrames = {
    ['tiles'] = GenerateTileQuads(gTextures['WordTiles']),
}

iFrames = {
    ['1'] = GenerateFrames(gTextures['i1'],5,1,135,232,27),
    ['2'] = GenerateFrames(gTextures['i2'],5,1,147,190,20),
    ['3'] = GenerateFrames(gTextures['i3'],5,1,205,212,10),
    ['4'] = GenerateFrames(gTextures['i4'],5,1,223,280,30),
    ['5'] = GenerateFrames(gTextures['i5'],5,1,124,280,25),
    ['6'] = GenerateFrames(gTextures['i6'],5,1,148,270,17)
}

aFrames = {
    ['1'] = GenerateFrames(gTextures['a1'],2,10,790,210,17),
    ['2'] = GenerateFrames(gTextures['a2'],2,8,900,255.85,17),
    ['3'] = GenerateFrames(gTextures['a3'],2,10,733,204.7, 0),
    ['4'] = GenerateFrames(gTextures['a4'],2,10,733,204.7, 0),
    ['5'] = GenerateFrames(gTextures['a2'],2,8,900,255.85,17),
    ['6'] = GenerateFrames(gTextures['a6'],2,8,910,256,17)
}