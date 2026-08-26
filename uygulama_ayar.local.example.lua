-- Bu dosyayı uygulama_ayar.local.lua adıyla kopyalayın.
-- Yerel dosya Git'e ve Android release AAB'sine dahil edilmez.
return {
	-- Debug derlemede "Bana Bir Hikâye Yaz" bağlantısını açar.
	hikayeYazmaDebug = true,
	-- Supabase projesi yeniden etkinleşene kadar false bırakın.
	-- false iken gönderilen hikâye yalnız bu cihazda saklanır.
	hikayeSunucuAktif = false
}
