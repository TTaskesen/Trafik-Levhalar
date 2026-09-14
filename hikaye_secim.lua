--------------------------------------------------------------------------------
-- Bir Hikâye Oku için paketlenmiş hikâye seçimi.
--------------------------------------------------------------------------------
local composer = require("composer")
local ortak = require("levha_ortak")
local dil = require("dil")
local scene = composer.newScene()

local HIKAYELER = {

	{
		id = "sifir_noktasi",
		baslik = function() return dil.metin("hikaye_basligi") end,
		aciklama = "Bilim kurgu hikâyesi"
	},
	{
		id = "kolumun_gucu",
		baslik = function() return dil.metin("hikaye_kolumun_gucu_basligi") end,
		aciklama = function() return dil.metin("hikaye_kolumun_gucu_aciklama") end
	}
}

local function hikayeyiAc(hikayeId)
	return function(event)
		if event.phase == "ended" or event.phase == "tap" then
			composer.setVariable("okunacakHikaye", hikayeId)
			composer.gotoScene("sahne7", "fade", 350)
			return true
		end
		return true
	end
end

local function kartOlustur(grup, hikaye, y)
	local kart = display.newGroup()
	grup:insert(kart)

	local zemin = display.newRoundedRect(kart, display.contentCenterX, y, display.contentWidth - 36, 104, 12)
	zemin:setFillColor(1, 1, 1)
	zemin.strokeWidth = 1
	zemin:setStrokeColor(0.72, 0.79, 0.85)

	local baslik = display.newText({
		parent = kart,
		text = hikaye.baslik(),
		x = 30,
		y = y - 19,
		width = display.contentWidth - 68,
		font = "Poppins-Bold",
		fontSize = 18,
		align = "left"
	})
	baslik.anchorX = 0
	baslik:setFillColor(0.05, 0.30, 0.55)

	local aciklama = display.newText({
		parent = kart,
		text = type(hikaye.aciklama) == "function" and hikaye.aciklama() or hikaye.aciklama,
		x = 30,
		y = y + 20,
		width = display.contentWidth - 68,
		font = "Poppins-Medium",
		fontSize = 12,
		align = "left"
	})
	aciklama.anchorX = 0
	aciklama:setFillColor(0.22, 0.25, 0.30)

	local dokun = hikayeyiAc(hikaye.id)
	zemin:addEventListener("touch", dokun)
	baslik:addEventListener("touch", dokun)
	aciklama:addEventListener("touch", dokun)
end

function scene:create(event)
	local sceneGroup = self.view
	local ust = display.safeScreenOriginY or display.screenOriginY or 0

	local zemin = display.newRect(sceneGroup, display.contentCenterX, display.contentCenterY,
		display.contentWidth, display.contentHeight)
	zemin:setFillColor(0.84, 0.91, 0.97)

	local baslik = display.newText({
		parent = sceneGroup,
		text = dil.metin("hikaye_oku"),
		x = display.contentCenterX,
		y = ust + 36,
		font = "Poppins-Bold",
		fontSize = 20
	})
	baslik:setFillColor(0.05, 0.30, 0.55)

	local bilgi = display.newText({
		parent = sceneGroup,
		text = dil.metin("hikaye_secim_bilgisi"),
		x = display.contentCenterX,
		y = ust + 67,
		width = display.contentWidth - 48,
		font = "Poppins-Medium",
		fontSize = 13,
		align = "center"
	})
	bilgi:setFillColor(0.22, 0.25, 0.30)

	kartOlustur(sceneGroup, HIKAYELER[1], ust + 144)
	kartOlustur(sceneGroup, HIKAYELER[2], ust + 268)

	ortak.listeGeriDonButonu(sceneGroup, function()
		composer.gotoScene("giris", "fade", 350)
	end)
end

function scene:show(event)
	if event.phase == "did" then
		ortak.tabBarGizle(composer.getVariable("tabBar"), 0)
	end
end

function scene:hide(event)
	if event.phase == "did" then
		composer.removeScene("hikaye_secim")
	end
end

scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)

return scene
