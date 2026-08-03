--------------------------------------------------------------------------------
--
-- sahne8.lua - Levha Tarihi
-- Trafik işaret levhalarının tarihsel gelişimini anlatan sayfa
--
--------------------------------------------------------------------------------

local widget = require("widget")
local composer = require("composer")
local scene = composer.newScene()

local scrollViewMetin

local icerik = [[Trafik işaret levhalarının tarihi, insanlığın yol kavramı kadar eskidir. İnsanlar yollarını bulabilmek ve tehlikelere karşı birbirlerini uyarabilmek için en eski çağlardan beri işaretler kullanmıştır.

ANTİK DÖNEM
Roma İmparatorluğu, yolları boyunca kilometre taşları ve yön levhaları diken ilk uygarlıklardan biriydi. Taş sütunlara işlenen bu işaretler, mesafe ve yön bilgisi veriyordu. Ancak bu işaretler henüz bugünkü anlamda trafik levhaları değildi.

19. YÜZYIL
Bisikletin ve ardından otomobilin icadıyla ulaşım hızlandı. Yollarda artan araç sayısı, sürücülerin ortak bir işaret diline ihtiyaç duymasına neden oldu. Avrupa'da çeşitli ülkeler kendi bölgesel işaret sistemlerini geliştirmeye başladı.

1909 PARİS KONVANSİYONU
Dört ülkenin katılımıyla yapılan bu toplantı, trafik işaretlerinde uluslararası standartlaşmanın ilk adımıdır. Yol tehlikeleri için sembolik işaretler belirlenmiştir.

1931 CENEVRE KONVANSİYONU
İşaretlerin sayısı artırılarak tehlike, tanzim ve bilgi işaretleri ayrımı netleştirildi. Aynı yıl uluslararası trafik işaretleri sistemi daha da geliştirildi.

1949 CENEVRE KONVANSİYONU
İkinci Dünya Savaşı'ndan sonra uluslararası trafik akışının düzenlenmesi için yeniden bir araya gelindi ve işaret standartları güncellendi.

1968 VİYANA KONVANSİYONU
Bugün kullanılan trafik işaret sisteminin temeli olan Viyana Konvansiyonu imzalandı. Üçgen tehlike işaretleri, daire tanzim işaretleri ve dikdörtgen bilgi işaretleri bu dönemde standart hale geldi.

TÜRKİYE'DEKİ GELİŞİM
Türkiye'de trafik işaretleri, 1950 yılında Karayolları Genel Müdürlüğü'nün kurulmasıyla sistematik olarak uygulanmaya başlandı. 1968 Viyana Konvansiyonu'na katılımın ardından işaret standartları uluslararası normlara uyumlu hale getirildi.

GÜNÜMÜZ
Günümüzde trafik işaretleri, uluslararası standartlara uygun olarak üretilmekte; yöresel düzenlemelerle birlikte sürücülerin güvenliğini sağlamaktadır. Bu uygulamada yer alan levhalar da günümüzde geçerli olan standart işaret levhalarıdır.
]]

-- Metin göstermek için ScrollView oluşturan fonksiyon
local function metinOlustur()
    if scrollViewMetin then
        scrollViewMetin:removeSelf()
        scrollViewMetin = nil
    end

    local tabBarHeight = composer.getVariable("tabBarHeight") or 0
    local ustBosluk = 64
    local oy = math.abs(display.screenOriginY)
    local scrollView = widget.newScrollView(
        {
            top = ustBosluk,
            left = 0,
            width = display.contentWidth,
            height = display.contentHeight + oy - ustBosluk - tabBarHeight,
            horizontalScrollDisabled = true,
            backgroundColor = { 1, 1, 1 }
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

    local baslik = display.newText("Levha Tarihi", 0, 0, "BebasNeue-Regular", 30)
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
