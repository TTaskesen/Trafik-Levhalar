--------------------------------------------------------------------------------
-- Levha sahnelerinde ortak kullanılan liste ve detay yardımcıları.
--------------------------------------------------------------------------------
local widget = require("widget")

local ortak = {}
local BASLIK_MAVI = { 0.05, 0.30, 0.55 }
local BASLIK_MAVI_ACIK = { 0.08, 0.40, 0.68 }
local BASLIK_BEYAZ = { 1, 1, 1 }

function ortak.ekranBilgileri()
    local originX = display.screenOriginX or 0
    local originY = display.screenOriginY or 0
    local safeOriginY = display.safeScreenOriginY or originY
    local safeHeight = display.safeActualContentHeight or display.actualContentHeight or display.contentHeight
    local bottomInset = 0

    if display.getSafeAreaInsets then
        local _, _, bottom = display.getSafeAreaInsets()
        bottomInset = math.max(0, bottom or 0)
    end

    return {
        letterboxX = math.abs(originX),
        letterboxY = math.abs(originY),
        safeBottom = safeOriginY + safeHeight,
        bottomInset = math.max(8, bottomInset)
    }
end

function ortak.metinOlustur(icerik, ustBosluk, tabBarHeight)
    local oy = math.abs(display.screenOriginY)
    local scrollView = widget.newScrollView({
        top = ustBosluk or 230,
        left = 0,
        width = display.contentWidth,
        height = display.contentHeight + oy - (ustBosluk or 230) - (tabBarHeight or 0),
        horizontalScrollDisabled = true,
        backgroundColor = { 1, 1, 1 }
    })

    local yStart = 10
    local mainPadding = 10
    for paragraph in string.gmatch((icerik or "") .. "\n", "([^\n]*)\n") do
        local newText = display.newText({
            text = paragraph,
            width = scrollView.width - (mainPadding * 2),
            fontSize = 16,
            font = "Poppins-Medium",
            align = "left"
        })
        newText.anchorX = 0
        newText.anchorY = 0
        newText.x = mainPadding
        newText.y = yStart
        newText:setFillColor(0.2)
        scrollView:insert(newText)
        yStart = yStart + newText.height + 5
    end

    scrollView:setScrollHeight(yStart + (mainPadding * 2))
    return scrollView
end

function ortak.levhaBoyut(kare, maxWidth, maxHeight, maxScale)
    local olcek = math.min(
        (maxWidth or 380) / kare.width,
        (maxHeight or 220) / kare.height,
        maxScale or 2.5
    )
    return kare.width * olcek, kare.height * olcek
end

-- Detay ekranında levha ve Geri Dön düğmesini birlikte ortalar.
-- Görsel boyutu değişse bile düğme görselin altında kalır ve güvenli
-- ekran alanının dışına taşmaması için konum sınırlandırılır.
function ortak.detayYerlesimi(gorselYuksekligi)
    local ekran = ortak.ekranBilgileri()
    -- Action barın altından 30 px boşluk bırak.
    local ustSinir = (display.safeScreenOriginY or display.screenOriginY or 0) + 70 + 30
    local altSinir = ekran.safeBottom - 20
    local gorselYuksekligi = math.max(1, gorselYuksekligi or 140)
    local dugmeYuksekligi = 32
    local bosluk = 24
    local resimY = ustSinir + (gorselYuksekligi / 2)
    local enAzResimY = ustSinir + (gorselYuksekligi / 2)
    local enFazlaResimY = altSinir - (gorselYuksekligi / 2) - bosluk - dugmeYuksekligi

    if enFazlaResimY >= enAzResimY then
        resimY = math.max(enAzResimY, math.min(resimY, enFazlaResimY))
    end

    local dugmeY = math.min(
        resimY + (gorselYuksekligi / 2) + bosluk,
        altSinir - (dugmeYuksekligi / 2)
    )
    local metinY = dugmeY + (dugmeYuksekligi / 2) + 26
    return resimY, dugmeY, metinY
end

function ortak.listeRenkleri()
    return {
        rowColor = { default = { 1 }, over = { 0.92, 0.95, 1 } },
        lineColor = { 220 / 255 },
        catColor = {
            default = { 0.05, 0.3, 0.55, 0.9 },
            over = { 0.05, 0.3, 0.55, 0.9 }
        },
        defaultLabelColor = { 0.2 },
        catLabelColor = { 1 }
    }
end

function ortak.sabitListeBasligi(sceneGroup, baslik, ox, oy)
    local y = -(oy or 0) + 35
    local sabitBaslik = display.newRect(
        sceneGroup,
        display.contentCenterX,
        y,
        display.contentWidth + (ox or 0) + (ox or 0),
        70
    )
    sabitBaslik:setFillColor(0.05, 0.3, 0.55, 0.9)
    sabitBaslik:addEventListener("touch", function()
        return true
    end)

    local sabitBaslikMetni = display.newText({
        parent = sceneGroup,
        text = baslik,
        x = display.contentCenterX,
        y = y,
        font = "Poppins-Bold",
        fontSize = 16,
        width = math.max(1, display.contentWidth - 20),
        align = "center"
    })
    sabitBaslikMetni:setFillColor(1)
end

function ortak.geriDonButonu(onRelease, genislik, yukseklik)
    local genislik = genislik or 160
    local yukseklik = yukseklik or 40
    local buton = display.newGroup()
    local zemin = display.newRoundedRect(buton, 0, 0, genislik, yukseklik, 6)
    zemin:setFillColor(unpack(BASLIK_MAVI))

    local yazi = display.newText({
        parent = buton,
        text = "Geri Dön",
        x = 0,
        y = 0,
        font = "Poppins-Bold",
        fontSize = 17,
        align = "center"
    })
    yazi:setFillColor(unpack(BASLIK_BEYAZ))

    function buton:touch(event)
        if event.phase == "began" then
            display.getCurrentStage():setFocus(self)
            self.isFocus = true
            zemin:setFillColor(unpack(BASLIK_MAVI_ACIK))
            return true
        elseif self.isFocus and (event.phase == "ended" or event.phase == "cancelled") then
            display.getCurrentStage():setFocus(nil)
            self.isFocus = false
            zemin:setFillColor(unpack(BASLIK_MAVI))
            if event.phase == "ended" and onRelease then
                onRelease(event)
            end
            return true
        end
        return true
    end

    buton:addEventListener("touch")
    return buton
end

function ortak.listeGeriDonButonu(sceneGroup, onRelease)
    local ekran = ortak.ekranBilgileri()
    local buton = ortak.geriDonButonu(onRelease)
    buton.x = display.contentCenterX
    buton.y = ekran.safeBottom - 28
    sceneGroup:insert(buton)
    return buton
end

function ortak.tabBarGizle(tabBar, sure)
    if not tabBar then return end
    transition.cancel(tabBar)
    tabBar.isVisible = true
    tabBar.alpha = 1
    transition.to(tabBar, {
        alpha = 0,
        time = sure or 150,
        onComplete = function()
            if tabBar then tabBar.isVisible = false end
        end
    })
end

function ortak.tabBarGoster(tabBar, sure)
    if not tabBar then return end
    transition.cancel(tabBar)
    tabBar.isVisible = true
    tabBar.alpha = 0
    tabBar:toFront()
    transition.to(tabBar, { alpha = 1, time = sure or 150 })
end

return ortak
