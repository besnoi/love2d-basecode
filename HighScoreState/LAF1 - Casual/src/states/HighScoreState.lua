--[[
	HighScoreState for Casual Games- Part of the big love2d-basecode project.
	Written By Neer (https://github.com/YoungNeer/love2d-basecode)
	You are free remove this header if you are uncomfortable with it and of-course same goes for other comments
]]--


HighScoreState=Class{__includes=BaseState}

function HighScoreState:init()
	love.graphics.setFont(gFonts['statsFont'])

	self:initMagicNumbers()

	self.buttonAnim={Anima:init(),Anima:init(),Anima:init()}
	self.bannerAnim=Anima:init()
	self.starAnim=Anima:init()
	self.backgroundAnim=Anima:init()
	self.statsAnim=Anima:init()
	self.infoAnim={Anima:init(),Anima:init()}
	self.statsIconAnim=Anima:init()
	self.textAnim={Anima:init(),Anima:init()}

	for i=1,3 do self.buttonAnim[i]:newAnimation('scale',1,1) end
	for i=1,2 do self.infoAnim[i]:newAnimation('move',70) end
	self.textAnim[1]:startNewTypingAnimation("Your Score:",20)
	self.textAnim[2]:startNewTypingAnimation("Time Taken:",20)
	self.bannerAnim:startNewAnimation('scale',0.7)
	self.starAnim:startNewAnimation('scale',0.8,0.8)
	self.statsAnim:startNewAnimation('scale',1)
	self.statsIconAnim:newAnimation('scale',1,1)
	self.statsIconAnim:newAnimation('rotate',math.rad(360))
	self.backgroundAnim:startNewAnimation('scale',0.5,0.5)

	self:initParticleSystem()
	self.starsanim=0
	self.starTimer=false

end

function HighScoreState:enter(params)
	self.stars=params.stars or 1
	self.isHighscore=params.isHighscore or false
	self.score=params.score or 30
	self.timeTaken=params.timeTaken or 105
	--since the s in our font looks exactly like 5 we have to make it look smaller
	self.sPosX=gFonts['statsInfoFont']:getWidth(tostring(self.timeTaken))+(self.timeTaken<10 and 3 or 0)+(self.timeTaken>100 and -4 or 0)
end

function HighScoreState:update(dt)
	for i=1,2 do self.infoAnim[i]:updateM(3,3) end
	for i=1,3 do self.buttonAnim[i]:updateS(0.02,0.02) end
	for i=1,2 do self.textAnim[i]:updateT(dt) end
	self.statsAnim:updateS(0.05)
	self.statsIconAnim:updateS(0.05,0.05)
	self.backgroundAnim:updateS(0.04,0.04)
	self.bannerAnim:updateS(0.04)
	self.starAnim:updateS(0.025,0.025)

	if self.starTimer==nil then self:hoverButtons() end

	if self.bannerAnim:animationOver() and self.starTimer==false then
		self.starTimer=0
	end

	if self.statsAnim:animationOver() and not self.infoAnim[1]:animationStarted() then
		self.infoAnim[1]:animationStart()
		self.infoAnim[2]:animationStart()
	end


	if self.starTimer==nil and not self.buttonAnim[1]:animationStarted() then
		for i=1,3 do self.buttonAnim[i]:animationStart() end
		-- self.statsAnim:animationStart()
		-- self.textAnim[1]:animationStart()
	end
	
	if self.statsAnim:animationOver() and not self.statsIconAnim:animationStarted() then
		self.statsIconAnim:animationStart()
	end		

	if self.starTimer then
		self.starTimer=self.starTimer+dt
		if self.starTimer>1.2 then
			self.starTimer=0
			if self.starsanim==0 and self.stars>=1 then
				self:oneStarPEffect()
				playSound(gSounds.stars[1])
				self.starsanim=1
				if self.stars==1 then self.starTimer=nil end
			elseif self.starsanim==1 and self.stars>=2 then
				self:twoStarPEffect()
				playSound(gSounds.stars[2])
				if self.stars==2 then self.starTimer=nil end
				self.starsanim=2
			elseif self.starsanim==2 and self.stars>=3 then
				self:threeStarPEffect()		
				playSound(gSounds.stars[3])
				self.starTimer=nil
				self.starsanim=3
			end
		end
	end

	self.psystem.big.y=self.psystem.big.y+0.1
	-- self.psystem.small.y=self.psystem.small.y+0.1
	
	self.psystem.small.obj:update(dt)
	self.psystem.big.obj:update(dt)
end

function HighScoreState:hoverButtons()
	--[[
		NOTE: BUTTONS ARE ASSUMED IN THE FORMAT PLAY -> RESTART -> MAIN-MENU
		Also note that in this context sx=sy since we are scaling them both with same velocity and by same magnitude
	]]

	for i=1,3 do
		if love.mouse.justReleased then self.buttonAnim[i].buttonClicked=nil end
		if love.mouse.x>BUTTON_X+(i-1)*(BUTTON_WIDTH+BUTTON_GAP) and love.mouse.y>BUTTON_Y  and love.mouse.x<BUTTON_X+BUTTON_WIDTH+(i-1)*(BUTTON_WIDTH+BUTTON_GAP) and love.mouse.y<BUTTON_Y+BUTTON_HEIGHT then
			if love.mouse.justPressed then self.buttonAnim[i].buttonClicked=true end
			if love.mouse.justReleased then
				if i==1 then
					print('Play Next Level')
				elseif i==2 then
					print('Restart game')
				else
					print('Go to Main-Menu')
				end
			end
			
			self.buttonAnim[i]:animationMark()
			self.buttonAnim[i]:startNewAnimation('scale',0.15,0.15,true)
			self.buttonAnim[i].mark.sx=math.min(1.15,self.buttonAnim[i].mark.sx)
			self.buttonAnim[i].mark.sy=self.buttonAnim[i].mark.sx
		else
			self.buttonAnim[i].buttonClicked=nil
			if self.buttonAnim[i]:getSX()>1 then
				self.buttonAnim[i]:animationMark()
				self.buttonAnim[i]:startNewAnimation('scale',1-self.buttonAnim[i]:getSX(),1-self.buttonAnim[i]:getSY(),true)
			end
		end
	end
end

function HighScoreState:render()

	self.backgroundAnim:render(gImages['hbackground'],BACKGROUND_X+BACK_WIDTH/2,BACKGROUND_Y+BACK_HEIGHT/2,0,0.5,0.5,BACK_WIDTH/2,BACK_HEIGHT/2)
	self.bannerAnim:render(gImages['hbanner'],BANNER_X+BANNER_WIDTH/2,BANNER_Y,0,0.3,1,BANNER_WIDTH/2)
	self:drawStats()
	self:drawButtons() 
	self:drawStars()
	self:renderParticles()

end

function HighScoreState:drawStats()
	self.statsAnim:render(gImages['hstats'],STATS_X,STATS_Y,0,0,1,0,0)
	self.statsAnim:render(gImages['hstats'],STATS_X,STATS_Y+STATS_GAP,0,0,1,0,0)
	self.statsIconAnim:render(gImages['hScore'],STATS_X+28,STATS_Y+20,0,0,0,STATS_ICON_WIDTH/2,STATS_ICON_HEIGHT/2)
	self.statsIconAnim:render(gImages['hTime'],STATS_X+28,STATS_Y+20+STATS_GAP,0,0,0,STATS_ICON_WIDTH/2,STATS_ICON_HEIGHT/2)
	love.graphics.setColor(1,0.371,0)
	love.graphics.setFont(gFonts['statsFont'])	
	self.textAnim[1]:draw(TEXT_POS_X,TEXT_POS_Y)
	self.textAnim[2]:draw(TEXT_POS_X,TEXT_POS_Y+STATS_GAP)
	
	love.graphics.setColor(1,1,1)
	love.graphics.setFont(gFonts['statsInfoFont'])

	if self.infoAnim[1]:animationStarted() then
		self.infoAnim[1]:printf(self.score..'/'..TOTAL_SCORE,STATS_X-50,STATS_Y+13,STATS_WIDTH,'center')
		self.infoAnim[2]:printf(self.timeTaken,STATS_X-50,STATS_Y+13+STATS_GAP,STATS_WIDTH-10,'center')
	end

	love.graphics.setFont(gFonts['statsInfoFontSmall'])
	if self.infoAnim[2]:animationOver() then
		love.graphics.printf("s",STATS_X+15+self.sPosX,STATS_Y+16+STATS_GAP,STATS_WIDTH-10,'center')
	end
	love.graphics.setColor(1,1,1)
	
end

function HighScoreState:drawButtons()
	self.buttonAnim[1]:renderQuad(gImages['hSpriteSheet'],gSprites['buttons'][self.buttonAnim[1].buttonClicked and 2 or 1][1],BUTTON_X+BUTTON_WIDTH/2,BUTTON_Y+BUTTON_HEIGHT/2,0,0,0,BUTTON_WIDTH/2,BUTTON_HEIGHT/2)
	self.buttonAnim[2]:renderQuad(gImages['hSpriteSheet'],gSprites['buttons'][self.buttonAnim[2].buttonClicked and 2 or 1][2],BUTTON_X+1.5*BUTTON_WIDTH+BUTTON_GAP,BUTTON_Y+BUTTON_HEIGHT/2,0,0,0,BUTTON_WIDTH/2,BUTTON_HEIGHT/2)
	self.buttonAnim[3]:renderQuad(gImages['hSpriteSheet'],gSprites['buttons'][self.buttonAnim[3].buttonClicked and 2 or 1][3],BUTTON_X+BUTTON_WIDTH/2+2*(BUTTON_WIDTH+BUTTON_GAP),BUTTON_Y+BUTTON_HEIGHT/2,0,0,0,BUTTON_WIDTH/2,BUTTON_HEIGHT/2)
end

function HighScoreState:drawStars()

	self.starAnim:renderQuad(gImages['hSpriteSheet'],gSprites.greyStar[1],STAR_X+STAR_WIDTH/2,STAR_Y+STAR_HEIGHT/2,0,0.1,0.1,STAR_WIDTH/2,STAR_HEIGHT/2)
	self.starAnim:renderQuad(gImages['hSpriteSheet'],gSprites.greyStar[2],STAR_X+1.5*STAR_WIDTH,STAR_Y+STAR_HEIGHT/2,0,0.1,0.1,STAR_WIDTH/2,STAR_HEIGHT/2)
	self.starAnim:renderQuad(gImages['hSpriteSheet'],gSprites.greyStar[3],STAR_X+2.5*STAR_WIDTH,STAR_Y+STAR_HEIGHT/2,0,0.1,0.1,STAR_WIDTH/2,STAR_HEIGHT/2)

	if self.starsanim>=1 then
		love.graphics.draw(gImages['hSpriteSheet'],gSprites.yellowStar[1],STAR_X,STAR_Y)
	end
	if self.starsanim>=2 then
		love.graphics.draw(gImages['hSpriteSheet'],gSprites.yellowStar[2],STAR_X+STAR_WIDTH,STAR_Y)
	end
	if self.starsanim==3 then
		love.graphics.draw(gImages['hSpriteSheet'],gSprites.yellowStar[3],STAR_X+2*STAR_WIDTH,STAR_Y)
	end
end

function HighScoreState:renderParticles()
	--At the last moment I found that the small particles doesn't look good (in this case) so i commented this out
	-- love.graphics.draw(self.psystem.small.obj,self.psystem.small.x,self.psystem.small.y)
	love.graphics.draw(self.psystem.big.obj,self.psystem.big.x,self.psystem.big.y)
end

function HighScoreState:initParticleSystem()
	
	self.psystem={
		small={
			obj=love.graphics.newParticleSystem(gImages.particles[1],100),
			buffer=10,
			x=STAR_X,
			y=STAR_Y+40
		},big={
			obj=love.graphics.newParticleSystem(gImages.particles[2],100),
			buffer=8,
			x=STAR_X-40,
			y=STAR_Y
		}
	}
end

function HighScoreState:oneStarPEffect()
	self.psystem.small.obj:setEmissionArea('normal',60,60)
	self.psystem.small.obj:setLinearAcceleration(-100,0,0,1000)
	self.psystem.small.obj:setParticleLifetime(1,4)
	self.psystem.small.obj:setSpin(0,3*math.pi)
	self.psystem.small.obj:setSpinVariation(1)
	self.psystem.small.obj:setRelativeRotation(true)
	-- self.psystem.small.obj:setRadialAcceleration(50)
	self.psystem.small.obj:setSizes(1.3,1,0.9,0.8,0.5,0.5,0.2)
	
	self.psystem.small.obj:setSpeed(-80)
	
	self.psystem.big.obj:setEmissionArea('normal',80,40)
	self.psystem.big.obj:setLinearAcceleration(-100,-100,0,1000)
	self.psystem.big.obj:setParticleLifetime(1,3)
	self.psystem.big.obj:setSpin(0,4*math.pi)	
	self.psystem.big.obj:setSpeed(-60)	
	self.psystem.big.obj:setSizes(1.3,0.9,1.3,0.9,0.5,0.3)
	
	self.psystem.big.obj:setRadialAcceleration(50)

	self.psystem.small.obj:emit(self.psystem.small.buffer)
	self.psystem.big.obj:emit(self.psystem.big.buffer)
end

function HighScoreState:twoStarPEffect()
	self.psystem.small.x=STAR_X+175
	self.psystem.big.x=STAR_X+175
	-- self.psystem.big.x=self.psystem.big.x+125
	self.psystem.small.obj:setEmissionArea('normal',60,20)
	self.psystem.small.obj:setLinearAcceleration(-100,-20,100,1000)
	self.psystem.small.obj:setParticleLifetime(1,4)
	self.psystem.small.obj:setSpin(0,3*math.pi)
	self.psystem.small.obj:setSpinVariation(1)
	self.psystem.small.obj:setRelativeRotation(true)
	-- self.psystem.small.obj:setRadialAcceleration(50)
	self.psystem.small.obj:setSizes(1.3,1,0.9,0.8,0.5,0.5,0.2)
	
	self.psystem.small.obj:setSpeed(-100,100)
	
	self.psystem.big.obj:setEmissionArea('uniform',60,60)	
	self.psystem.big.obj:setLinearAcceleration(-100,-100,200,1000)
	self.psystem.big.obj:setParticleLifetime(1,3)
	self.psystem.big.obj:setSpin(0,4*math.pi)	
	self.psystem.big.obj:setSpeed(-100,100)
	self.psystem.big.obj:setSizes(1.3,0.9,1.3,0.9,0.5,0.3)
	
	self.psystem.big.obj:setRadialAcceleration(50)

	-- self.psystem.small.obj:emit(2*self.psystem.small.buffer)
	self.psystem.big.obj:emit(self.psystem.big.buffer)
end

function HighScoreState:threeStarPEffect()
	self.psystem.small.x=STAR_X+350
	self.psystem.big.x=STAR_X+370
	self.psystem.big.y=STAR_Y+80
	-- self.psystem.big.x=self.psystem.big.x+125
	self.psystem.small.obj:setEmissionArea('uniform',60,60)
	self.psystem.small.obj:setLinearAcceleration(-100,-20,300,1000)
	self.psystem.small.obj:setParticleLifetime(1,4)
	self.psystem.small.obj:setSpin(0,3*math.pi)
	self.psystem.small.obj:setSpinVariation(1)
	self.psystem.small.obj:setRelativeRotation(true)
	-- self.psystem.small.obj:setRadialAcceleration(50)
	self.psystem.small.obj:setSizes(1.3,1,0.9,0.8,0.5,0.5,0.2)
	
	self.psystem.small.obj:setSpeed(230)
	
	self.psystem.big.obj:setEmissionArea('uniform',60,20)	
	self.psystem.big.obj:setLinearAcceleration(-100,-20,200,1000)
	self.psystem.big.obj:setParticleLifetime(1,3)
	self.psystem.big.obj:setSpin(0,4*math.pi)	
	self.psystem.big.obj:setSpeed(100)
	self.psystem.big.obj:setSizes(1.3,0.9,1.3,0.9,0.5,0.3)
	
	self.psystem.big.obj:setRadialAcceleration(50)

	self.psystem.small.obj:emit(2*self.psystem.small.buffer)
	self.psystem.big.obj:emit(self.psystem.big.buffer)
end

function HighScoreState:initMagicNumbers()
	BACKGROUND_X=400-211
	BACKGROUND_Y=300-365/2

	BANNER_WIDTH=gImages['hbanner']:getWidth()

	BACK_WIDTH,BACK_HEIGHT=gImages['hbackground']:getDimensions()

	BANNER_X,BANNER_Y=176,52

	STAR_X,STAR_Y=205,150

	STAR_WIDTH,STAR_HEIGHT=125,125

	STATS_X=415
	STATS_Y=295
	STATS_WIDTH=147
	STATS_GAP=63
		
	STATS_ICON_WIDTH,STATS_ICON_HEIGHT=39,40

	TEXT_POS_X=250
	TEXT_POS_Y=306

	BUTTON_X,BUTTON_Y=247,425
	BUTTON_WIDTH,BUTTON_HEIGHT=92,96
	BUTTON_GAP=25

	TOTAL_SCORE=35
	
end
