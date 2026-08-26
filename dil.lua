--------------------------------------------------------------------------------
-- Uygulama arayuzu icin coklu dil yardimcisi.
--------------------------------------------------------------------------------
local json = require("json")

local dil = {}
local aktifDil = "tr"
local metinler = {}

local function diliBelirle()
    local kayitliDil = system.getPreference("app", "language", "string")
    if kayitliDil == "tr" or kayitliDil == "de" or kayitliDil == "fr" or kayitliDil == "ko" then
        return kayitliDil
    end

    local sistemDili = system.getPreference("ui", "language", "string") or "tr"
    sistemDili = sistemDili:lower()

    if sistemDili:find("^de") then
        return "de"
    elseif sistemDili:find("^fr") then
        return "fr"
    elseif sistemDili:find("^ko") then
        return "ko"
    end

    return "tr"
end

local function dosyayiOku(dilKodu)
    local yol = "diller/" .. dilKodu .. ".json"
    local dosya = io.open(system.pathForFile(yol, system.ResourceDirectory), "r")
    if not dosya then
        return nil
    end

    local icerik = dosya:read("*a")
    dosya:close()

    local basarili, sonuc = pcall(json.decode, icerik)
    if basarili and type(sonuc) == "table" then
        return sonuc
    end

    return nil
end

function dil.dosyaMetni(anahtar, varsayilan)
    if aktifDil == "tr" then
        return varsayilan
    end

    local yol = system.pathForFile("diller/" .. anahtar .. "_" .. aktifDil .. ".txt", system.ResourceDirectory)
    if not yol then
        return varsayilan
    end

    local dosya = io.open(yol, "r")
    if not dosya then
        return varsayilan
    end

    local icerik = dosya:read("*a")
    dosya:close()
    return (icerik and #icerik > 0) and icerik or varsayilan
end

function dil.yukle(dilKodu)
    dilKodu = dilKodu or diliBelirle()
    local yeniMetinler = dosyayiOku(dilKodu)

    if not yeniMetinler and dilKodu ~= "tr" then
        dilKodu = "tr"
        yeniMetinler = dosyayiOku("tr")
    end

    aktifDil = dilKodu
    metinler = yeniMetinler or {}
    return aktifDil
end

function dil.sec(dilKodu)
    if dilKodu ~= "tr" and dilKodu ~= "de" and dilKodu ~= "fr" and dilKodu ~= "ko" then
        dilKodu = "tr"
    end

    pcall(system.setPreferences, "app", { language = dilKodu })
    return dil.yukle(dilKodu)
end

function dil.kodu()
    return aktifDil
end

function dil.metin(anahtar)
    return metinler[anahtar] or anahtar
end

-- İlk açılışta kayıtlı veya cihaz dili kullanılır; kullanıcı karşılama
-- ekranından dili değiştirdiğinde seçim cihazda saklanır.
dil.yukle()

return dil
