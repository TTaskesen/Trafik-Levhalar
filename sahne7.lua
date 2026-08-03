--------------------------------------------------------------------------------
--
-- sahne7.lua
--
---------------------------------------------------------------------------------

local sahneDegis = require("composer")
local sahne = sahneDegis.newScene()

local widget = require("widget")

local resim, resim1, yazi1, yazi2, yazi3, yazi4, zamanSay

local myText =
[[Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque semper mollis erat a interdum. Praesent tristique diam in nulla varius, nec aliquet mauris posuere. Suspendisse pretium risus lacus, commodo lacinia sapien dictum et. Sed non varius felis. Curabitur elementum tortor non libero pulvinar, at convallis lectus varius. Interdum et malesuada fames ac ante ipsum primis in faucibus. Curabitur sit amet nunc congue, molestie erat vel, facilisis turpis. Morbi vitae diam ligula. Suspendisse purus turpis, commodo in aliquam id, lobortis a sapien. Sed at libero porta, aliquam odio nec, porta dui. In a congue velit. Aliquam ac quam feugiat, ultricies metus nec, porta neque. Phasellus posuere mollis magna, ac vestibulum ligula congue id. Pellentesque imperdiet aliquam lacus, ac pellentesque dui eleifend nec. Suspendisse auctor vehicula facilisis. Pellentesque id massa tincidunt neque luctus varius.

Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Maecenas sit amet dapibus nulla. Suspendisse ut risus nulla. Maecenas varius elit non faucibus fermentum. Fusce rhoncus, nisl et varius tristique, enim felis egestas purus, et feugiat lorem urna a augue. Maecenas non pulvinar tortor. Aenean condimentum nibh id eros fringilla viverra. Fusce condimentum urna ut volutpat porttitor. Nunc tincidunt congue ligula.

Duis placerat felis varius, convallis massa sed, volutpat magna. Sed vitae viverra neque. Integer ac sollicitudin libero, at ornare purus. Aliquam egestas hendrerit tellus. Aliquam eu elit vitae lorem lacinia tempus. Proin vel dictum mi. Maecenas porttitor, justo a dictum volutpat, nisl libero dictum ligula, vitae posuere urna elit a quam. Nam arcu metus, semper suscipit pellentesque ac, tempor ut arcu. Vestibulum eu nibh erat. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Sed semper sollicitudin lorem, vel commodo libero commodo eget. Proin lacinia euismod elit vitae porttitor. Proin ipsum neque, dictum at dictum eu, egestas malesuada turpis. Nulla eros lectus, adipiscing eget velit sed, malesuada aliquam ipsum. Curabitur et egestas massa. Vestibulum luctus est est, tincidunt viverra nisi vulputate id.

Integer lobortis tellus eu ligula viverra egestas. Quisque commodo, massa vel pretium imperdiet, nisl enim euismod justo, sed ultricies lacus mi ut nisi. Maecenas molestie vitae magna non interdum. In gravida ornare orci in vulputate. Praesent suscipit lobortis dui ut interdum. Proin pulvinar metus ligula, a malesuada nunc interdum at. Aenean et scelerisque enim. Integer eget congue sapien. Etiam suscipit mauris neque, id semper quam volutpat vel. Proin venenatis dictum felis quis ultricies. Suspendisse feugiat mi congue ante gravida, id accumsan leo mollis. Lorem ipsum dolor sit amet, consectetur adipiscing elit. In hac habitasse platea dictumst. Nulla facilisi.

Nam arcu mauris, convallis sit amet dictum consequat, imperdiet at mi. Vestibulum velit erat, accumsan sit amet vehicula vitae, tempor id nisi. Quisque eu tellus vulputate nisi vestibulum tincidunt at vitae tellus. Quisque sed pretium nisl. Vivamus a aliquet purus. Integer pulvinar neque in dapibus pharetra. Quisque convallis urna vulputate ligula mattis dictum. Vivamus pharetra molestie nunc, ac rhoncus dolor euismod at. Cras fringilla sollicitudin sapien vel sagittis. Donec dignissim scelerisque mi nec pulvinar. Mauris at metus gravida, lacinia dolor quis, vehicula lacus. Donec a pellentesque tellus. Praesent sit amet lorem nisl. Pellentesque interdum felis quis vehicula vestibulum. Donec ut dolor tortor.
]]



local function yaziyaDokun(olay)
	if olay.phase == "began" then
		sahneDegis.gotoScene("sahne1", "fade", 400)

		return true
	end
end

