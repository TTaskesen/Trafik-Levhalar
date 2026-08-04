---------------------------------------------------------------------------------
--
-- splash.lua
-- Ana menüden sayfalara geçişte gösterilen hareketli yükleme ekranı
--
---------------------------------------------------------------------------------
local sahneDegis = require("composer")

local splash = {}

function splash.goster(hedefSahne, gecisTuru)
	local grup = display.newGroup()

	-- Karartma tüm fiziksel ekranı kapsar; böylece tab bar da splash sırasında dokunulamaz
	local ox, oy = math.abs(display.screenOriginX), math.abs(display.screenOriginY)
	local karart = display.newRect(display.contentCenterX, display.contentCenterY,
		display.contentWidth + ox + ox, display.contentHeight + oy + oy)
	karart:setFillColor(0, 0, 0, 0.55)
	grup:insert(karart)

	local kutu = display.newRoundedRect(display.contentCenterX, display.contentCenterY, 280, 190, 18)
	kutu:setFillColor(1)
	grup:insert(kutu)

	local baslik = display.newText("Trafik Levhaları", 0, 0, native.systemFontBold, 16)
	baslik:setFillColor(0.15)
	baslik.x, baslik.y = display.contentCenterX, kutu.y - 60
	grup:insert(baslik)

	local lambaX = display.contentCenterX
	local lambaY = kutu.y - 8
	local renkler = { { 1, 0.25, 0.25 }, { 1, 0.8, 0.1 }, { 0.2, 0.9, 0.2 } }
	local isiklar = {}
	for i = 1, 3 do
		local isik = display.newCircle(lambaX, lambaY - 22 + (i - 1) * 22, 10)
		isik:setFillColor(0.85)
		grup:insert(isik)
		isiklar[i] = isik
	end

	local metin = display.newText("Yükleniyor", 0, 0, native.systemFont, 15)
	metin:setFillColor(0.35)
	metin.x, metin.y = display.contentCenterX, lambaY + 62
	grup:insert(metin)

	local adim = 1
	local noktaSayisi = 0

	local function lambaCevir()
		for i = 1, 3 do
			if i == adim then
				isiklar[i]:setFillColor(unpack(renkler[i]))
			else
				isiklar[i]:setFillColor(0.85)
			end
		end
		adim = adim % 3 + 1
	end

	local function noktaCevir()
		noktaSayisi = noktaSayisi % 3 + 1
		metin.text = "Yükleniyor" .. string.rep(".", noktaSayisi)
	end

	local lambaZaman = timer.performWithDelay(350, lambaCevir, 0)
	local noktaZaman = timer.performWithDelay(400, noktaCevir, 0)

	local gecisZaman = timer.performWithDelay(1300, function()
		timer.cancel(lambaZaman)
		timer.cancel(noktaZaman)
		-- Splash sırasında kullanıcı başka sayfaya geçtiyse hedefe zorla gitme
		if sahneDegis.getSceneName("current") == "sahne1" then
			sahneDegis.gotoScene(hedefSahne, gecisTuru, 700)
		end
		transition.fadeOut(grup, { time = 600, onComplete = function()
			grup:removeSelf()
			grup = nil
		end })
	end, 1)
end

return splash
