local composer = require( "composer" )
local mui = require ( "plugin.materialui" )
 
local scene = composer.newScene()

-- forward declare
local background, title_box, text_view_box, scroll_box, contact_box

-- mui helper functions
function goToTitle() 
    print("here")
    composer.gotoScene( "title" )
end

function scene:create( event )

    local sceneGroup = self.view
    
    mui.init()

    mui.newNavbar ({
        name = "settings_nav",
        height = mui.getScaleVal(80),
        left = 0,
        top = 0,
        fillColor = { { type="gradient", color1 = { 1,1,1 }, color2 = { .7,.7,.7 }, direction = "down" } },
        activeText = { 0, 0, 0 },
        padding = mui.getScaleVal(10)
        })

    mui.newRoundedRectButton ({
        name = "back_nav_button",
        text = "nothing",
        width = mui.getScaleVal(80),
        height = mui.getScaleVal(80),
        textColor = { 0,0,0,0 },
        radius = 10,
        callBack = mui.actionSwitchScene,
        callBackData = { 
            sceneDestination = "title",
            sceneTransitionColor = { .5,.5,.5 },
            sceneTransitionAnimation = true
        },
        image = {
            src = "images/back-icon-sheet.png",
            sheetIndex = 1,
            touchIndex = 2,
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
        width = mui.getScaleVal(600),
        font = native.systemFont,
        fontSize = mui.getScaleVal(50),
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