---------------------------------------------------------------------------------
--
-- giris.lua
-- Karayolları Standart İşaret Levhaları sayfasına girmeden önceki karşılama ekranı
--
---------------------------------------------------------------------------------
local widget = require("widget")
local sahneDegis = require("composer")
local sahne = sahneDegis.newScene()

local tabBar

function sahne:create(olay)
	local sceneGroup = self.view

	local resim = display.newImage("bg.jpg")
	resim.x = display.contentCenterX
	resim.y = display.contentCenterY
	sceneGroup:insert(resim)

	local baslik = display.newText("Karayolları Standart İşaret Levhaları", 0, 0, "Poppins-Bold", 15)
	baslik:setFillColor(1)
	baslik.x = display.contentCenterX
	baslik.y = 90
	sceneGroup:insert(baslik)

	local altBaslik = display.newText("Trafik İşaretleri Eğitim Uygulaması", 0, 0, "Poppins-Medium", 13)
	altBaslik:setFillColor(0.85)
	altBaslik.x = display.contentCenterX
	altBaslik.y = 120
	sceneGroup:insert(altBaslik)

	-- Uyarı üçgeni (tehlike işareti)
	local ucgen = display.newPolygon(display.contentCenterX - 75, 210, {
		0, -50,
		-45, 40,
		45, 40
	})
	ucgen:setFillColor(1)
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
	local dur = display.newPolygon(display.contentCenterX + 75, 210, kose)
	dur:setFillColor(0.8, 0, 0)
	dur:setStrokeColor(1)
	dur.strokeWidth = 6
	sceneGroup:insert(dur)

	local durMetin = display.newText("DUR", 0, 0, "Poppins-Bold", 26)
	durMetin:setFillColor(1)
	durMetin.x, durMetin.y = dur.x, dur.y
	sceneGroup:insert(durMetin)

	local baslaButonu = widget.newButton {
		width = 200,
		height = 48,
		label = "BAŞLA",
		fontSize = 18,
		labelColor = { default = { 1 }, over = { 1 } },
		onRelease = function()
			if tabBar then
				tabBar.isVisible = true
			end
			sahneDegis.gotoScene("sahne1", "fade", 500)
		end
	}
	baslaButonu.x = display.contentCenterX
	baslaButonu.y = 350
	sceneGroup:insert(baslaButonu)

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
