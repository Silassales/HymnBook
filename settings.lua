local composer = require( "composer" )
local mui = require( "materialui.mui" )
 
local scene = composer.newScene()



-- forward declare
local background, title_box, text_view_box, scroll_box, contact_box

-- mui helper functions
local function goToTitle ()
    composer.removeScene( "settings", true )
    composer.gotoScene( "title", "slideUp", 300)
end

local function saveTextFormat ()
    print("saving text")
end

function scene:create( event )

    local sceneGroup = self.view
    
    mui.init()

    --constants
    local spacer = mui.getScaleVal(50)

    local nav_bar_by = mui.getScaleVal(80)

    local text_textsize = mui.getScaleVal(30)
    local text_check_width_height = mui.getScaleVal(50)
    local text_check_y = nav_bar_by + text_textsize + spacer + text_check_width_height/2
    local text_check_x = mui.getScaleVal(500)

    local text_check_text = display.newText( sceneGroup, "Display Hymn's in text format:", 0, 0, native.systemFont, 16 )
    text_check_text:setFillColor( 1, 1, 1 )
    text_check_text.anchorX = 0
    text_check_text.x = 10
    text_check_text.y = nav_bar_by + text_textsize + spacer
    text_check_text.align = "left"


    mui.newCheckBox ({
        name = "check",
        text = "check_box_outline_blank",
        width = text_check_width_height,
        height = text_check_width_height,
        x = text_check_x,
        y = text_check_y,
        font = mui.materialFont,
        textColor = { 1,1,1 },
        value = 500,
        callBack = mui.actionForCheckbox
        })

    mui.newNavbar ({
        name = "settings_nav",
        height = nav_bar_by,
        left = 0,
        top = 0,
        fillColor = { .93,.93,.93 },
        activeText = { 0, 0, 0 },
        padding = mui.getScaleVal(10)
        })

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