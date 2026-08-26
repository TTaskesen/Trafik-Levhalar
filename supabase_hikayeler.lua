--------------------------------------------------------------------------------
-- Supabase REST bağlantısı. Ayarlar boşsa uygulama yerel kayıtla çalışır.
--------------------------------------------------------------------------------
local json = require("json")
local config = {}
local yuklendi, yerelConfig = pcall(require, "supabase_config")
if yuklendi and type(yerelConfig) == "table" then
    config = yerelConfig
end

local supabase = {}

local function hazirMi()
    return type(config.url) == "string" and config.url ~= ""
        and type(config.publishableKey) == "string" and config.publishableKey ~= ""
end

local function istekYap(method, yol, veri, listener)
    if not hazirMi() then
        if listener then listener(false, "Supabase ayarları henüz yapılmadı.") end
        return false
    end

    local basliklar = {
        ["Content-Type"] = "application/json",
        apikey = config.publishableKey,
        Authorization = "Bearer " .. config.publishableKey
    }
    local parametreler = {
        method = method,
        headers = basliklar,
        timeout = 10000
    }
    if veri then
        parametreler.body = json.encode(veri)
    end
    network.request(config.url .. "/rest/v1/" .. yol, method, function(event)
        if event.isError then
            if listener then listener(false, event.response or "Ağ bağlantısı kurulamadı.") end
            return
        end
        local basarili = event.status >= 200 and event.status < 300
        local sonuc = event.response
        if basarili and type(sonuc) == "string" and sonuc ~= "" then
            local cozuldu, tablo = pcall(json.decode, sonuc)
            if cozuldu then sonuc = tablo end
        end
        if listener then listener(basarili, sonuc) end
    end, parametreler)
    return true
end

function supabase.aktif()
    return hazirMi()
end

function supabase.hikayeGonder(baslik, metin, dilKodu, yazarKimligi, listener)
	return istekYap("POST", "hikayeler", {
		baslik = baslik,
		metin = metin,
		dil = dilKodu or "tr",
		yazar_kimligi = yazarKimligi,
		durum = "beklemede"
	}, listener)
end

function supabase.yayinlananlariGetir(listener)
	return istekYap("GET", "hikayeler?select=id,baslik,metin,dil,yazar_kimligi,olusturma_tarihi&durum=eq.yayinda&order=olusturma_tarihi.desc", nil, listener)
end

function supabase.icerikBildir(hikayeId, bildirenKimlik, neden, listener)
	return istekYap("POST", "hikaye_raporlari", {
		hikaye_id = hikayeId,
		bildiren_kimlik = bildirenKimlik,
		neden = neden
	}, listener)
end

return supabase
