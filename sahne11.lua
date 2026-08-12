--------------------------------------------------------------------------------
--
-- sahne11.lua - Yeni_standart levhalar
--
--------------------------------------------------------------------------------

local widget = require("widget")
local composer = require("composer")
local ortak = require("levha_ortak")
local scene = composer.newScene()

local scrollViewMetin

local levhaKareleri = {
    sheetContentWidth = 700,
    sheetContentHeight = 1085,
    frames = {
        [1]  = { x = 27, y = 28, width = 160, height = 128 },
        [2]  = { x = 189, y = 28, width = 160, height = 128 },
        [3]  = { x = 351, y = 28, width = 160, height = 128 },
        [4]  = { x = 513, y = 28, width = 160, height = 128 },
        [5]  = { x = 27, y = 157, width = 160, height = 129 },
        [6]  = { x = 189, y = 157, width = 160, height = 129 },
        [7]  = { x = 351, y = 157, width = 160, height = 129 },
        [8]  = { x = 513, y = 157, width = 160, height = 129 },
        [9]  = { x = 27, y = 287, width = 160, height = 128 },
        [10] = { x = 189, y = 287, width = 160, height = 128 },
        [11] = { x = 351, y = 287, width = 160, height = 128 },
        [12] = { x = 513, y = 287, width = 160, height = 128 },
        [13] = { x = 27, y = 416, width = 160, height = 129 },
        [14] = { x = 189, y = 416, width = 160, height = 129 },
        [15] = { x = 351, y = 416, width = 160, height = 129 },
        [16] = { x = 513, y = 416, width = 160, height = 129 },
        [17] = { x = 27, y = 546, width = 160, height = 128 },
        [18] = { x = 189, y = 546, width = 160, height = 128 },
        [19] = { x = 351, y = 546, width = 160, height = 128 },
        [20] = { x = 513, y = 546, width = 160, height = 128 },
        [21] = { x = 27, y = 675, width = 160, height = 129 },
        [22] = { x = 189, y = 675, width = 160, height = 129 },
        [23] = { x = 351, y = 675, width = 160, height = 129 },
        [24] = { x = 513, y = 675, width = 160, height = 129 },
        [25] = { x = 27, y = 805, width = 160, height = 128 },
        [26] = { x = 189, y = 805, width = 160, height = 128 },
        [27] = { x = 351, y = 805, width = 160, height = 128 },
        [28] = { x = 513, y = 805, width = 160, height = 128 },
        [29] = { x = 27, y = 934, width = 160, height = 130 },
    }
}

local resimLevha = graphics.newImageSheet("levha/levha/5-yeni-standart/yeni-standart.png", levhaKareleri)

