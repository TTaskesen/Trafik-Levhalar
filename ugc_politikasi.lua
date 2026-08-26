local politika = {}
local SURUM = "ugc_terms_v1"

politika.metin = [[Hikâye göndererek, tehdit, taciz, nefret söylemi, cinsel içerik, kişisel bilgi, telif ihlali veya hukuka aykırı içerik paylaşmayacağını kabul edersin. Hikâyeler önce incelenir; kurala aykırı içerik reddedilebilir veya yayından kaldırılabilir. Yayındaki içerikleri bildirebilir ve yazarını cihazında engelleyebilirsin. Reddedilen içerik için turguttaskesen@gmail.com adresinden itiraz edebilirsin.]]

function politika.kabulEdildiMi()
	return system.getPreference("app", SURUM, "boolean") == true
end

function politika.kabulEt()
	pcall(system.setPreferences, "app", { [SURUM] = true })
end

return politika
