# Awesome Base-code for your LÖVE (ly) Game

The goal of this repository is to **make - the process of making games with LÖVE much faster**. Almost every game-jam out there allows you to use base-code and you may use base-code from your own game. But the problem is time and customization. Plucking out code from your game to use in another game can get very ugly and may sometimes take a lot of time and customization is also very difficult. So to solve this problem I recommended that you arrange base-code the way you arrange clothes in your wardrobe - all lined up in a closet or in this context all filed up in folder.

To get an idea of what I'm saying here's an example screenshot:-

<p align="center">
<a href="https://github.com/YoungNeer/love2d-basecode/blob/master/HighScoreState/LAF1 - Casual/">
  <img src="https://github.com/YoungNeer/love2d-basecode/blob/master/HighScoreState/LAF1 - Casual/assets/screens/demo.gif"/>
</a><br>
<span style="align:center">HighScore State for Casual Games (Highly Customizable)</span>
</p>

## Templates Arrangement

You can think each sub-repository as templates but I insist on calling them "states" like "HighScore State", "MainMenu State", etc. Each of these folders have more folders in it - which is "Look and Feel" (the idea is borrowed from Java). So *there's not one HighScoreState but several of them* - depending on the game that you are developing for eg.- casual, sci-fi, etc

## Customization

Each of the states are highly customizable - infact I believe by playing with the magic numbers (and changing the default resources) you can make your state completely different from the original state. It's not just the magic numbers that add to the customization but the entire base-code itself. Every function has been written keeping customization in mind. Say you don't want the particle effects then remove the essential function calls like initParticles and then keeping up with the error that shows up you can remove others such as update and drawParticles. And note that the default sprites used are mostly royalty-free so you don't have to worry about plagiarism, etc. To make things easy for you each ReadMe.md file in the main state folder has "CREDITS" section at the end of it - which lists all the resources like sound, sprites and fonts.

## Contribution

I'd love anyone's contribution. You don't have to create any particular aesthetic state- although I personally like modern-feel aesthetic. The only compulson is that if your contribution is a new state then it must follow the basic template - (i.e. all assets in "assets" folder with sub-folders 'images','fonts','audio' and 'screens' (if you have screenshots) and all the libraries used in the "lib" folder and finally all the source files in the "src" folder with the actual-state in the "states" folder. And note that the main.lua shouldn't be ANY more than 50 lines and there's currently no limit in the actual-state file but I'd recommend it to be less than 500 lines - but again that's not cumpulsory.

Finally all these compulsion exists only to give the best to the community. If your contribution doesn't match the template yet it has that "awesome" feel in it - then I'll myself (or try to) convert it to the format love2d-basecode expects it to be in. And also note that your contribution will be listed in the CREDITS section in the main ReadMe file along with the ReadMe file of the state that you contributed.

"Alone we can do so little, together we can do SO MUCH."

## Credits

Neer (https://github.com/YoungNeer)
