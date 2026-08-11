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
    [2] = { ad = "Levha 1", aciklama = [[Açıklama eklenecek.]] },
    [3] = { ad = "Levha 2", aciklama = [[Açıklama eklenecek.]] },
    [4] = { ad = "Levha 3", aciklama = [[Açıklama eklenecek.]] },
    [5] = { ad = "Levha 4", aciklama = [[Açıklama eklenecek.]] },
    [6] = { ad = "Levha 5", aciklama = [[Açıklama eklenecek.]] },
    [7] = { ad = "Levha 6", aciklama = [[Açıklama eklenecek.]] },
    [8] = { ad = "Levha 7", aciklama = [[Açıklama eklenecek.]] },
    [9] = { ad = "Levha 8", aciklama = [[Açıklama eklenecek.]] },
    [10] = { ad = "Levha 9", aciklama = [[Açıklama eklenecek.]] },
    [11] = { ad = "Levha 10", aciklama = [[Açıklama eklenecek.]] },
    [12] = { ad = "Levha 11", aciklama = [[Açıklama eklenecek.]] },
    [13] = { ad = "Levha 12", aciklama = [[Açıklama eklenecek.]] },
    [14] = { ad = "Levha 13", aciklama = [[Açıklama eklenecek.]] },
    [15] = { ad = "Levha 14", aciklama = [[Açıklama eklenecek.]] },
    [16] = { ad = "Levha 15", aciklama = [[Açıklama eklenecek.]] },
    [17] = { ad = "Levha 16", aciklama = [[Açıklama eklenecek.]] },
    [18] = { ad = "Levha 17", aciklama = [[Açıklama eklenecek.]] },
    [19] = { ad = "Levha 18", aciklama = [[Açıklama eklenecek.]] },
    [20] = { ad = "Levha 19", aciklama = [[Açıklama eklenecek.]] },
    [21] = { ad = "Levha 20", aciklama = [[Açıklama eklenecek.]] },
    [22] = { ad = "Levha 21", aciklama = [[Açıklama eklenecek.]] },
    [23] = { ad = "Levha 22", aciklama = [[Açıklama eklenecek.]] },
    [24] = { ad = "Levha 23", aciklama = [[Açıklama eklenecek.]] },
    [25] = { ad = "Levha 24", aciklama = [[Açıklama eklenecek.]] },
    [26] = { ad = "Levha 25", aciklama = [[Açıklama eklenecek.]] },
    [27] = { ad = "Levha 26", aciklama = [[Açıklama eklenecek.]] },
    [28] = { ad = "Levha 27", aciklama = [[Açıklama eklenecek.]] },
    [29] = { ad = "Levha 28", aciklama = [[Açıklama eklenecek.]] },
    [30] = { ad = "Levha 29", aciklama = [[Açıklama eklenecek.]] },
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

    self.backButton = widget.newButton {
        width = 128,
        height = 32,
        label = "Geri Dön",
        onRelease = goBack
    }
    self.backButton.x = 100
    self.backButton.y = detayButonY
    sceneGroup:insert(self.backButton)

    local function onRowRender(event)
        local row = event.row
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
            width = 240,
            font = "Poppins-Medium",
            fontSize = 15,
            align = "left"
        })
        rowTitle.anchorX = 0
        rowTitle.x = 80
        rowTitle.y = groupContentHeight * 0.5
        rowTitle._levhaSatirOgesi = true

        if (row.isCategory) then
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

        if ("release" == phase) then
            if not row.isCategory then
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
