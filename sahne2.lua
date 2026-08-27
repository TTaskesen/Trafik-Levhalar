--------------------------------------------------------------------------------
--
-- sahne2.lua
--
---------------------------------------------------------------------------------
local widget = require("widget")
local sahneDegis = require("composer")
local ortak = require("levha_ortak")
local sahne = sahneDegis.newScene()
local scrollViewMetin

local levhaResimleriAl =
{
	frames =
	{
		{ --1
			x = 5,
			y = 3,
			width = 163,
			height = 146
		},
		{ --2
			x = 180,
			y = 3,
			width = 163,
			height = 146
		},
		{ --3
			x = 360,
			y = 3,
			width = 163,
			height = 146
		},
		{ --4
			x = 530,
			y = 3,
			width = 163,
			height = 146
		},
		{ --5
			x = 5,
			y = 153,
			width = 163,
			height = 146
		},
		{ --6
			x = 180,
			y = 153,
			width = 163,
			height = 146
		},
		{ --7
			x = 360,
			y = 153,
			width = 163,
			height = 146
		},
		{ --8
			x = 530,
			y = 153,
			width = 163,
			height = 146
		},
		{ --9
			x = 5,
			y = 303,
			width = 163,
			height = 146
		},
		{ --10
			x = 180,
			y = 303,
			width = 163,
			height = 146
		},
		{ --11
			x = 360,
			y = 303,
			width = 163,
			height = 146
		},
		{ --12
			x = 530,
			y = 303,
			width = 163,
			height = 146
		},
		{ --13
			x = 5,
			y = 453,
			width = 163,
			height = 146
		},
		{ --14
			x = 180,
			y = 453,
			width = 163,
			height = 146
		},
		{ --15
			x = 360,
			y = 453,
			width = 163,
			height = 146
		},
		{ --16
			x = 530,
			y = 453,
			width = 163,
			height = 146
		},
		{ --17
			x = 5,
			y = 603,
			width = 163,
			height = 146
		},
		{ --18
			x = 180,
			y = 603,
			width = 163,
			height = 146
		},
		{ --19
			x = 360,
			y = 603,
			width = 163,
			height = 146
		},
		{ --20
			x = 530,
			y = 603,
			width = 163,
			height = 146
		},
		{ --21
			x = 5,
			y = 753,
			width = 163,
			height = 146
		},
		{ --22
			x = 180,
			y = 753,
			width = 163,
			height = 146
		},
		{ --23
			x = 360,
			y = 753,
			width = 163,
			height = 146
		},
		{ --24
			x = 530,
			y = 753,
			width = 163,
			height = 146
		},
		{ --25
			x = 5,
			y = 903,
			width = 163,
			height = 146
		},
		{ --26
			x = 180,
			y = 903,
			width = 163,
			height = 146
		},
		{ --27
			x = 360,
			y = 903,
			width = 163,
			height = 146
		},
		{ --28
			x = 530,
			y = 903,
			width = 163,
			height = 146
		},
		{ --29
			x = 5,
			y = 1053,
			width = 163,
			height = 146
		},
		{ --30
			x = 180,
			y = 1053,
			width = 163,
			height = 146
		},
		{ --31
			x = 360,
			y = 1053,
			width = 163,
			height = 146
		},
		{ --32
			x = 530,
			y = 1053,
			width = 163,
			height = 146
		},
		{ --33
			x = 5,
			y = 1203,
			width = 163,
			height = 146
		},
		{ --34
			x = 180,
			y = 1203,
			width = 163,
			height = 146
		},
		{ --35
			x = 360,
			y = 1203,
			width = 163,
			height = 146
		},
		{ --36
			x = 530,
			y = 1203,
			width = 163,
			height = 146
		},
		{ --37
			x = 5,
			y = 1353,
			width = 163,
			height = 146
		},
		{ --38
			x = 180,
			y = 1353,
			width = 163,
			height = 146
		},
		{ --39
			x = 360,
			y = 1353,
			width = 163,
			height = 146
		},
		{ --40
			x = 530,
			y = 1353,
			width = 163,
			height = 146
		},
		{ --41
			x = 5,
			y = 1503,
			width = 163,
			height = 146
		},
		{ --42
			x = 180,
			y = 1503,
			width = 163,
			height = 146
		},
		{ --43
			x = 360,
			y = 1503,
			width = 163,
			height = 146
		},
		{ --44
			x = 530,
			y = 1503,
			width = 163,
			height = 146
		},
		{ --45
			x = 5,
			y = 1653,
			width = 163,
			height = 146
		},
		{ --46
			x = 180,
			y = 1653,
			width = 163,
			height = 146
		},
		{ --47
			x = 360,
			y = 1653,
			width = 163,
			height = 146
		},
		{ --48
			x = 530,
			y = 1653,
			width = 163,
			height = 146
		},
		{ --49
			x = 5,
			y = 1803,
			width = 163,
			height = 146
		},
		{ --50
			x = 180,
			y = 1803,
			width = 163,
			height = 146
		},
		{ --51
			x = 360,
			y = 1803,
			width = 163,
			height = 146
		},
		{ --52
			x = 530,
			y = 1803,
			width = 163,
			height = 146
		},
	},
}
local resimLevha = graphics.newImageSheet("levha/levha/1-tehlike/tehlike.png",
	levhaResimleriAl)