local levhaDetaylari =
{
    [1] = { ad = "", aciklama = "" },
[2] = { ad = "Trafik Sıkışıklığı", aciklama = [[İleride trafik yoğunluğu veya trafik kuyruğu olabileceğini bildirir. Hızınızı azaltarak takip mesafesini koruyunuz.]] },
[3] = { ad = "Tramvay Hattı ile Oluşan Kavşak", aciklama = [[İleride tramvay hattının bulunduğu bir kavşak olduğunu gösterir. Tramvay geçişlerine ve kavşaktaki diğer araçlara dikkat ediniz.]] },
[4] = { ad = "Okul Bölgesi Azami Hız Sınırı", aciklama = [[Okul bölgesinde uygulanacak azami hız sınırını gösterir. Belirtilen hız sınırını aşmayınız ve öğrencilerin geçişlerine dikkat ediniz.]] },
[5] = { ad = "Yayalar ve Bisikletliler Tarafından Kullanılabilen Yol", aciklama = [[Yolun yayalar ve bisikletliler tarafından birlikte kullanılabileceğini bildirir. Tüm yol kullanıcıları birbirlerine karşı dikkatli olmalıdır.]] },
[6] = { ad = "Yayalar ve Bisikletliler Tarafından Kullanılabilen Yolun Sonu", aciklama = [[Yayalar ve bisikletliler tarafından birlikte kullanılabilen yolun sona erdiğini gösterir. Yolun devamındaki trafik düzenine uyunuz.]] },
[7] = { ad = "Yayalar ve Bisikletliler İçin Ayrı Ayrı Kullanılabilen Yol", aciklama = [[Yayalar ve bisikletliler için ayrılmış bölümlerin bulunduğunu gösterir. Her kullanıcı kendisine ayrılan bölümü kullanmalıdır.]] },
[8] = { ad = "Yayalar ve Bisikletliler İçin Ayrı Ayrı Kullanılabilen Yolun Sonu", aciklama = [[Yayalar ve bisikletliler için ayrı bölümlere ayrılmış yolun sona erdiğini bildirir.]] },
[9] = { ad = "Girişi Olmayan Yol Kavşağı", aciklama = [[İleride araç girişine kapalı bir yolun bulunduğu kavşağı gösterir. Bu yola girmeyiniz ve yönlendirmelere uyunuz.]] },
[10] = { ad = "Kavşak İçi Yön Levhası (Metro)", aciklama = [[Kavşak içinde metro istasyonuna veya metro yönüne ulaşmak için izlenecek yönü gösterir.]] },
[11] = { ad = "İleri Tek Yönlü Yol", aciklama = [[Trafiğin yalnızca ileri yönde ve tek yönlü olarak ilerlediğini bildirir. Ters yönde giriş yapmayınız.]] },
[12] = { ad = "Rampalı Yaya Üst Geçidi", aciklama = [[Yayaların rampalı üst geçidi kullanarak yolu güvenli şekilde geçebileceğini gösterir.]] },
[13] = { ad = "İki Yönlü Trafik", aciklama = [[Yolun iki yönlü trafiğe açıldığını bildirir. Karşı yönden gelen araçlara ve şerit çizgilerine dikkat ediniz.]] },
[14] = { ad = "Yaya Öncelikli Yol", aciklama = [[Yayaların öncelikli olduğu yolu gösterir. Sürücüler yayalara geçiş hakkı vermeli ve düşük hızla ilerlemelidir.]] },
[15] = { ad = "Yaya Öncelikli Yolun Sonu", aciklama = [[Yaya önceliğinin uygulandığı yolun sona erdiğini bildirir. Bundan sonra geçerli trafik kurallarına uyunuz.]] },
[16] = { ad = "İstasyon", aciklama = [[Yakında bir toplu taşıma istasyonu bulunduğunu gösterir. İstasyona giriş ve çıkış yapan yayalara dikkat ediniz.]] },
[17] = { ad = "Tramvay Durağı", aciklama = [[Tramvay durağının bulunduğunu bildirir. Durağa yanaşan tramvaylara ve yolculara dikkat ediniz.]] },
[18] = { ad = "Sanayi Bölgesi (OSB)", aciklama = [[Organize sanayi bölgesine veya sanayi alanına girildiğini gösterir. Ağır araç ve iş makinesi hareketlerine dikkat ediniz.]] },
[19] = { ad = "Trafik Elektronik Denetleme", aciklama = [[Trafiğin elektronik sistemlerle denetlendiğini bildirir. Hız sınırı ve diğer trafik kurallarına uyunuz.]] },
[20] = { ad = "Trafik Elektronik Denetleme", aciklama = [[Bu bölgede trafik ihlallerinin elektronik sistemlerle izlenebileceğini gösterir. Belirtilen kurallara uyunuz.]] },
[21] = { ad = "Trafik Elektronik Denetleme", aciklama = [[Elektronik trafik denetiminin devam ettiğini bildirir. Hızınızı ve sürüş kurallarına uyumunuzu kontrol ediniz.]] },
[22] = { ad = "Kapalı Park Yeri", aciklama = [[Kapalı otopark alanını gösterir. Park etmek için belirtilen giriş ve yönlendirmeleri kullanınız.]] },
[23] = { ad = "Park Yeri (Metrodan Yararlanacaklar İçin)", aciklama = [[Aracını park edip metroya devam etmek isteyenler için ayrılmış park alanını gösterir.]] },
[24] = { ad = "Park Yeri (Tramvaydan Yararlanacaklar İçin)", aciklama = [[Aracını park edip tramvaya devam etmek isteyenler için ayrılmış park alanını gösterir.]] },
[25] = { ad = "Ağaç Engeli", aciklama = [[Yol üzerinde veya yol kenarında ağaç engeli bulunabileceğini bildirir. Hızınızı azaltarak dikkatli ilerleyiniz.]] },
[26] = { ad = "Araç Çekilir", aciklama = [[Kurallara aykırı park edilen araçların çekilebileceğini bildirir. Aracınızı yalnızca izin verilen yerlere park ediniz.]] },
[27] = { ad = "İki Yönlü Trafik", aciklama = [[İki yönlü araç trafiğinin bulunduğu bölümü gösterir. Karşı yönden gelen araçlara ve geçiş önceliğine dikkat ediniz.]] },
[28] = { ad = "İki Yönlü Trafik", aciklama = [[Yolun iki yönlü kullanıldığını bildirir. Şerit değiştirmeden önce karşı yönden gelen trafiği kontrol ediniz.]] },
[29] = { ad = "Askeri Araç Çıkabilir", aciklama = [[Askeri araçların yola çıkabileceği veya yolu kullanabileceği bölgeyi bildirir. Ani araç çıkışlarına karşı dikkatli olunuz.]] },
[30] = { ad = "Yüksek Gerilim Hattı", aciklama = [[Yakında yüksek gerilim hattı bulunduğunu gösterir. Elektrik tesislerine yaklaşmayınız ve güvenlik uyarılarına uyunuz.]] },

}

