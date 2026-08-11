---------------------------------------------------------------------------------
--
-- sahne1.lua
--
---------------------------------------------------------------------------------
local widget = require("widget")
local sahneDegis = require("composer")
local splash = require("splash")
local ortak = require("levha_ortak")
local sahne = sahneDegis.newScene()

---------------------------------------------------------------------------------
-- BEGINNING OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------

local resim, yazi1, yazi2, yazi3, yazi4, yazi5, yazi6, yazi7, yazi8, zamanSay
local menuler

-- Tehlike/uyarı işareti resim kutusu (700x1950, 4 sütun x 13 satır = 52 kare)
local levhaKareleri = {
	sheetContentWidth = 700,
	sheetContentHeight = 1950,
	frames = {}
}
local xKonumlari = { 5, 180, 360, 530 }
local kareNo = 0
for satir = 0, 12 do
	for sutun = 1, 4 do
		kareNo = kareNo + 1
		levhaKareleri.frames[kareNo] = {
			x = xKonumlari[sutun],
			y = 3 + satir * 150,
			width = 163,
			height = 146
		}
	end
end
local resimLevha = graphics.newImageSheet("levha/levha/1-tehlike/tehlike.png", levhaKareleri)

-- Touch event listener for background image
local function yaziyaDokun2(olay, yazi)
	if olay.phase == "began" and yazi2 then
		splash.goster("sahne2", "slideLeft")
		return true
	end
end
local function yaziyaDokun3(olay, yazi)
	if olay.phase == "began" and yazi3 then
		splash.goster("sahne3", "slideRight")
		return true
	end
end

local function yaziyaDokun4(olay, yazi)
	if olay.phase == "began" and yazi4 then
		splash.goster("sahne4", "fade")
		return true
	end
end

local function yaziyaDokun5(olay, yazi)
	if olay.phase == "began" and yazi5 then
		splash.goster("sahne5", "crossFade")
		return true
	end
end

local function yaziyaDokun6(olay, yazi)
	if olay.phase == "began" and yazi6 then
		splash.goster("sahne6", "fade")
		return true
	end
end

local function yaziyaDokun7(olay, yazi)
	if olay.phase == "began" and yazi7 then
		splash.goster("sahne11", "slideLeft")
		return true
	end
end

local function yaziyaDokun8(olay, yazi)
	if olay.phase == "began" and yazi8 then
		splash.goster("sahne12", "slideRight")
		return true
	end
end

-- Kart/yazı basılı tutma görsel efekti
local function basiliEfekt(olay)
	local nesne = olay.target
	if olay.phase == "began" then
		transition.to(nesne, { xScale = 0.93, yScale = 0.93, time = 90 })
	elseif olay.phase == "ended" or olay.phase == "cancelled" then
		transition.to(nesne, { xScale = 1, yScale = 1, time = 140, transition = easing.outBack })
	end
	return false
end


