--------------------------------------------------------------------------------
--
-- sahne5.lua - Duraklama ve Park İşaretleri
--
--------------------------------------------------------------------------------

local widget = require("widget")
local composer = require("composer")
local ortak = require("levha_ortak")
local scene = composer.newScene()

local scrollViewMetin

local levhaKareleri = {
    sheetContentWidth = 698,
    sheetContentHeight = 300,
    frames = {
        [1] = { x = 2, y = 2, width = 170, height = 146 },
        [2] = { x = 176, y = 2, width = 170, height = 146 },
        [3] = { x = 350, y = 2, width = 170, height = 146 },
        [4] = { x = 524, y = 2, width = 170, height = 146 },
        [5] = { x = 2, y = 152, width = 170, height = 146 },
        [6] = { x = 176, y = 152, width = 170, height = 146 },
        [7] = { x = 350, y = 152, width = 170, height = 146 },
    }
}

local resimLevha = graphics.newImageSheet("levha/levha/4-durma-park/durma-park.jpg", levhaKareleri)

local levhaDetaylari =
{
    [1] = { ad = "", aciklama = "" },
    [2] = { ad = "(P-1) Park etmek yasaktır", aciklama = [[Bu işaretin bulunduğu yerde park etmek (araçtan inip kalkmak dahil) yasaktır.]] },
    [3] = { ad = "(P-2) Duraklamak ve park etmek yasaktır", aciklama = [[Bu işaretin bulunduğu yerde duraklamak ve park etmek yasaktır.]] },
    [4] = { ad = "(P-3a) Park yeri", aciklama = [[Bu alanın araç park etmeye ayrıldığını gösterir.]] },
    [5] = { ad = "(P-3b) Park yeri", aciklama = [[Bu alanın araç park etmeye ayrıldığını gösterir.]] },
    [6] = { ad = "(P-3c) Park yeri", aciklama = [[Bu alanın araç park etmeye ayrıldığını gösterir.]] },
    [7] = { ad = "(P-3d) Park yeri", aciklama = [[Bu alanın araç park etmeye ayrıldığını gösterir.]] },
    [8] = { ad = "(P-3e) Park yeri", aciklama = [[Bu alanın araç park etmeye ayrıldığını gösterir.]] },
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
    return ortak.levhaBoyut(kare, 380, 220, 2.5)
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
            fontSize = row.isCategory and 16 or 15,
            font = row.isCategory and "Poppins-Bold" or "Poppins-Medium",
            width = math.max(1, display.contentWidth - 92),
            align = "left"
        })
        rowTitle.anchorX = 0
        rowTitle.x = 80
        rowTitle.y = groupContentHeight * 0.5
        rowTitle._levhaSatirOgesi = true

        if (row.isCategory) then
            rowTitle.isVisible = false
            rowTitle:setFillColor(unpack(row.params.catLabelColor))
            rowTitle.text = "DURAKLAMA ve PARK İŞARETLERİ (7 LEVHA)"
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
    for i = 1, 8 do
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
    ortak.sabitListeBasligi(sceneGroup, "DURAKLAMA VE PARK ETME İŞARETLERİ (7 LEVHA)", ox, oy)
end

function scene:show(event)
    local phase = event.phase
    if "did" == phase then
        local tabBar = composer.getVariable("tabBar")
        ortak.tabBarGizle(tabBar)
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