-- Metin göstermek için ScrollView oluşturan fonksiyon
local function metinOlustur(icerik, ustBosluk)
    if scrollViewMetin then
        scrollViewMetin:removeSelf()
        scrollViewMetin = nil
    end
    scrollViewMetin = ortak.metinOlustur(icerik, ustBosluk, 0)
end

local function levhaBoyut(kare)
    return ortak.levhaBoyut(kare, 260, 200, 1.7)
end

function scene:create(event)
    local sceneGroup = self.view

    local ox, oy = math.abs(display.screenOriginX), math.abs(display.screenOriginY)
    local tabBarHeight = composer.getVariable("tabBarHeight") or 0
    local themeID = composer.getVariable("themeID")

    local tableViewColors = ortak.listeRenkleri()

    local ilkKare = levhaKareleri.frames[1]
    local g, y = levhaBoyut(ilkKare)
    local detayResimY, detayButonY = ortak.detayYerlesimi(y)
    self.yeniLevha = display.newImageRect(sceneGroup, resimLevha, 1, g, y)
    self.yeniLevha.x = display.contentCenterX
    self.yeniLevha.y = detayResimY
    self.yeniLevha.isVisible = false -- Satır seçilene kadar gizli kalsın (arka planda soluk görünmesin)
    sceneGroup:insert(self.yeniLevha)

    local function goBack(event)
        local tabBar = composer.getVariable("tabBar")
        ortak.tabBarGizle(tabBar)
        transition.to(self.tableView, { x = display.contentWidth * 0.5, time = 600, transition = easing.outQuint })
        transition.to(self.backButton, { x = 100, y = 200, time = 480, transition = easing.outQuint })
        transition.to(self.yeniLevha, { x = display.contentWidth + self.yeniLevha.contentWidth, time = 480, transition = easing.outQuint,
            onComplete = function()
                self.yeniLevha.isVisible = false
            end })

        if scrollViewMetin then
            scrollViewMetin:removeSelf()
            scrollViewMetin = nil
        end
    end

    self.backButton = ortak.geriDonButonu(goBack, 128, 32)
    self.backButton.x = 100
    self.backButton.y = detayButonY
    sceneGroup:insert(self.backButton)

    local function onRowRender(event)
        local row = event.row
        row._detayAcildi = false
        local groupContentHeight = row.contentHeight
        for i = row.numChildren, 1, -1 do
            local child = row[i]
            if child and child._levhaSatirOgesi then child:removeSelf() end
        end

        local rowTitle = display.newText({
            parent = row,
            text = levhaDetaylari[row.index].ad,
            x = 0,
            y = 0,
            width = math.max(1, display.contentWidth - 92),
            font = "Poppins-Medium",
            fontSize = 15,
            align = "left"
        })
        rowTitle.anchorX = 0
        rowTitle.x = 80
        rowTitle.y = groupContentHeight * 0.5
        rowTitle._levhaSatirOgesi = true

        if (row.isCategory) then
            rowTitle.isVisible = false
            rowTitle:setFillColor(unpack(row.params.catLabelColor))
            rowTitle.text = "YENİ STANDART LEVHALAR (29 LEVHA)"
            rowTitle.font = "Poppins-Bold"
            rowTitle.size = 16
        else
            rowTitle:setFillColor(unpack(row.params.defaultLabelColor))
            local kare = levhaKareleri.frames[row.index - 1]
            local oran = kare.width / kare.height
            local rw, rh = 50, 50 / oran
            if oran < 1 then rw, rh = 50 * oran, 50 end
            local rowResim = display.newImageRect(row, resimLevha, row.index - 1, rw, rh)
            rowResim._levhaSatirOgesi = true
            rowResim.x = 20
            rowResim.y = groupContentHeight * 0.5
        end
    end

    local function onRowTouch(event)
        local phase = event.phase
        local row = event.target

        if (phase == "press" or phase == "release" or phase == "tap" or phase == "ended") then
            if not row.isCategory and not row._detayAcildi then
                row._detayAcildi = true
                local tabBar = composer.getVariable("tabBar")
                ortak.tabBarGizle(tabBar)
                transition.to(self.tableView, {
                    x = ((display.contentWidth / 2) + ox + ox) * -1,
                    time = 600,
                    transition = easing.outQuint
                })

                if self.yeniLevha then
                    self.yeniLevha:removeSelf()
                    self.yeniLevha = nil
                end
                local secilenKare = row.index - 1
                local kare = levhaKareleri.frames[secilenKare]
                local g, y = levhaBoyut(kare)
                local yeniDetayY, yeniButonY, yeniMetinY = ortak.detayYerlesimi(y)
                self.yeniLevha = display.newImageRect(sceneGroup, resimLevha, secilenKare, g, y)
                self.yeniLevha.x = display.contentCenterX
                self.yeniLevha.y = yeniDetayY
                sceneGroup:insert(self.yeniLevha)
				self.backButton.x = display.contentCenterX
				self.backButton.y = yeniButonY

                transition.to(self.backButton,
                    {
                        x = display.contentCenterX,
                        y = yeniButonY,
                        time = 750,
                        transition = easing.outQuint
                    })

                local secilenMetin = levhaDetaylari[row.index].aciklama
                metinOlustur(secilenMetin, yeniMetinY)
                sceneGroup:insert(scrollViewMetin)
            end
        end
    end

    self.tableView = widget.newTableView
        {
            top = -oy,
            left = -ox,
            width = display.contentWidth + ox + ox,
            height = display.contentHeight - 70 + oy + oy,
            hideBackground = true,
            onRowRender = onRowRender,
            onRowTouch = onRowTouch,
        }
    sceneGroup:insert(self.tableView)

    -- 1 kategori satırı + levha satırları
    for i = 1, 30 do
        local isCategory = false
        local rowHeight = 70
        local rowColor = {
            default = tableViewColors.rowColor.default,
            over = tableViewColors.rowColor.over,
        }

        if i == 1 then
            isCategory = true
            rowHeight = 70
            rowColor = {
                default = tableViewColors.catColor.default,
                over = tableViewColors.catColor.over
            }
        end

        self.tableView:insertRow
        {
            isCategory = isCategory,
            rowHeight = rowHeight,
            rowColor = rowColor,
            lineColor = tableViewColors.lineColor,
            params = { defaultLabelColor = tableViewColors.defaultLabelColor, catLabelColor = tableViewColors.catLabelColor }
        }
    end

    ortak.listeGeriDonButonu(sceneGroup, function()
        composer.gotoScene("sahne1", "fade", 400)
    end)
    ortak.sabitListeBasligi(sceneGroup, "YENİ STANDART LEVHALAR (29 LEVHA)", ox, oy)
end

function scene:show(event)
    local phase = event.phase
    if "did" == phase then
        local tabBar = composer.getVariable("tabBar")
        if tabBar then
            ortak.tabBarGizle(tabBar)
        end
        collectgarbage("collect")
    end
end

function scene:hide(event)
    local phase = event.phase
    if "did" == phase then
    end
end

function scene:destroy(event)
    if self.yeniLevha then
        self.yeniLevha:removeSelf(); self.yeniLevha = nil
    end
    if self.backButton then
        self.backButton:removeSelf(); self.backButton = nil
    end
    if self.tableView then
        self.tableView:removeSelf(); self.tableView = nil
    end
    if scrollViewMetin then
        scrollViewMetin:removeSelf(); scrollViewMetin = nil
    end
end

--------------------------------------------------------------------------------

scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)
scene:addEventListener("destroy", scene)

--------------------------------------------------------------------------------

return scene
