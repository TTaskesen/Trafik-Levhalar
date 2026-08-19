--------------------------------------------------------------------------------
-- E-book kitaplığı: hikâyeleri JSON'dan okur ve başlık kartları olarak listeler.
--------------------------------------------------------------------------------
local composer = require("composer")
local widget = require("widget")
local json = require("json")
local scene = composer.newScene()

local function hikayeleriOku()
	local yol = system.pathForFile("hikayeler.json", system.ResourceDirectory)
	local dosya = io.open(yol, "r")
	if not dosya then return {} end
	local icerik = dosya:read("*a")
	dosya:close()
	local basarili, sonuc = pcall(json.decode, icerik)
	return basarili and type(sonuc) == "table" and sonuc or {}
end

function scene:create()
	local grup = self.view
	local zemin = display.newRect(grup, display.contentCenterX, display.contentCenterY,
		display.contentWidth, display.contentHeight)
	zemin:setFillColor(0.84, 0.91, 0.97)

	local baslik = display.newText(grup, "HİKÂYE KİTAPLIĞI", display.contentCenterX, 42,
		native.systemFontBold, 22)
	baslik:setFillColor(0.05, 0.3, 0.55)

	local scroll = widget.newScrollView({
		top = 62,
		left = 12,
		width = display.contentWidth - 24,
		height = display.contentHeight - 92,
		horizontalScrollDisabled = true,
		backgroundColor = { 0.98, 0.94, 0.68 }
	})
	grup:insert(scroll)

	local hikayeler = hikayeleriOku()
	local gorulen = {}
	-- ScrollView içeriğinin koordinat başlangıcı merkezdir; üst kenarı açıkça hesapla.
	local y = -(scroll.height * 0.5) + 14
	local kartYuksekligi = 54
	local kartAraligi = 12
	local function hikayeAnahtari(hikaye)
		return tostring(hikaye.metin or ""):gsub("%s+", " "):match("^%s*(.-)%s*$")
	end

	local function kartEkle(hikaye)
		local anahtar = hikayeAnahtari(hikaye)
		if gorulen[anahtar] then return end
		gorulen[anahtar] = true
		local kart = display.newRoundedRect(scroll, 0, y + kartYuksekligi * 0.5,
			scroll.width - 20, kartYuksekligi, 10)
		kart:setFillColor(1, 1, 0.82)
		kart:setStrokeColor(0.05, 0.3, 0.55, 0.55)
		kart.strokeWidth = 1.5

		local metin = display.newText({
			parent = scroll,
			text = hikaye.baslik or "Başlıksız hikâye",
			x = -(scroll.width * 0.5) + 18,
			y = y + kartYuksekligi * 0.5,
			width = scroll.width - 36,
			font = native.systemFontBold,
			fontSize = 17,
			align = "left"
		})
		metin.anchorX = 0
		metin:setFillColor(0.05, 0.3, 0.55)

		local function ac()
			composer.gotoScene("okuyucu", {
				time = 350,
				effect = "slideLeft",
				params = { hikaye = hikaye }
			})
			return true
		end
		kart:addEventListener("tap", ac)
		metin:addEventListener("tap", ac)
		y = y + kartYuksekligi + kartAraligi
	end

	for _, hikaye in ipairs(hikayeler) do
		kartEkle(hikaye)
	end

	scroll:setScrollHeight(math.max(scroll.height, y + 12))
end

scene:addEventListener("create", scene)
return scene
