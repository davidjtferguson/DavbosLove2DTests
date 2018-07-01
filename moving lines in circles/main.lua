
function love.load(args)
    t=0

    hello = {
        text='hello world',
        x=0,
        y=0
    }

    echo = {
        text='can you hear me?',
        x=0,
        y=0
    }
end

function love.update(dt)
    t=t+dt

    hello.x=350+200*math.cos(t)-(#hello*3)
    hello.y=300+200*math.sin(t)

    echo.x=350+100*math.cos(t)-(#echo*3)
    echo.y=300+100*math.sin(t)
end

function love.draw()
    love.graphics.setColor( 1.0, 1.0, 1.0, 1.0 )

    love.graphics.print(hello.text, hello.x, hello.y)
    love.graphics.print(echo.text, echo.x, echo.y)

    love.graphics.setColor( 0.2, 0.9, 0.3, 0.8 )

    love.graphics.line(hello.x,hello.y,echo.x,echo.y)
    
    love.graphics.line(hello.x+(#hello.text*6),hello.y,
                        echo.x+(#hello.text*10),echo.y)

                        
    love.graphics.line(hello.x,hello.y+14,echo.x,echo.y+14)
    
    love.graphics.line(hello.x+(#hello.text*6),hello.y+14,
                        echo.x+(#hello.text*10),echo.y+14)

end
