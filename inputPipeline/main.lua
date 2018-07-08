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

    -- bind all controls for the colours gamestate
    gameStates.colours = {
        -- bind to functions
        bindings = {
            showRed = red,
            showGreen = green,
            showBlue = blue,
            showGrey = reset,
            toMovement = function() state = gameStates.movement end,
        },
        -- keyboard bindings
        keys = {
            r = "showRed",
            g = "showGreen",
            b = "showBlue",
        },
        keysDown = {},
        keysReleased = {
            r = "showGrey",
            g = "showGrey",
            b = "showGrey",
            m = "toMovement",
        },
        -- controller bindings
        buttons = {
            b = "showRed",
            a = "showGreen",
            x = "showBlue",
            back = "toMovement",
        },
        buttonsDown = {},
        buttonsReleased = {
            b = "showGrey",
            a = "showGrey",
            x = "showGrey",
        },
        --update = function(dt)

        draw = function()
            -- I assume there's a nicer way to pass an appropriate obj to a function...
            love.graphics.setColor(
                drawColours[1],
                drawColours[2],
                drawColours[3],
                drawColours[4])
        
            love.graphics.rectangle('fill', 10, 10, 780, 285)
        end
    }

    gameStates.movement = {
        bindings = {
            -- button pressed/released require no dt
            toColours = function() state = gameStates.colours end,

            -- button down requires dt
            moveUp = function() wordsPos.y=wordsPos.y-5 end,
            moveDown = function() wordsPos.y=wordsPos.y+5 end,
            moveLeft = function() wordsPos.x=wordsPos.x-5 end,
            moveRight = function() wordsPos.x=wordsPos.x+5 end,
        },
        keys = {},
        keysDown = {
            w = "moveUp",
            s = "moveDown",
            a = "moveLeft",
            d = "moveRight",
        },
        keysReleased = {
            c = "toColours",
        },
        buttons = {},
        buttonsDown = {
            y = "moveUp",
            a = "moveDown",
            x = "moveLeft",
            b = "moveRight",
        },
        buttonsReleased = {
            back = "toColours",
        },
        draw = function()
            love.graphics.setColor(1, 1, 1, 1)
            love.graphics.print(test, wordsPos.x, wordsPos.y)
        end
    }

    state = gameStates.colours
end

function love.update()
    test="hello world"
    checkInputsDown()
end
 
function love.draw()
    state.draw()
end

-- PROCESS INPUTS

function inputHandler(input)
    local action = state.bindings[input]
    if action then
        return action()
    end
end

function checkInputsDown(dt)
    -- Good way to pipe dt down and up?
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