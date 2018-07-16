--[[ mucking around with ideas from:
http://lua.space/gamedev/handling-input-in-lua
to get them in my head]]

function love.load()
    drawColours = {0.5, 0.5, 0.5, 1}
    
    wordsPos = {x=10, y=400}

    test="hello world"

    local joysticks = love.joystick.getJoysticks()
    joystick = joysticks[1]
 
    gameStates = {}

    gameStates.colourState = require "colourState"
    gameStates.movementState = require "movementState"

    state = gameStates.colourState
end

function love.update()
    test="hello world"
    checkInputsDown()
end
 
function love.draw()
    state.draw()
end

-- PROCESS INPUTS.. should all be in a state manager, not main

function inputHandler(input)
    local action = state.bindings[input]
    if action then
        return action()
    end
end

function checkInputsDown(dt)
    -- Good way to pipe dt down and up?
    -- return bool then call function in each state?
    for k,v in pairs(state.keysDown) do
        if love.keyboard.isDown(k) then
            inputDown(state.keysDown, k)
        end
    end

    for k,v in pairs(state.buttonsDown) do
        if joystick and joystick:isGamepadDown(k) then
            inputDown(state.buttonsDown, k)
        end
    end
end

function inputDown(array, input)
    local binding = array[input]
    return inputHandler(binding)
end

function love.keypressed(k)
    local binding = state.keys[k]
    return inputHandler(binding)
end

function love.keyreleased(k)
    local binding = state.keysReleased[k]
    return inputHandler(binding)
end

function love.gamepadpressed(gamepad, button)
    local binding = state.buttons[button]
    return inputHandler(binding)
end

function love.gamepadreleased(gamepad, button)
    local binding = state.buttonsReleased[button]
    return inputHandler(binding)
end

-- TEST FUNCTIONS

-- should be part of colour state, but interesting I can call them here from colour state!!

function red()
    drawColours = {1, 0, 0, 1}
end

function green()
    drawColours = {0, 1, 0, 1}
end

function blue()
    drawColours = {0, 0, 1, 1}
end

function reset()
    drawColours = {0.5, 0.5, 0.5, 1}
end