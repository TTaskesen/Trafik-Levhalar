-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------
-- hide device status bar
display.setStatusBar( display.HiddenStatusBar )

-- Set the background to white
display.setDefault( "background", 1 )	-- white

-- require controller module
local sahneDegis = require ("composer")

local widget = require ("widget")
local ortak = require ("levha_ortak")

local temaIdleri = {
	"widget_theme_android_holo_dark",
	"widget_theme_android_holo_light",
	"widget_theme_android",
	"widget_theme_ios7",
	--"widget_theme_ios", 
}
local function widgetleriGoster( widgetTemaNumarasi )

	local ekranBilgileri = ortak.ekranBilgileri()

	if ( temaIdleri[widgetTemaNumarasi] ~= "auto" ) then
		-- Set theme based on user selection
		widget.setTheme( temaIdleri[widgetTemaNumarasi] )

		-- Store theme in Composer variable for use elsewhere
		sahneDegis.setVariable( "themeID", temaIdleri[widgetTemaNumarasi] )
		
		-- Proje arka planı: açık renkli düz zemin (tab yazıları ve içerik net görünsün)
		display.setDefault( "background", 0.93, 0.95, 0.97, 1 )
	end

	local tabBar
	local tabButtonWidth = display.contentWidth / 4
	local function anaSayfayaGit()
		-- Ana Sayfa sekmesine her dokunuşta ana menüyü aç.
		-- Mevcut sahne kontrolü yapılmıyor; böylece detay/listeden
		-- sekmeye yeniden dokunmak da sahne1'e dönüşü garanti eder.
		sahneDegis.gotoScene("sahne1", "fade", 400)
	end

	-- Create buttons table for the tabBar
	local tabButtons = 
	{
		{
			label = "Ana Sayfa",
			width = tabButtonWidth,
			onPress = anaSayfayaGit,
			selected = true
		},
		{
			label = "Levha Tarihi",
			width = tabButtonWidth,
			onPress = function() sahneDegis.gotoScene( "sahne8" ); end,
		},
		{
			label = "Bilgi",
			width = tabButtonWidth,
			onPress = function() sahneDegis.gotoScene( "sahne9" ); end,
		},
		{
			label = "Hakkımızda",
			width = tabButtonWidth,
			onPress = function() sahneDegis.gotoScene( "sahne10" ); end,
		}
	}
	tabBar = widget.newTabBar
	{
		left = 0,
		top = display.contentHeight,
		width = display.contentWidth,
		buttons = tabButtons
	}
	tabBar.isHitTestable = true

	-- Widget tam yüklendikten sonra yüksekliği ve konumu doğru okunur;
	-- hemen okunduğunda height 0 dönebildiği için ertelenmiş ayar yapılır.
	local altGuvenlikBoslugu = math.max(40, ekranBilgileri.bottomInset)
	local function tabBarAyarla()
		local h = tabBar.contentHeight or tabBar.height
		if not h or h == 0 then
			h = 50
		end
		tabBar.y = ekranBilgileri.safeBottom - altGuvenlikBoslugu - (h / 2)
		-- Sahnelere, tab bar üst kenarının biraz üzerinde durmaları için pay eklenmiş yükseklik ver
		sahneDegis.setVariable( "tabBarHeight", h + altGuvenlikBoslugu )
	end
	tabBarAyarla()
	timer.performWithDelay( 100, tabBarAyarla )
	-- Sahne içerikleri sonradan oluşturulsa bile tab bar her zaman
	-- en üst katmanda kalsın. Detay sayfalarında görünürlük false ise
	-- gizli kalır; geri dönüldüğünde yeniden öne alınır.
	timer.performWithDelay( 250, function()
		if tabBar and tabBar.isVisible then
			tabBar:toFront()
		end
		return true
	end, 0)

	-- Store tabBar in Composer variable
	sahneDegis.setVariable( "tabBar", tabBar )

	-- Start at giris (karşılama ekranı)
	sahneDegis.gotoScene( "giris" )
end

-- Soru sormadan doğrudan Android teması ile başla (Android Dark)
widgetleriGoster( 1 )


-- load first scene
--sahneDegis.gotoScene( "sahne1", "fade", 400 )

--
-- Display objects added below will not respond to composer transitions
--

-- table to setup tabBar buttons
--[[ local tabButtons = 
{
	{ 
		width = 32,
		height = 32,
		defaultFile = "icon1.png",
		overFile = "icon1-down.png",
		label = "Birinci",
		selected = true,
	},
	{ 
		width = 32,
		height = 32,
		defaultFile = "icon2.png",
		overFile = "icon2-down.png",
		label = "İkinci",
	},
}

-- create the actual tabBar widget
local tabBar = widget.newTabBar
{
	top = display.contentHeight - 20,
	width = display.contentWidth,
	backgroundFile = "tabbar.png",
	tabSelectedLeftFile = "tabBar_tabSelectedLeft.png",
	tabSelectedMiddleFile = "tabBar_tabSelectedMiddle.png",
	tabSelectedRightFile = "tabBar_tabSelectedRight.png",
	tabSelectedFrameWidth = 20,
	tabSelectedFrameHeight = 52,
	buttons = tabButtons
} ]]
