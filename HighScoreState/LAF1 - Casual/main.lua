
require 'src/dependencies'

function love.load()
	love.window.setTitle("Your Game")
	gStateMachine=StateMachine{
		['highscore']=function() return HighScoreState() end
	}
	--TRY GIVING 2 STARS OR 1 STARS OR NO STAR AT ALL
	gStateMachine:change('highscore',{
		stars=3
	})
-- love.graphics.setFont(love.graphics.newFont(50))
end

-- love.audio.setVolume(0)
function love.update(dt)
	--The next line is to improve performance (even if a bit)
	--Also if you are using push then you just have to modify love.mouse.getPosition() with _:toGame(love.mouse.getPosition())
	love.mouse.x,love.mouse.y=love.mouse.getPosition()
	gStateMachine:update(dt)

	love.mouse.justPressed=nil
	love.keyboard.lastKeyPressed=nil
	love.mouse.justReleased=nil
end

love.graphics.setBackgroundColor(0.4,0.4,0.4)

function love.draw()
	love.graphics.draw(gImages['background'])
	gStateMachine:render()
end

function love.mousepressed(x,y,btn) love.mouse.justPressed=btn end
function love.keypressed(key) love.keyboard.lastKeyPressed=key end
function love.mousereleased(x,y,btn) love.mouse.justReleased=true end