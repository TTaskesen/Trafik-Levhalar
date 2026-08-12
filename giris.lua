---------------------------------------------------------------------------------
--
-- giris.lua
-- Karayolları Standart İşaret Levhaları sayfasına girmeden önceki karşılama ekranı
--
---------------------------------------------------------------------------------
local widget = require("widget")
local sahneDegis = require("composer")
local ortak = require("levha_ortak")
local sahne = sahneDegis.newScene()

local tabBar

function sahne:create(olay)
	local sceneGroup = self.view
	local ekranBilgileri = ortak.ekranBilgileri()
	local ustSinir = display.safeScreenOriginY or display.screenOriginY or 0
	local blokUstu = ustSinir + 12
	local baslikY = blokUstu + 45
	local levhaY = blokUstu + 175
	local butonY = blokUstu + 330
	local hikayeY = math.min(blokUstu + 455, ekranBilgileri.safeBottom - 30)

	-- Arka plan: buz mavisi tonu (uygulamanın mavi temasıyla uyumlu karşılama ekranı)
	local zemin = display.newRect(display.contentCenterX, display.contentCenterY,
		display.contentWidth, display.contentHeight)
	zemin:setFillColor(0.84, 0.91, 0.97)
	sceneGroup:insert(zemin)

	-- Başlık kartı (diğer sayfalarla aynı stil: mavi kart + beyaz Bebas yazı)
	local baslikKarti = display.newRoundedRect(display.contentCenterX, baslikY, 310, 74, 10)
	baslikKarti:setFillColor(0.05, 0.3, 0.55, 0.85)
	baslikKarti:setStrokeColor(1, 1, 1, 0.35)
	baslikKarti.strokeWidth = 1.5
	sceneGroup:insert(baslikKarti)

	local baslik = display.newText("KARAYOLLARI STANDART\nİŞARET LEVHALARI", 0, 0, "BebasNeue-Regular", 26)
	baslik:setFillColor(1)
	baslik.x = display.contentCenterX
	baslik.y = baslikY
	sceneGroup:insert(baslik)

	local altBaslik = display.newText("Trafik İşaretleri Eğitim Uygulaması", 0, 0, "Poppins-Medium", 13)
	altBaslik:setFillColor(0.45)
	altBaslik.x = display.contentCenterX
	altBaslik.y = baslikY + 48
	sceneGroup:insert(altBaslik)

	-- Uyarı üçgeni (tehlike işareti)
	local ucgen = display.newPolygon(display.contentCenterX - 75, levhaY, {
		0, -50,
		-45, 40,
		45, 40
	})
	ucgen:setFillColor(0.92)
	ucgen:setStrokeColor(0.75, 0, 0)
	ucgen.strokeWidth = 7
	sceneGroup:insert(ucgen)

	local isaret = display.newText("!", 0, 0, "Poppins-Bold", 40)
	isaret:setFillColor(0.75, 0, 0)
	isaret.x, isaret.y = ucgen.x, ucgen.y + 12
	sceneGroup:insert(isaret)

	-- DUR işareti (sekizgen)
	local kose = {}
	for i = 1, 8 do
		local aci = (i - 1) * 45 * (math.pi / 180)
		kose[#kose + 1] = 50 * math.cos(aci)
		kose[#kose + 1] = 50 * math.sin(aci)
	end
	local dur = display.newPolygon(display.contentCenterX + 75, levhaY, kose)
	dur:setFillColor(0.8, 0, 0)
	dur:setStrokeColor(1)
	dur.strokeWidth = 6
	sceneGroup:insert(dur)

	local durMetin = display.newText("DUR", 0, 0, "Poppins-Bold", 26)
	durMetin:setFillColor(1)
	durMetin.x, durMetin.y = dur.x, dur.y
	sceneGroup:insert(durMetin)

	local baslaButonu = display.newRoundedRect(display.contentCenterX, butonY, 210, 48, 8)
	baslaButonu:setFillColor(0.05, 0.3, 0.55, 0.85)
	baslaButonu:setStrokeColor(1, 1, 1, 0.35)
	baslaButonu.strokeWidth = 1.5
	sceneGroup:insert(baslaButonu)

	local baslaMetin = display.newText("BAŞLA", 0, 0, "Poppins-Bold", 18)
	baslaMetin:setFillColor(1)
	baslaMetin.x, baslaMetin.y = baslaButonu.x, baslaButonu.y
	sceneGroup:insert(baslaMetin)

	local function basla()
		if tabBar then
			tabBar.isVisible = true
		end
		sahneDegis.gotoScene("sahne1", "fade", 500)
	end

	local function baslaDokun(olay)
		local nesne = olay.target
		if olay.phase == "began" then
			display.getCurrentStage():setFocus(nesne)
			nesne.isFocus = true
			transition.to(nesne, { xScale = 0.93, yScale = 0.93, time = 90 })
		elseif nesne.isFocus and (olay.phase == "ended" or olay.phase == "cancelled") then
			display.getCurrentStage():setFocus(nil)
			nesne.isFocus = false
			transition.to(nesne, { xScale = 1, yScale = 1, time = 140, transition = easing.outBack })
			if olay.phase == "ended" then
				basla()
			end
		end
		return true
	end

	baslaButonu:addEventListener("touch", baslaDokun)
	baslaMetin:addEventListener("touch", baslaDokun)

	-- Hikâye kısayolu: sahne7'ye gider
	local hikayeYazi = display.newText({
		text = "BİR HİKAYE OKU",
		x = 0, y = 0,
		font = "Poppins-Bold",
		fontSize = 14
	})
	hikayeYazi:setFillColor(0.05, 0.3, 0.55)
	hikayeYazi.x = display.contentCenterX
	hikayeYazi.y = hikayeY
	sceneGroup:insert(hikayeYazi)

	local function hikayeDokun(olay)
		if olay.phase == "began" then
			if tabBar then
				tabBar.isVisible = true
			end
			sahneDegis.gotoScene("sahne7", "fade", 400)
			return true
		end
	end
	hikayeYazi:addEventListener("touch", hikayeDokun)

	local function nabiz()
		if dur then
			transition.to(dur, { xScale = 1.05, yScale = 1.05, time = 500, transition = easing.inOutSine,
				onComplete = function()
					transition.to(dur, { xScale = 1, yScale = 1, time = 500, transition = easing.inOutSine,
						onComplete = nabiz })
				end })
		end
	end
	nabiz()
end

function sahne:show(olay)
	if "did" == olay.phase then
		tabBar = sahneDegis.getVariable("tabBar")
		if tabBar then
			tabBar.isVisible = false
		end
	end
end

function sahne:hide(olay)
	if "will" == olay.phase then
		if tabBar then
			tabBar.isVisible = true
		end
	end
end

function sahne:destroy(olay)
end

sahne:addEventListener("create", sahne)
sahne:addEventListener("show", sahne)
sahne:addEventListener("hide", sahne)
sahne:addEventListener("destroy", sahne)

return sahne
