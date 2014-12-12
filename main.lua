
--variables
deathDelay = 0
score = 0



--background
bg = display.newImageRect("background.jpg",display.contentWidth,display.contentHeight)
bg.x = display.contentWidth*.5
bg.y = display.contentHeight*.5


--bird
bird = display.newImageRect("corona.png",100,100)
bird.x = display.contentWidth*.25
bird.y = display.contentHeight*.5
bird.xSpeed = 0
bird.ySpeed = -50

--wall
wall1 = display.newRect(0,0,200,display.contentHeight)
wall1.x = 500 +1500
wall1.y = 0
wall1:setFillColor(.8,.5,.2)
wall1.strokeWidth = 8
wall1:setStrokeColor(.5,1,0)

wall2 = display.newRect(0,0,200,display.contentHeight)
wall2.x = 500+750
wall2.y = display.contentHeight
wall2:setFillColor(.1,.5,.8)
wall2.strokeWidth = 8
wall2:setStrokeColor(0,1,.5)

--score text
myScoreText = display.newText("Score: 0",200,70,native.systemFont, 72)

function kill()
	deathDelay = 0
	bird.x = display.contentWidth*.25
	bird.y = display.contentHeight*.5
	bird.xSpeed = 0
	bird.ySpeed = -50
	wall1.x = 500 + 1500
	wall1.y = 0
	wall2.x = 500+750
	wall2.y = display.contentHeight
	score = 0
	myScoreText.text = "Score: 0"
end

function onEveryFrame(event)

	--move walls
	wall1.x = wall1.x - 9
	wall2.x = wall2.x - 9

	--reset walls
	if wall1.x < -200 then
		wall1.x = wall1.x + 1500
		wall1.y = math.random(-display.contentHeight*.4,0)
	end
	if wall2.x < -200 then
		wall2.x = wall2.x + 1500
		wall2.y = math.random(display.contentHeight*.8,display.contentHeight*1.4)
	end


	--add gravity
	bird.ySpeed = bird.ySpeed + 5

	--update position
	bird.x = bird.x + bird.xSpeed
	bird.y = bird.y + bird.ySpeed

	--check death
	if bird.y > display.contentHeight - 100 then
		bird.y = display.contentHeight - 100
		deathDelay = deathDelay + 1
		if deathDelay > 60 then
			kill()
		end
	end
	--check wall death
	if bird.y < wall1.y + wall1.height*.5 then
		if bird.x > wall1.x - wall1.width*.5 then
			if bird.x < wall1.x + wall1.width*.5 then
				kill()
			end
		end
	end
	if bird.y > wall2.y - wall2.height*.5 then
		if bird.x > wall2.x - wall2.width*.5 then
			if bird.x < wall2.x + wall2.width*.5 then
				kill()
			end
		end
	end
	--score
	if bird.x > wall2.x - wall2.width*.5 and bird.x < wall2.x + wall2.width*.5 then
		score = score + 1/22
		myScoreText.text = "Score: "..math.round(score)
	end
	if bird.x > wall1.x - wall1.width*.5 and bird.x < wall1.x + wall1.width*.5 then
		score = score + 1/22
		myScoreText.text = "Score: "..math.round(score)
	end
end
Runtime:addEventListener( "enterFrame", onEveryFrame)



function onTap(event)
	if deathDelay == 0 then
		bird.ySpeed = -50
	end

end
Runtime:addEventListener("tap",onTap)