local levhaTablo = {}

--[[ local function levhaOlustur()
	for i = 1, 4 do
		local yeniLevha = display.newImageRect(sahneGroup, resimLevha, i, 163, 146)
		table.insert(levhaTablo, yeniLevha)
		yeniLevha.myName = "yeni levha" .. i
	end
	return yeniLevha
end ]]
local levhaDetaylari = ortak.levhaAciklamalariniOku("levha/levha/1-tehlike/Tehlike ve Uyari Aciklama.json", 53)

local function metinOlustur(icerik, ustBosluk)
	if scrollViewMetin then
		scrollViewMetin:removeSelf()
		scrollViewMetin = nil
	end
	scrollViewMetin = ortak.metinOlustur(icerik, ustBosluk, 0)
end

function sahne:create(olay)
	local sceneGroup = self.view
	local sahneGroup = display.newGroup()
	sceneGroup:insert(sahneGroup)


	local ox, oy = math.abs(display.screenOriginX), math.abs(display.screenOriginY)
	local tabBarHeight = sahneDegis.getVariable("tabBarHeight")
	local themeID = sahneDegis.getVariable("themeID")

	-- Açık renkli, projeyle uyumlu liste renkleri (tema ne olursa olsun)
	local tableViewColors = ortak.listeRenkleri()

	-- Forward reference for the tableView
	local tableView
	local seciliSatir
	-- Görsel ve geri düğmesi, üst başlık ile açıklama alanı arasındaki
	-- boşlukta üstten ve alttan dengeli dursun.
	local function detayLevhaOlustur(frameIndex)
		local kare = levhaResimleriAl.frames[frameIndex]
		return display.newImageRect(
			sahneGroup,
			resimLevha,
			frameIndex,
			kare.width,
			kare.height
		)
	end

	local yeniLevha = detayLevhaOlustur(1)
	local detayResimY, detayButonY = ortak.detayYerlesimi(yeniLevha.contentHeight)

	yeniLevha.x = display.contentCenterX - 130
	yeniLevha.y = detayResimY
	yeniLevha.myName = "levha"
	yeniLevha.isVisible = false -- Satır seçilene kadar gizli kalsın (arka planda soluk görünmesin)
	sceneGroup:insert(yeniLevha)

	-- Function to return to the tableView
	local function goBack(event)
		local tabBar = sahneDegis.getVariable("tabBar")
		if tabBar then tabBar.isVisible = false end
		if seciliSatir then
			seciliSatir._detayAcildi = false
			seciliSatir = nil
		end
		transition.to(tableView, { x = display.contentWidth * 0.5, time = 600, transition = easing.outQuint })
		transition.to(event.target,
			{ x = display.contentWidth + event.target.contentWidth, time = 480, transition = easing.outQuint })
		transition.to(yeniLevha,
			{
				x = display.contentCenterX + display.contentCenterY,
				time = 480,
				transition = easing.outQuint,
				onComplete = function()
					yeniLevha.isVisible = false
				end
			})
		if scrollViewMetin then
			scrollViewMetin:removeSelf() -- scrollView'u sahneden kaldır
			scrollViewMetin = nil -- Belleği serbest bırak
		end
	end

	-- Back button
	local backButton = ortak.geriDonButonu(goBack, 128, 32)
	backButton.x = 100
	backButton.y = detayButonY
	sceneGroup:insert(backButton)

	-- Handle row rendering
	local function onRowRender(event)
		local phase = event.phase
		local row = event.row
		row._detayAcildi = false
		local groupContentHeight = row.contentHeight

		-- TableView satırları yeniden kullanır. Önceki satırın metin ve görseli
		-- temizlenmezse başka bir levhanın üstünde soluk hayalet içerik kalır.
		for i = row.numChildren, 1, -1 do
			local child = row[i]
			if child and child._levhaSatirOgesi then
				child:removeSelf()
			end
		end

		local kareNo = math.max(1, row.index - 1)
		local rowTitle = display.newText({
			parent = row,
			text = ortak.levhaAdi(levhaDetaylari[row.index].ad),
			x = 0,
			y = 0,
			width = 240,
			font = "Poppins-Medium",
			fontSize = 15,
			align = "left"
		})
		rowTitle._levhaSatirOgesi = true
		local rowResim = display.newImageRect(row, resimLevha, kareNo, 50, 50)
		rowResim._levhaSatirOgesi = true

		rowResim.x = 20
		rowResim.y = groupContentHeight * 0.5
		rowTitle.x = 50
		rowTitle.anchorX = 0
		rowTitle.y = groupContentHeight * 0.5

		if (row.isCategory) then
			rowTitle.isVisible = false
			rowTitle:setFillColor(unpack(row.params.catLabelColor))
			rowTitle.text = ortak.listeBasligi("tehlike", 52)
			rowTitle.font = "Poppins-Bold"
			rowTitle.size = 16
			rowTitle:setFillColor(unpack(row.params.catLabelColor))
			if (rowResim) then -- Kategori satırında resim olmaması için kontrol
				rowResim:removeSelf()
				rowResim = nil
			end
		else
			rowTitle:setFillColor(unpack(row.params.defaultLabelColor))
		end
	end

	-- Handle touches on the row
	local function onRowTouch(event)
		local phase = event.phase
		local row = event.target
		if (phase == "release" or phase == "tap" or phase == "ended")
			and not row.isCategory and not row._detayAcildi then
			row._detayAcildi = true
			seciliSatir = row
			local tabBar = sahneDegis.getVariable("tabBar")
			ortak.tabBarGizle(tabBar)
			yeniLevha.isVisible = true -- Satır seçilince levha resmi görünsün
			-- Görsel ve geri düğmesi aynı yatay merkez çizgisinde dursun.
			yeniLevha.x = display.contentCenterX
			backButton.x = display.contentCenterX
				transition.to(tableView, {
				x = ((display.contentWidth / 2) + ox + ox) * -1,
				time = 600,
				transition = easing
					.outQuint
				})
				transition.to(backButton, { x = display.contentCenterX, time = 750, transition = easing.outQuint })

				if yeniLevha then
					yeniLevha:removeSelf()
				end
				yeniLevha = detayLevhaOlustur(row.index - 1)
				sceneGroup:insert(yeniLevha)
				yeniLevha.x = display.contentCenterX
				yeniLevha.isVisible = true

				local yeniDetayY, yeniButonY, yeniMetinY = ortak.detayYerlesimi(yeniLevha.contentHeight)
			yeniLevha.y = yeniDetayY
			backButton.y = yeniButonY
			local secilenMetin = ortak.levhaAciklamasi(levhaDetaylari[row.index])
			metinOlustur(secilenMetin, yeniMetinY)
			sceneGroup:insert(scrollViewMetin)

			-- Detay açıklaması sonradan eklendiği için tab barın üzerinde
			-- kalmasını ve Ana Sayfa dokunuşunu almasını garanti et.
			local tabBar = sahneDegis.getVariable("tabBar")
			if tabBar then
				tabBar:toFront()
			end
		end
	end
	-- Create a tableView
	tableView = widget.newTableView
		{
			top = -oy,
			left = -ox,
			width = display.contentWidth + ox + ox,
			height = ortak.listeIcerikYuksekligi(oy),
			hideBackground = true,
			onRowRender = onRowRender,
			onRowTouch = onRowTouch,
		}
	sceneGroup:insert(tableView)

	-- Create 75 rows
	for i = 1, 53 do
		local isCategory = false
		local rowHeight = 70
		local rowColor = {
			default = tableViewColors.rowColor.default,
			over = tableViewColors.rowColor.over,
		}


		-- Make some rows categories
		if i == 1 then
			isCategory = true
			rowHeight = 70
			rowColor = {
				default = tableViewColors.catColor.default,
				over = tableViewColors.catColor.over
			}
		end
		-- Insert the row into the tableView
		tableView:insertRow
		{
			isCategory = isCategory,
			rowHeight = rowHeight,
			rowColor = rowColor,
			lineColor = tableViewColors.lineColor,
			params = { defaultLabelColor = tableViewColors.defaultLabelColor, catLabelColor = tableViewColors.catLabelColor }
		}
	end

	ortak.listeGeriDonButonu(sahneGroup, function()
		sahneDegis.gotoScene("sahne1", "fade", 400)
	end)

	ortak.sabitListeBasligi(sceneGroup, ortak.listeBasligi("tehlike", 52), ox, oy)
end

function sahne:show(olay)
	local faz = olay.phase

	if "did" == faz then
		-- Bu kategori sayfasında tab bar kullanılmıyor.
		local tabBar = sahneDegis.getVariable("tabBar")
			ortak.tabBarGizle(tabBar)

		-- remove previous scene's view
		collectgarbage("collect")
	end
end

function sahne:hide(olay)
	local faz = olay.phase
	if "will" == faz then
	elseif "did" == faz then
		-- DİKKAT: removeScene("sahne1") KALDIRILDI.
		-- Ana sayfa butonu ile sahne1'e geçilirken hedef sahne yok
		-- ediliyor ve ilk geçişte boş ekran çıkıyordu.
		sahneDegis.removeScene("sahne2")
	end
end

function sahne:destroy(olay)
	if scrollViewMetin then
		scrollViewMetin:removeSelf(); scrollViewMetin = nil
	end -- Global olanı da temizle
end

---------------------------------------------------------------------------------

-- Listener setup
sahne:addEventListener("create", sahne)
sahne:addEventListener("show", sahne)
sahne:addEventListener("hide", sahne)
sahne:addEventListener("destroy", sahne)

---------------------------------------------------------------------------------

return sahne
