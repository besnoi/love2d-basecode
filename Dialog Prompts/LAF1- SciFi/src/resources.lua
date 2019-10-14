-- gSounds={
-- 	['yes-click']=love.audio.newSource("assets/audio/new_highscore.mp3",'static'),
-- 	['no-click']=love.audio.newSource("assets/audio/new_highscore.mp3",'static')
-- }

gImages={
	['background']=love.graphics.newImage("assets/images/back.jpg")
}

gFonts={
	['msgFont']=love.graphics.newFont("assets/fonts/Orbitron Medium.otf",21),
	['btnFont']=love.graphics.newFont("assets/fonts/Orbitron Medium.otf",18),
}

function playSound(id)
	id:stop()
	id:play()
end