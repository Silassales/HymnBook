local composer = require( "composer" )
local mui = require( "materialui.mui" )
 
local scene = composer.newScene()

-- forward declare
local background, title_box, text_view_box, scroll_box, contact_box

-- mui helper functions

-- removes current scene and moves to title screen
local function goToTitle ()
    composer.removeScene( "settings", true )
    composer.gotoScene( "title", "slideUp", 300)
end

-- function to save text/full page view option
local function saveTextView ( e )
    mui.actionForCheckbox(e)

    print("saving text view")
end

-- function to save scroll up/down left/right option
local function saveScrollType ( e )
    mui.actionForCheckbox(e)

    print("saving scroll type")
end


function scene:create( event )

    local sceneGroup = self.view
    
    mui.init()

    -- attributes of GUI
    local spacer = mui.getScaleVal(100)

    local nav_bar_by = mui.getScaleVal(80)

    local text_x = 10
    local text_size = mui.getScaleVal(30)
    local check_box_x = mui.getScaleVal(500)
    local check_width = mui.getScaleVal(50)

    local text_text_y = nav_bar_by + spacer + text_size
    local text_check_y = nav_bar_by + text_size + spacer + check_width/2

    local scroll_text_y = text_text_y + text_size + spacer
    local scroll_check_y = text_text_y + text_size + spacer + check_width/2

    -- Text text/check box
    -- allows users to specify just text view or default full hymn page view
    local text_check_text = display.newText( sceneGroup, "Display Hymn's in text format:", 0, 0, native.systemFont, text_size )
    text_check_text:setFillColor( 1, 1, 1 )
    text_check_text.anchorX = 0
    text_check_text.x = text_x
    text_check_text.y = text_text_y
    text_check_text.align = "left"

    mui.newCheckBox ({
        name = "text_check",
        text = "check_box_outline_blank",
        width = check_width,
        height = check_width,
        x = check_box_x,
        y = text_check_y,
        font = mui.materialFont,
        textColor = { 1,1,1 },
        value = 500,
        callBack = saveTextView
        })

    -- Scroll text/check box
    -- allows users to specify type of scroll, either up/down or (defualt) left/right
    local scroll_type_text = display.newText( sceneGroup, "Scroll down (default right):", 0, 0, native.systemFont, text_size )
    scroll_type_text:setFillColor( 1, 1, 1 )
    scroll_type_text.anchorX = 0
    scroll_type_text.x = text_x
    scroll_type_text.y = scroll_text_y
    scroll_type_text.align = "left"

    mui.newCheckBox ({
        name = "scroll_check",
        text = "check_box_outline_blank",
        width = check_width,
        height = check_width,
        x = check_box_x,
        y = scroll_check_y,
        font = mui.materialFont,
        textColor = { 1,1,1 },
        value = 500,
        callBack = saveScrollType
        })  

    -- Nav bar
    -- set last so that it writes over all other objects
    -- Only contains a back button that goes back to the menu screen
    -- and a text object that contains the string "Settings"
    mui.newNavbar ({
        name = "settings_nav",
        height = nav_bar_by,
        left = 0,
        top = 0,
        fillColor = { .93,.93,.93 },
        activeText = { 0, 0, 0 },
        padding = mui.getScaleVal(10)
        })

    -- Back button
    mui.newRoundedRectButton ({
        name = "back_nav_button",
        text = "nothing",
        width = nav_bar_by,
        height = nav_bar_by,
        textColor = { 0,0,0,0 },
        radius = 10,
        callBack = goToTitle,
        image = {
            src = "images/back-icon-sheet.png",
            sheetIndex = 2,
            touchIndex = 1,
            touchFadeAnimation = true,
            touchFadeAnimationSpeedOut = 500,
            sheetOptions = {
                width = 101,
                height = 101,
                numFrames = 2
            }
        }
        })

    -- Text
    mui.newEmbossedText ({
        x = 0,
        y = 0,
        name = "settings_text",
        text = "Settings",
        align = "center",
        width = mui.getScaleVal(700),
        font = native.systemFont,
        fontSize = mui.getScaleVal(40),
        fillColor = { 0,0,0,1 }
        })

    mui.attachToNavBar ( "settings_nav", {
            widgetName = "back_nav_button",
            widgetType = "RectButton",
            align = "left"
        })

    mui.attachToNavBar ( "settings_nav", {
            widgetName = "settings_text",
            widgetType = "EmbossedText",
            align = "right"
        })
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

    mui.destroy()
end
 
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene
