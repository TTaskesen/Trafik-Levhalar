--------------------------------------------------------------------------------
--
-- sahne12.lua - OTOYOL LEVHALARI
--
--------------------------------------------------------------------------------

local widget = require("widget")
local composer = require("composer")
local ortak = require("levha_ortak")
local scene = composer.newScene()

local scrollViewMetin

local levhaKareleri = {
    sheetContentWidth = 1174,
    sheetContentHeight = 197,
    frames = {
        [1] = { x = 28,   y = 48, width = 155, height = 108 },
        [2] = { x = 214,  y = 60, width = 80,  height = 92 },
        [3] = { x = 337,  y = 60, width = 65,  height = 92 },
        [4] = { x = 435,  y = 60, width = 82,  height = 92 },
        [5] = { x = 558,  y = 60, width = 83,  height = 92 },
        [6] = { x = 680,  y = 75, width = 84,  height = 80 },
        [7] = { x = 800,  y = 75, width = 84,  height = 80 },
        [8] = { x = 914,  y = 60, width = 93,  height = 92 },
        [9] = { x = 1035, y = 60, width = 88,  height = 92 },
    }
}

local resimLevha = graphics.newImageSheet("levha/levha/7-otoyol/Otoyol.png", levhaKareleri)

local levhaDetaylari =
{
{ ad = "", aciklama = "" },
[2] = { ad = "Kavşak isim levhası", aciklama = [[Yeşil levhadaki kavşak adı, yol numarası ve mesafe bilgisi, sürücünün hangi kavşağa yaklaştığını önceden bildirir. Görseldeki “Düzce Kavşağı”, K.16 kodu ve 2000 m bilgisi, kavşağın iki kilometre ileride olduğunu gösterir. Sürücü güzergâhını önceden planlamalı ve çıkış ya da bağlantı şeridine zamanında geçmelidir.]] },
[3] = { ad = "Otoyol rejimi levhası", aciklama = [[Mavi-kırmızı hız ve yasak sembollerinin birlikte bulunduğu levha, otoyol kesiminde geçerli olan temel trafik düzenini hatırlatır. Görselde 40 ve 120 hız değerleri ile durma, geri dönme veya yaya trafiğine ilişkin yasak sembolleri yer alır. Sürücü, levhadaki her sembolü ayrı bir kural olarak değerlendirmeli ve otoyolun kontrollü giriş-çıkış düzenine uymalıdır.]] },
[4] = { ad = "Acil durum levhaları", aciklama = [[Birden fazla acil yardım ve hizmet sembolünün bulunduğu panel, otoyol üzerindeki acil durum noktalarını ve yardımcı tesisleri gösterir. Telefon, sağlık, itfaiye veya benzeri semboller sürücünün ihtiyaç halinde hangi hizmetlere ulaşabileceğini bildirir. Arıza ya da acil durumda araç güvenli yere alınmalı, bu işaretlerle gösterilen yardım noktalarına yönlendirme takip edilmelidir.]] },
[5] = { ad = "Servis alanı levhaları", aciklama = [[Levhadaki “P” ve hizmet sembolleri, otoyol üzerindeki servis veya dinlenme alanında sunulan imkânları gösterir. Park, tuvalet, telefon, yakıt ya da diğer hizmet sembolleri sürücüye alanda neler bulunabileceği hakkında ön bilgi verir. Uzun yolculuklarda dinlenmek için yalnızca belirtilen servis alanlarına giriniz ve otoyolun ana taşıt yolunda durmayınız.]] },
[6] = { ad = "Park alanı levhası", aciklama = [[Yeşil zemin üzerindeki “Park Alanı” yazısı ve “500 m” mesafe bilgisi, ileride bir park alanı bulunduğunu bildirir. Sürücü park ihtiyacını bu alana göre planlamalı, emniyet şeridinde veya otoyol taşıt yolunda durmamalıdır. Park alanına yaklaşırken yönlendirme işaretlerini ve giriş şeridini takip ediniz.]] },
[7] = { ad = "Başüstü şerit seçimi levhası", aciklama = [[Araç ve şerit bilgilerini içeren yeşil levha, başüstü bir yönlendirme sistemiyle hangi şeridin hangi bağlantıya hizmet ettiğini gösterir. Görseldeki oklar ve araç sembolleri, sürücünün ilerleyeceği güzergâhı ve şerit seçimini önceden yapmasına yardımcı olur. Şerit değiştirmek gerekiyorsa sinyal veriniz, aynaları kontrol ediniz ve son anda manevra yapmayınız.]] },
[8] = { ad = "OGS levhası", aciklama = [[OGS sembolü ve radyo dalgalarını andıran çizgiler, elektronik otoyol geçiş sistemine ait noktayı gösterir. Bu levha, geçiş veya ücretlendirme sistemiyle ilgili bir alan bulunduğunu bildirir; sürücü doğru şeridi takip etmeli ve geçiş için gerekli sistemin etkin olduğundan emin olmalıdır. Gişe ya da geçiş noktasında hız ve şerit düzenine uyunuz.]] },
[9] = { ad = "HGS levhası", aciklama = [[Yeşil levhadaki HGS yazısı, Hızlı Geçiş Sistemi kullanılan geçiş noktasını gösterir. Araç, sistemde tanımlı bir HGS hesabı veya etiketiyle geçiş yapmalıdır; geçiş sırasında şerit ve hız uyarılarına uyulmalıdır. Hesabı veya etiketi bulunmayan araçlar için ilgili otoyol kurallarını ve alternatif geçiş düzenini kontrol ediniz.]] },
[10] = { ad = "Şerit seçimi ve kullanma levhaları", aciklama = [[Üstten görülen yol ve birden fazla yön oku, şeritlerin farklı yön ve güzergâhlara ayrıldığını gösterir. Kırmızı çarpı işareti, ilgili şeridin veya yönün kullanılmaması gerektiğini; açık oklar ise kullanılabilecek yönleri belirtir. Sürücü kavşağa yaklaşmadan önce hedef yönünü seçmeli ve yol çizgileriyle levhadaki okları birlikte takip etmelidir.]] },

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
    -- Otoyol.png içindeki kareler düşük çözünürlüklü olduğundan
    -- doğal boyutlarının üzerine büyütülmeyerek bulanıklık azaltılır.
    return ortak.levhaBoyut(kare, 220, 160, 1.0)
end

function scene:create(event)
    local sceneGroup = self.view

    local ox, oy = math.abs(display.screenOriginX), math.abs(display.screenOriginY)
    local tabBarHeight = composer.getVariable("tabBarHeight") or 0

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
            rowTitle.text = "OTOYOL LEVHALARI (9 LEVHA)"
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
    for i = 1, 10 do
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
    ortak.sabitListeBasligi(sceneGroup, "OTOYOL LEVHALARI (9 LEVHA)", ox, oy)
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
