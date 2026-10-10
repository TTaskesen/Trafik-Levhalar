--------------------------------------------------------------------------------
-- Trafik levhalarını öğrenmeye dönük çevrimdışı mini sınav.
-- Kullanıcı önce seviyeyi seçer; her seviyede 10 soru bulunur ve bütün
-- kategorilerden levhalar soru/çeldirici havuzuna dahil edilir.
--------------------------------------------------------------------------------
local composer = require("composer")
local ortak = require("levha_ortak")
local dil = require("dil")
local ogrenme = require("ogrenme_kaydi")
local quizVerileri = require("quiz_verileri")

local scene = composer.newScene()

local function karistir(liste)
    for i = #liste, 2, -1 do
        local j = math.random(i)
        liste[i], liste[j] = liste[j], liste[i]
    end
    return liste
end

function scene:create()
    local sceneGroup = self.view
    local ekran = ortak.ekranBilgileri()
    local ust = ekran.safeOriginY or display.safeScreenOriginY or display.screenOriginY or 0

    math.randomseed(os.time() + math.floor(os.clock() * 1000))

    local zemin = display.newRect(sceneGroup, display.contentCenterX, display.contentCenterY,
        display.contentWidth, display.contentHeight)
    zemin:setFillColor(0.84, 0.91, 0.97)
    zemin:addEventListener("touch", function() return true end)

    local baslikKarti = display.newRoundedRect(sceneGroup, display.contentCenterX, ust + 37,
        display.contentWidth - 24, 58, 10)
    baslikKarti:setFillColor(0.05, 0.30, 0.55)

    local baslik = display.newText({
        parent = sceneGroup, text = dil.metin("quiz_baslik"),
        x = display.contentCenterX, y = ust + 37,
        font = "Poppins-Bold", fontSize = 20
    })
    baslik:setFillColor(1)

    local geri = display.newText({
        parent = sceneGroup, text = dil.metin("geri_don"),
        x = 48, y = ust + 76,
        font = "Poppins-Bold", fontSize = 13
    })
    geri.anchorX = 0
    geri:setFillColor(0.05, 0.30, 0.55)
    geri:addEventListener("touch", function(event)
        if event.phase == "ended" then
            composer.gotoScene("giris", "fade", 350)
        end
        return true
    end)

    local seviyePaneli = display.newGroup()
    sceneGroup:insert(seviyePaneli)
    local seviyeBasligi = display.newText({
        parent = seviyePaneli, text = dil.metin("quiz_zorluk_sec"),
        x = display.contentCenterX, y = ust + 145,
        width = display.contentWidth - 36,
        font = "Poppins-Bold", fontSize = 17, align = "center"
    })
    seviyeBasligi:setFillColor(0.10, 0.12, 0.15)

    local seviyeAciklama = display.newText({
        parent = seviyePaneli, text = dil.metin("quiz_seviye_aciklama"),
        x = display.contentCenterX, y = ust + 177,
        width = display.contentWidth - 42,
        font = "Poppins-Medium", fontSize = 11, align = "center"
    })
    seviyeAciklama:setFillColor(0.32, 0.35, 0.39)

    local oyunOgesi = display.newGroup()
    sceneGroup:insert(oyunOgesi)
    oyunOgesi.isVisible = false

    local ilerleme = display.newText({
        parent = oyunOgesi, text = "", x = display.contentCenterX, y = ust + 89,
        font = "Poppins-Medium", fontSize = 12
    })
    ilerleme:setFillColor(0.25, 0.28, 0.32)

    local kayitBilgisi = display.newText({
        parent = oyunOgesi, text = "", x = display.contentCenterX, y = ust + 125,
        width = display.contentWidth - 28, font = "Poppins-Medium", fontSize = 9,
        align = "center"
    })
    kayitBilgisi:setFillColor(0.32, 0.35, 0.39)

    local soruBasligi = display.newText({
        parent = oyunOgesi, text = dil.metin("quiz_soru"),
        x = display.contentCenterX, y = ust + 104,
        font = "Poppins-Bold", fontSize = 15
    })
    soruBasligi:setFillColor(0.10, 0.12, 0.15)

    local levhaGorseli
    local secenekGruplari = {}
    local geriBildirim
    local sonrakiButon
    local sonrakiYazi
    local tekrarButonu
    local tekrarYazi
    local sifirlaButonu
    local sifirlaYazi
    local sorular = {}
    local seviye
    local soruSirasi = 1
    local puan = 0
    local cevaplandi = false
    local yanlislar = {}
    local sonucKaydedildi = false

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
            if secenek and secenek.removeSelf then secenek:removeSelf() end
        end
        secenekGruplari = {}
    end

    local function oyunDugmeleriniGizle()
        if sonrakiButon then sonrakiButon.isVisible = false end
        if sonrakiYazi then sonrakiYazi.isVisible = false end
        if tekrarButonu then tekrarButonu.isVisible = false end
        if tekrarYazi then tekrarYazi.isVisible = false end
        if sifirlaButonu then sifirlaButonu.isVisible = false end
        if sifirlaYazi then sifirlaYazi.isVisible = false end
    end

    local function seviyeButonunuGoster(kod, y, renk, yaziBoyutu)
        local dugme = display.newRoundedRect(seviyePaneli, display.contentCenterX, y,
            display.contentWidth - 58, 48, 9)
        dugme:setFillColor(renk[1], renk[2], renk[3])
        dugme:setStrokeColor(1, 1, 1, 0.35)
        dugme.strokeWidth = 1.5
        local yazi = display.newText({
            parent = seviyePaneli, text = dil.metin("quiz_" .. kod),
            x = dugme.x, y = dugme.y, font = "Poppins-Bold", fontSize = yaziBoyutu or 15
        })
        yazi:setFillColor(1)
        yazi.isHitTestable = false

        local function dokun(event)
            if event.phase == "began" then
                display.getCurrentStage():setFocus(dugme)
                dugme.isFocus = true
                dugme:setFillColor(math.min(1, renk[1] + 0.08), math.min(1, renk[2] + 0.08),
                    math.min(1, renk[3] + 0.08))
            elseif dugme.isFocus and (event.phase == "ended" or event.phase == "cancelled") then
                display.getCurrentStage():setFocus(nil)
                dugme.isFocus = false
                dugme:setFillColor(renk[1], renk[2], renk[3])
                if event.phase == "ended" then
                    seviye = kod
                    seviyePaneli.isVisible = false
                    oyunOgesi.isVisible = true
                    soruSirasi, puan, cevaplandi, sonucKaydedildi = 1, 0, false, false
                    yanlislar = {}
                    sorular = quizVerileri.sorulariOlustur(seviye, 10)
                    scene._sinaviCiz()
                end
            end
            return true
        end
        dugme:addEventListener("touch", dokun)
        return dugme
    end

    seviyeButonunuGoster("kolay", ust + 235, { 0.12, 0.52, 0.30 })
    seviyeButonunuGoster("orta", ust + 300, { 0.05, 0.30, 0.55 })
    seviyeButonunuGoster("zor", ust + 365, { 0.68, 0.18, 0.18 })

    local function sinaviBaslangicaDondur()
        soruSirasi, puan, cevaplandi, sonucKaydedildi = 1, 0, false, false
        yanlislar = {}
        sorular = quizVerileri.sorulariOlustur(seviye, 10)
        soruBasligi.text = dil.metin("quiz_soru")
        soruBasligi.y = ust + 104
        ilerleme.y = ust + 89
        geriBildirim.text = ""
        geriBildirim.x = -1000
        secenekleriKaldir()
        oyunDugmeleriniGizle()
        scene._sinaviCiz()
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
        geriBildirim.x = display.contentCenterX
        geriBildirim.y = ust + 245
        tekrarButonu.isVisible = true
        tekrarYazi.isVisible = true
        sifirlaButonu.isVisible = true
        sifirlaYazi.isVisible = true
        secenekleriKaldir()
    end

    local function sonrakiSoruyuGoster()
        soruSirasi = soruSirasi + 1
        cevaplandi = false
        if soruSirasi > #sorular then
            sonucEkraniniGoster()
            return
        end
        if geriBildirim then geriBildirim.text = "" end
        secenekleriKaldir()
        oyunDugmeleriniGizle()
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
                if diger._dogru then diger._zemin:setFillColor(0.18, 0.58, 0.30) end
            end
        end
        ilerleme.text = string.format(dil.metin("quiz_puan_kisa"), soruSirasi, #sorular, puan)
        sonrakiButon.isVisible = true
        sonrakiYazi.isVisible = true
    end

    function scene._sinaviCiz()
        local soru = sorular[soruSirasi]
        if not soru then
            sonucEkraniniGoster()
            return
        end

        if levhaGorseli then levhaGorseli:removeSelf() end
        local frame = soru.kareBilgisi
        local maxWidth, maxHeight = math.min(display.contentWidth - 48, 190), 122
        local oran = frame.width / frame.height
        local gorselW, gorselH = maxWidth, maxWidth / oran
        if gorselH > maxHeight + 35 then
            gorselH = maxHeight + 35
            gorselW = gorselH * oran
        end
        levhaGorseli = display.newContainer(math.max(120, gorselW + 12), maxHeight)
        oyunOgesi:insert(levhaGorseli)
        levhaGorseli.x = display.contentCenterX
        levhaGorseli.y = ust + 178
        local levhaResmi = display.newImageRect(levhaGorseli, soru.imageSheet, soru.kare, gorselW, gorselH)
        levhaResmi.x = 0
        levhaResmi.y = 8

        soruBasligi.text = dil.metin("quiz_soru")
        soruBasligi.y = ust + 104
        ilerleme.text = string.format(dil.metin("quiz_puan_kisa"), soruSirasi, #sorular, puan)
        kayitMetniniGuncelle()
        geriBildirim.text = ""
        geriBildirim.x = -1000

        local adaylar = { soru.dogru }
        local digerCevaplar = quizVerileri.distraktorler(soru, 3)
        for _, cevap in ipairs(digerCevaplar) do adaylar[#adaylar + 1] = cevap end
        karistir(adaylar)

        local baslangicY = ust + 258
        for i, cevapMetni in ipairs(adaylar) do
            local secenek = display.newGroup()
            oyunOgesi:insert(secenek)
            local y = baslangicY + ((i - 1) * 47)
            local zeminSecenek = display.newRoundedRect(secenek, display.contentCenterX, y,
                display.contentWidth - 44, 39, 8)
            zeminSecenek:setFillColor(0.05, 0.30, 0.55)
            local etiket = display.newText({
                parent = secenek, text = cevapMetni, x = display.contentCenterX, y = y,
                width = display.contentWidth - 66, font = "Poppins-Bold", fontSize = 13, align = "center"
            })
            etiket:setFillColor(1)
            secenek._zemin, secenek._etiket = zeminSecenek, etiket
            secenek._dogru = cevapMetni == soru.dogru
            local function secenekDokun(event)
                if event.phase == "began" then
                    display.getCurrentStage():setFocus(secenek)
                    secenek.isFocus = true
                    zeminSecenek:setFillColor(0.08, 0.40, 0.68)
                elseif secenek.isFocus and (event.phase == "ended" or event.phase == "cancelled") then
                    display.getCurrentStage():setFocus(nil)
                    secenek.isFocus = false
                    if event.phase == "ended" then cevapla(secenek, soru) end
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
        parent = oyunOgesi, text = "", x = -1000, y = ust + 444,
        width = display.contentWidth - 30, font = "Poppins-Bold", fontSize = 12, align = "center"
    })

    sonrakiButon = display.newRoundedRect(oyunOgesi, display.contentCenterX, ust + 466, 150, 34, 7)
    sonrakiButon:setFillColor(0.05, 0.30, 0.55)
    sonrakiYazi = display.newText({ parent = oyunOgesi, text = dil.metin("quiz_sonraki"),
        x = sonrakiButon.x, y = sonrakiButon.y, font = "Poppins-Bold", fontSize = 13 })
    sonrakiYazi:setFillColor(1)
    local function sonrakiDokun(event)
        if event.phase == "ended" and sonrakiButon.isVisible then
            oyunDugmeleriniGizle()
            sonrakiSoruyuGoster()
        end
        return true
    end
    sonrakiButon:addEventListener("touch", sonrakiDokun)
    sonrakiYazi:addEventListener("touch", sonrakiDokun)

    tekrarButonu = display.newRoundedRect(oyunOgesi, display.contentCenterX, ust + 245, 190, 34, 7)
    tekrarButonu:setFillColor(0.05, 0.30, 0.55)
    tekrarYazi = display.newText({ parent = oyunOgesi, text = dil.metin("quiz_tekrar"),
        x = tekrarButonu.x, y = tekrarButonu.y, font = "Poppins-Bold", fontSize = 12 })
    tekrarYazi:setFillColor(1)
    local function tekrarDokun(event)
        if event.phase == "ended" and tekrarButonu.isVisible then sinaviBaslangicaDondur() end
        return true
    end
    tekrarButonu:addEventListener("touch", tekrarDokun)
    tekrarYazi:addEventListener("touch", tekrarDokun)

    sifirlaButonu = display.newRoundedRect(oyunOgesi, display.contentCenterX, ust + 292, 190, 30, 7)
    sifirlaButonu:setFillColor(0.38, 0.42, 0.48)
    sifirlaYazi = display.newText({ parent = oyunOgesi, text = dil.metin("quiz_sifirla"),
        x = sifirlaButonu.x, y = sifirlaButonu.y, font = "Poppins-Bold", fontSize = 10 })
    sifirlaYazi:setFillColor(1)
    local function ilerlemeyiSifirla()
        native.showAlert(
            dil.metin("quiz_sifirla"), dil.metin("quiz_sifirla_aciklama"),
            { dil.metin("quiz_iptal"), dil.metin("quiz_onayla") },
            function(event)
                if event.action ~= "clicked" or event.index ~= 2 then return end
                if not ogrenme.sifirla() then
                    native.showAlert(dil.metin("quiz_sifirla"), dil.metin("quiz_sifirla_hata"), { "OK" })
                    return
                end
                sinaviBaslangicaDondur()
            end
        )
    end
    local function sifirlaDokun(event)
        if event.phase == "ended" and sifirlaButonu.isVisible then ilerlemeyiSifirla() end
        return true
    end
    sifirlaButonu:addEventListener("touch", sifirlaDokun)
    sifirlaYazi:addEventListener("touch", sifirlaDokun)

    oyunDugmeleriniGizle()
end

function scene:show(event)
    if event.phase == "did" then
        ortak.tabBarGizle(composer.getVariable("tabBar"), 0)
    end
end

function scene:hide(event)
    if event.phase == "did" then composer.removeScene("quiz") end
end

scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)

return scene
