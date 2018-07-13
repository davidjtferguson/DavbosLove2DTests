
colourState = {}

-- need to investigate this
colourState.__index = colourState

-- bind all controls for the colours gamestate
colourState = {
    -- bind to functions
    bindings = {
        showRed = red,
        showGreen = green,
        showBlue = blue,
        showGrey = reset,
        -- gamestates shouldn't be edited in a file it doesn't exist in - create manager?
        toMovement = function() state = gameStates.movementState end,
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

return colourState