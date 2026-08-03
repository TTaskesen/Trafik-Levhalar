--------------------------------------------------------------------------------
--
-- sahne10.lua - Hakkımızda
-- Uygulama geliştiricisini tanıtan sayfa
--
--------------------------------------------------------------------------------

local widget = require("widget")
local composer = require("composer")
local scene = composer.newScene()

local scrollViewMetin

local icerik = [[Bu uygulama, trafik işaret levhalarını daha kolay tanıyabilmek ve öğrenebilmek amacıyla hazırlanmıştır.

TURGUT TAŞKESEN
Uygulamanın geliştiricisi Turgut Taşkesen, makine mühendisidir ve Kahramanmaraş'ta yaşamaktadır.

Turgut Taşkesen, yazılım geliştirme ile bu uygulama üzerinde yeni çalışmaya başlamıştır. Trafik levhalarının toplumdaki herkes tarafından doğru bilinmesinin trafik güvenliği açısından önemli olduğunu düşünerek bu uygulamayı geliştirmeye karar vermiştir.

HEDEF
Uygulamanın amacı; sürücü adaylarına, sürücülere ve tüm yol kullanıcılarına trafik işaret levhalarını görsel olarak tanıtmak ve anlamlarını öğretmektir.

Uygulama geliştikçe yeni özellikler ve güncellemeler eklenmeye devam edilecektir. Görüş ve önerileriniz, uygulamanın daha iyi bir hale gelmesine katkı sağlayacaktır.
]]

-- Metin göstermek için ScrollView oluşturan fonksiyon
local function metinOlustur()
    if scrollViewMetin then
        scrollViewMetin:removeSelf()
        scrollViewMetin = nil
    end

    local tabBarHeight = composer.getVariable("tabBarHeight") or 0
    local ustBosluk = 60
    local scrollView = widget.newScrollView(
        {
            top = ustBosluk,
            left = 0,
            width = display.contentWidth,
            height = display.contentHeight - ustBosluk - tabBarHeight,
            horizontalScrollDisabled = true
        })

    local yStart = 10
    local mainPadding = 10

    for paragraph in string.gmatch(icerik .. "\n", "([^\n]*)\n") do
        local newText = display.newText({
            text = paragraph,
            width = scrollView.width - (mainPadding * 2),
            fontSize = 17,
            font = "Poppins-Medium",
            align = "left"
        })
        newText.anchorX = 0
        newText.anchorY = 0
        newText.x = mainPadding
        newText.y = yStart
        newText:setFillColor(0)
        scrollView:insert(newText)
        yStart = yStart + newText.height + 5
    end

    scrollView:setScrollHeight(yStart + (mainPadding * 2))
    scrollViewMetin = scrollView
end

function scene:create(event)
    local sceneGroup = self.view

    local baslik = display.newText("Hakkımızda", 0, 0, "BebasNeue-Regular", 30)
    baslik:setFillColor(0)
    baslik.x = display.contentCenterX
    baslik.y = 30
    sceneGroup:insert(baslik)

    metinOlustur()
    sceneGroup:insert(scrollViewMetin)
end

function scene:show(event)
    local phase = event.phase
    if "did" == phase then
        collectgarbage("collect")
    end
end

function scene:hide(event)
    local phase = event.phase
    if "did" == phase then
    end
end

function scene:destroy(event)
    if scrollViewMetin then
        scrollViewMetin:removeSelf(); scrollViewMetin = nil
    end
end

--------------------------------------------------------------------------------

scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)
scene:addEventListener("destroy", scene)

--------------------------------------------------------------------------------

return scene
