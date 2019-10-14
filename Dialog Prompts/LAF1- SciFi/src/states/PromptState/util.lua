function PromptState:check_mouse_hover(x,y,width,height)
	return love.mouse.getX()>=x and love.mouse.getX()<=x+width and
		   love.mouse.getY()>=y and love.mouse.getY()<=y+height
end

function PromptState:check_button_hover()
	self.no_hovered=self:check_mouse_hover(self.x+self.width-105,self.y+58,65,30) or nil
	self.yes_hovered=self:check_mouse_hover(self.x+40,self.y+58,65,30) or nil
	if love.mouse.isDown(1) then
		if self.yes_hovered then
			print("You clicked on Yes")
		end
		if self.no_hovered then
			print("You clicked on No")
		end
	end
end

function PromptState:check_closebtn_hover()
	self.closebtn_hovered=self:check_mouse_hover(self.x+self.width-5,self.y-10,15,15) or nil
	if love.mouse.isDown(1) and self.closebtn_hovered then
		gStateMachine:change('background-state')
		print("You made the dialog disappear")
	end
end