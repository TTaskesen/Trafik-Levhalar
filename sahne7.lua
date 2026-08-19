--------------------------------------------------------------------------------
--
-- sahne7.lua
--
---------------------------------------------------------------------------------

local sahneDegis = require("composer")
local ortak = require("levha_ortak")
local dil = require("dil")
local sahne = sahneDegis.newScene()

local widget = require("widget")

local resim, resim1, yazi1, yazi2, yazi3, yazi4, zamanSay

local myText =
[[
SIFIR NOKTASI

—— Bölüm 1: İlk Sinyal ——

Dr. Eylül, laboratuvarından dışarı fırladığında İstanbul'un üzerinde tek bir bulut bile yoktu.

Gökyüzü, bu saatlerde hiç olmadığı kadar temizdi; o kadar temiz ki güneş, binaların camlarından geri dönen ışıkla birlikte şehri ikinci kez aydınlatıyor gibiydi. Ama Eylül bunları görmedi. Onun gözleri, elindeki tablette yanıp sönen kırmızı grafiğe kilitlenmişti: sıcaklık, son on dakikada üç buçuk derece düşmüştü.

"Bu mümkün değil," diye mırıldandı. Nefesi, sabah soğuğunda değil; korkudan buharlaşmıştı.

Arkasında, laboratuvarın cam kapısının üstündeki dijital saat 06:47'yi gösteriyordu. İçeride, altı ay boyunca gece gündüz üzerinde çalıştığı deney düzeneği vardı: manyetik alanın, atmosferin yüksek katmanlarındaki su buharı üzerindeki etkisini ölçmek için tasarlanmış dev bir halka. O halka, sabah 06:40'ta, kendi kendine açılmıştı.

Ve şimdi, İstanbul'un üzerinde tek bir bulut yokken, sıcaklık düşüyordu.

Eylül, sağır edici sessizliğin içinde sokağa adımını attığında ilk çığlığı duydu. Sonra ikincisini. Sonra, bir anda, onlarcasını.

Boğaz'ın üzerinde, gökyüzünde ince bir çizgi belirmişti. Beyaz değildi, mavimsiydi; sanki biri, gök kubbenin dokusunu iki parmağıyla kavrayıp ayırmıştı. Çizgiden aşağıya, ağır ağır, kar yağıyordu.

Ama bu karın taneleri yere düşmüyordu. Denizin yüzeyine değdikleri yerde duruyor, birikir, donuyor ve orada, suyun üstünde kalıyorlardı. Boğaz, bir saat içinde, yürünebilir bir beyaza dönüştü.

Eylül, laboratuvarına geri koştu. Tableti masanın üstüne bıraktı, halkaya yaklaştı ve ekrandaki son veriyi okudu. O anda, bilim insanı olarak bildiği her şeyi bir kenara bırakıp, sadece bir insan gibi düşündü:

"Bunu ben yapmadım. Peki ya biri yaptıysa?"

Dışarıda, İstanbul artık eski İstanbul değildi. Şehrin her yerinde insanlar durmuş, gökyüzündeki mavimsi çizgiye bakıyordu. Bazıları dua ediyor, bazıları telefonla birilerine ulaşmaya çalışıyor, bazıları ise — çoğunluk onlardı — susuyordu.

Çünkü o çizginin altındaki kar, yalnızca Boğaz'a değil; her yere yağıyordu. Ama kimse bunun ne olduğunu bilmiyordu.

Eylül biliyordu. En azından bir kısmını.

Halkada, deneyden önce olması gereken enerji değerinin tam on iki katı ölçülmüştü. On iki kat. Ve o enerjinin kaynağı, dünyanın herhangi bir yerinde üretilemezdi — İstanbul'un altında, binlerce yıldır hiç kimsenin açmadığı bir kapı olduğunu o anda anladı.

"Sıfır noktası," dedi sesli. Kelimeleri ağzında buz gibi soğudu.

Ve dışarıda, ilk kez, kar taneleri yere ulaştı.

—— Bölüm 2: Beyaz Sessizlik ——

İlk kar tanesi yere değdiğinde, Eylül hâlâ laboratuvarındaydı.

Onu duymadı. Ama kısa bir süre sonra, tüm İstanbul'u örten o sessizliği duydu. Sessizlik, sirenlerin ve çığlıkların ortasında bile, betonların arasından süzülen bir akşam gibiydi. Herkes durmuş, aynı göğe bakıyordu. Ne araba sesi vardı, ne vapur düdüğü, ne kuş sesi. Kentin sesi, buzun içinde sıkışmış gibiydi.

Eylül, karın diz hizasına ulaştığı saatin içinde dışarı çıktı.

Bu kar erimiyordu. Güpeğündüz olmasına rağmen, değdiği her yüzeyde duruyor, birikiyor, donuyordu. Sanki bir el, şehrin üzerine, sabırla ve soğuk bir özenle, uçsuz bir örtü seriyordu.

Eylül, laboratuvarın önündeki arabaya koştu. Motor çalışmadı; yakıt donmuştu. Telefonla önce koordinasyon merkezini, sonra tesisi, sonra arkadaşlarını aradı. Kimse yanıt vermedi. Ekranda yalnızca "Çağrı gönderildi" yazısı ve yavaşça düşen sıcaklık değeri vardı: üç, iki, bir...

Çizginin altında, İstanbul nefes almıyordu.

Ve işte o sırada Eylül, buz tutmuş Boğaz'ın yüzeyinde yürüyen birini gördü. Bir kadın. Ayak izi bırakmadan, kayıyormuş gibi ilerliyordu. Uzun paltosunun etekleri, karın üzerinde kırışıksız bir iz çiziyordu.

Kadın durdu ve Eylül'e doğru döndü. Yüzü uzaktan seçilmiyordu. Ama Eylül o duruştan bir şeyi anladı: bu kadın tesadüfen gelmemişti; bir şey arıyordu.

Ve Eylül, aradığı şeyin deney halkası olabileceğini düşündü.

Laboratuvara geri koştu. Kapıyı kilitledi, perdeyi kapattı ve ölçüm değerini açtı: on iki kat. Rakam hâlâ sabit duruyordu. Eylül o an, o enerjinin ne deneyden ne de bu dünyanın bildiği kaynaklardan geldiğini kesin olarak gördü. O enerji, İstanbul'un altındaki sıfır noktasından geliyordu.

Ve sıfır noktasının kilidini açan şey, o kadın olabilirdi.

Bir saniye, iki saniye... Eylül o an, karın içinde ilerleyen kadının ne bir hayalet ne bir kurtarıcı görmediğini anladı. Bu, bir varlıktı; bir insan, bir araç, bir mekanizma — hangisi olduğu belirsizdi. Ve gökyüzündeki mavimsi çizginin aslında ne olduğunu ilk kez kavradı: bir çizgi değil, bir işaretti.

Dışarıda, kar yağmaya devam ediyordu. Ve o kar, zamanın üzerine çekilen bir çentik gibi, dünyanın ilk sıfırından itibaren her şeyi yeniden saymaya başlamıştı.

—— Bölüm 3: Kapı ——

Eylül, geceyi laboratuvarda geçirdi.

Sıcaklık, gece yarısını geçtiğinde bir derece daha düştü ve sonra durdu — tıpkı birinin termometreye bakıp sabırla beklediği gibi. Dışarıda kar, diz boyundan göğüs hizasına varan bir birikintinin içinde hareketsizdi; rüzgâr yoktu, araba yoktu, kuş yoktu. Şehir, donmuş bir fotoğraf gibiydi.

Eylül gözlerini açtığında o kadını düşündü. Ayak izi bırakmadan yürüyen kadın. Bir fizikçi için bu görüntü, çözülmesi gereken bir bilmeceden çok daha ötesiydi: o kadın, Eylül'ün yirmi yıldır aradığı sorunun cevabı gibi duruyordu. İstanbul'un altında, yüzyıllardır kimsenin açmadığı bir kapı vardı ve o kadın bunu biliyordu.

İlk bilinçli adım, laboratuvarın en eski servis asansörüyle başladı.

Asansör, kırk metrelik bir inişten sonra durdu. Kapılar açıldığında, Eylül'ü yeri sarsan bir sessizlik karşıladı. Ayaklarının altında, İstanbul'un antik haritalarındaki desenlere benzeyen dev bir çember vardı. Bu, hiçbir arşivde geçmeyen bir katmandı.

Eylül, çemberin ortasına yürüdü. Duvarlarda, tanımadığı bir alfabeyle yazılmış satırlar vardı. Kimi yazılar tarih gibiydi, kimi uyarı.

O alanda soluk beklerken, taşın içinden tok ve uzak bir ses geldi. Çemberin ortasındaki bir karonun etrafında, önce ince bir çatlak belirdi.

Eylül geri çekildi. Yer, kendiliğinden açılıyordu — düzenli, ağır, neredeyse saygılı bir hareketle. Bu bir kapıydı; ama bir dilek değil, bir ağızdı. Genişledi, aşağıya, İstanbul'un derinliklerine doğru bir boşluk açtı.

Eylül kapının ağzında durdu ve içeri indi.

Aşağıda, çok uzun bir merdiven vardı. İki yanında, buz gibi parlayan raflarda, billur kaplar içinde nesneler diziliydi. Bazıları tanıdık şekildi; bazıları hiçbir dile, hiçbir çağa, hiçbir coğrafyaya ait değildi.

Merdivenin sonunda çift bir kapı. Üzerinde, yazıların yalnızca bir kısmı İstanbul'un dilleriydi: "ÖLÇÜM — SICAKLIK — SIFIR".

Ve kapının tam ortasında, kadının paltosunun kolundan kopmuş küçük bir kumaş parçası, bir sigara izmariti gibi değil; bir davet gibi, Eylül'e bakıyordu.

Eylül kapıyı itti.

Kapı, hiçbir zorluk yaşatmadan, kendiliğinden açıldı.

Ve içeride, sıfırınucu bekliyordu.

—— Bölüm 4: Sıfırın İçi ——

İçeride, beklediği hiçbir şey yoktu.

Ne makineler vardı, ne tüpler, ne bir laboratuvarın çelik titizliği. Sıfır noktası, evrenin bir köşesinden koparılıp buraya taşınmış gibiydi. Tavan yok gibiydi; ışık, yukarıdaki karanlığın ta içinden süzülüyordu. Yer, bastığı her noktada usulca parlıyordu.

Odanın ortasında bir adam oturuyordu.

Yaşı belli değildi. Derisi kireç gibi parlıyordu. Gözleri kapalıydı. Odadaki bütün sessizlik, bir mıknatısın önündeki toz gibi, adama doğru akıyordu.

Eylül bir adım attı. Adam gözlerini açmadı.

"Buraya nasıl girdiniz?" diye sordu. Sesi, taşların içinde boğuldu.

Adam dudaklarını oynatmadı ama konuştu: "Herkes üzerinde yaşadığı toprağı bilmez. Ama İstanbul'un kapısı, bir kez açılır. O da yalnızca doğru kişiye."

Zemin, adamın sözüyle birlikte aydınlandı. Eylül, parlayan çizgilerin arasında denizleri, dağları, göğü gördü. "Bunlar nedir?"

Adanın gözleri açıldı. "Bunlar, ilk sıfır yazıldığında toprağın, kendine sorduğu soruların cevaplarıdır. Dünyaya örülmüş bir saat."

Ve tam o anda kapının ağzından bir ses geldi:

"Sen gelmeden önce, bunların hepsini bir bekleyişin parçası sanan tek kişi bendim."

Eylül arkasına döndü. Kadın, kapıda duruyordu. Paltosu kıpırtısızdı.

"Hoş geldin," dedi kadın. "On yıldır beni 'sıfırın bekçisi' diye bilirler. Gerçek adım Vefa."

Eylül, tabletini elinden bırakıp adımında ona yaklaştı. "O deney benimdi," dedi. "Onu altı ay ben çalıştım. O sabah kendiliğinden açıldı. Ben çalışmadım."

Vefa gülümsedi. "Senin gelişin bir kaza değildi. Kapı, doğru anahtarı bekledi."

"Anahtar?" dedi Eylül. "Ben neyim ki?"

"O anahtarın sen olduğunu," dedi Vefa, "deneyin sonucundan başka hiçbir şey kanıtlayamaz."

Ve o anda, zeminin altından tok bir ses yükseldi. Eylül ayaklarının altına baktı: çember dönüyordu.
]]

