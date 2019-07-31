gSounds={
	stars={
		love.audio.newSource("assets/audio/star_1.mp3",'static'),
		love.audio.newSource("assets/audio/star_2.mp3",'static'),
		love.audio.newSource("assets/audio/star_3.mp3",'static')
	},
	['new-highscore']=love.audio.newSource("assets/audio/new_highscore.mp3",'static')
}

gImages={
	['hSpriteSheet']=love.graphics.newImage('assets/images/spritesheet.png'),
	['hbackground']=love.graphics.newImage('assets/images/hback.png'),
	['background']=love.graphics.newImage('assets/images/BG.png'),
	['hbanner']=love.graphics.newImage('assets/images/hbanner.png'),
	['hstats']=love.graphics.newImage('assets/images/hstats.png'),
	['hTime']=love.graphics.newImage('assets/images/statsTimer.png'),
	['hScore']=love.graphics.newImage('assets/images/statsScore.png'),
	particles={
		love.graphics.newImage('assets/images/particle3.png'),
		love.graphics.newImage('assets/images/particle4.png'),
	}
}

gFonts={
	['statsFont']=love.graphics.newFont("assets/fonts/c.ttf",21),
	['statsInfoFont']=love.graphics.newFont("assets/fonts/c.ttf",16),
	['statsInfoFontSmall']=love.graphics.newFont("assets/fonts/c.ttf",12)
}


function playSound(id)
	id:stop()
	id:play()
end

function generateQuads()
	return {
		yellowStar={
			love.graphics.newQuad(0,0,125,125,gImages['hSpriteSheet']:getDimensions()),
			love.graphics.newQuad(125,0,125,125,gImages['hSpriteSheet']:getDimensions()),
			love.graphics.newQuad(250,0,125,125,gImages['hSpriteSheet']:getDimensions())
		},
		greyStar={
			love.graphics.newQuad(0,125,125,125,gImages['hSpriteSheet']:getDimensions()),
			love.graphics.newQuad(125,125,125,125,gImages['hSpriteSheet']:getDimensions()),
			love.graphics.newQuad(250,125,125,125,gImages['hSpriteSheet']:getDimensions())
		},
		--1 when not-hovered and 2 when hovered
		buttons={{},{}}
	}
end
gSprites=generateQuads()

for i=1,2 do
	for j=1,3 do
		gSprites['buttons'][i][j]=love.graphics.newQuad(420+(j-1)*92,(i-1)*96,92,96,gImages['hSpriteSheet']:getDimensions())
	end
end
