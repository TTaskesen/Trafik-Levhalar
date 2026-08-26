-- Yayın ayarları. Yerel debug geçersiz kılmaları uygulama_ayar.local.lua
-- dosyasından okunur; bu dosya Git'e ve release AAB'ye girmez.
local ayarlar = {
	-- Statik hikâye okuyucu yayın akışında yer alır.
	hikayeOkumaAktif = true,
	-- Kullanıcı hikâyesi yazma yalnız debug'da açık tutulur.
	hikayeYazmaDebug = false,
	-- Sunucu kapalıyken debug yazıları sadece cihazda saklanır.
	hikayeSunucuAktif = false
}

local yuklendi, yerel = pcall(require, "uygulama_ayar.local")
if yuklendi and type(yerel) == "table" then
	for anahtar, deger in pairs(yerel) do
		ayarlar[anahtar] = deger
	end
end

return ayarlar
