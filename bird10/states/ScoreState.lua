--[[
    ScoreState Class
    Author: Colton Ogden
    cogden@cs50.harvard.edu

    A simple state used to display the player's score before they
    transition back into the play state. Transitioned to from the
    PlayState when they collide with a Pipe.
]]

ScoreState = Class{__includes = BaseState}

--[[
    When we enter the score state, we expect to receive the score
    from the play state so we know what to render to the State.
]]
function ScoreState:enter(params)
    self.score = params.score
end

function ScoreState:update(dt)
    -- go back to play if enter is pressed
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('countdown')
    end
end

function ScoreState:render()
    img = love.graphics.newImage("flappy4MedalsSprite.jpeg")
 
  -- Let's say we want to display only the top-left 
  -- 32x32 quadrant of the Image:
  top_left = love.graphics.newQuad(0, 0, 75, 75, img:getDimensions())
 
  -- And here is bottom left:
  bottom_left = love.graphics.newQuad(0, 75, 75, 75, img:getDimensions())

  -- top right
  top_right = love.graphics.newQuad(75, 0, 75, 75, img:getDimensions())

  -- bottom right
  bottom_right = love.graphics.newQuad(75, 75, 75, 75, img:getDimensions())

    -- simply render the score to the middle of the screen
    love.graphics.setFont(flappyFont)
    love.graphics.printf('Oof! You lost!', 0, 64, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(mediumFont)
    love.graphics.printf('Score: ' .. tostring(self.score), 0, 100, VIRTUAL_WIDTH, 'center')
    if self.score < 2 then
      love.graphics.printf('You won a tin medal!', 0, 120, VIRTUAL_WIDTH, 'center')
      love.graphics.draw(img, bottom_right, 220, 200)
    elseif self.score < 5 then
      love.graphics.printf('You won a bronze medal!', 0, 120, VIRTUAL_WIDTH, 'center')
      love.graphics.draw(img, bottom_left, 220, 200)
    elseif self.score < 10 then
      love.graphics.printf('You won a silver medal!', 0, 120, VIRTUAL_WIDTH, 'center')
      love.graphics.draw(img, top_right, 220, 200)
    else
      love.graphics.printf('You won a gold medal!', 0, 120, VIRTUAL_WIDTH, 'center')
      love.graphics.draw(img, bottom_left, 220, 200)
    end
   
    love.graphics.printf('Press Enter to Play Again!', 0, 160, VIRTUAL_WIDTH, 'center')
end
