require 'src/dependencies'

function love.load()
	gStateMachine=StateMachine{
		['prompt-state']=function() return PromptState() end,
		['background-state']=function() return BaseState() end
	}
	gStateMachine:change('prompt-state',{
		msg="Do you want to play again?"
	})
end

function love.update(dt)
	gStateMachine:update(dt)
	love.keyboard.lastKeyPressed=nil
end

function love.draw()
	love.graphics.setColor(1,1,1,1)
	love.graphics.draw(gImages.background)	
	-- love.graphics.setBackgroundColor(1,1,1)
	love.graphics.setColor(1,1,1,0.85)
	gStateMachine:render()
end

function love.keypressed(key) love.keyboard.lastKeyPressed=key end