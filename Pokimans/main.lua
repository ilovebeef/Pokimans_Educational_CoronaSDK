-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------
local myCurrentLvl = {
	BGText = {
		display.newImage ("Assets/Art/gameTexture/grassTexture.png", 100, 100),
		display.newImage ("Assets/Art/gameTexture/grassTexture.png", 300, 100),
		display.newImage ("Assets/Art/gameTexture/grassTexture.png", 500, 100),
		display.newImage ("Assets/Art/gameTexture/grassTexture.png", 100, 300),
		display.newImage ("Assets/Art/gameTexture/grassTexture.png", 300, 300),
		display.newImage ("Assets/Art/gameTexture/grassTexture.png", 500, 300),
		display.newImage ("Assets/Art/gameTexture/grassTexture.png", 100, 500),
		display.newImage ("Assets/Art/gameTexture/grassTexture.png", 300, 500),
		display.newImage ("Assets/Art/gameTexture/grassTexture.png", 500, 500)
	}
}
local myBackgroundGroup = display.newGroup ()
for i=1, #myCurrentLvl.BGText do
	myBackgroundGroup:insert (myCurrentLvl.BGText[i])
end

local sinXWalkUpSheet = graphics.newImageSheet ("Assets/Art/mainSin/gSinWalk_Up.png", {width = 240, height =240, numFrames = 7})
local sinXWalkDownSheet = graphics.newImageSheet ("Assets/Art/mainSin/gSinWalk_Down.png", {width = 240, height =240, numFrames = 7})
local sinXWalkLeftSheet = graphics.newImageSheet ("Assets/Art/mainSin/gSinWalk_Left.png", {width = 240, height =240, numFrames = 7})
local sinXWalkRightSheet = graphics.newImageSheet ("Assets/Art/mainSin/gSinWalk_Right.png", {width = 240, height =240, numFrames = 7})

local sinXSequeneces = {
	{name = "walkUp", sheet = sinXWalkUpSheet, start = 1, count = 7, time = 700, loopCount = 0},
	{name = "walkDown", sheet = sinXWalkDownSheet, start = 1, count = 7, time = 700, loopCount = 0},
	{name = "walkLeft", sheet = sinXWalkLeftSheet, start = 1, count = 7, time = 700, loopCount = 0},
	{name = "walkRight", sheet = sinXWalkRightSheet, start = 1, count = 7, time = 700, loopCount = 0}
}

local tempSinX = display.newSprite (sinXWalkUpSheet, sinXSequeneces)
tempSinX.x = 160
tempSinX.y = 200
tempSinX:play()
--tempSinX.ColDection = display.newRect (tempSinX.x, tempSinX.y, 30, 90)





local arrowPressed = false
local arrowCurrent = "Up"
local arrowUp = display.newImage ("Assets/Art/GUI/gamePlay/Arrow.png", 160, 360)
local arrowDown = display.newImage ("Assets/Art/GUI/gamePlay/Arrow.png", 160, 430)
local arrowLeft = display.newImage ("Assets/Art/GUI/gamePlay/Arrow.png", 100, 395)
local arrowRight = display.newImage ("Assets/Art/GUI/gamePlay/Arrow.png", 220, 395)
arrowDown:rotate (180)
arrowLeft:rotate (-90)
arrowRight:rotate (90)

arrowUp.ID = "Up"
arrowDown.ID = "Down"
arrowLeft.ID = "Left"
arrowRight.ID = "Right"

local myVel = 6

local function onUpdate (event)
	if (arrowPressed == true) then
		if (arrowCurrent == "Up") then
			myBackgroundGroup:translate (0,myVel)
		elseif (arrowCurrent == "Down") then
			myBackgroundGroup:translate (0,-myVel)
		elseif (arrowCurrent == "Left") then
			myBackgroundGroup:translate (myVel,0)
		elseif (arrowCurrent == "Right") then
			myBackgroundGroup:translate (-myVel,0)
		end
	end
end


local function arrowListner (event)
	if (event.phase == "began") then
		arrowPressed = true
		if (event.target.ID == "Up") then
			tempSinX:setSequence ("walkUp")
			tempSinX:play()
			arrowCurrent = "Up"
		elseif (event.target.ID == "Down") then
			tempSinX:setSequence ("walkDown")
			tempSinX:play()
			arrowCurrent = "Down"
		elseif (event.target.ID == "Left") then
			tempSinX:setSequence ("walkLeft")
			tempSinX:play()
			arrowCurrent = "Left"
		elseif (event.target.ID == "Right") then
			tempSinX:setSequence ("walkRight")
			tempSinX:play()
			arrowCurrent = "Right"
		end
	elseif (event.phase == "moved") then
		if (event.x >= (event.target.x+(event.target.contentWidth/3)) or 
			event.x <= (event.target.x-(event.target.contentWidth/3)) or
			event.y >= (event.target.y+(event.target.contentHeight/3)) or             
			event.y <= (event.target.y-(event.target.contentHeight/3))) then
			arrowPressed = false
			tempSinX:pause()
		end
	elseif (event.phase == "ended") then
		arrowPressed = false
		tempSinX:pause()
	end
	return true
end

arrowUp:addEventListener ("touch", arrowListner)
arrowDown:addEventListener ("touch", arrowListner)
arrowLeft:addEventListener ("touch", arrowListner)
arrowRight:addEventListener ("touch", arrowListner)
Runtime:addEventListener ("enterFrame", onUpdate)





