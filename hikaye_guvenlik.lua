--------------------------------------------------------------------------------
-- Kullanıcı hikâyeleri için temel istemci tarafı doğrulama ve spam kontrolü.
--------------------------------------------------------------------------------
local guvenlik = {}
local sonGonderim = 0

local function kirp(metin)
	return tostring(metin or ""):gsub("^%s+", ""):gsub("%s+$", "")
end

function guvenlik.kontrol(baslik, metin)
	baslik = kirp(baslik)
	metin = kirp(metin)

	if baslik == "" then return false, "Lütfen hikâyene bir başlık yaz." end
	if #baslik > 80 then return false, "Başlık en fazla 80 karakter olabilir." end
	if metin == "" then return false, "Hikâye metni boş bırakılamaz." end
	if #metin < 20 then return false, "Hikâye en az 20 karakter olmalı." end
	if #metin > 5000 then return false, "Hikâye en fazla 5000 karakter olabilir." end

	if os.time() - sonGonderim < 30 then
		return false, "Yeni hikâye göndermek için biraz bekle."
	end
	return true, nil
end

function guvenlik.gonderimBaslat()
	sonGonderim = os.time()
end

return guvenlik
