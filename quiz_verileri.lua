--------------------------------------------------------------------------------
-- Sınavın bütün levha kategorilerini ortak bir soru havuzunda birleştirir.
-- Her kategori kendi sprite sayfasını ve JSON açıklama sırasını korur.
--------------------------------------------------------------------------------
local ortak = require("levha_ortak")

local modul = {}

local function tehlikeKareleri()
    local kareler = {
        sheetContentWidth = 700,
        sheetContentHeight = 1950,
        frames = {}
    }
    local xKonumlari = { 5, 180, 360, 530 }
    local kareNo = 0
    for satir = 0, 12 do
        for sutun = 1, 4 do
            kareNo = kareNo + 1
            kareler.frames[kareNo] = {
                x = xKonumlari[sutun], y = 3 + satir * 150,
                width = 163, height = 146
            }
        end
    end
    return kareler
end

local function tanzimKareleri()
    local kareler = {
        sheetContentWidth = 700,
        sheetContentHeight = 2439,
        frames = {}
    }
    local sutunGenislikleri = { 175, 180, 170, 175 }
    for i = 1, 60 do
        local satir = math.floor((i - 1) / 4)
        local sutun = (i - 1) % 4
        local x = 0
        for s = 1, sutun do
            x = x + sutunGenislikleri[s]
        end
        kareler.frames[i] = {
            x = x, y = satir * 150,
            width = sutunGenislikleri[sutun + 1], height = 150
        }
    end
    kareler.frames[61] = { x = 0, y = 2250, width = 700, height = 189 }
    return kareler
end

