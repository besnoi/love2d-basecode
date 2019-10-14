PromptState=Class{__includes=BaseState}

function PromptState:init()
	self.yes_hovered=nil
	self.no_hovered=nil
	self.closebtn_hovered=nil
end

function PromptState:enter(params)
	print("ia m her")
	self.msg=params.msg or "Are you sure you want to quit?"
	self.width=params.width or 300
	self.height=params.height or 100
	self.x=params.x or WWIDTH/2-self.width/2
	self.y=params.y or WHEIGHT/2-self.height/2
end

function PromptState:update(dt)
	--this function is responsible for what happens when you click button	
	self:check_button_hover()
	self:check_closebtn_hover()

	--this function is responsible for what happens when you close the dialog
	
end

function PromptState:render()
	self:renderWindow()
	self:renderX()
	self:renderButtons()
	self:renderText()
end

function PromptState:renderWindow()
	lovecc.setColor('lightGrey',0.9)
	love.graphics.rectangle('fill',self.x,self.y,self.width,self.height)	
	lovecc.setColor('slateGrey')
	love.graphics.rectangle('line',self.x-1,self.y-1,self.width,self.height)
end

function PromptState:renderButtons()
	if self.yes_hovered then
		lovecc.setColor('darkSlateGrey')				
	else
		lovecc.setColor('slateGrey')
	end
	love.graphics.rectangle("fill",self.x+40,self.y+58,65,30)              --yes

	if self.no_hovered then
		lovecc.setColor('darkSlateGrey')
	else
		lovecc.setColor('slateGrey')		
	end
	love.graphics.rectangle("fill",self.x+self.width-105,self.y+58,65,30)  --no
end

function PromptState:renderX()
	if self.closebtn_hovered then
		lovecc.setColor('slateGrey')
	else
		lovecc.setColor('darkSlateGrey')		
	end
	love.graphics.circle('fill',self.x+self.width,self.y,10,6)
	if self.closebtn_hovered then
		lovecc.setColor('darkSlateGrey')				
	else
		lovecc.setColor('lightSlateGrey')		
	end
	love.graphics.circle('fill',self.x+self.width,self.y,3,10)
end

function PromptState:renderText()
	lovecc.setColor("black")
    love.graphics.printf(self.msg,self.x,self.y+10,self.width,'center')
    love.graphics.setFont(gFonts.btnFont)   
    love.graphics.print("Yes",self.x+50,self.y+65)
    love.graphics.print("No",self.x+self.width-90,self.y+65)
end