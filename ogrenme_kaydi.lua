--------------------------------------------------------------------------------
-- Çevrimdışı öğrenme ilerlemesi.
-- Kullanıcı hesabı, ağ bağlantısı, reklam veya analiz içermez; yalnızca bu
-- cihazdaki sınav ilerlemesini DocumentsDirectory altında saklar.
--------------------------------------------------------------------------------
local json = require("json")

local modul = {}
local DOSYA_ADI = "ogrenme_kaydi.json"

local function varsayilanKayit()
    return {
        attempts = 0,
        best = 0,
        totalAnswered = 0,
        lastScore = 0,
        lastTotal = 0,
        wrong = {}
    }
end

local function kayitYolu()
    return system.pathForFile(DOSYA_ADI, system.DocumentsDirectory)
end

local function alanlariTamamla(kayit)
    local temel = varsayilanKayit()
    if type(kayit) ~= "table" then
        return temel
    end
    for anahtar, deger in pairs(temel) do
        if kayit[anahtar] == nil then
            kayit[anahtar] = deger
        end
    end
    if type(kayit.wrong) ~= "table" then
        kayit.wrong = {}
    end
    return kayit
end

local function kaydiOku()
    local yol = kayitYolu()
    if not yol then
        return varsayilanKayit()
    end
    local dosya = io.open(yol, "r")
    if not dosya then
        return varsayilanKayit()
    end
    local icerik = dosya:read("*a")
    dosya:close()
    local kayit
    if icerik and icerik ~= "" then
        local basarili, sonuc = pcall(json.decode, icerik)
        if basarili then
            kayit = sonuc
        end
    end
    return alanlariTamamla(kayit)
end

local function kaydiYaz(kayit)
    local yol = kayitYolu()
    if not yol then
        return false
    end
    local dosya = io.open(yol, "w")
    if not dosya then
        return false
    end
    dosya:write(json.encode(kayit))
    dosya:close()
    return true
end

function modul.oku()
    return kaydiOku()
end

function modul.sinaviKaydet(puan, toplam, yanlislar)
    local kayit = kaydiOku()
    kayit.attempts = (tonumber(kayit.attempts) or 0) + 1
    kayit.best = math.max(tonumber(kayit.best) or 0, tonumber(puan) or 0)
    kayit.totalAnswered = (tonumber(kayit.totalAnswered) or 0) + (tonumber(toplam) or 0)
    kayit.lastScore = tonumber(puan) or 0
    kayit.lastTotal = tonumber(toplam) or 0
    kayit.wrong = type(yanlislar) == "table" and yanlislar or {}
    kaydiYaz(kayit)
    return kayit
end

-- Bu işlem yalnızca uygulamanın DocumentsDirectory alanındaki yerel kaydı
-- siler. Kayıt henüz oluşmadıysa başarılı kabul edilir.
function modul.sifirla()
    local yol = kayitYolu()
    if not yol then
        return false
    end

    local dosya = io.open(yol, "r")
    if not dosya then
        return true
    end
    dosya:close()

    local basarili = os.remove(yol)
    return basarili ~= nil
end

return modul