local bilgiKareleri = {
    sheetContentWidth = 707,
    sheetContentHeight = 3601,
    frames = {
        [1] = { x = 30, y = 1, width = 122, height = 147 },
        [2] = { x = 182, y = 1, width = 351, height = 139 },
        [3] = { x = 554, y = 7, width = 123, height = 141 },
        [4] = { x = 28, y = 151, width = 126, height = 147 },
        [5] = { x = 202, y = 151, width = 124, height = 147 },
        [6] = { x = 366, y = 151, width = 150, height = 147 },
        [7] = { x = 556, y = 151, width = 120, height = 147 },
        [8] = { x = 12, y = 339, width = 167, height = 101 },
        [9] = { x = 184, y = 339, width = 169, height = 101 },
        [10] = { x = 353, y = 301, width = 180, height = 139 },
        [11] = { x = 535, y = 337, width = 166, height = 103 },
        [12] = { x = 33, y = 452, width = 171, height = 146 },
        [13] = { x = 247, y = 469, width = 220, height = 121 },
        [14] = { x = 536, y = 451, width = 104, height = 147 },
        [15] = { x = 7, y = 601, width = 228, height = 145 },
        [16] = { x = 241, y = 604, width = 228, height = 141 },
        [17] = { x = 474, y = 622, width = 228, height = 124 },
        [18] = { x = 10, y = 760, width = 228, height = 130 },
        [19] = { x = 243, y = 765, width = 228, height = 125 },
        [20] = { x = 476, y = 769, width = 227, height = 124 },
        [21] = { x = 10, y = 907, width = 228, height = 138 },
        [22] = { x = 243, y = 921, width = 228, height = 122 },
        [23] = { x = 476, y = 920, width = 227, height = 120 },
        [24] = { x = 10, y = 1072, width = 228, height = 118 },
        [25] = { x = 243, y = 1051, width = 228, height = 142 },
        [26] = { x = 476, y = 1067, width = 227, height = 123 },
        [27] = { x = 34, y = 1208, width = 123, height = 135 },
        [28] = { x = 209, y = 1208, width = 123, height = 135 },
        [29] = { x = 378, y = 1201, width = 118, height = 144 },
        [30] = { x = 560, y = 1201, width = 118, height = 140 },
        [31] = { x = 24, y = 1351, width = 116, height = 146 },
        [32] = { x = 210, y = 1351, width = 114, height = 147 },
        [33] = { x = 384, y = 1359, width = 123, height = 134 },
        [34] = { x = 531, y = 1384, width = 172, height = 109 },
        [35] = { x = 28, y = 1502, width = 130, height = 145 },
        [36] = { x = 182, y = 1501, width = 178, height = 142 },
        [37] = { x = 384, y = 1502, width = 114, height = 145 },
        [38] = { x = 556, y = 1502, width = 127, height = 146 },
        [39] = { x = 32, y = 1652, width = 126, height = 146 },
        [40] = { x = 208, y = 1652, width = 125, height = 141 },
        [41] = { x = 396, y = 1652, width = 95, height = 141 },
        [42] = { x = 558, y = 1652, width = 125, height = 141 },
        [43] = { x = 31, y = 1801, width = 125, height = 146 },
        [44] = { x = 188, y = 1801, width = 160, height = 146 },
        [45] = { x = 368, y = 1801, width = 140, height = 146 },
        [46] = { x = 559, y = 1801, width = 125, height = 147 },
        [47] = { x = 35, y = 1954, width = 121, height = 143 },
        [48] = { x = 210, y = 1954, width = 121, height = 143 },
        [49] = { x = 385, y = 1954, width = 121, height = 143 },
        [50] = { x = 540, y = 1954, width = 154, height = 143 },
        [51] = { x = 35, y = 2105, width = 121, height = 140 },
        [52] = { x = 211, y = 2105, width = 120, height = 143 },
        [53] = { x = 380, y = 2101, width = 124, height = 147 },
        [54] = { x = 556, y = 2105, width = 125, height = 135 },
        [55] = { x = 20, y = 2256, width = 144, height = 139 },
        [56] = { x = 209, y = 2251, width = 121, height = 146 },
        [57] = { x = 384, y = 2251, width = 121, height = 144 },
        [58] = { x = 572, y = 2251, width = 96, height = 144 },
        [59] = { x = 49, y = 2402, width = 93, height = 144 },
        [60] = { x = 204, y = 2402, width = 134, height = 144 },
        [61] = { x = 399, y = 2402, width = 93, height = 142 },
        [62] = { x = 554, y = 2402, width = 127, height = 144 },
        [63] = { x = 35, y = 2556, width = 121, height = 138 },
        [64] = { x = 210, y = 2556, width = 121, height = 140 },
        [65] = { x = 385, y = 2556, width = 121, height = 138 },
        [66] = { x = 550, y = 2556, width = 131, height = 138 },
        [67] = { x = 32, y = 2701, width = 120, height = 147 },
        [68] = { x = 224, y = 2701, width = 93, height = 145 },
        [69] = { x = 376, y = 2703, width = 130, height = 143 },
        [70] = { x = 550, y = 2703, width = 132, height = 145 },
        [71] = { x = 19, y = 2853, width = 153, height = 145 },
        [72] = { x = 194, y = 2853, width = 153, height = 141 },
        [73] = { x = 376, y = 2853, width = 132, height = 145 },
        [74] = { x = 552, y = 2853, width = 132, height = 145 },
        [75] = { x = 35, y = 3002, width = 133, height = 144 },
        [76] = { x = 210, y = 3002, width = 134, height = 146 },
        [77] = { x = 385, y = 3002, width = 133, height = 146 },
        [78] = { x = 544, y = 3002, width = 153, height = 146 },
        [79] = { x = 30, y = 3156, width = 132, height = 142 },
        [80] = { x = 208, y = 3156, width = 123, height = 136 },
        [81] = { x = 381, y = 3151, width = 126, height = 145 },
        [82] = { x = 564, y = 3155, width = 100, height = 141 },
        [83] = { x = 44, y = 3301, width = 102, height = 147 },
        [84] = { x = 208, y = 3301, width = 112, height = 147 },
        [85] = { x = 376, y = 3301, width = 126, height = 147 },
        [86] = { x = 548, y = 3301, width = 128, height = 147 },
        [87] = { x = 37, y = 3451, width = 170, height = 144 },
        [88] = { x = 272, y = 3451, width = 167, height = 147 },
        [89] = { x = 509, y = 3451, width = 168, height = 147 }
    }
}

local function kareListesi(genislik, yukseklik, kareler)
    return { sheetContentWidth = genislik, sheetContentHeight = yukseklik, frames = kareler }