local function hikayeyiDileUyarla(metin)
	-- Türkçe metin zaten bu dosyada bulunduğu için hikaye_tr.txt aranmaz.
	-- Böylece eksik kaynak dosyası nil döndürüp io.open hatasına yol açmaz.
	if dil.kodu() ~= "tr" then
		local dosyaYolu = system.pathForFile(
			"Sifir Noktasi/hikaye_" .. dil.kodu() .. ".txt",
			system.ResourceDirectory
		)
		if dosyaYolu then
			local dilDosyasi = io.open(dosyaYolu, "r")
			if dilDosyasi then
				local yerelMetin = dilDosyasi:read("*a")
				dilDosyasi:close()
				if yerelMetin and #yerelMetin > 0 then
					return yerelMetin
				end
			end
		end
	end

	metin = metin:gsub("SIFIR NOKTASI", dil.metin("hikaye_basligi"))
	metin = metin:gsub("—— Bölüm 1: İlk Sinyal ——", dil.metin("hikaye_bolum1"))
	metin = metin:gsub("—— Bölüm 2: Beyaz Sessizlik ——", dil.metin("hikaye_bolum2"))
	metin = metin:gsub("—— Bölüm 3: Kapı ——", dil.metin("hikaye_bolum3"))
	metin = metin:gsub("—— Bölüm 4: Sıfırın İçi ——", dil.metin("hikaye_bolum4"))
	return metin
