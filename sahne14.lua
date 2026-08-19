--------------------------------------------------------------------------------
-- Uygulama içindeki kullanıcı hikâyeleri için e-kitap okuyucu.
--------------------------------------------------------------------------------
local composer = require("composer")
local widget = require("widget")
local dil = require("dil")
local ortak = require("levha_ortak")
local kayit = require("hikaye_kayit")
local hikayeCache = require("hikaye_cache")
local supabase = require("supabase_hikayeler")
local scene = composer.newScene()

function scene:create()
	local grup = self.view
	local ust = display.safeScreenOriginY or display.screenOriginY or 0
	local ekran = ortak.ekranBilgileri()
	local zemin = display.newRect(grup, display.contentCenterX, display.contentCenterY,
		display.contentWidth, display.contentHeight)
	 zemin:setFillColor(0.84, 0.91, 0.97)

	local baslik = display.newText(grup, dil.metin("hikayelerim_baslik"), display.contentCenterX, ust + 32,
		"Poppins-Bold", 21)
	baslik:setFillColor(0.05, 0.3, 0.55)

	local hikayeler = kayit.tumu()
	local gorunenHikayeler = {}
	local function hikayeAnahtari(icerik)
		-- Yerel kayıt ile Supabase kaydındaki satır sonu ve boşluk farklarını yok say.
		return tostring(icerik or ""):gsub("%s+", " "):match("^%s*(.-)%s*$")
	end
	local function tarihGoster(tarih)
		-- Supabase UTC tarihini Türkiye saatine çevirip kısa göster.
		local yil, ay, gun, saat, dakika, saniye = tostring(tarih or ""):
			match("^(%d%d%d%d)%-(%d%d)%-(%d%d)[T ](%d%d):(%d%d):(%d%d)")
		if yil then
			local zaman = os.time({
				year = tonumber(yil), month = tonumber(ay), day = tonumber(gun),
				hour = tonumber(saat), min = tonumber(dakika), sec = tonumber(saniye),
				isdst = false
			})
			-- Proje Türkiye için olduğundan UTC+00 değerine 3 saat eklenir.
			return os.date("%Y-%m-%d %H:%M", zaman + 3 * 60 * 60)
		end
		local yerelGun, yerelSaat = tostring(tarih or ""):match("^(%d%d%d%d%-%d%d%-%d%d)[T ](%d%d:%d%d)")
		return yerelGun and (yerelGun .. " " .. yerelSaat) or tostring(tarih or "")
	end

	local scroll = widget.newScrollView({
		top = ust + 72,
		left = 12,
		width = display.contentWidth - 24,
		height = ekran.safeBottom - (ust + 72) - 72,
		horizontalScrollDisabled = true,
		backgroundColor = { 0.98, 0.94, 0.68 }
	})
	grup:insert(scroll)

	local kartlar = {}
	local bosYazi
	local function kartlariYerlestir()
		local y = 12
		for _, kart in ipairs(kartlar) do
			local yukseklik = kart.baslikYuksekligi + 18
			if kart.acik then
				yukseklik = yukseklik + kart.metin.height + 18
				kart.metin.isVisible = true
			else
				kart.metin.isVisible = false
			end
			kart.zemin.height = yukseklik
			kart.zemin.y = yukseklik * 0.5
			kart.grup.y = y
			kart.metin.y = kart.baslikYuksekligi + 10
			y = y + yukseklik + 10
		end
		scroll:setScrollHeight(math.max(scroll.height, y + 12))
	end

	local function kartEkle(baslik, metin, tarih)
		if bosYazi then
			bosYazi:removeSelf()
			bosYazi = nil
		end

		local kartGrubu = display.newGroup()
		scroll:insert(kartGrubu)
		local baslikMetni = tostring(baslik or dil.metin("hikaye_yok"))
		if tarih and tostring(tarih) ~= "" then
			baslikMetni = baslikMetni .. "\n" .. tarihGoster(tarih)
		end
		local kartBasligi = display.newText({
			parent = kartGrubu,
			text = baslikMetni,
			x = 14,
			y = 10,
			width = scroll.width - 28,
			font = "Poppins-Bold",
			fontSize = 16,
			align = "left"
		})
		kartBasligi.anchorX, kartBasligi.anchorY = 0, 0
		kartBasligi:setFillColor(0.05, 0.3, 0.55)

		local kartMetni = display.newText({
			parent = kartGrubu,
			text = tostring(metin or ""),
			x = 14,
			y = 0,
			width = scroll.width - 28,
			font = "Poppins-Medium",
			fontSize = 15,
			align = "left"
		})
		kartMetni.anchorX, kartMetni.anchorY = 0, 0
		kartMetni:setFillColor(0.08, 0.08, 0.08)

		local kart = {
			grup = kartGrubu,
			metin = kartMetni,
			baslikYuksekligi = math.max(30, kartBasligi.height),
			acik = false
		}
		kart.zemin = display.newRoundedRect(kartGrubu, scroll.width * 0.5, 0,
			scroll.width - 16, 1, 8)
		kart.zemin:toBack()
		kart.zemin:setFillColor(1, 1, 0.82)
		kart.zemin:setStrokeColor(0.05, 0.3, 0.55, 0.55)
		kart.zemin.strokeWidth = 1.5

		local function kartDokun()
			kart.acik = not kart.acik
			kartlariYerlestir()
			return true
		end
		-- Metin ve zemin ayrı nesneler olduğu için dokunmayı ikisine de bağla.
		kart.zemin:addEventListener("tap", kartDokun)
		kartBasligi:addEventListener("tap", kartDokun)
		kartMetni:addEventListener("tap", kartDokun)
		kartlar[#kartlar + 1] = kart
		kartlariYerlestir()
	end

	if #hikayeler == 0 then
		bosYazi = display.newText({
			parent = scroll,
			text = dil.metin("hikaye_yok"),
			x = scroll.width * 0.5,
			y = 24,
			width = scroll.width - 28,
			font = "Poppins-Medium",
			fontSize = 16,
			align = "center"
		})
		bosYazi:setFillColor(0.08, 0.08, 0.08)
	else
		for _, hikaye in ipairs(hikayeler) do
			local anahtar = hikayeAnahtari(hikaye.metin)
			if not gorunenHikayeler[anahtar] then
				gorunenHikayeler[anahtar] = true
				kartEkle(hikaye.baslik, hikaye.metin, hikaye.tarih)
			end
		end
	end

	-- İnternet yoksa son başarılı Supabase listesini cihazdan göster.
	for _, hikaye in ipairs(hikayeCache.oku()) do
		local anahtar = hikayeAnahtari(hikaye.metin)
		if not gorunenHikayeler[anahtar] then
			gorunenHikayeler[anahtar] = true
			kartEkle(hikaye.baslik, hikaye.metin, hikaye.olusturma_tarihi)
		end
	end

	-- Supabase ayarlıysa yönetici tarafından yayınlanan hikâyeleri de ekle.
	-- Ayarlar boşsa ekran yalnızca cihazdaki yerel kayıtları gösterir.
	if supabase.aktif() then
			supabase.yayinlananlariGetir(function(basarili, sonuc)
			if not basarili or type(sonuc) ~= "table" then return end
			hikayeCache.kaydet(sonuc)
			if not scene.view then return end
			for _, hikaye in ipairs(sonuc) do
				local anahtar = hikayeAnahtari(hikaye.metin)
				if not gorunenHikayeler[anahtar] then
					gorunenHikayeler[anahtar] = true
					kartEkle(hikaye.baslik, hikaye.metin, hikaye.olusturma_tarihi)
				end
			end
		end)
	end

	local geri = display.newRoundedRect(grup, display.contentCenterX, ekran.safeBottom - 30, 190, 48, 8)
	geri:setFillColor(0.05, 0.3, 0.55, 0.9)
	geri:setStrokeColor(1, 1, 1, 0.35)
	geri.strokeWidth = 1.5
	local geriMetin = display.newText(grup, dil.metin("geri_don"), geri.x, geri.y, "Poppins-Bold", 16)
	geriMetin:setFillColor(1)
	local function geriDokun()
		composer.gotoScene("sahne13", "slideRight", 400)
		return true
	end
	geri:addEventListener("tap", geriDokun)
	geriMetin:addEventListener("tap", geriDokun)
end

function scene:show(event)
	if event.phase == "did" then
		local tabBar = composer.getVariable("tabBar")
		ortak.tabBarGizle(tabBar, 0)
	end
end

scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
return scene
