--[[ mucking around with ideas from:
http://lua.space/gamedev/handling-input-in-lua
to get them in my head]]

function love.load()
    drawColours = {0.5, 0.5, 0.5, 1}
    
    rectPos = {x=10, y=10}

    test=""

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
            n = "showBlue",
        },
        keysReleased = {
            r = "showGrey",
            g = "showGrey",
            b = "showGrey",
            n = "showGrey",
            m = "toMovement",
        },
        -- controller bindings
        buttons = {
            b = "showRed",
            a = "showGreen",
            x = "showBlue",
            back = "toMovement",
        },
        buttonsReleased = {
            b = "showGrey",
            a = "showGrey",
            x = "showGrey",
        }
    }

    gameStates.movement = {
        bindings = {
            moveUp = function() rectPos.y=rectPos.y-5 end,
            moveDown = function() rectPos.y=rectPos.y+5 end,
            moveLeft = function() rectPos.x=rectPos.x-5 end,
            moveRight = function() rectPos.x=rectPos.x+5 end,
            toColours = function() state = gameStates.colours end,
        },
        keys = {
            w = "moveUp",
            s = "moveDown",
            a = "moveLeft",
            d = "moveRight",
            c = "toColours",
        },
        keysReleased = {},
        buttons = {
            y = "moveUp",
            a = "moveDown",
            x = "moveLeft",
            b = "moveRight",
            back = "toColours",
        },
        buttonsReleased = {}
    }

    state = gameStates.colours
end

function love.update(dt)

end

function love.draw()
    -- I assume there's a nicer way to pass an appropriate obj to a function...
    love.graphics.setColor(
        drawColours[1],
        drawColours[2],
        drawColours[3],
        drawColours[4])

        love.graphics.rectangle('fill', rectPos.x,rectPos.y,780,285)
        
        love.graphics.print(test, 10, 400)
end

-- PROCESS INPUTS

function inputHandler(input)
    local action = state.bindings[input]
    if action then
        return action()
    end
end

function love.keypressed(k)
    local binding = state.keys[k]

    test = k
    if binding then
        test = binding
    end

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