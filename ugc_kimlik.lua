-- Hesap oluşturmadan moderasyon ve yerel engelleme için rastgele yazar kimliği.
local kimlik = {}
local ANAHTAR = "ugc_author_id_v1"

local function yeniKimlik()
	local parcalar = {}
	for _ = 1, 32 do
		parcalar[#parcalar + 1] = string.format("%x", math.random(0, 15))
	end
	return table.concat(parcalar)
end

function kimlik.kodu()
	local mevcut = system.getPreference("app", ANAHTAR, "string")
	if type(mevcut) == "string" and #mevcut == 32 then return mevcut end
	local yeni = yeniKimlik()
	pcall(system.setPreferences, "app", { [ANAHTAR] = yeni })
	return yeni
end

return kimlik
