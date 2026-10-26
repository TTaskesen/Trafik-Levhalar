--------------------------------------------------------------------------------
-- Uygulama içi gizlilik politikası.
--------------------------------------------------------------------------------
local composer = require("composer")
local widget = require("widget")
local ortak = require("levha_ortak")
local scene = composer.newScene()
local GIZLILIK_URL = "https://ttaskesen.github.io/Trafik-Levhalar/privacy/"

local politika = [[
GİZLİLİK POLİTİKASI

Son güncelleme: 26 Ekim 2026

Bu politika, Trafik Levhaları uygulamasının kullanıcı verilerini nasıl işlediğini açıklar. Geliştirici hesabındaki ad Turgut Taskesen, geliştirici iletişimindeki ad Turgut Taşkesen'dir. Gizlilik soruları için turguttaskesen@gmail.com adresinden iletişime geçebilirsiniz.

UYGULAMA İÇİNDE KULLANILAN VE CİHAZDA SAKLANAN VERİLER

Uygulama, sınav ilerlemesini (tamamlanan sınav sayısı, en iyi ve son puan, soru sayısı ve yanlış cevap kayıtları) ve seçilen arayüz dilini işlevleri sunmak için yalnızca cihazda saklar. Bu kayıtlar uygulama tarafından bir sunucuya gönderilmez. Uygulama hesabı, ad, e-posta, telefon, konum, kişi listesi, kamera, mikrofon, fotoğraf, reklam kimliği veya kullanım analitiği istemez. Kullanıcı hikâyesi gönderme ve Supabase bağlantısı bu Android yayın paketinden çıkarılmıştır.

VERİLERİN KULLANIMI VE PAYLAŞIMI

Yerel sınav kaydı sınav sonucunu ve yanlış cevapları göstermek; dil tercihi seçilen dili sonraki açılışta korumak için kullanılır. Bu sürüm reklam göstermez, analiz/izleme amacıyla veri aktarmaz ve bu kayıtları üçüncü taraflarla paylaşmaz.

YEREL KAYITLAR

Sınav kayıtları ve dil tercihi uygulamanın cihazdaki özel alanında tutulur. İlk açılışta kullanıcının politika bağlantısını açıp devam etmeyi seçtiği bilgisi de yalnızca bu cihazdaki uygulama tercihlerinde saklanır. Bu seçim, kişisel veri işleme izni değildir. Uygulama içindeki “İlerlemeyi sıfırla” seçeneği sınav kayıtlarını siler. Uygulamayı kaldırmak cihazdaki uygulama kayıtlarını kaldırır. Bu sürüm kullanıcı hesabı veya çevrimiçi kullanıcı içeriği oluşturmaz.

SAKLAMA, ERİŞİM VE SİLME

Yerel kayıtlar kullanıcı uygulama içi sıfırlama seçeneğini kullanana veya uygulamayı kaldırana kadar cihazda kalır. Kullanıcı ilerleme verisini uygulamadaki sıfırlama seçeneğiyle silebilir; dil tercihi ve politika bağlantısını açma kaydı cihaz ayarlarından uygulama verileri temizlenerek veya uygulama kaldırılarak silinebilir. Erişim, kopya veya gizlilikle ilgili talepler için geliştiriciyle turguttaskesen@gmail.com adresinden iletişime geçebilirsiniz. Geliştirici sunucusunda bu yerel kayıtlara ait bir kopya bulunmaz.

GÜVENLİK

Yerel kayıtlar uygulamanın özel alanında tutulur. Bu sürümde söz konusu kayıtlar ağ üzerinden aktarılmaz. Gelecekte çevrimiçi özellik eklenirse politika ve mağaza gizlilik beyanları yayın öncesinde güncellenir.

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

    local geri = display.newRoundedRect(grup, display.contentCenterX - 78, ust + 76,
        142, 42, 8)
    geri:setFillColor(0.05, 0.3, 0.55)
    local geriMetin = display.newText(grup, "GERİ DÖN", geri.x, geri.y,
        "Poppins-Bold", 12)
    geriMetin:setFillColor(1)

    local webdeAc = display.newRoundedRect(grup, display.contentCenterX + 78, ust + 76,
        142, 42, 8)
    webdeAc:setFillColor(0.05, 0.3, 0.55)
    local webdeAcMetin = display.newText(grup, "WEB'DE AÇ", webdeAc.x, webdeAc.y,
        "Poppins-Bold", 12)
    webdeAcMetin:setFillColor(1)

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
    local function webdeGoster()
        system.openURL(GIZLILIK_URL)
        return true
    end
    geri:addEventListener("tap", don)
    geriMetin:addEventListener("tap", don)
    webdeAc:addEventListener("tap", webdeGoster)
    webdeAcMetin:addEventListener("tap", webdeGoster)
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