end

local kategoriTanimlari = {
    { kod = "tehlike", dosya = "levha/levha/1-tehlike/Tehlike ve Uyari Aciklama.json", adet = 53,
        image = "levha/levha/1-tehlike/tehlike.png", frames = tehlikeKareleri() },
    { kod = "tanzim", dosya = "levha/levha/2-tanzim/Trafik Tanzim Aciklama.json", adet = 62,
        image = "levha/levha/2-tanzim/tanzim.png", frames = tanzimKareleri() },
    { kod = "bilgi", dosya = "levha/levha/3-bilgi/Bilgi Levhaları Aciklama.json", adet = 90,
        image = "levha/levha/3-bilgi/bilgi.png", frames = bilgiKareleri },
    { kod = "durma", dosya = "levha/levha/4-durma-park/Durma ve Park Yapma Aciklama.json", adet = 8,
        image = "levha/levha/4-durma-park/durma-park.jpg", frames = kareListesi(698, 300, {
            [1] = { x = 2, y = 2, width = 170, height = 146 }, [2] = { x = 176, y = 2, width = 170, height = 146 },
            [3] = { x = 350, y = 2, width = 170, height = 146 }, [4] = { x = 524, y = 2, width = 170, height = 146 },
            [5] = { x = 2, y = 152, width = 170, height = 146 }, [6] = { x = 176, y = 152, width = 170, height = 146 },
            [7] = { x = 350, y = 152, width = 170, height = 146 }
        }) },
    { kod = "yatay", dosya = "levha/levha/6-yatay/Yatay Levhalar Aciklama.json", adet = 8,
        image = "levha/levha/6-yatay/yatay.png", frames = kareListesi(632, 948, {
            [1] = { x = 32, y = 19, width = 140, height = 374 }, [2] = { x = 178, y = 19, width = 140, height = 374 },
            [3] = { x = 323, y = 19, width = 141, height = 374 }, [4] = { x = 469, y = 19, width = 140, height = 374 },
            [5] = { x = 105, y = 480, width = 140, height = 374 }, [6] = { x = 251, y = 480, width = 140, height = 374 },
            [7] = { x = 396, y = 480, width = 141, height = 374 }
        }) },
    { kod = "yeni", dosya = "levha/levha/5-yeni-standart/Yeni Standart Levhalar Aciklama.json", adet = 30,
        image = "levha/levha/5-yeni-standart/yeni-standart.png", frames = kareListesi(700, 1085, {
            [1] = { x = 27, y = 28, width = 160, height = 128 }, [2] = { x = 189, y = 28, width = 160, height = 128 },
            [3] = { x = 351, y = 28, width = 160, height = 128 }, [4] = { x = 513, y = 28, width = 160, height = 128 },
            [5] = { x = 27, y = 157, width = 160, height = 129 }, [6] = { x = 189, y = 157, width = 160, height = 129 },
            [7] = { x = 351, y = 157, width = 160, height = 129 }, [8] = { x = 513, y = 157, width = 160, height = 129 },
            [9] = { x = 27, y = 287, width = 160, height = 128 }, [10] = { x = 189, y = 287, width = 160, height = 128 },
            [11] = { x = 351, y = 287, width = 160, height = 128 }, [12] = { x = 513, y = 287, width = 160, height = 128 },
            [13] = { x = 27, y = 416, width = 160, height = 129 }, [14] = { x = 189, y = 416, width = 160, height = 129 },
            [15] = { x = 351, y = 416, width = 160, height = 129 }, [16] = { x = 513, y = 416, width = 160, height = 129 },
            [17] = { x = 27, y = 546, width = 160, height = 128 }, [18] = { x = 189, y = 546, width = 160, height = 128 },
            [19] = { x = 351, y = 546, width = 160, height = 128 }, [20] = { x = 513, y = 546, width = 160, height = 128 },
            [21] = { x = 27, y = 675, width = 160, height = 129 }, [22] = { x = 189, y = 675, width = 160, height = 129 },
            [23] = { x = 351, y = 675, width = 160, height = 129 }, [24] = { x = 513, y = 675, width = 160, height = 129 },
            [25] = { x = 27, y = 805, width = 160, height = 128 }, [26] = { x = 189, y = 805, width = 160, height = 128 },
            [27] = { x = 351, y = 805, width = 160, height = 128 }, [28] = { x = 513, y = 805, width = 160, height = 128 },
            [29] = { x = 27, y = 934, width = 160, height = 130 }
        }) },
    { kod = "otoyol", dosya = "levha/levha/7-otoyol/Otoyol Isaretleri  Aciklama.json", adet = 10,
        image = "levha/levha/7-otoyol/Otoyol.png", frames = kareListesi(1174, 197, {
            [1] = { x = 28, y = 48, width = 155, height = 108 }, [2] = { x = 214, y = 60, width = 80, height = 92 },
            [3] = { x = 337, y = 60, width = 65, height = 92 }, [4] = { x = 435, y = 60, width = 82, height = 92 },
            [5] = { x = 558, y = 60, width = 83, height = 92 }, [6] = { x = 680, y = 75, width = 84, height = 80 },
            [7] = { x = 800, y = 75, width = 84, height = 80 }, [8] = { x = 914, y = 60, width = 93, height = 92 },
            [9] = { x = 1035, y = 60, width = 88, height = 92 }
        }) }
}

