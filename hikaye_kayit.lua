--------------------------------------------------------------------------------
-- Kullanıcı hikâyelerini cihazın Documents klasöründe saklar.
--------------------------------------------------------------------------------
local json = require("json")
local kayit = {}
local DOSYA = "kullanici_hikayeleri.json"

local function oku()
	local yol = system.pathForFile(DOSYA, system.DocumentsDirectory)
	local dosya = io.open(yol, "r")
	if not dosya then return {} end
	local icerik = dosya:read("*a")
	dosya:close()
	local basarili, sonuc = pcall(json.decode, icerik)
	return basarili and type(sonuc) == "table" and sonuc or {}
end

function kayit.ekle(baslik, metin)
	if metin == nil then
		metin = baslik
		baslik = "Kullanıcı Hikâyesi"
	end
	if type(metin) ~= "string" or metin:gsub("%s", "") == "" then
		return false
	end
	local hikayeler = oku()
	hikayeler[#hikayeler + 1] = {
		baslik = (type(baslik) == "string" and baslik ~= "") and baslik or "Kullanıcı Hikâyesi",
		metin = metin,
		tarih = os.date("%Y-%m-%d %H:%M")
	}
	local yol = system.pathForFile(DOSYA, system.DocumentsDirectory)
	local dosya = io.open(yol, "w")
	if not dosya then return false end
	dosya:write(json.encode(hikayeler))
	dosya:close()
	return true
end

function kayit.tumu()
	return oku()
end

return kayit
