--------------------------------------------------------------------------------
-- Trafik levhalarını öğrenmeye dönük çevrimdışı mini sınav.
-- Bu ekran, uygulamadaki görsel ve açıklama içeriğini kullanıcı etkileşimi,
-- anlık geri bildirim ve puan takibiyle birleştirir.
--------------------------------------------------------------------------------
local composer = require("composer")
local ortak = require("levha_ortak")
local dil = require("dil")
local ogrenme = require("ogrenme_kaydi")

local scene = composer.newScene()

local FRAME_DESCRIPTOR = {
    sheetContentWidth = 700,
    sheetContentHeight = 1950,
    frames = {}
}

local xKonumlari = { 5, 180, 360, 530 }
local frameNo = 0
for satir = 0, 12 do
    for sutun = 1, 4 do
        frameNo = frameNo + 1
        FRAME_DESCRIPTOR.frames[frameNo] = {
            x = xKonumlari[sutun],
            y = 3 + satir * 150,
            width = 163,
            height = 146
        }
    end
end

local imageSheet = graphics.newImageSheet(
    "levha/levha/1-tehlike/tehlike.png",
    FRAME_DESCRIPTOR
)

local function karistir(liste)
    for i = #liste, 2, -1 do
        local j = math.random(i)
        liste[i], liste[j] = liste[j], liste[i]
    end
    return liste
end

local function sinavSorulariOlustur()
    local kayitlar = ortak.levhaAciklamalariniOku(
        "levha/levha/1-tehlike/Tehlike ve Uyari Aciklama.json",
        53
    )
    -- İki taraftan ve sağ/sol taraftan daralan kaplama levhaları da
    -- birbirinden ayrı kayıtlar olarak sınava dahil edilir.
    local secilecekKayitlar = { 2, 3, 4, 5, 6, 7, 8, 9, 10 }
    local sorular = {}

    for _, kayitIndeksi in ipairs(secilecekKayitlar) do
        local kayit = kayitlar[kayitIndeksi]
        if kayit and kayit.ad and kayit.ad ~= "" then
            sorular[#sorular + 1] = {
                -- JSON'daki ilk boş kayıt görsel sprite'ında bulunmaz.
                kare = kayitIndeksi - 1,
                kayit = kayit,
                dogru = ortak.levhaAdi(kayit.ad)
            }
        end
    end

    return karistir(sorular)
end