local function sinavKareleriniOlustur(kareler)
    local sonuc = {
        sheetContentWidth = kareler.sheetContentWidth,
        sheetContentHeight = kareler.sheetContentHeight,
        frames = {}
    }
    for index, kare in pairs(kareler.frames) do
        -- Sprite sayfalarındaki küçük katalog etiketleri cevabı açığa
        -- çıkarmasın; levhanın üstteki ana görselini koruyarak alt kısmı kes.
        sonuc.frames[index] = {
            x = kare.x,
            y = kare.y,
            width = kare.width,
            height = math.max(1, math.floor(kare.height * 0.82))
        }
    end
    return sonuc
end

for _, kategori in ipairs(kategoriTanimlari) do
    kategori.sinavFrames = sinavKareleriniOlustur(kategori.frames)
    kategori.imageSheet = graphics.newImageSheet(kategori.image, kategori.sinavFrames)
end

local function yalinAd(ad)
    return tostring(ad or ""):gsub("^%b()%s*", "")
end

-- Açıkça temel düzeyde tanınması beklenen levhalar. Havuzun geri kalanı
-- kategori sırasına göre dengeli biçimde üç seviyeye dağıtılır; böylece 254
-- levhanın tamamı sınav sorusu veya çeldirici olarak kullanılabilir.
local kolayAdlari = {
    ["Dur"] = true, ["Yol ver"] = true, ["Park etmek yasaktır"] = true,
    ["Duraklamak ve park etmek yasaktır"] = true, ["Yaya geçidi"] = true,
    ["Okul geçidi"] = true, ["Hastane"] = true, ["Tünel"] = true,
    ["Akaryakıt istasyonu"] = true, ["Otoyol başlangıcı"] = true,
    ["Otoyol sonu"] = true, ["Trafik Sıkışıklığı"] = true,
    ["Yaya giremez"] = true, ["Bisiklet giremez"] = true
}

local ortaAdlari = {
    ["Azami hız sınırlaması"] = true, ["Hız sınırlaması sonu"] = true,
    ["Sağa dönülmez"] = true, ["Sola dönülmez"] = true,
    ["U dönüşü yapılmaz"] = true, ["Kaygan yol"] = true,
    ["Yandan rüzgar"] = true, ["Gizli buzlanma"] = true,
    ["Kontrollü demiryolu geçidi"] = true, ["Kontrolsüz demiryolu geçidi"] = true,
    ["Park yeri"] = true, ["İlk yardım"] = true,
    ["Tamirhane"] = true, ["Telefon"] = true, ["Kavşak isim levhası"] = true
}

