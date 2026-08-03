---------------------------------------------------------------------------------
--
-- sahne1.lua
--
---------------------------------------------------------------------------------
local widget = require("widget")
local sahneDegis = require("composer")
local splash = require("splash")
local sahne = sahneDegis.newScene()

---------------------------------------------------------------------------------
-- BEGINNING OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------

local resim, yazi1, yazi2, yazi3, yazi4, yazi5, yazi6, yazi7, zamanSay

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


-- Called when the scene's view does not exist:
function sahne:create(olay)
	local sceneGroup = self.view

	resim = display.newImage("bg.jpg")
	resim.x = display.contentCenterX
	resim.y = display.contentCenterY
	sceneGroup:insert(resim)

	local yazifont = "Poppins-Bold"
	local baslikfont = "BebasNeue-Regular"

	-- Başlık kartı
	local baslikKarti = display.newRoundedRect(display.contentCenterX, 50, 310, 70, 10)
	baslikKarti:setFillColor(0.05, 0.3, 0.55, 0.85)
	baslikKarti:setStrokeColor(1, 1, 1, 0.35)
	baslikKarti.strokeWidth = 1.5
	sceneGroup:insert(baslikKarti)

	yazi1 = display.newText("KARAYOLLARI STANDART\nİŞARET LEVHALARI", 0, 0, baslikfont, 26)
	yazi1:setFillColor(1)
	yazi1.x, yazi1.y = display.contentCenterX, 50
	sceneGroup:insert(yazi1)

	local menuler = {
		{ metin = "TEHLİKE UYARI",          dokun = yaziyaDokun2 },
		{ metin = "TRAFİK TANZİM",          dokun = yaziyaDokun3 },
		{ metin = "BİLGİ",                  dokun = yaziyaDokun4 },
		{ metin = "DURAKLAMA VE PARK ETME", dokun = yaziyaDokun5 },
		{ metin = "ÖZEL",                   dokun = yaziyaDokun6 },
		{ metin = "OTOYOL LEVHALARI",       dokun = yaziyaDokun7 },
	}

	-- Levha tab bara yakın durur; yazı satırları aradaki alana eşit aralıklarla dağılır
	local kartYukseklik = 30
	local tabBarHeight = sahneDegis.getVariable("tabBarHeight") or 50
	local ustSinir = baslikKarti.y + baslikKarti.contentHeight / 2 -- başlığın alt kenarı
	local altSinir = display.contentHeight - tabBarHeight       -- tab barın üst kenarı
	local kartToplamYukseklik = #menuler * kartYukseklik
	local levhaYukseklik = 41
	local levhaAltBosluk = 5                                  -- levha ile tab bar arasındaki boşluk
	local esitBosluk = (altSinir - levhaAltBosluk - levhaYukseklik - ustSinir - kartToplamYukseklik) / (#menuler + 1)
	local baslangicY = ustSinir + esitBosluk + kartYukseklik / 2 -- ilk kartın merkezi

	for i, menu in ipairs(menuler) do
		local y = baslangicY + (i - 1) * (kartYukseklik + esitBosluk)
		local kart = display.newRoundedRect(display.contentCenterX, y, 300, kartYukseklik, 8)
		kart:setFillColor(0.1, 0.13, 0.17, 0.6)
		kart:setStrokeColor(1, 1, 1, 0.25)
		kart.strokeWidth = 1
		sceneGroup:insert(kart)

		local yazi = display.newText(menu.metin, 0, 0, yazifont, 15)
		yazi:setFillColor(1)
		yazi.x, yazi.y = display.contentCenterX, y
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
		else
			yazi7 = yazi
		end
	end

	-- ÖZEL yazısının altındaki boşluğa her açılışta rastgele bir tehlike/uyarı işareti koy
	math.randomseed(os.time() + os.clock())
	local levhaGenislik = levhaYukseklik * 163 / 146
	local rastgeleLevha = display.newImageRect(sceneGroup, resimLevha, math.random(1, 52), levhaGenislik, levhaYukseklik)
	rastgeleLevha.x = display.contentCenterX
	rastgeleLevha.y = altSinir - levhaAltBosluk - levhaYukseklik / 2
	sceneGroup:insert(rastgeleLevha)



	--print("\n1: create olayı oluştu")
end

function sahne:show(olay)
	local faz = olay.phase

	if "did" == faz then
		--print("1: show olayı, faz did")

		-- Update Lua memory text display
		local hafizaGoster = function()
			--resim:addEventListener( "touch", resim )
			--yazi7.isVisible = true
			yazi2.text = yazi2.text .. " İŞARETLERİ"
			yazi2.x = display.contentWidth * 0.5
			yazi3.text = yazi3.text .. " İŞARETLERİ"
			yazi3.x = display.contentWidth * 0.5
			yazi4.text = yazi4.text .. " İŞARETLERİ"
			yazi4.x = display.contentWidth * 0.5
			yazi5.text = yazi5.text .. " İŞARETLERİ"
			yazi5.x = display.contentWidth * 0.5
			yazi6.text = yazi6.text .. " İŞARETLER"
			yazi6.x = display.contentWidth * 0.5
			yazi7.text = yazi7.text .. " İŞARETLERİ"
			yazi7.x = display.contentWidth * 0.5
		end
		zamanSay = timer.performWithDelay(1000, hafizaGoster, 1)
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
