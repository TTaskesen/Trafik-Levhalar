--------------------------------------------------------------------------------
-- Tek okuyucu sahnesi: seçilen her hikâyeyi dinamik olarak gösterir.
--------------------------------------------------------------------------------
local composer = require("composer")
local widget = require("widget")
local scene = composer.newScene()

function scene:create(event)
	local grup = self.view
	local hikaye = event.params and event.params.hikaye or {}
	local safeOriginY = display.safeScreenOriginY or display.screenOriginY or 0
	local safeHeight = display.safeActualContentHeight or display.actualContentHeight or display.contentHeight
	local bottomInset = 0
	if display.getSafeAreaInsets then
		local _, _, bottom = display.getSafeAreaInsets()
		bottomInset = math.max(0, bottom or 0)
	end
	local safeBottom = math.min(display.contentHeight,
		safeOriginY + safeHeight - bottomInset)
	local geriY = safeBottom - 30
	local zemin = display.newRect(grup, display.contentCenterX, display.contentCenterY,
		display.contentWidth, display.contentHeight)
	zemin:setFillColor(0.84, 0.91, 0.97)

	local baslik = display.newText({
		parent = grup,
		text = hikaye.baslik or "Hikâye",
		x = display.contentCenterX,
		y = 38,
		width = display.contentWidth - 28,
		font = native.systemFontBold,
		fontSize = 21,
		align = "center"
	})
	baslik:setFillColor(0.05, 0.3, 0.55)

	local scroll = widget.newScrollView({
		top = 62,
		left = 12,
		width = display.contentWidth - 24,
		height = math.max(120, geriY - 21 - 12 - 62),
		horizontalScrollDisabled = true,
		verticalScrollDisabled = false,
		hideScrollBar = false,
		backgroundColor = { 1, 1, 0.82 }
	})
	grup:insert(scroll)

	local metin = display.newText({
		text = hikaye.metin or "",
		x = 14,
		y = 14,
		width = scroll.width - 28,
		font = native.systemFont,
		fontSize = 18,
		align = "left"
	})
	scroll:insert(metin)
	metin.anchorX, metin.anchorY = 0, 0
	metin:setFillColor(0.08, 0.08, 0.08)
	-- Metin dokunmaları ScrollView'un kaydırma hareketini engellemesin.
	metin.isHitTestable = false
	-- Okuma alanında metnin son satırına kadar belirgin bir kaydırma payı bırak.
	-- Böylece kısa metinlerde bile ScrollView sınırı düğmenin altına taşmaz.
	scroll:setScrollHeight(math.max(scroll.height + 1, metin.height + 200))

	local geri = display.newRoundedRect(grup, display.contentCenterX, geriY,
		170, 42, 8)
	geri:setFillColor(0.05, 0.3, 0.55)
	local geriMetin = display.newText(grup, "Kitaplığa Dön", geri.x, geri.y,
		native.systemFontBold, 14)
	geriMetin:setFillColor(1)
	local function don()
		composer.gotoScene("kitaplik", { effect = "slideRight", time = 350 })
		return true
	end
	geri:addEventListener("tap", don)
	geriMetin:addEventListener("tap", don)
end

scene:addEventListener("create", scene)
return scene
