--------------------------------------------------------------------------------
-- Supabase'ten indirilen yayınlanmış hikâyelerin çevrimdışı önbelleği.
--------------------------------------------------------------------------------
local json = require("json")
local cache = {}
local DOSYA = "yayinlanan_hikayeler.json"

function cache.oku()
	local yol = system.pathForFile(DOSYA, system.DocumentsDirectory)
	local dosya = io.open(yol, "r")
	if not dosya then return {} end
	local icerik = dosya:read("*a")
	dosya:close()
	local basarili, sonuc = pcall(json.decode, icerik)
	return basarili and type(sonuc) == "table" and sonuc or {}
end

function cache.kaydet(hikayeler)
	if type(hikayeler) ~= "table" then return false end
	local yol = system.pathForFile(DOSYA, system.DocumentsDirectory)
	local dosya = io.open(yol, "w")
	if not dosya then return false end
	dosya:write(json.encode(hikayeler))
	dosya:close()
	return true
end

return cache
