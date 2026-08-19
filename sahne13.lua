--------------------------------------------------------------------------------
-- Kullanıcının kendi hikâyesini yazıp e-posta ile gönderebildiği sayfa.
--------------------------------------------------------------------------------
local composer = require("composer")
local dil = require("dil")
local ortak = require("levha_ortak")
local hikayeKayit = require("hikaye_kayit")
local guvenlik = require("hikaye_guvenlik")
local supabase = require("supabase_hikayeler")
local scene = composer.newScene()

local alani
local baslikAlani
local tabBar
local durumMesaji
local gonderiliyor = false
local GONDERILECEK_ADRES = "turguttaskesen@gmail.com"

local function urlKodla(metin)
	return tostring(metin or ""):gsub("[^%w%-%._~ ]", function(karakter)
		return string.format("%%%02X", string.byte(karakter))
	end):gsub(" ", "%%20")
end

local function anaSayfayaDon()
	composer.gotoScene("giris", "fade", 400)
	return true
end

function scene:create()
	local grup = self.view
	local ust = display.safeScreenOriginY or display.screenOriginY or 0
	local ekran = ortak.ekranBilgileri()
	local altGuvenlik = math.max(16, ekran.bottomInset)

	local zemin = display.newRect(grup, display.contentCenterX, display.contentCenterY,
		display.contentWidth, display.contentHeight)
	zemin:setFillColor(0.84, 0.91, 0.97)

	local baslikKarti = display.newRoundedRect(grup, display.contentCenterX, ust + 34, 300, 54, 10)
	baslikKarti:setFillColor(0.05, 0.3, 0.55, 0.9)
	local baslik = display.newText(grup, dil.metin("hikaye_yaz_baslik"), display.contentCenterX, ust + 34,
		"Poppins-Bold", 20)
	baslik:setFillColor(1)

	local haftaninKonusu = display.newText({
		parent = grup,
		text = dil.metin("hikaye_haftanin_konusu"),
		x = display.contentCenterX,
		y = ust + 72,
		width = display.contentWidth - 24,
		font = "Poppins-Bold",
		fontSize = 13,
		align = "center"
	})
	haftaninKonusu:setFillColor(0.05, 0.3, 0.55)

	local bilgi = display.newText({
		parent = grup,
		text = dil.metin("hikaye_yaz_bilgi"),
		x = display.contentCenterX,
		y = ust + 116,
		width = display.contentWidth - 36,
		font = "Poppins-Medium",
		fontSize = 13,
		align = "center"
	})
	bilgi:setFillColor(0.05, 0.3, 0.55)

	-- Düğmeler güvenli alt alanda sabitlenir; yazı alanı kalan yüksekliği kullanır.
	local geriY = ekran.safeBottom - altGuvenlik - 28
	local butonYuksekligi = 40
	local butonGenisligi = 170
	local gonderY = geriY - butonYuksekligi - 10
	local okumaY = gonderY - butonYuksekligi - 10
	-- Açıklama birkaç satıra uzadığında başlık alanı onun üstüne binmesin.
	local baslikY = math.max(ust + 154, bilgi.y + bilgi.height / 2 + 22)
	local baslikZemini = display.newRoundedRect(grup, display.contentCenterX, baslikY,
		display.contentWidth - 36, 34, 6)
	baslikZemini:setFillColor(1.0, 0.93, 0.55, 1)
	baslikZemini:setStrokeColor(0.95, 0.78, 0.25, 1)
	baslikZemini.strokeWidth = 1
	baslikAlani = native.newTextField(display.contentCenterX, baslikY,
		display.contentWidth - 48, 30)
	baslikAlani.placeholder = ""
	baslikAlani.isEditable = true
	baslikAlani.font = native.newFont("Poppins-Medium", 14)
	baslikAlani:setTextColor(0.08, 0.08, 0.08)
	baslikAlani.hasBackground = false
	local baslikYerTutucu = display.newText(grup, dil.metin("hikaye_baslik_yer_tutucu"),
		display.contentCenterX, baslikY, "Poppins-Medium", 14)
	baslikYerTutucu:setFillColor(0.18, 0.18, 0.18)
	baslikYerTutucu.isHitTestable = false

	local yaziUstu = baslikY + 40
	local yaziAlti = okumaY - 12 - 16
	local yaziYuksekligi = math.max(150, yaziAlti - yaziUstu)
	local yaziGenisligi = display.contentWidth - 36

	local yaziZemini = display.newRoundedRect(
		grup,
		display.contentCenterX,
		yaziUstu + yaziYuksekligi / 2,
		yaziGenisligi,
		yaziYuksekligi,
		6
	)
	yaziZemini:setFillColor(1.0, 0.93, 0.55, 1)
	yaziZemini:setStrokeColor(0.95, 0.78, 0.25, 1)
	yaziZemini.strokeWidth = 1

	alani = native.newTextBox(display.contentCenterX, yaziUstu + yaziYuksekligi / 2,
		yaziGenisligi, yaziYuksekligi)
	alani.text = ""
	alani.placeholder = ""
	alani.isEditable = true
	alani.font = native.newFont("Poppins-Medium", 15)
	-- Uzun hikâyeler için native TextBox çok satırlı metni kendi içinde kaydırır.
	-- Arka plan rengi, native kutunun arkasındaki display nesnesinden gelir.
	alani:setTextColor(0.08, 0.08, 0.08)
	alani.hasBackground = false
	local metinYerTutucu = display.newText({
		parent = grup,
		text = dil.metin("hikaye_yaz_yer_tutucu"),
		x = display.contentCenterX - yaziGenisligi / 2 + 12,
		y = yaziUstu + 8,
		font = "Poppins-Medium",
		fontSize = 15,
		align = "left"
	})
	metinYerTutucu.anchorX, metinYerTutucu.anchorY = 0, 0
	metinYerTutucu:setFillColor(0.18, 0.18, 0.18)
	metinYerTutucu.isHitTestable = false
	local function yerTutucuyuGuncelle(olay)
		local dolu = olay.target.text and olay.target.text ~= ""
		if olay.target == baslikAlani then
			baslikYerTutucu.isVisible = not dolu
		else
			metinYerTutucu.isVisible = not dolu
		end
		return false
	end
	baslikAlani:addEventListener("userInput", yerTutucuyuGuncelle)
	alani:addEventListener("userInput", yerTutucuyuGuncelle)


	local gonder = display.newRoundedRect(grup, display.contentCenterX, gonderY, butonGenisligi, butonYuksekligi, 8)
	gonder:setFillColor(0.05, 0.3, 0.55, 0.9)
	gonder:setStrokeColor(1, 1, 1, 0.35)
	local gonderMetin = display.newText(grup, dil.metin("hikaye_gonder"), gonder.x, gonder.y,
		"Poppins-Bold", 14)
	gonderMetin:setFillColor(1)

	local function durumGoster(metin, hata)
		if durumMesaji then
			durumMesaji:removeSelf()
			durumMesaji = nil
		end
		durumMesaji = display.newText(grup, metin, display.contentCenterX, gonder.y - 28,
			"Poppins-Medium", 11)
		durumMesaji:setFillColor(hata and 0.75 or 0.05, hata and 0.12 or 0.45, hata and 0.12 or 0.2)
	end

	local hikayelerimButon = display.newRoundedRect(grup, display.contentCenterX, okumaY,
		butonGenisligi, butonYuksekligi, 8)
	hikayelerimButon:setFillColor(0.05, 0.3, 0.55, 0.9)
	hikayelerimButon:setStrokeColor(1, 1, 1, 0.35)
	hikayelerimButon.strokeWidth = 1.5
	local hikayelerim = display.newText(grup, dil.metin("hikayelerim_oku"), hikayelerimButon.x, hikayelerimButon.y,
		"Poppins-Bold", 11)
	hikayelerim:setFillColor(1)
	local function hikayelerimiOku()
		composer.gotoScene("sahne14", "slideLeft", 400)
		return true
	end
	hikayelerim:addEventListener("tap", hikayelerimiOku)
	hikayelerimButon:addEventListener("tap", hikayelerimiOku)

	local geri = display.newRoundedRect(grup, display.contentCenterX, geriY, butonGenisligi, butonYuksekligi, 8)
	geri:setFillColor(0.05, 0.3, 0.55, 0.9)
	geri:setStrokeColor(1, 1, 1, 0.35)
	geri.strokeWidth = 1.5
	local geriMetin = display.newText(grup, dil.metin("geri_don"), geri.x, geri.y, "Poppins-Bold", 14)
	geriMetin:setFillColor(1)

	local function gonderDokun(olay)
		if olay.phase ~= "ended" then
			return true
		end
		if gonderiliyor then return true end
		native.setKeyboardFocus(nil)
		local baslik = baslikAlani and baslikAlani.text or ""
		local hikaye = alani and alani.text or ""
		local uygun, hataMesaji = guvenlik.kontrol(baslik, hikaye)
		if not uygun then
			durumGoster(hataMesaji, true)
			return true
		end
		gonderiliyor = true
		guvenlik.gonderimBaslat()
		local konu = dil.metin("hikaye_mail_konu") .. ": " .. baslik
		local govde = dil.metin("hikaye_mail_giris") .. "\n\n" .. hikaye
		local mailto = "mailto:" .. GONDERILECEK_ADRES
			.. "?subject=" .. urlKodla(konu)
			.. "&body=" .. urlKodla(govde)
		system.openURL(mailto)
		local istekBasladi = supabase.hikayeGonder(baslik, hikaye, dil.kodu(), function(basarili)
			gonderiliyor = false
			if basarili then
				hikayeKayit.ekle(baslik, hikaye)
				alani.text = ""
				baslikAlani.text = ""
				baslikYerTutucu.isVisible = true
				metinYerTutucu.isVisible = true
				durumGoster("Hikâyen gönderildi; onay bekliyor.", false)
			else
				durumGoster("Gönderilemedi; yazın korunuyor.", true)
			end
		end)
		if not istekBasladi then
			gonderiliyor = false
		end
		return true
	end

	gonder:addEventListener("touch", gonderDokun)
	gonderMetin:addEventListener("touch", gonderDokun)
	geri:addEventListener("touch", function() return anaSayfayaDon() end)
	geriMetin:addEventListener("touch", function() return anaSayfayaDon() end)
end

function scene:show(event)
	if event.phase == "did" then
		tabBar = composer.getVariable("tabBar")
		-- Tabbar görünmese bile dokunma alanı açık kalmamalı.
		-- Aksi halde Geri Dön düğmesinin altındaki sekmeler olayı yakalayabilir.
		ortak.tabBarGizle(tabBar, 0)
		if alani then alani.isVisible = true end
		if baslikAlani then baslikAlani.isVisible = true end
	end
end

function scene:hide(event)
	if event.phase == "will" and alani then
		native.setKeyboardFocus(nil)
		alani.isVisible = false
		if baslikAlani then baslikAlani.isVisible = false end
	end
end

function scene:destroy()
	if alani then
		native.remove(alani)
		alani = nil
	end
	if baslikAlani then
		native.remove(baslikAlani)
		baslikAlani = nil
	end
end

scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)
scene:addEventListener("destroy", scene)

return scene