local function seviyeyiBelirle(kategoriIndex, kayitIndex, ad)
    local ad = yalinAd(ad)
    if kolayAdlari[ad] then return "kolay" end
    if ortaAdlari[ad] then return "orta" end
    local seviyeler = { "kolay", "orta", "zor" }
    return seviyeler[((kategoriIndex + kayitIndex) % #seviyeler) + 1]
end

local tumSorular

function modul.tumunuOlustur()
    if tumSorular then return tumSorular end
    tumSorular = {}
    for kategoriIndex, kategori in ipairs(kategoriTanimlari) do
        local kayitlar = ortak.levhaAciklamalariniOku(kategori.dosya, kategori.adet)
        for kayitIndex = 2, #kayitlar do
            local kayit = kayitlar[kayitIndex]
            local kare = kategori.sinavFrames.frames[kayitIndex - 1]
            if kayit and type(kayit.ad) == "string" and kayit.ad ~= "" and kare then
                tumSorular[#tumSorular + 1] = {
                    kimlik = kategori.kod .. ":" .. tostring(kayitIndex),
                    kategori = kategori.kod,
                    kayit = kayit,
                    kare = kayitIndex - 1,
                    kareBilgisi = kare,
                    imageSheet = kategori.imageSheet,
                    dogru = ortak.levhaAdi(kayit.ad),
                    zorluk = seviyeyiBelirle(kategoriIndex, kayitIndex, kayit.ad)
                }
            end
        end
    end
    return tumSorular
end

local function karistir(liste)
    for i = #liste, 2, -1 do
        local j = math.random(i)
        liste[i], liste[j] = liste[j], liste[i]
    end
    return liste
end

function modul.sorulariOlustur(zorluk, adet)
    adet = adet or 10
    local gruplar = {}
    for _, soru in ipairs(modul.tumunuOlustur()) do
        if soru.zorluk == zorluk then
            gruplar[soru.kategori] = gruplar[soru.kategori] or {}
            gruplar[soru.kategori][#gruplar[soru.kategori] + 1] = soru
        end
    end

    local secilen, secilenler = {}, {}
    local kategoriSirasi = { "tehlike", "tanzim", "bilgi", "durma", "yatay", "yeni", "otoyol" }
    local function ekle(soru)
        if soru and not secilenler[soru.kimlik] then
            secilenler[soru.kimlik] = true
            secilen[#secilen + 1] = soru
        end
    end

    -- Her sınavda bütün levha gruplarından en az bir örnek bulunur.
    for _, kategori in ipairs(kategoriSirasi) do
        local havuz = gruplar[kategori]
        if havuz and #havuz > 0 then
            ekle(havuz[math.random(#havuz)])
        end
    end

    local kalan = {}
    for _, soru in ipairs(modul.tumunuOlustur()) do
        if soru.zorluk == zorluk and not secilenler[soru.kimlik] then
            kalan[#kalan + 1] = soru
        end
    end
    karistir(kalan)
    for _, soru in ipairs(kalan) do
        if #secilen >= adet then break end
        ekle(soru)
    end

    -- Herhangi bir dil/veri güncellemesinde seviye havuzu 10'un altına düşerse
    -- sınav yine tamamlanabilir; eksik sayı diğer levhalardan tamamlanır.
    if #secilen < adet then
        local tamamlayicilar = {}
        for _, soru in ipairs(modul.tumunuOlustur()) do
            if not secilenler[soru.kimlik] then tamamlayicilar[#tamamlayicilar + 1] = soru end
        end
        karistir(tamamlayicilar)
        for _, soru in ipairs(tamamlayicilar) do
            if #secilen >= adet then break end
            ekle(soru)
        end
    end

    karistir(secilen)
    return secilen
end

function modul.distraktorler(soru, adet)
    local sonuc, kullanilan = {}, { [soru.dogru] = true }
    local adaylar = {}
    for _, aday in ipairs(modul.tumunuOlustur()) do
        if aday.kimlik ~= soru.kimlik and not kullanilan[aday.dogru] then
            adaylar[#adaylar + 1] = aday.dogru
        end
    end
    karistir(adaylar)
    for _, aday in ipairs(adaylar) do
        if #sonuc >= adet then break end
        if not kullanilan[aday] then
            kullanilan[aday] = true
            sonuc[#sonuc + 1] = aday
        end
    end
    return sonuc
end

return modul
