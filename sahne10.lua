--------------------------------------------------------------------------------
--
-- sahne10.lua - Hakkımızda
-- Uygulama geliştiricisini tanıtan sayfa
--
--------------------------------------------------------------------------------

local widget = require("widget")
local composer = require("composer")
local ortak = require("levha_ortak")
local dil = require("dil")
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

icerik = dil.dosyaMetni("hakkimizda", icerik)

-- Metin göstermek için ScrollView oluşturan fonksiyon
local function metinOlustur()
    if scrollViewMetin then
        scrollViewMetin:removeSelf()
        scrollViewMetin = nil
    end

    local tabBarHeight = composer.getVariable("tabBarHeight") or 0
    -- Başlık ve gizlilik bağlantısı için üstte ayrılmış alan bırak.
    local ustBosluk = (display.safeScreenOriginY or display.screenOriginY or 0) + 112
    local oy = math.abs(display.screenOriginY)
    local scrollView = widget.newScrollView(
        {
            top = ustBosluk,
            left = 0,
            width = display.contentWidth,
            height = display.contentHeight + oy - ustBosluk - tabBarHeight,
            horizontalScrollDisabled = true,
            backgroundColor = { 0, 0, 0, 0 }
        })

    local yStart = 10
    local mainPadding = 10

    for paragraph in string.gmatch(icerik .. "\n", "([^\n]*)\n") do
        local baslikMi = #paragraph > 3 and paragraph == paragraph:upper()
        local newText = display.newText({
            text = paragraph,
            width = scrollView.width - (mainPadding * 2),
            fontSize = baslikMi and 15 or 17,
            font = baslikMi and "Poppins-Bold" or "Poppins-Medium",
            align = "left"
        })
        if baslikMi then
            yStart = yStart + 8
        end
        newText.anchorX = 0
        newText.anchorY = 0
        newText.x = mainPadding
        newText.y = yStart
        newText:setFillColor(1, 1, 1)
        scrollView:insert(newText)
        yStart = yStart + newText.height + 5
    end

    scrollView:setScrollHeight(yStart + (mainPadding * 2))
    scrollViewMetin = scrollView
end

function scene:create(event)
    local sceneGroup = self.view
    local baslikY = (display.safeScreenOriginY or display.screenOriginY or 0) + 30

    local arkaPlan = display.newImageRect(
        sceneGroup,
        "levha/bg3.jpg",
        display.contentWidth,
        display.contentHeight
    )
    arkaPlan.x = display.contentCenterX
    arkaPlan.y = display.contentCenterY

    local metinKontrast = display.newRect(
        sceneGroup,
        display.contentCenterX,
        display.contentCenterY,
        display.contentWidth,
        display.contentHeight
    )
    metinKontrast:setFillColor(0, 0, 0, 0.5)

    local baslikKarti = display.newRoundedRect(display.contentCenterX, baslikY, 240, 52, 10)
    baslikKarti:setFillColor(0.05, 0.3, 0.55, 0.85)
    baslikKarti:setStrokeColor(1, 1, 1, 0.35)
    baslikKarti.strokeWidth = 1.5
    sceneGroup:insert(baslikKarti)

    local baslik = display.newText(dil.metin("hakkimizda_basligi"), 0, 0, "BebasNeue-Regular", 30)
    baslik:setFillColor(1)
    baslik.x = display.contentCenterX
    baslik.y = baslikY
    sceneGroup:insert(baslik)

    metinOlustur()
    sceneGroup:insert(scrollViewMetin)

    local gizlilikY = baslikY + 70
    local gizlilikArka = display.newRoundedRect(sceneGroup,
        display.contentCenterX, gizlilikY, 210, 30, 8)
    gizlilikArka:setFillColor(0.90, 0.95, 1, 0.96)
    gizlilikArka:setStrokeColor(0.05, 0.3, 0.55, 0.45)
    gizlilikArka.strokeWidth = 1

    local gizlilik = display.newText(sceneGroup, dil.metin("gizlilik_politikasi"),
        display.contentCenterX, gizlilikY,
        "Poppins-Bold", 11)
    gizlilik:setFillColor(0.05, 0.3, 0.55)
    gizlilik.isHitTestable = true
    gizlilikArka.isHitTestable = true
    gizlilik:addEventListener("tap", function()
        composer.gotoScene("gizlilik", "slideLeft", 350)
        return true
    end)
    gizlilikArka:addEventListener("tap", function()
        composer.gotoScene("gizlilik", "slideLeft", 350)
        return true
    end)
end

function scene:show(event)
    local phase = event.phase
    if "did" == phase then
        local tabBar = composer.getVariable("tabBar")
        ortak.tabBarGoster(tabBar)
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
