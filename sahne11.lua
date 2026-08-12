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
[2] = { ad = "Trafik Sıkışıklığı", aciklama = [[Görselde art arda dizilmiş araçlar bulunması, ileride trafik yoğunluğu veya araç kuyruğu oluşabileceğini bildirir. Sürücü, hızını azaltmalı, öndeki araçla güvenli takip mesafesini korumalı ve ani fren yapabilecek araçlara karşı hazırlıklı olmalıdır. Özellikle kavşak, tünel ve yol daralmalarında kuyruğun sonundaki araca çarpmamak için dikkatli olunmalıdır.]] },
[3] = { ad = "Tramvay Hattı ile Oluşan Kavşak", aciklama = [[Üçgen içindeki tramvay sembolü, ileride tramvay hattının karayoluyla kesiştiği bir kavşağı gösterir. Tramvayların ray üzerinde ve belirli bir güzergâhta ilerlediğini unutmayınız; kavşağa yaklaşırken hızı azaltınız, sinyal ve geçiş önceliği kurallarına uyunuz.]] },
[4] = { ad = "Okul Bölgesi Azami Hız Sınırı", aciklama = [[Sarı okul bölgesi paneli ve altındaki 30 hız göstergesi, okul çevresinde azami hızın 30 km/s olduğunu bildirir. Bu bölgede çocukların yola aniden çıkabileceğini dikkate alarak yavaşlayınız, geçiş yapan öğrencilere öncelik veriniz ve park etmiş araçların arasından çıkabilecek yayalara karşı dikkatli olunuz.]] },
[5] = { ad = "Yayalar ve Bisikletliler Tarafından Kullanılabilen Yol", aciklama = [[Mavi daire içindeki yaya ve bisikletli sembolleri, yolun her iki kullanıcı grubu tarafından birlikte kullanılabileceğini gösterir. Bu işaret, yayalar ile bisikletlilerin aynı ortak alanda hareket ettiğini belirtir; bisikletliler yayalara yaklaşırken hızını azaltmalı, yayalar da bisiklet geçişlerini engellememelidir.]] },
[6] = { ad = "Yayalar ve Bisikletliler Tarafından Kullanılabilen Yolun Sonu", aciklama = [[Mavi ortak yaya-bisiklet yolu sembolü üzerindeki kırmızı çapraz çizgi, bu ortak kullanım yolunun sona erdiğini bildirir. İşaretten sonra yol kullanıcıları için farklı bir düzen başlayabileceğinden bisikletliler ve yayalar yönlendirme levhalarını takip etmeli, sürücüler de yolun yeni kullanım biçimine dikkat etmelidir.]] },
[7] = { ad = "Yayalar ve Bisikletliler İçin Ayrı Ayrı Kullanılabilen Yol", aciklama = [[Mavi dairede yaya ve bisiklet sembollerinin ayrı bölümlerde gösterilmesi, yaya ve bisikletliler için ayrılmış ayrı şerit veya bölümlerin bulunduğunu belirtir. Yayalar kendilerine ayrılan kısmı, bisikletliler ise bisiklet bölümünü kullanmalı; bölümler arasındaki sınırı ihlal etmemelidir.]] },
[8] = { ad = "Yayalar ve Bisikletliler İçin Ayrı Ayrı Kullanılabilen Yolun Sonu", aciklama = [[Ayrı yaya ve bisiklet bölümlerini gösteren sembol üzerindeki kırmızı çizgi, bu düzenin sona erdiğini bildirir. Bundan sonra ayrı şerit bulunmayabileceği için bisikletliler hızını azaltmalı, yayalar güvenli alanda yürümeli ve tüm kullanıcılar yeni trafik düzenine uyum sağlamalıdır.]] },
[9] = { ad = "Girişi Olmayan Yol Kavşağı", aciklama = [[Mavi levhadaki beyaz T sembolü ve kırmızı kapalı kol, ileride araç girişine izin verilmeyen bir yol kolunun bulunduğunu gösterir. Bu levha, kavşakta yön seçerken kapalı kola girmemeniz gerektiğini önceden bildirir; yolun açık yönlerine ve diğer yön levhalarına uyunuz.]] },
[10] = { ad = "Kavşak İçi Yön Levhası (Metro)", aciklama = [[Üzerinde “P + METRO” yazısı ve sağ yön oku bulunan levha, metroya aktarma yapmak isteyenlerin kullanacağı park alanını veya metro yönünü gösterir. Sürücü, ok yönünde ilerlemeli; levhanın park ve metro bağlantısını birlikte bildirdiğini dikkate almalıdır.]] },
[11] = { ad = "İleri Tek Yönlü Yol", aciklama = [[Mavi kare içindeki ileri yön oku ve “TEK YÖN” ifadesi, yolun bu bölümünde trafiğin yalnızca ileri yönde aktığını bildirir. Karşı yönden giriş yapmayınız, geri manevra ve dönüşleri yalnızca izin verilen noktalarda gerçekleştiriniz.]] },
[12] = { ad = "Rampalı Yaya Üst Geçidi", aciklama = [[Tekerlekli sandalye sembolü bulunan mavi levha, rampalı ve erişilebilir bir yaya üst geçidini gösterir. Bu geçit, engelli bireylerin, bebek arabası kullananların ve hareket kabiliyeti sınırlı yayaların yolu güvenli biçimde geçebilmesi için düzenlenmiştir; yayalar geçişte bu yapıyı kullanmalıdır.]] },
[13] = { ad = "İki Yönlü Trafik", aciklama = [[Karşılıklı iki ok, yolun iki yönlü trafiğe açık olduğunu gösterir. Tek yönlü bölümden sonra karşı yönden araç gelebileceğini dikkate alınız; şerit çizgilerine, karşıdan gelen trafiğe ve sollama kurallarına uyunuz.]] },
[14] = { ad = "Yaya Öncelikli Yol", aciklama = [[Yaya, araç ve ev sembollerinin birlikte bulunduğu mavi levha, yayaların öncelikli olduğu bir yol veya yerleşim alanını gösterir. Sürücüler düşük hızla ilerlemeli, yayalara geçiş hakkı vermeli ve araçlarını yayaların hareketini engellemeyecek yerlere park etmelidir.]] },
[15] = { ad = "Yaya Öncelikli Yolun Sonu", aciklama = [[Yaya öncelikli yol sembolü üzerindeki kırmızı çizgi, bu özel yol düzeninin sona erdiğini bildirir. Levhadan sonra yayaların önceliği farklı kurallara bağlı olabileceği için sürücüler normal yol ve geçiş kurallarına dönmeli, yayalar da işaretli geçiş noktalarını kullanmalıdır.]] },
[16] = { ad = "İstasyon", aciklama = [[Mavi levhadaki tren veya toplu taşıma aracı sembolü, ileride bir istasyon bulunduğunu gösterir. İstasyon çevresinde yolcu iniş-binişi ve karşıdan karşıya geçen yayalar artabileceğinden hızı azaltınız ve istasyon giriş-çıkışlarına dikkat ediniz.]] },
[17] = { ad = "Tramvay Durağı", aciklama = [[Levhadaki tramvay sembolü, tramvay durağının bulunduğunu bildirir. Durakta bekleyen veya tramvaydan inen yolcular yola yaklaşabilir; sürücüler durağa yaklaşırken yavaşlamalı, tramvay ve yolcuların güvenli geçişini gözetmelidir.]] },
[18] = { ad = "Sanayi Bölgesi (OSB)", aciklama = [[Fabrika sembolü bulunan levha, organize sanayi bölgesine veya sanayi tesislerinin yoğun olduğu bir alana girildiğini gösterir. Kamyon, servis aracı, iş makinesi ve fabrika giriş-çıkışlarıyla karşılaşılabileceğinden hızınızı azaltınız ve ağır araç manevralarına dikkat ediniz.]] },
[19] = { ad = "Trafik Elektronik Denetleme", aciklama = [[Kamera ve denetim cihazı sembolü, trafik akışının elektronik sistemlerle izlenebileceğini bildirir. Bu levha hız, kırmızı ışık, şerit ve diğer trafik ihlallerinin denetlenebileceği anlamına gelir; sürücü tüm trafik kurallarına uymalıdır.]] },
[20] = { ad = "Trafik Elektronik Denetleme", aciklama = [[Dikey kamera ve kontrol cihazı görseli, elektronik trafik denetiminin devam ettiğini gösterir. Sürücü hızını kontrol etmeli, sinyal ve şerit kurallarına uymalı; denetim cihazlarının bulunduğu bölgede ani ve kural dışı manevralardan kaçınmalıdır.]] },
[21] = { ad = "Trafik Elektronik Denetleme", aciklama = [[Levhanın yatay ve uzun biçimde tasarlanması, elektronik denetim bilgisinin yol boyunca veya belirli bir kesim için verildiğini gösterir. Denetim alanında hız sınırına, takip mesafesine ve şerit disiplinine özellikle dikkat edilmelidir.]] },
[22] = { ad = "Kapalı Park Yeri", aciklama = [[Üstü çatı biçiminde ve altında “P” bulunan mavi levha, kapalı otopark alanını gösterir. Sürücü park girişini, araç yüksekliği ve yönlendirme işaretlerini kontrol etmeli; otopark içinde belirtilen hız ve park düzenine uymalıdır.]] },
[23] = { ad = "Park Yeri (Metrodan Yararlanacaklar İçin)", aciklama = [[“P + METRO” ibaresi, aracını park ederek yolculuğuna metro ile devam etmek isteyenler için ayrılmış park alanını gösterir. Bu alan, karayolu ile metro arasında aktarma yapılmasını sağlar; araç park edildikten sonra metro yönlendirmelerini takip ediniz.]] },
[24] = { ad = "Park Yeri (Tramvaydan Yararlanacaklar İçin)", aciklama = [[“P + tramvay” sembolü, aracını park edip tramvayla devam etmek isteyen yolculara ayrılmış park alanını bildirir. Park alanından tramvay durağına geçerken yaya yollarını kullanınız ve raylı sistem geçişlerine dikkat ediniz.]] },
[25] = { ad = "Ağaç Engeli", aciklama = [[Ağaç ve yol engeli görseli, yol üzerinde veya yol kenarında görüşü ve geçiş alanını daraltabilecek bir ağaç engeli bulunduğunu bildirir. Sürücü hızını azaltmalı, engelin çevresinden geçerken karşı yönden gelen araçları kontrol etmeli ve yol kenarına yaklaşan yayalara dikkat etmelidir.]] },
[26] = { ad = "Araç Çekilir", aciklama = [[Çekici üzerindeki araç sembolü, kurallara aykırı veya trafiği engelleyen araçların çekilebileceğini gösterir. Bu bölgede park etmeyiniz; aracınızı yalnızca izin verilen park alanlarına bırakınız ve çekici çalışma alanına yaklaşmayınız.]] },
[27] = { ad = "İki Yönlü Trafik", aciklama = [[Karşılıklı oklar, yolun iki yönde kullanıldığını gösterir. Alt panel bulunmadığından levha genel iki yönlü trafik bilgisini verir; karşı yönden gelen araçlara dikkat ediniz ve şerit değiştirmeden önce yolu kontrol ediniz.]] },
[28] = { ad = "İki Yönlü Trafik (200 m)", aciklama = [[Karşılıklı okların altında “200 m” mesafe bilgisinin bulunması, iki yönlü trafik düzeninin 200 metre sonra başlayacağını bildirir. Sürücü bu mesafe içinde hızını ve şerit konumunu ayarlamalı, karşı yönden gelecek araçlara hazırlıklı olmalıdır.]] },
[29] = { ad = "Askeri Araç Çıkabilir", aciklama = [[Tank sembolü, askeri araçların yola çıkabileceği veya yolu kullanabileceği bir bölgeye yaklaşıldığını gösterir. Askeri araçlar geniş, yavaş ve manevra kabiliyeti sınırlı olabilir; ani çıkışlara karşı hızınızı azaltınız ve geçişlerine engel olmayınız.]] },
[30] = { ad = "Yüksek Gerilim Hattı", aciklama = [[Şimşek sembolü ve 4.50 m yükseklik bilgisi, ileride yüksek gerilim hattı bulunduğunu ve belirtilen düşey açıklığa dikkat edilmesi gerektiğini gösterir. Özellikle kamyon, otobüs ve yük taşıyan araçlar yüksekliklerini kontrol etmeli; elektrik hatlarına ve tesislerine yaklaşmamalıdır.]] },

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
