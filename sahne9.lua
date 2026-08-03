--------------------------------------------------------------------------------
--
-- sahne9.lua - Bilgi
-- Uygulamayı tanıtan genel bilgi sayfası
--
--------------------------------------------------------------------------------

local widget = require("widget")
local composer = require("composer")
local scene = composer.newScene()

local scrollViewMetin

local icerik = [[Bu uygulama, Türkiye'de geçerli olan karayolları standart işaret levhalarını tanıtmayı ve öğretmeyi amaçlamaktadır.

İÇERİK
Uygulamada yer alan işaret levhaları aşağıdaki kategorilere ayrılmıştır:

1. TEHLİKE UYARI İŞARETLERİ
Yolda karşılaşılabilecek tehlikeler konusunda sürücüyü önceden uyarır. Üçgen şeklindedir. Örneğin: viraj, yaya geçidi, kaygan yol.

2. TRAFİK TANZİM İŞARETLERİ
Sürücülere uymaları gereken kuralları bildirir. Daire şeklindedir. Örneğin: dur, yol ver, hız sınırlaması, geçme yasağı.

3. BİLGİ İŞARETLERİ
Yol kullanıcılarına yol ve çevresi hakkında bilgi verir. Dikdörtgen şeklindedir. Örneğin: yön levhaları, mesafe levhaları, yerleşim yeri levhaları.

4. DURAKLAMA VE PARK ETME İŞARETLERİ
Duraklamanın ve park etmenin yasak olduğu veya serbest olduğu yerleri gösterir.

5. ÖZEL İŞARETLER
Özel durumları ve özel amaçlı işaretleri kapsar.

NASIL KULLANILIR
Ana sayfadan bir kategori seçin. Açılan listeden bir levhaya dokunun. Levha büyütülerek gösterilir ve altında levhanın anlamını açıklayan bilgi metni görüntülenir.

SORUMLULUK REDDİ
Bu uygulamadaki bilgiler eğitim amaçlıdır. Trafikte geçerli olan kurallar için resmi kaynaklar ve yetkili kuruluşların yayınları esas alınmalıdır.
]]

-- Metin göstermek için ScrollView oluşturan fonksiyon
local function metinOlustur()
    if scrollViewMetin then
        scrollViewMetin:removeSelf()
        scrollViewMetin = nil
    end

    local tabBarHeight = composer.getVariable("tabBarHeight") or 0
    local ustBosluk = 64
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
        newText:setFillColor(unpack(baslikMi and { 0.05, 0.3, 0.55 } or { 0.2 }))
        scrollView:insert(newText)
        yStart = yStart + newText.height + 5
    end

    scrollView:setScrollHeight(yStart + (mainPadding * 2))
    scrollViewMetin = scrollView
end

function scene:create(event)
    local sceneGroup = self.view

    local baslikKarti = display.newRoundedRect(display.contentCenterX, 30, 240, 52, 10)
    baslikKarti:setFillColor(0.05, 0.3, 0.55, 0.85)
    baslikKarti:setStrokeColor(1, 1, 1, 0.35)
    baslikKarti.strokeWidth = 1.5
    sceneGroup:insert(baslikKarti)

    local baslik = display.newText("Bilgi", 0, 0, "BebasNeue-Regular", 30)
    baslik:setFillColor(1)
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