end



local function yaziyaDokun(olay)
	if olay.phase == "began" then
		sahneDegis.gotoScene("sahne1", "fade", 400)

		return true
	end
end

function sahne:create(olay)
	local sceneGroup = self.view
	local ustSinir = display.safeScreenOriginY or display.screenOriginY or 0

	-- Sıfır Noktası hikâyesi için uzay atmosferli arka plan.
	local arkaPlan = display.newImageRect(
		sceneGroup,
		"levha/bg.jpg",
		display.contentWidth,
		display.contentHeight
	)
	arkaPlan.x = display.contentCenterX
	arkaPlan.y = display.contentCenterY

	-- Açık metnin arka planda okunabilmesi için hafif karartma katmanı.
	local metinKontrast = display.newRect(
		sceneGroup,
		display.contentCenterX,
		display.contentCenterY,
		display.contentWidth,
		display.contentHeight
	)
	metinKontrast:setFillColor(0, 0, 0, 0.48)

	--resim.touch = sahneyeDokun

	local baslikKontrast = display.newRoundedRect(
		sceneGroup,
		display.contentCenterX,
		ustSinir + 20,
		220,
		42,
		10
	)
	baslikKontrast:setFillColor(0.02, 0.04, 0.12, 0.88)

	yazi1 = display.newText(dil.metin("hikaye_basligi"), 0, 0, "Poppins-Bold", 16)
	yazi1:setFillColor(1, 1, 1)
	yazi1.x, yazi1.y = display.contentCenterX, ustSinir + 20
	sceneGroup:insert(yazi1)
	yazi1:addEventListener("touch", yaziyaDokun)

	--[[ yazi2 = display.newText( "SAĞA TEHLİKELİ VİRAJ SAĞA TEHLİKELİ VİRAJ SAĞA TEHLİKELİ VİRAJ", 0, 0, native.systemFontBold, 16 )
	yazi2:setFillColor( 255 )
	yazi2.x, yazi2.y = display.contentWidth * 0.5, 260
	sceneGroup:insert( yazi2 ) ]]

	resim1 = display.newImageRect("levha/logo.png", 80, 80)
	resim1.x = display.contentCenterX
	resim1.y = ustSinir + 100
	sceneGroup:insert(resim1)



	--[[ yazi3 = display.newText( "MemUsage: ", 0, 0, native.systemFont, 14 )
	yazi3:setFillColor( 255 )
	yazi3.x, yazi3.y = display.contentWidth * 0.5, display.contentHeight * 0.5
	sceneGroup:insert( yazi3 )
	
	yazi4 = display.newText( "Touch to continue", 0, 0, native.systemFontBold, 14 )
	yazi4:setFillColor( 255 ); yazi4.isVisible = false
	yazi4.x, yazi4.y = display.contentWidth * 0.5, display.contentHeight - 100
	sceneGroup:insert( yazi4 ) ]]


	local oy7 = math.abs(display.screenOriginY)
	local scrollView = widget.newScrollView(
		{
			top = ustSinir + 148,
			left = 0,
			width = display.contentWidth,
			height = display.contentHeight + oy7 - 148 - (sahneDegis.getVariable("tabBarHeight") or 0),
			horizontalScrollDisabled = true,
			backgroundColor = { 0, 0, 0, 0 }
		})

	local paragraphs = {}
	local paragraph
	local tmpString = hikayeyiDileUyarla(myText)

	local yStart = 10
	local mainPadding = 10

	repeat
		paragraph, tmpString = string.match(tmpString, "([^\n]*)\n(.*)")
		paragraphs[#paragraphs + 1] = display.newText({ text = paragraph, width = scrollView.width - (mainPadding * 2), fontSize = 16, font = "Poppins-Medium" })
		paragraphs[#paragraphs].anchorX = 0
		paragraphs[#paragraphs].anchorY = 0
		paragraphs[#paragraphs].x = mainPadding
		paragraphs[#paragraphs].y = yStart
		paragraphs[#paragraphs]:setFillColor(1, 1, 1)
		scrollView:insert(paragraphs[#paragraphs])
		yStart = yStart + paragraphs[#paragraphs].height + 5
	until tmpString == nil or string.len(tmpString) == 0

	scrollView:setScrollHeight(scrollView:getView().height + (mainPadding * 2))
	sceneGroup:insert(scrollView)


end

function sahne:show(olay)
	local faz = olay.phase

	if "did" == faz then
		local tabBar = sahneDegis.getVariable("tabBar")
		ortak.tabBarGoster(tabBar)

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

		-- cancel timer
		--timer.cancel( zamanSay ); zamanSay = nil;

		-- reset label text
		--yazi2.text = "MemUsage: "
	elseif "did" == faz then
		sahneDegis.removeScene("sahne7")
	end
end

function sahne:destroy(olay)
end

---------------------------------------------------------------------------------

-- Listener setup
sahne:addEventListener("create", sahne)
sahne:addEventListener("show", sahne)
sahne:addEventListener("hide", sahne)
sahne:addEventListener("destroy", sahne)

---------------------------------------------------------------------------------

return sahne
