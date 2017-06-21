local composer = require( "composer" )
 
local scene = composer.newScene()

-- forward declare
local background, title_box, text_view_box, scroll_box, contact_box

function scene:create( event )

    local sceneGroup = self.view
 
    local gradient = {
        type="gradient",
        color1={ 0,.300,0 }, color2={ 0,.500,0 }, direction="down"
    }

    background = display.newRect( sceneGroup, display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight )
    background:setFillColor( gradient )
    

    -- create the different settings:

    -- title bar

    -- just text
    text_view_box = display.newRect( sceneGroup, display.contentCenterX, display.contentHeight*.25 - 30, display.contentWidth, display.contentHeight*.25 - 20 )
    -- make it invisible only for detection if needed
    text_view_box:setFillColor( 1,0,0,0 )

    local text_line = display.newLine( sceneGroup, 0, 40, display.contentWidth, 40)
    text_line:setStrokeColor( 0.5,0.5,0.5, 1 )
    text_line.strokeWidth = 8

    -- type of scroll
    scroll_box = display.newRect( sceneGroup, display.contentCenterX, display.contentHeight*.5 - display.contentHeight*.125 + 10, display.contentWidth, display.contentHeight*.25 - 20)
    -- make it invisible only for detection if needed
    scroll_box:setFillColor( 0,1,0,0 )

    local scroll_line = display.newLine( sceneGroup, 0, (display.contentCenterY/2 + 20), display.contentWidth, (display.contentCenterY/2 + 20))
    scroll_line:setStrokeColor( 0.5,0.5,0.5, 1 )
    scroll_line.strokeWidth = 8

    -- contact info
    contact_box = display.newRect( sceneGroup, display.contentCenterX, display.contentHeight*.75, display.contentWidth, display.contentHeight*.5 )
    -- make it invisible only for detection if needed
    contact_box:setFillColor( 0,0,0,0 )

    local line = display.newLine( sceneGroup, 0, display.contentCenterY, display.contentWidth, display.contentCenterY)
    line:setStrokeColor( 0.5,0.5,0.5, 1 )
    line.strokeWidth = 8

    local contact_tex = display.newText( "This will be the contact text", display.contentCenterX, display.contentCenterY, native.systemFont, 16 )

end
 
function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
 
    elseif ( phase == "did" ) then
 
    end
end
 
function scene:hide( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then

 
    elseif ( phase == "did" ) then
 
    end
end

function scene:destroy( event )
 
    local sceneGroup = self.view

 
end
 
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene