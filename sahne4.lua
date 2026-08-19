--------------------------------------------------------------------------------
--
-- sahne4.lua - Trafik Bilgi İşaretleri
--
--------------------------------------------------------------------------------

local widget = require("widget")
local composer = require("composer")
local ortak = require("levha_ortak")
local scene = composer.newScene()

local scrollViewMetin

local levhaKareleri = {
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
        [89] = { x = 509, y = 3451, width = 168, height = 147 },
    }
}

local resimLevha = graphics.newImageSheet("levha/levha/3-bilgi/bilgi.png", levhaKareleri)

local levhaDetaylari = ortak.levhaAciklamalariniOku("levha/levha/3-bilgi/Bilgi Levhaları Aciklama.json", 90)

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
    local seciliSatir

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
        if seciliSatir then
            seciliSatir._detayAcildi = false
            seciliSatir = nil
        end
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
            text = ortak.levhaAdi(levhaDetaylari[row.index].ad),
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
            rowTitle.text = ortak.listeBasligi("bilgi", 89)
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

        if (phase == "release" or phase == "tap" or phase == "ended") then
            if not row.isCategory and not row._detayAcildi then
                row._detayAcildi = true
                seciliSatir = row
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

                local secilenMetin = ortak.levhaAciklamasi(levhaDetaylari[row.index])
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
    for i = 1, 90 do
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
    ortak.sabitListeBasligi(sceneGroup, ortak.listeBasligi("bilgi", 89), ox, oy)
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