function scene:create()
    local sceneGroup = self.view
    local ekran = ortak.ekranBilgileri()
    local ust = ekran.safeOriginY or display.safeScreenOriginY or display.screenOriginY or 0

    local zemin = display.newRect(
        sceneGroup,
        display.contentCenterX,
        display.contentCenterY,
        display.contentWidth,
        display.contentHeight
    )
    zemin:setFillColor(0.84, 0.91, 0.97)
    zemin:addEventListener("touch", function() return true end)

    local baslikKarti = display.newRoundedRect(sceneGroup, display.contentCenterX, ust + 37,
        display.contentWidth - 24, 58, 10)
    baslikKarti:setFillColor(0.05, 0.30, 0.55)

    local baslik = display.newText({
        parent = sceneGroup,
        text = dil.metin("quiz_baslik"),
        x = display.contentCenterX,
        y = ust + 37,
        font = "Poppins-Bold",
        fontSize = 20
    })
    baslik:setFillColor(1)

    local geri = display.newText({
        parent = sceneGroup,
        text = dil.metin("geri_don"),
        x = 48,
        y = ust + 76,
        font = "Poppins-Bold",
        fontSize = 13
    })
    geri.anchorX = 0
    geri:setFillColor(0.05, 0.30, 0.55)
    geri:addEventListener("touch", function(event)
        if event.phase == "ended" then
            composer.gotoScene("giris", "fade", 350)
        end
        return true
    end)

    local ilerleme = display.newText({
        parent = sceneGroup,
        text = "",
        x = display.contentCenterX,
        y = ust + 89,
        font = "Poppins-Medium",
        fontSize = 12
    })
    ilerleme:setFillColor(0.25, 0.28, 0.32)

    local kayitBilgisi = display.newText({
        parent = sceneGroup,
        text = "",
        x = display.contentCenterX,
        y = ust + 125,
        width = display.contentWidth - 28,
        font = "Poppins-Medium",
        fontSize = 9,
        align = "center"
    })
    kayitBilgisi:setFillColor(0.32, 0.35, 0.39)

    local soruBasligi = display.newText({
        parent = sceneGroup,
        text = dil.metin("quiz_soru"),
        x = display.contentCenterX,
        y = ust + 104,
        font = "Poppins-Bold",
        fontSize = 15
    })
    soruBasligi:setFillColor(0.10, 0.12, 0.15)

    local levhaGorseli
    local secenekGruplari = {}
    local geriBildirim
    local sonrakiButon
    local sonrakiYazi
    local sorular = {}
    local soruSirasi = 1
    local puan = 0
    local cevaplandi = false
    local yanlislar = {}
    local sonucKaydedildi = false
    local sifirlaButonu
    local sifirlaYazi

    local function kayitMetniniGuncelle(kayit)
        kayit = kayit or ogrenme.oku()
        local toplam = tonumber(kayit.lastTotal) or #sorular
        if toplam < 1 then toplam = #sorular end
        kayitBilgisi.text = string.format(
            dil.metin("quiz_ilerleme"),
            tonumber(kayit.best) or 0,
            toplam,
            tonumber(kayit.attempts) or 0
        )
    end

    local function secenekleriKaldir()
        for _, secenek in ipairs(secenekGruplari) do
            if secenek and secenek.removeSelf then
                secenek:removeSelf()
            end
        end
        secenekGruplari = {}
    end

    local function sinaviBaslangicaDondur()
        soruSirasi = 1
        puan = 0
        yanlislar = {}
        sonucKaydedildi = false
        cevaplandi = false
        sorular = sinavSorulariOlustur()
        soruBasligi.text = dil.metin("quiz_soru")
        soruBasligi.y = ust + 104
        ilerleme.y = ust + 89
        geriBildirim.text = ""
        geriBildirim.x = -1000
        secenekleriKaldir()
        if sonrakiButon then sonrakiButon.isVisible = false end
        if sonrakiYazi then sonrakiYazi.isVisible = false end
        if scene._sinaviCiz then
            scene._sinaviCiz()
        end
    end

    local function sonucEkraniniGoster()
        if not sonucKaydedildi then
            sonucKaydedildi = true
            local kayit = ogrenme.sinaviKaydet(puan, #sorular, yanlislar)
            kayitMetniniGuncelle(kayit)
        end
        if levhaGorseli then levhaGorseli.isVisible = false end
        soruBasligi.text = dil.metin("quiz_tamamlandi")
        soruBasligi.y = ust + 153
        ilerleme.text = string.format(dil.metin("quiz_puan"), puan, #sorular)
        ilerleme.y = ust + 185
        geriBildirim.text = dil.metin("quiz_tekrar")
        geriBildirim.x = display.contentCenterX
        geriBildirim.y = ust + 245
        geriBildirim:setFillColor(0.05, 0.30, 0.55)
        geriBildirim:addEventListener("touch", function(event)
            if event.phase == "ended" then
                sinaviBaslangicaDondur()
            end
            return true
        end)
        if sonrakiButon then sonrakiButon.isVisible = false end
        if sonrakiYazi then sonrakiYazi.isVisible = false end
        secenekleriKaldir()
    end

    local function sonrakiSoruyuGoster()
        soruSirasi = soruSirasi + 1
        cevaplandi = false
        if soruSirasi > #sorular then
            sonucEkraniniGoster()
            return
        end
        if sonrakiButon then sonrakiButon.isVisible = false end
        if sonrakiYazi then sonrakiYazi.isVisible = false end
        if geriBildirim then geriBildirim.text = "" end
        secenekleriKaldir()
        scene._sinaviCiz()
    end

    local function cevapla(secenek, soru)
        if cevaplandi then return end
        cevaplandi = true
        geriBildirim.x = display.contentCenterX
        if secenek._dogru then
            puan = puan + 1
            secenek._zemin:setFillColor(0.18, 0.58, 0.30)
            geriBildirim.text = dil.metin("quiz_dogru")
            geriBildirim:setFillColor(0.12, 0.45, 0.22)
        else
            yanlislar[#yanlislar + 1] = soru.dogru
            secenek._zemin:setFillColor(0.75, 0.20, 0.20)
            geriBildirim.text = dil.metin("quiz_yanlis") .. " " .. soru.dogru
            geriBildirim:setFillColor(0.65, 0.12, 0.12)
            for _, diger in ipairs(secenekGruplari) do
                if diger._dogru then
                    diger._zemin:setFillColor(0.18, 0.58, 0.30)
                end
            end
        end
        ilerleme.text = string.format(dil.metin("quiz_puan_kisa"), soruSirasi, #sorular, puan)
        if sonrakiButon then sonrakiButon.isVisible = true end
        if sonrakiYazi then sonrakiYazi.isVisible = true end
    end

    function scene._sinaviCiz()
        local soru = sorular[soruSirasi]
        if not soru then
            sonucEkraniniGoster()
            return
        end

        if levhaGorseli then levhaGorseli:removeSelf() end
        -- Levha görselindeki küçük teknik açıklama metni cevabı açık
        -- edebiliyor. Alt kısmı kırparak yalnızca işaretin kendisini göster.
        levhaGorseli = display.newContainer(120, 84)
        sceneGroup:insert(levhaGorseli)
        levhaGorseli.x = display.contentCenterX
        levhaGorseli.y = ust + 178
        local levhaResmi = display.newImageRect(levhaGorseli, imageSheet, soru.kare, 120, 108)
        levhaResmi.x = 0
        levhaResmi.y = 12

        soruBasligi.text = dil.metin("quiz_soru")
        soruBasligi.y = ust + 104
        ilerleme.text = string.format(dil.metin("quiz_puan_kisa"), soruSirasi, #sorular, puan)
        kayitMetniniGuncelle()
        geriBildirim.text = ""
        geriBildirim.x = -1000

        -- Doğru cevap her zaman seçeneklerin içinde bulunmalı. Önce mevcut
        -- sorunun cevabını ekle, kalan üç seçeneği havuzdan rastgele seç.
        local adaylar = { soru.dogru }
        local digerCevaplar = {}
        for index, aday in ipairs(sorular) do
            if index ~= soruSirasi and aday.dogru ~= soru.dogru then
                digerCevaplar[#digerCevaplar + 1] = aday.dogru
            end
        end
        karistir(digerCevaplar)
        for i = 1, math.min(3, #digerCevaplar) do
            adaylar[#adaylar + 1] = digerCevaplar[i]
        end
        karistir(adaylar)

        local baslangicY = ust + 258
        for i, cevapMetni in ipairs(adaylar) do
            local secenek = display.newGroup()
            sceneGroup:insert(secenek)
            local zeminSecenek = display.newRoundedRect(secenek, display.contentCenterX,
                baslangicY + ((i - 1) * 47), display.contentWidth - 44, 39, 8)
            zeminSecenek:setFillColor(0.05, 0.30, 0.55)
            local etiket = display.newText({
                parent = secenek,
                text = cevapMetni,
                x = display.contentCenterX,
                y = baslangicY + ((i - 1) * 47),
                width = display.contentWidth - 66,
                font = "Poppins-Bold",
                fontSize = 13,
                align = "center"
            })
            etiket:setFillColor(1)
            secenek._zemin = zeminSecenek
            secenek._etiket = etiket
            secenek._dogru = cevapMetni == soru.dogru
            local function secenekDokun(event)
                if event.phase == "began" then
                    display.getCurrentStage():setFocus(secenek)
                    secenek.isFocus = true
                    zeminSecenek:setFillColor(0.08, 0.40, 0.68)
                elseif secenek.isFocus and (event.phase == "ended" or event.phase == "cancelled") then
                    display.getCurrentStage():setFocus(nil)
                    secenek.isFocus = false
                    if event.phase == "ended" then
                        cevapla(secenek, soru)
                    elseif not cevaplandi then
                        zeminSecenek:setFillColor(0.05, 0.30, 0.55)
                    end
                end
                return true
            end
            secenek:addEventListener("touch", secenekDokun)
            zeminSecenek:addEventListener("touch", secenekDokun)
            etiket:addEventListener("touch", secenekDokun)
            secenekGruplari[#secenekGruplari + 1] = secenek
        end
    end

    geriBildirim = display.newText({
        parent = sceneGroup,
        text = "",
        x = -1000,
        y = ust + 444,
        width = display.contentWidth - 30,
        font = "Poppins-Bold",
        fontSize = 12,
        align = "center"
    })

    sonrakiButon = display.newRoundedRect(sceneGroup, display.contentCenterX, ust + 466,
        150, 34, 7)
    sonrakiButon:setFillColor(0.05, 0.30, 0.55)
    sonrakiYazi = display.newText({
        parent = sceneGroup,
        text = dil.metin("quiz_sonraki"),
        x = sonrakiButon.x,
        y = sonrakiButon.y,
        font = "Poppins-Bold",
        fontSize = 13
    })
    sonrakiYazi:setFillColor(1)
    sonrakiButon.isVisible = false
    sonrakiYazi.isVisible = false
    local function sonrakiDokun(event)
        if event.phase == "ended" and sonrakiButon.isVisible then
            sonrakiButon.isVisible = false
            sonrakiYazi.isVisible = false
            sonrakiSoruyuGoster()
        end
        return true
    end
    sonrakiButon:addEventListener("touch", sonrakiDokun)
    sonrakiYazi:addEventListener("touch", sonrakiDokun)

    sifirlaButonu = display.newRoundedRect(sceneGroup, display.contentCenterX, ust + 515,
        190, 30, 7)
    sifirlaButonu:setFillColor(0.38, 0.42, 0.48)
    sifirlaYazi = display.newText({
        parent = sceneGroup,
        text = "İlerlemeyi sıfırla",
        x = sifirlaButonu.x,
        y = sifirlaButonu.y,
        font = "Poppins-Bold",
        fontSize = 10
    })
    sifirlaYazi:setFillColor(1)

    local function ilerlemeyiSifirla()
        native.showAlert(
            "İlerlemeyi sıfırla",
            "Kayıtlı en iyi skor, tamamlanan sınav sayısı ve yanlış cevaplar silinecek. Bu işlem yalnızca bu cihazdaki yerel veriyi etkiler.",
            { "İptal", "Sıfırla" },
            function(event)
                if event.action ~= "clicked" or event.index ~= 2 then
                    return
                end

                if not ogrenme.sifirla() then
                    native.showAlert(
                        "Sıfırlama başarısız",
                        "Yerel sınav kaydı silinemedi. Lütfen tekrar deneyin.",
                        { "Tamam" }
                    )
                    return
                end

                sinaviBaslangicaDondur()
            end
        )
    end

    local function sifirlaDokun(event)
        if event.phase == "ended" then
            ilerlemeyiSifirla()
        end
        return true
    end
    sifirlaButonu:addEventListener("touch", sifirlaDokun)
    sifirlaYazi:addEventListener("touch", sifirlaDokun)

    -- Ekran ilk açıldığında ve her dil seçiminden sonra aynı çizim yolu kullanılır.
    math.randomseed(os.time() + math.floor(os.clock() * 1000))
    sorular = sinavSorulariOlustur()
    kayitMetniniGuncelle()
    scene._sinaviCiz()
end

function scene:show(event)
    if event.phase == "did" then
        ortak.tabBarGizle(composer.getVariable("tabBar"), 0)
    end
end

function scene:hide(event)
    if event.phase == "did" then
        composer.removeScene("quiz")
    end
end

scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)

return scene