function sahne:create(olay)
	local sceneGroup = self.view

	resim = display.newImage("bg3.jpg")
	resim.x = display.contentCenterX
	resim.y = display.contentCenterY

	sceneGroup:insert(resim)

	--resim.touch = sahneyeDokun

	yazi1 = display.newText("SAĞA TEHLİKELİ VİRAJ", 0, 0, native.systemFontBold, 16)
	yazi1:setFillColor(255)
	yazi1.x, yazi1.y = display.contentWidth * 0.5, 50
	sceneGroup:insert(yazi1)
	yazi1:addEventListener("touch", yaziyaDokun)

	--[[ yazi2 = display.newText( "SAĞA TEHLİKELİ VİRAJ SAĞA TEHLİKELİ VİRAJ SAĞA TEHLİKELİ VİRAJ", 0, 0, native.systemFontBold, 16 )
	yazi2:setFillColor( 255 )
	yazi2.x, yazi2.y = display.contentWidth * 0.5, 260
	sceneGroup:insert( yazi2 ) ]]

	resim1 = display.newImageRect("levha/logo.png", 150, 150)
	resim1.x = display.contentCenterX
	resim1.y = display.contentCenterY - 100
	sceneGroup:insert(resim1)



	--[[ yazi3 = display.newText( "MemUsage: ", 0, 0, native.systemFont, 14 )
	yazi3:setFillColor( 255 )
	yazi3.x, yazi3.y = display.contentWidth * 0.5, display.contentHeight * 0.5
	sceneGroup:insert( yazi3 )
	
	yazi4 = display.newText( "Touch to continue", 0, 0, native.systemFontBold, 14 )
	yazi4:setFillColor( 255 ); yazi4.isVisible = false
	yazi4.x, yazi4.y = display.contentWidth * 0.5, display.contentHeight - 100
	sceneGroup:insert( yazi4 ) ]]


	local scrollView = widget.newScrollView(
		{
			top = 230,
			left = 0,
			width = display.contentWidth,
			height = display.contentHeight - 230 - (sahneDegis.getVariable("tabBarHeight") or 0),
			horizontalScrollDisabled = true
		})

	local paragraphs = {}
	local paragraph
	local tmpString = myText

	local yStart = 10
	local mainPadding = 10

	repeat
		paragraph, tmpString = string.match(tmpString, "([^\n]*)\n(.*)")
		paragraphs[#paragraphs + 1] = display.newText({ text = paragraph, width = scrollView.width - (mainPadding * 2), fontSize = 14 })
		paragraphs[#paragraphs].anchorX = 0
		paragraphs[#paragraphs].anchorY = 0
		paragraphs[#paragraphs].x = mainPadding
		paragraphs[#paragraphs].y = yStart
		paragraphs[#paragraphs]:setFillColor(0)
		scrollView:insert(paragraphs[#paragraphs])
		yStart = yStart + paragraphs[#paragraphs].height
	until tmpString == nil or string.len(tmpString) == 0

	scrollView:setScrollHeight(scrollView:getView().height + (mainPadding * 2))
	sceneGroup:insert(scrollView)


	print("\n2: create olay")
end

function sahne:show(olay)
	local faz = olay.phase

	if "did" == faz then
		print("2: show olay, faz did")

		-- remove previous scene's view
		sahneDegis.removeScene("sahne2")
		collectgarbage("collect")

		-- Update Lua memory text display
		--[[ local hafizaGoster = function()
			resim:addEventListener( "touch", resim )
			yazi4.isVisible = true
			yazi3.text = yazi3.text .. string.format("%.2g", collectgarbage("count")/1000) .. "MB"
			yazi3.x = display.contentWidth * 0.5
		end
		zamanSay = timer.performWithDelay( 1000, hafizaGoster, 1 ) ]]
	end
end

function sahne:hide(olay)
	local faz = olay.phase
	if "will" == faz then
		print("2: hide olayı, faz will")

		-- cancel timer
		--timer.cancel( zamanSay ); zamanSay = nil;

		-- reset label text
		--yazi2.text = "MemUsage: "
	elseif "did" == faz then
		sahneDegis.removeScene("sahne7")
	end
end

function sahne:destroy(olay)
	print("((sahne 6 yok ediliyor)")
end

---------------------------------------------------------------------------------

-- Listener setup
sahne:addEventListener("create", sahne)
sahne:addEventListener("show", sahne)
sahne:addEventListener("hide", sahne)
sahne:addEventListener("destroy", sahne)

---------------------------------------------------------------------------------

return sahne
