--------------------------------------------------------------------------------
-- Uygulama içi gizlilik politikası.
--------------------------------------------------------------------------------
local composer = require("composer")
local widget = require("widget")
local ortak = require("levha_ortak")
local scene = composer.newScene()

local politika = [[
GİZLİLİK POLİTİKASI

Son güncelleme: 26 Ağustos 2026

Bu politika, Trafik Levhaları uygulamasının kullanıcı verilerini nasıl işlediğini açıklar. Uygulamanın geliştiricisi Turgut Taşkesen'dir. Gizlilik soruları için turguttaskesen@gmail.com adresinden iletişime geçebilirsiniz.

TOPLANAN VERİLER

Bu release; hesap, ad, e-posta, konum, kişi listesi, kamera, mikrofon, fotoğraf, reklam kimliği veya kullanım analitiği toplamaz. Kullanıcı hikâyesi yazma ve Supabase bağlantısı release paketine dahil değildir.

VERİLERİN KULLANIMI VE PAYLAŞIMI

Uygulama trafik levhası içeriklerini ve statik hikâye okuyucuyu çevrimdışı sunar. Reklam göstermez, üçüncü taraflara kullanıcı verisi aktarmaz ve izleme amacıyla SDK kullanmaz.

YEREL KAYITLAR

Dil tercihi gibi sınırlı teknik tercihler uygulamanın cihazdaki özel alanında saklanabilir. Bu release kullanıcı hikâyesi, kullanıcı hesabı veya çevrimiçi kullanıcı içeriği kaydetmez.

SAKLAMA VE SİLME

Uygulama hesap oluşturmaz ve kişisel veri işlemez. Gizlilikle ilgili sorularınız için turguttaskesen@gmail.com adresine yazabilirsiniz.

GÜVENLİK

Bu release'te kişisel veri aktarımı yoktur. Gelecekte kullanıcı hikâyesi veya çevrimiçi bir özellik yayınlanırsa, bu politika ve Google Play Data Safety beyanı yayın öncesinde güncellenir.

DEĞİŞİKLİKLER

Bu politika değiştiğinde uygulama içindeki güncelleme tarihi yenilenir.
]]

function scene:create()
    local grup = self.view
    local ekran = ortak.ekranBilgileri()
    local ust = display.safeScreenOriginY or display.screenOriginY or 0
    local zemin = display.newRect(grup, display.contentCenterX, display.contentCenterY,
        display.contentWidth, display.contentHeight)
    zemin:setFillColor(0.84, 0.91, 0.97)

    local baslik = display.newText(grup, "GİZLİLİK POLİTİKASI", display.contentCenterX,
        ust + 30,
        "BebasNeue-Regular", 26)
    baslik:setFillColor(0.05, 0.3, 0.55)

    local geri = display.newRoundedRect(grup, display.contentCenterX, ust + 76,
        170, 42, 8)
    geri:setFillColor(0.05, 0.3, 0.55)
    local geriMetin = display.newText(grup, "GERİ DÖN", geri.x, geri.y,
        "Poppins-Bold", 14)
    geriMetin:setFillColor(1)

    local scroll = widget.newScrollView({
        top = ust + 105,
        left = 12,
        width = display.contentWidth - 24,
        height = math.max(120, ekran.safeBottom - ust - 105 - 12),
        horizontalScrollDisabled = true,
        backgroundColor = { 0.98, 0.94, 0.68 }
    })
    grup:insert(scroll)

    local metin = display.newText({
        text = politika,
        x = 14,
        y = 14,
        width = scroll.width - 28,
        font = "Poppins-Medium",
        fontSize = 13,
        align = "left"
    })
	 scroll:insert(metin)
    metin.anchorX, metin.anchorY = 0, 0
    metin:setFillColor(0.08, 0.08, 0.08)
    scroll:setScrollHeight(metin.height + 30)

    local function don()
        composer.gotoScene("sahne10", "slideRight", 350)
        return true
    end
    geri:addEventListener("tap", don)
    geriMetin:addEventListener("tap", don)
end

function scene:show(event)
    if event.phase == "did" then
        local tabBar = composer.getVariable("tabBar")
        ortak.tabBarGizle(tabBar, 0)
    end
end

scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
return scene
