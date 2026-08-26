local json = require("json")
local engelleme = {}

local function yol()
	return system.pathForFile("engellenen_yazarlar.json", system.DocumentsDirectory)
end

local function tumu()
	local dosya = io.open(yol(), "r")
	if not dosya then return {} end
	local icerik = dosya:read("*a")
	dosya:close()
	local basarili, sonuc = pcall(json.decode, icerik)
	return basarili and type(sonuc) == "table" and sonuc or {}
end

function engelleme.engelliMi(yazarKimligi)
	return type(yazarKimligi) == "string" and tumu()[yazarKimligi] == true
end

function engelleme.engelle(yazarKimligi)
	if type(yazarKimligi) ~= "string" or #yazarKimligi ~= 32 then return false end
	local kayitlar = tumu()
	kayitlar[yazarKimligi] = true
	local dosya = io.open(yol(), "w")
	if not dosya then return false end
	dosya:write(json.encode(kayitlar))
	dosya:close()
	return true
end

return engelleme
