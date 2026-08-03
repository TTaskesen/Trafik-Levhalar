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

local json = require( "json" )

local temaIdleri = {
	"widget_theme_android_holo_dark",
	"widget_theme_android_holo_light",
	"widget_theme_android",
	"widget_theme_ios7",
	--"widget_theme_ios", 
}
local temaAdlari = {
	"Android Dark",
	"Android Normal",
	"Android",
	"iOS",
}

local function widgetleriGoster( widgetTemaNumarasi )

	local ekranGenisligiYarisi= display.contentCenterX
	local ekranYuksekligiYarisi = display.contentCenterY
	local ekranGenisligi, ekranYuksekligi = math.abs(display.screenOriginX), math.abs(display.screenOriginY)

	if ( temaIdleri[widgetTemaNumarasi] ~= "auto" ) then
		-- Set theme based on user selection
		widget.setTheme( temaIdleri[widgetTemaNumarasi] )

		-- Store theme in Composer variable for use elsewhere
		sahneDegis.setVariable( "themeID", temaIdleri[widgetTemaNumarasi] )
		
		-- Proje arka planı: açık renkli düz zemin (tab yazıları ve içerik net görünsün)
		display.setDefault( "background", 0.93, 0.95, 0.97, 1 )
	end

	-- Create buttons table for the tabBar
	local tabButtons = 
	{
		{
			label = "Ana Sayfa",
			onPress = function()
				if sahneDegis.getSceneName("current") ~= "sahne1" then
					sahneDegis.gotoScene("sahne1")
				end
			end,
			selected = true
		},
		{
			label = "Levha Tarihi",
			onPress = function() sahneDegis.gotoScene( "sahne8" ); end,
		},
		{
			label = "Bilgi",
			onPress = function() sahneDegis.gotoScene( "sahne9" ); end,
		},
		{
			label = "Hakkımızda",
			onPress = function() sahneDegis.gotoScene( "sahne10" ); end,
		}
	}
	local tabBar = widget.newTabBar
	{
		top = display.contentHeight,
		width = display.contentWidth+ekranGenisligi+ekranGenisligi,
		buttons = tabButtons
	}
	tabBar.x = ekranGenisligiYarisi

	-- Widget tam yüklendikten sonra yüksekliği ve konumu doğru okunur;
	-- hemen okunduğunda height 0 dönebildiği için ertelenmiş ayar yapılır.
	local altGuvenlikBoslugu = 40 -- Gerçek cihazın alt tuşlarına (nav bar / home göstergesi) çarpmaması için pay
	local function tabBarAyarla()
		local h = tabBar.contentHeight or tabBar.height
		if not h or h == 0 then
			h = 50
		end
		tabBar.y = display.contentHeight - altGuvenlikBoslugu - (h / 2) + ekranYuksekligi
		-- Sahnelere, tab bar üst kenarının biraz üzerinde durmaları için pay eklenmiş yükseklik ver
		sahneDegis.setVariable( "tabBarHeight", h + altGuvenlikBoslugu )
	end
	tabBarAyarla()
	timer.performWithDelay( 100, tabBarAyarla )

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