-- Called when the scene's view does not exist:
function sahne:create(olay)
	local sceneGroup = self.view
	local ekranBilgileri = ortak.ekranBilgileri()
	local ustEkranSiniri = display.safeScreenOriginY or display.screenOriginY or 0

	-- Arka plan: ana uygulama arka planı açık renkli düz zemindir (bg.jpg kullanılmaz)

	local yazifont = "Poppins-Bold"
	local baslikfont = "BebasNeue-Regular"

	-- Başlık kartı
	local baslikY = ustEkranSiniri + 50
	local baslikKarti = display.newRoundedRect(display.contentCenterX, baslikY, 310, 70, 10)
	baslikKarti:setFillColor(0.05, 0.3, 0.55, 0.85)
	baslikKarti:setStrokeColor(1, 1, 1, 0.35)
	baslikKarti.strokeWidth = 1.5
	sceneGroup:insert(baslikKarti)

	yazi1 = display.newText("KARAYOLLARI STANDART\nİŞARET LEVHALARI", 0, 0, baslikfont, 26)
	yazi1:setFillColor(1)
	yazi1.x, yazi1.y = display.contentCenterX, baslikY
	sceneGroup:insert(yazi1)

	menuler = {
		{ metin = "TEHLİKE UYARI İŞARETLERİ",          dokun = yaziyaDokun2 },
		{ metin = "TRAFİK TANZİM İŞARETLERİ",          dokun = yaziyaDokun3 },
		{ metin = "BİLGİ İŞARETLERİ",                  dokun = yaziyaDokun4 },
		{ metin = "DURAKLAMA VE PARK ETME İŞARETLERİ", dokun = yaziyaDokun5 },
		{ metin = "ÖZEL İŞARETLER",                    dokun = yaziyaDokun6 },
		{ metin = "YENİ STANDART LEVHALAR",            dokun = yaziyaDokun7 },
		{ metin = "OTOYOL LEVHALARI",                  dokun = yaziyaDokun8 },
	}

	-- Düzen: kartlar başlık ile tab bar arasına sığmalı; son kart ile tab bar arasındaki
	-- boşluğa rastgele levha konur. Metinler alana sığmazsa yazı boyutu kademeli küçülür.
	local tabBarHeight = sahneDegis.getVariable("tabBarHeight") or 50
	local ustSinir = baslikKarti.y + baslikKarti.contentHeight / 2 -- başlığın alt kenarı
	local altSinir = ekranBilgileri.safeBottom - tabBarHeight       -- tab barın üst kenarı
	local kartGenislik = 300
	local yaziGenislik = kartGenislik - 16
	local ustBosluk = 10
	local minKartAralik = 8

	-- Yazıları oluştur ve yüksekliklerini ölç (genişlik sınırı taşmayı önler)
	for i, menu in ipairs(menuler) do
		local yazi = display.newText({
			text = menu.metin,
			x = 0,
			y = 0,
			font = yazifont,
			fontSize = 16,
			width = yaziGenislik,
			align = "center"
		})
		yazi:setFillColor(1)
		menu.yazi = yazi
	end

	-- Son kart ile tab bar arasında üç rastgele levha için ayrılan pay
	local levhaPayi = 82
	local function toplamKartYuksekliginiHesapla()
		local toplam = 0
		for i, menu in ipairs(menuler) do
		menu.kartYukseklik = menu.yazi.contentHeight + 12
			toplam = toplam + menu.kartYukseklik
		end
		return toplam
	end
	local toplamKartYukseklik = toplamKartYuksekliginiHesapla()

	-- Kartlar ayrılan alana sığana kadar yazı boyutunu küçült (16 -> 15 -> 14)
	local yaziBoyutu = 16
	local kartAralik = (altSinir - levhaPayi - ustSinir - ustBosluk - toplamKartYukseklik) / (#menuler - 1)
	while kartAralik < minKartAralik and yaziBoyutu > 14 do
		yaziBoyutu = yaziBoyutu - 1
		for i, menu in ipairs(menuler) do
			menu.yazi.size = yaziBoyutu
		end
		toplamKartYukseklik = toplamKartYuksekliginiHesapla()
		kartAralik = (altSinir - levhaPayi - ustSinir - ustBosluk - toplamKartYukseklik) / (#menuler - 1)
	end
	if kartAralik < minKartAralik then
		-- Hâlâ sığmıyorsa levha payını daralt; levha küçülerek yer açar
		levhaPayi = 44
		kartAralik = (altSinir - levhaPayi - ustSinir - ustBosluk - toplamKartYukseklik) / (#menuler - 1)
		if kartAralik < minKartAralik then
			kartAralik = minKartAralik
			levhaPayi = altSinir - ustSinir - ustBosluk - toplamKartYukseklik - kartAralik * (#menuler - 1)
			if levhaPayi < 10 then levhaPayi = 10 end
		end
	end

	-- Kartları başlıktan aşağıya doğru diz; kalan boşluk kart aralarına eşit dağıtılır
	local y = ustSinir + ustBosluk
	local kartMerkezleri = {}
	for i = 1, #menuler do
		kartMerkezleri[i] = y + menuler[i].kartYukseklik / 2
		y = y + menuler[i].kartYukseklik + kartAralik
	end
	-- Son kartın alt kenarı (levha buradan tab bara kadar olan boşluğa yerleşir)
	local sonKartAlt = y - kartAralik

	for i, menu in ipairs(menuler) do
		local y = kartMerkezleri[i]
		local kart = display.newRoundedRect(display.contentCenterX, y, kartGenislik, menu.kartYukseklik, 8)
		kart:setFillColor(0.05, 0.3, 0.55, 0.85)
		kart:setStrokeColor(1, 1, 1, 0.35)
		kart.strokeWidth = 1.5
		sceneGroup:insert(kart)
		menu.kart = kart
		kart:addEventListener("touch", basiliEfekt)
		kart:addEventListener("touch", menu.dokun)

		local yazi = menu.yazi
		yazi.x, yazi.y = display.contentCenterX, y
		yazi:addEventListener("touch", basiliEfekt)
		yazi:addEventListener("touch", menu.dokun)
		sceneGroup:insert(yazi)

		if i == 1 then
			yazi2 = yazi
		elseif i == 2 then
			yazi3 = yazi
		elseif i == 3 then
			yazi4 = yazi
		elseif i == 4 then
			yazi5 = yazi
		elseif i == 5 then
			yazi6 = yazi
		elseif i == 6 then
			yazi7 = yazi
		else
			yazi8 = yazi
		end
	end

	-- Son kart ile tab bar arasındaki boşluğa her açılışta üç rastgele tehlike/uyarı
	-- işareti koy. Aynı yükseklikte ve yan yana gösterilirler.
	local levhaYukseklik = math.min(math.max(altSinir - sonKartAlt - 4, 58), 105)
	math.randomseed(os.time() + os.clock())
	local levhaGenislik = levhaYukseklik * 163 / 146
	local levhaAraligi = 6
	local rastgeleLevhalar = display.newGroup()
	sceneGroup:insert(rastgeleLevhalar)

	-- Herhangi bir levhaya dokununca karşılama ekranına (giris) dön
	local function girseDon()
		sahneDegis.gotoScene("giris", "fade", 400)
	end

	for i = 1, 3 do
		local rastgeleLevha = display.newImageRect(
			rastgeleLevhalar,
			resimLevha,
			math.random(1, 52),
			levhaGenislik,
			levhaYukseklik
		)
		rastgeleLevha.x = (i - 2) * (levhaGenislik + levhaAraligi)
		rastgeleLevha.y = 0
		rastgeleLevha:addEventListener("tap", girseDon)
	end
	rastgeleLevhalar.x = display.contentCenterX
	rastgeleLevhalar.y = altSinir - levhaYukseklik / 2



	--print("\n1: create olayı oluştu")
end

function sahne:show(olay)
	local faz = olay.phase

	if "did" == faz then
		--print("1: show olayı, faz did")
		local tabBar = sahneDegis.getVariable("tabBar")
		if tabBar then
			ortak.tabBarGoster(tabBar)
		end

		-- Giriş efektleri: başlık ve menü kartları/yazıları kademeli belirir
		yazi1.alpha = 0
		transition.to(yazi1, { alpha = 1, time = 450, transition = easing.outQuad })
		for i, menu in ipairs(menuler) do
			menu.kart.alpha = 0
			menu.kart.xScale, menu.kart.yScale = 0.85, 0.85
			menu.yazi.alpha = 0
			menu.yazi.xScale, menu.yazi.yScale = 0.75, 0.75
		end
		for i, menu in ipairs(menuler) do
			local gecikme = 180 + (i - 1) * 110
			transition.to(menu.kart, {
				alpha = 1,
				xScale = 1,
				yScale = 1,
				time = 360,
				delay = gecikme,
				transition = easing.outQuad
			})
			transition.to(menu.yazi, {
				alpha = 1,
				xScale = 1,
				yScale = 1,
				time = 420,
				delay = gecikme + 40,
				transition = easing.outQuad
			})
		end
	end
end

function sahne:hide(olay)
	local faz = olay.phase

	if "will" == faz then
		print("1: hide olayı, faz will")

		-- zamanlayıcıyı iptal et
		if zamanSay then
			timer.cancel(zamanSay)
			zamanSay = nil
		end
	elseif "did" == faz then
		sahneDegis.removeScene("sahne1")
	end
end

function sahne:destroy(olay)
	print("((sahne 1 in yok edilmesi))")
end

---------------------------------------------------------------------------------

-- Listener setup
sahne:addEventListener("create", sahne)
sahne:addEventListener("show", sahne)
sahne:addEventListener("hide", sahne)
sahne:addEventListener("destroy", sahne)

---------------------------------------------------------------------------------

return sahne
