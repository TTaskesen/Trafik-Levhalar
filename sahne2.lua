--------------------------------------------------------------------------------
--
-- sahne2.lua
--
---------------------------------------------------------------------------------
local widget = require("widget")
local sahneDegis = require("composer")
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

local levhaKareIndeksleri = {}
for i = 1, 52 do
	levhaKareIndeksleri[i] = i
end
local levhaSpriteKareleri = {
	{ name = "levhalar", frames = levhaKareIndeksleri }
}

local levhaTablo = {}

--[[ local function levhaOlustur()
	for i = 1, 4 do
		local yeniLevha = display.newImageRect(sahneGroup, resimLevha, i, 163, 146)
		table.insert(levhaTablo, yeniLevha)
		yeniLevha.myName = "yeni levha" .. i
	end
	return yeniLevha
end ]]
local levhaDetaylari =
{
    [1]  = { ad = "", aciklama = "" },
    [2] = { ad = "Sağa Tehlikeli Viraj", aciklama = [[Tehlikeli viraj veya birbirini izleyen tehlikeli virajlar, yukarıda verilen işaret levhalarının uygun olanlarından birisi ile belirtilir. 
Levhanın dikileceği yer, kurbun tanjant noktasından itibaren Tablo :9 da verilen değerlerde olmalı ve levhanın konulduğu kesim dikkate alınarak, viraj veya virajların ilk dönüşü sağa ise (T-1a veya T-2a) nolu
sola ise (T-1b veya T- 2b) nolu işaret levhalarından birisi konulmalıdır.]] },
    [3] = { ad = "Sola Tehlikeli Viraj", aciklama = [[Tehlikeli viraj veya birbirini izleyen tehlikeli virajlar, yukarıda verilen işaret levhalarının uygun olanlarından birisi ile belirtilir. 
Levhanın dikileceği yer, kurbun tanjant noktasından itibaren Tablo :9 da verilen değerlerde olmalı ve levhanın konulduğu kesim dikkate alınarak, viraj veya virajların ilk dönüşü sağa ise (T-1a veya T-2a) nolu
sola ise (T-1b veya T- 2b) nolu işaret levhalarından birisi konulmalıdır.]] },
    [4] = { ad = "Sağa Tehlikeli Devamlı Virajlar", aciklama = [[Tehlikeli viraj veya birbirini izleyen tehlikeli virajlar, yukarıda verilen işaret levhalarının uygun olanlarından birisi ile belirtilir. 
Levhanın dikileceği yer, kurbun tanjant noktasından itibaren Tablo :9 da verilen değerlerde olmalı ve levhanın konulduğu kesim dikkate alınarak, viraj veya virajların ilk dönüşü sağa ise (T-1a veya T-2a) nolu
sola ise (T-1b veya T- 2b) nolu işaret levhalarından birisi konulmalıdır.]] },
    [5] = { ad = "Sola Tehlikeli Devamlı Virajlar", aciklama = [[Tehlikeli viraj veya birbirini izleyen tehlikeli virajlar, yukarıda verilen işaret levhalarının uygun olanlarından birisi ile belirtilir. 
Levhanın dikileceği yer, kurbun tanjant noktasından itibaren Tablo :9 da verilen değerlerde olmalı ve levhanın konulduğu kesim dikkate alınarak, viraj veya virajların ilk dönüşü sağa ise (T-1a veya T-2a) nolu
sola ise (T-1b veya T- 2b) nolu işaret levhalarından birisi konulmalıdır.]] },
    [6] = { ad = "Tehlikeli Eğim (İniş)", aciklama = [[Bu işaret levhaları, tehlikeli olduğu düşünülen iniş yada çıkış eğimli yol kesimlerini gösterir ve özellikle kamyon vb büyük 
araç sürücülerinin vites düşürmeleri gerektiğini bildirir. Uyarı levhası üzerinde belirtilen eğim derecesi uyarıya konu olan yol kesiminin ortalama eğimi olmalıdır.]] },
    [7] = { ad = "Tehlikeli Eğim (Çıkış)", aciklama = [[Bu işaret levhaları, tehlikeli olduğu düşünülen iniş yada çıkış eğimli yol kesimlerini gösterir ve özellikle kamyon vb büyük 
araç sürücülerinin vites düşürmeleri gerektiğini bildirir. Uyarı levhası üzerinde belirtilen eğim derecesi uyarıya konu olan yol kesiminin ortalama eğimi olmalıdır.]] },
    [8] = { ad = "İki taraftan daralan kaplama", aciklama = [[Bu işaretler, devamlı veya geçici nedenlerle yol kaplamasının her iki taraftan veya sağdan-soldan önlem almaksızın yan yana geçemeyebilecekleri kesimleri belirtmek amacı ile kullanılmalıdır.
Bölünmüş yollarda yapılan çalışmalardaki daralmalarda bölünmüş yollardan iki yönlü yollara geçişlerdeki daralmalarda bu işaret levhaları kullanılmaz.Ancak bölünmüş yollarda köprü ve benzeri nedenlerle bankette daralma varsa (YB-4a,b,c,d)nolu levhalar yerine 
(T-4a,b,c)nolu işaret levhalarından uygun olanı kullanılmalıdır.]] },
    [9] = { ad = "Sağdan daralan daralan kaplama", aciklama = [[Bu işaretler, devamlı veya geçici nedenlerle yol kaplamasının her iki taraftan veya sağdan-soldan önlem almaksızın yan yana geçemeyebilecekleri kesimleri belirtmek amacı ile kullanılmalıdır.
Bölünmüş yollarda yapılan çalışmalardaki daralmalarda bölünmüş yollardan iki yönlü yollara geçişlerdeki daralmalarda bu işaret levhaları kullanılmaz.Ancak bölünmüş yollarda köprü ve benzeri nedenlerle bankette daralma varsa (YB-4a,b,c,d)nolu levhalar yerine 
(T-4a,b,c)nolu işaret levhalarından uygun olanı kullanılmalıdır.]] },
    [10] = { ad = "Soldan daralan kaplama", aciklama = [[Bu işaretler, devamlı veya geçici nedenlerle yol kaplamasının her iki taraftan veya sağdan-soldan önlem almaksızın yan yana geçemeyebilecekleri kesimleri belirtmek amacı ile kullanılmalıdır.
Bölünmüş yollarda yapılan çalışmalardaki daralmalarda bölünmüş yollardan iki yönlü yollara geçişlerdeki daralmalarda bu işaret levhaları kullanılmaz.Ancak bölünmüş yollarda köprü ve benzeri nedenlerle bankette daralma varsa (YB-4a,b,c,d)nolu levhalar yerine 
(T-4a,b,c)nolu işaret levhalarından uygun olanı kullanılmalıdır.]] },
    [11] = { ad = "açılan köprü", aciklama = [[Bu işaret levhası, karayolu üzerindeki trafiği engelleyecek şekilde açılabilen köprüleri bildirmek için kullanılabilir.]] },
    [12] = { ad = "Deniz veya nehir kıyısında biten yol", aciklama = [[Bu işaret levhası, yolun deniz ya da nehir kıyısında son bulduğunu ve taşıtların
suya düşme tehlikesinin olduğu uyarısında bulunur. Bu işaret levhası rıhtımları
belirtmek için de kullanılabilir. ]] },
    [13] = { ad = "kasisli yol", aciklama = [[Bu işaret levhası, taşıtların daha önceki yol şartlarına göre normal hızlarını
düşürmedikleri takdirde, taşıtları tehlikeye düşürebilecek hendek, kasis, çukur ve
benzeri üst yapı bozukluklarını uyarmak için kullanılır. Kaplama ile köprüler
arasındaki trafik güvenliğini tehlikeye düşürebilecek kot farkları da bu işaret levhası
ile bildirilebilir.
Eğer bozuk olan yol kesimi 100 metreden daha uzun ise bozuk olan kesimin
uzunluğu ilave bir panelle (PL-1) gösterilmelidir. (Ör. 150-800 m gibi)
Gerekli görüldüğü hallerde bu işaret levhası, Azami Hız Sınırlaması levhaları ile
birlikte kullanılabilir.
 Bozuk olan yol kesimi onarıldıktan sonra bu işaret levhası derhal kaldırılmalıdır.]] },
    [14] = { ad = "Kaygan yol", aciklama = [[Bu trafik işaret levhası, yol yüzeyinin kaygan olduğu hakkında uyarıda bulunur ve
sürücülerin fren yapmamaları, hızlanmamaları ve ani manevralar yapmamaları
gerektiğini bildirir.
Normal olarak bu işaret levhasının yol kaplamasının geçici olarak kayganlaştığı
yerler ve/veya koşullarda uyarıda bulunmak için kullanılması gerekir. Bununla birlikte,
kaplamadaki aşınma nedeniyle yağmurlu havalarda ya da siste kayganlaşan yol
kesimlerinde, bu işaret kaplama yenileninceye kadar kalıcı olarak kullanılmalı ve PL7 ilave bir panellerinden şemsiye figürlü olanı ile pekiştirilmelidir. Ancak, aşınma
bulunmayan bir yol kesiminde, yağmur veya sis nedeniyle yolun kaygan olduğu işaret
levhası ile belirtilmez. Ayrıca, kar nedeniyle kaygan yol işaret levhası
kullanılmamalıdır.
Uyarının yolun uzun bir kesimini ilgilendirmesi halinde, işaret levhasının altına
uyarıya konu kesimin uzunluğunu belirten ilave bir panel (PL-1) konulmalıdır
(Örneğin 200 m -1.5 km gibi).
 Yoldaki geçici kayganlığın sona erdirilmesinden sonra bu levha derhal
kaldırılmalıdır.]] },
    [15] = { ad = "Gevşek Malzemeli zemin", aciklama = [[Bu işaret levhası, taşıt yolu üzerinde gevşek malzeme olduğunu ve öndeki
araçlardan taş sıçrayabileceğini bildirir.
Bu işaret levhası, sathi kaplama işlemi yapıldıktan sonra yol üzerinde gevşek
malzeme kalmış olması halinde kullanılır. Ayrıca beklenmeyen bir şekilde gevşek
malzeme ortaya çıkan diğer durumlarda da kullanılabilir.
Bu işaret levhası, yolun bir kesiminde normalden fazla miktarda gevşek malzeme
olsa dahi, hiç bir zaman stabilize yollarda kullanılmamalıdır.
Uyarının yolun uzun bir kesimini ilgilendirmesi halinde, işaret levhasının altına
uyarıya konu kesimin uzunluğunu belirten ilave bir panel (PL-1) konulmalıdır
(Örneğin 200 m -1.5 km gibi). Bu gibi hallerde uyarı her kilometrede ve kavşaklardan
sonra tekrarlanmalıdır.]] },
    [16] = { ad = "Gevşek şev", aciklama = [[ Bu işaret levhası, yarma şevinden taşıt yolu üzerine taş ve kaya parçaları
yuvarlanabileceğini ve/veya kaplama üzerinde taş ve kaya parçaları olabileceğini
gösterir. Sürücülerin bu işaret ile belirtilen kesime yaklaşırken yavaşlamaları ancak
bu kesimde durmamaları ve park etmemeleri gerektiğini bildirir.
Yarma şevinin yola nazaran durumuna göre levha içindeki sembolün yönü
değiştirilebilir.
Uyarının yolun uzun bir kesimini ilgilendirmesi halinde, işaret levhasının altına
uyarıya konu kesimin uzunluğunu belirten ilave bir panel (PL-1) konulmalıdır.]] },
    [17] = { ad = "Yaya geçidi", aciklama = [[Bu işaret levhaları, ileride yaya geçidi olduğu uyarısında bulunur.
Bu işaret levhalarının, normal olarak şehir içlerinde B-14a nolu Yaya Geçidi
levhasının ön uyarısı olarak kullanımına gerek bulunmamaktadır. Ancak, görüş
koşulları sınırlı ise ya da işletme hızı 50 km/saatin üzerinde ise, bu işaret levhası kent
içi alanlarda da kullanılabilir.
İşletme hızlarının yüksek olduğu kesimlerde yaya geçidi oluşturmak için işletme
hızının 50 km / saat’e düşürülmesi gerekir.]] },
    [18] = { ad = "Okul geçidi", aciklama = [[Bu işaret levhası, okul ya da oyun alanları gibi çocukların sık sık geçtiği yol
kesimlerini belirtmek için kullanılır. Bu işaret levhasını gören sürücüler hızlarını
düşürmeli ve ani bir duruş için hazırlıklı olmalıdırlar.
Bu işaret levhasının, sadece okul bahçeleri ya da oyun alanları çıkışlarının bir yol
ya da cadde ile doğrudan bağlantılı olduğu durumlarda geçiş yerlerine konan B-14b
nolu işaret levhasının ön uyarısı olarak kullanılması gerekir.
Hızın düşük olduğu şehir içi alanlarda, bu işaret levhasının kullanımına gerek
bulunmamaktadır. Bu durumlarda, sadece B-14b nolu Okul Geçidi bilgi levhasının
kullanılması yeterlidir. Bununla birlikte, görüş imkanı zayıf ise ya da işletme hızı 50
km/saatin üzerinde ise, bu işaretin kullanılması gerekir.
Çocuklar için yol güvenliğinin artırılması amacıyla bu tehlike uyarı işareti ile
birlikte 30 km / saat gibi bir hız sınırı işareti de konulabilir.]] },
    [19] = { ad = "Bisiklet geçebilir", aciklama = [[Bu işaret levhası, bir bisiklet yolunun bu işaretin konulduğu yola bağlandığını ya
da bisikletlilerin yol eksenini dik olarak karşıya geçebilecekleri kesimleri belirtmek için
kullanılabilir.]] },
    [20] = { ad = "Ehil hayvanlar geçebilir", aciklama = [[Bu işaret levhaları, yol üzerinde bir hayvan olabileceğini ve/veya hayvanların
geçiş yaptıkları bir kesim olduğunu ve aynı zamanda kaplama üzerinde kir ve çamur
olabileceğini belirtmek için kullanılır.
Ehli hayvanların geçiş yapabilecekleri kesimler (T-14a) nolu, vahşi hayvanların
geçebilecekleri kesimlerde (T-14b) nolu işaret levhası ile belirtilmelidir.
Uyarının yolun uzun bir kesimini ilgilendirmesi halinde, işaret levhasının altına
uyarıya konu kesimin uzunluğunu belirten ilave bir panel (PL-1) konulmalıdır.]] },
    [21] = { ad = "Vahşi hayvanlar geçebilir", aciklama = [[Bu işaret levhaları, yol üzerinde bir hayvan olabileceğini ve/veya hayvanların
geçiş yaptıkları bir kesim olduğunu ve aynı zamanda kaplama üzerinde kir ve çamur
olabileceğini belirtmek için kullanılır.
Ehli hayvanların geçiş yapabilecekleri kesimler (T-14a) nolu, vahşi hayvanların
geçebilecekleri kesimlerde (T-14b) nolu işaret levhası ile belirtilmelidir.
Uyarının yolun uzun bir kesimini ilgilendirmesi halinde, işaret levhasının altına
uyarıya konu kesimin uzunluğunu belirten ilave bir panel (PL-1) konulmalıdır.]] },
    [22] = { ad = "Yolda çalışma", aciklama = [[Bu işaret levhası, ilerideki yol kesiminde yol çalışmasının olduğunu, kaplama
üzerinde kir ve/veya çamur nedeniyle yol yüzeyinin kaygan olabileceğini belirtir.
Yolda çalışma işaret levhalarının her zaman, yolun her iki tarafına konulması ve
bunların sarı zeminli dörtgen bir levhanın içinde olması gerekir.
Bu işaret levhasının konulduğu kesim ile çalışma mahalli arasındaki mesafe ilave
bir panelle (500 m -1.5 km gibi) belirtilebilir.
Yolda yapılan çalışmaların kaza tehlikesini artırması nedeniyle, işaret levhalarının
konulduğu yer ve durum son derece önemlidir. Bu bakımdan, tam olarak
görülebilmeleri için en iyi konuma yerleştirilmeleri gerekir. Yolda çalışma olduğu
uyarısında bulunan trafik işaret levhaları, daima temiz ve iyi durumda tutulmalıdır.
Yansıtıcı yüzeylerinin hasar görmesi halinde bu levhalar yenisi ile değiştirilmelidir.
Yukarıda sözü edilen bütün tedbirler önemli olup bunlara yolda çalışma yapılan
kesimlerde kullanılan diğer trafik kontrol cihazları da dahildir.]] },
    [23] = { ad = "Işıklı işaret cihazı", aciklama = [[Bu işaret levhası, ışıklı işaret cihazları ile kontrol edilen kavşakları belirtmek için
kullanılabilir.
Bu işaret levhası, sürücülerin beklemedikleri kesimlerdeki ışıklı işaretle yönetilen
kavşakları belirtmek amacıyla kullanılmalıdır. Dolayısıyla, normal olarak bu işaret
levhasının ışıklı işaret cihazlarının yaygın olduğu şehir içinde kullanılmaması,
şehirlere girişteki ilk ışıklı işaretle yönetilen kavşaklardan önce kullanılması gerekir.
Bu işaretin kullanıldığı kavşaklarda, ayrıca diğer kavşak uyarı işaretlerinin
kullanımına gerek bulunmamaktadır.]] },
    [24] = { ad = "Havaalanı-havalimanı(Alçak Uçuş)", aciklama = [[Bu işaret levhası, karayolu üzerinden alçaktan geçen uçakların olabileceğini ve
sürücülerin bu kesimlerde ani gürültülere karşı hazırlıklı olmaları gerektiğini bildirir.
Havaalanı levhası, havaalanı-havalimanı yakınlarındaki karayolları üzerinde,
karayoluna yakın mesafede alçaktan uçan uçaklar olması durumunda kullanılabilir.
Uyarının yolun uzun bir kesimini ilgilendirmesi halinde, işaret levhasının altına
uyarıya konu kesimin uzunluğunu belirten ilave bir panel (PL-1) konulmalıdır.
İşaret levhası içindeki sembol ters çevrilebilir.]] },
    [25] = { ad = "Yandan rüzgar", aciklama = [[Bu işaret levhaları, sık sık yandan kuvvetli rüzgar esen yüksek köprüler, dolgular
vb. yol kesimlerini belirtmek için kullanılabilir. Bu işaret levhası, aynı zamanda
sürücülerin hızlarını düşürmeleri ve önlerindeki araçları geçmekten kaçınmaları
gerektiğini bildirir.
Uyarının yolun uzun bir kesimini ilgilendirmesi halinde, işaret levhasının altına
uyarıya konu kesimin uzunluğunu belirten ilave bir panel (PL-1) konulmalıdır.
İşaret levhası içindeki sembol ters çevrilebilir.]] },
    [26] = { ad = "İki yönlü trafik", aciklama = [[Bu işaret levhası, iki yönlü trafiğin işlediği yol kesimlerini belirtir.
İki Yönlü Trafik levhası, tek yönlü yol kesiminin geçici ya da sürekli olarak iki
yönlü yola dönüştüğü zaman kullanılır.]] },
    [27] = { ad = "Dikkat", aciklama = [[Bu işaret levhası, tehlike uyarı işaretleri (T Grubu) ile belirlenen tehlikeler dışında
kalan diğer tehlikeler hakkında uyarıda bulunmak amacıyla kullanılabilir. 
Dikkat levhası ile belirtilen tehlikenin cinsi mutlaka ilave bir panelle belirtilmelidir.
 Bu işaret levhası, tehlike uyarı işaretleri ile belirtilen tehlikelere veya trafik
tanzim işaretleri ile verilen yasaklama ve kısıtlamalara dikkat çekmek için
kullanılamaz. Ayrıca, tali yoldan veya bir mülkten çıkabilecek araçları uyarmak için
de (İş Makineleri Çıkabilir – Askeri Araç Çıkabilir vb. gibi) bu işaret levhası
kullanılmamalıdır.]] },
    [28] = { ad = "Kontrolsüz kavşak", aciklama = [[Bu işaret levhası, ileride genel geçiş önceliği kuralının yürürlükte olduğu, diğer bir
ifadeyle sağdan gelmekte olan araçların ilk geçiş hakkına sahip olduğu ve hızın
düşürülmesi gerektiği kontrolsüz kavşakları bildirmek için kullanılabilir.]] },
    [29] = { ad = "Anayol-tali yol kavşaklarının işaretlenmesi", aciklama = [[Bu işaret levhaları, bir tali yol kavşağına yaklaşılmakta olduğunu, bu işaretin
kullanıldığı yoldaki trafiğin ilk geçiş hakkına sahip bulunduğunu ve tali yoldan
yaklaşmakta olan sürücülerin ana yola girmeden önce yol vermelerinin veya
durmalarının gerekli olduğunu bildirir.
 Bu işaret levhalarının kullanıldığı kavşaklarda, tali yoldaki araç sürücüleri için TT1 nolu Yol Ver veya TT-2 nolu Dur işaret levhalarından uygun olanı konulmalıdır.
 Bu işaret levhaları, aynı zamanda öndeki taşıtı geçmenin yasak olduğunu
belirttiğinden, bu işaret levhaları ile birlikte TT-27 nolu Öndeki Taşıtı Geçmek
Yasaktır işaret levhası kullanılmaz. Ayrıca, ana yol üzerinde B-38 nolu Ana Yol işaret levhası ya da B-1a nolu Kavşak
Öncesi Yön Levhası kullanılmışsa, bu levhaların kullanımına gerek yoktur. Ancak, bu
işaretlerden hangisi kullanılırsa kullanılsın tali yolda TT-1 nolu Yol Ver veya TT-2
nolu Dur işaret levhalarından uygun olanı konulmalıdır.
Ana yol-tali yol kavşaklarının işaretlenmesinde kullanılacak sembol, yoldaki
mevcut durumunu yansıtmalıdır. Yani ana yol, Şekil 10’da olduğu gibi ise bu işaret
levhalarından uygun olanı kullanılabilir. Ancak, ana yolun doğru giden güzergah
olmaması durumunda, bu işaret levhaları yerine uygun ilave panelle B-38 nolu Ana
Yol işaret levhası kullanılmalıdır.]] },
    [30] = { ad = "Anayol-tali yol kavşaklarının işaretlenmesi", aciklama = [[Bu işaret levhaları, bir tali yol kavşağına yaklaşılmakta olduğunu, bu işaretin
kullanıldığı yoldaki trafiğin ilk geçiş hakkına sahip bulunduğunu ve tali yoldan
yaklaşmakta olan sürücülerin ana yola girmeden önce yol vermelerinin veya
durmalarının gerekli olduğunu bildirir.
 Bu işaret levhalarının kullanıldığı kavşaklarda, tali yoldaki araç sürücüleri için TT1 nolu Yol Ver veya TT-2 nolu Dur işaret levhalarından uygun olanı konulmalıdır.
 Bu işaret levhaları, aynı zamanda öndeki taşıtı geçmenin yasak olduğunu
belirttiğinden, bu işaret levhaları ile birlikte TT-27 nolu Öndeki Taşıtı Geçmek
Yasaktır işaret levhası kullanılmaz. Ayrıca, ana yol üzerinde B-38 nolu Ana Yol işaret levhası ya da B-1a nolu Kavşak
Öncesi Yön Levhası kullanılmışsa, bu levhaların kullanımına gerek yoktur. Ancak, bu
işaretlerden hangisi kullanılırsa kullanılsın tali yolda TT-1 nolu Yol Ver veya TT-2
nolu Dur işaret levhalarından uygun olanı konulmalıdır.
Ana yol-tali yol kavşaklarının işaretlenmesinde kullanılacak sembol, yoldaki
mevcut durumunu yansıtmalıdır. Yani ana yol, Şekil 10’da olduğu gibi ise bu işaret
levhalarından uygun olanı kullanılabilir. Ancak, ana yolun doğru giden güzergah
olmaması durumunda, bu işaret levhaları yerine uygun ilave panelle B-38 nolu Ana
Yol işaret levhası kullanılmalıdır.]] },
    [31] = { ad = "Anayol-tali yol kavşaklarının işaretlenmesi", aciklama = [[Bu işaret levhaları, bir tali yol kavşağına yaklaşılmakta olduğunu, bu işaretin
kullanıldığı yoldaki trafiğin ilk geçiş hakkına sahip bulunduğunu ve tali yoldan
yaklaşmakta olan sürücülerin ana yola girmeden önce yol vermelerinin veya
durmalarının gerekli olduğunu bildirir.
 Bu işaret levhalarının kullanıldığı kavşaklarda, tali yoldaki araç sürücüleri için TT1 nolu Yol Ver veya TT-2 nolu Dur işaret levhalarından uygun olanı konulmalıdır.
 Bu işaret levhaları, aynı zamanda öndeki taşıtı geçmenin yasak olduğunu
belirttiğinden, bu işaret levhaları ile birlikte TT-27 nolu Öndeki Taşıtı Geçmek
Yasaktır işaret levhası kullanılmaz. Ayrıca, ana yol üzerinde B-38 nolu Ana Yol işaret levhası ya da B-1a nolu Kavşak
Öncesi Yön Levhası kullanılmışsa, bu levhaların kullanımına gerek yoktur. Ancak, bu
işaretlerden hangisi kullanılırsa kullanılsın tali yolda TT-1 nolu Yol Ver veya TT-2
nolu Dur işaret levhalarından uygun olanı konulmalıdır.
Ana yol-tali yol kavşaklarının işaretlenmesinde kullanılacak sembol, yoldaki
mevcut durumunu yansıtmalıdır. Yani ana yol, Şekil 10’da olduğu gibi ise bu işaret
levhalarından uygun olanı kullanılabilir. Ancak, ana yolun doğru giden güzergah
olmaması durumunda, bu işaret levhaları yerine uygun ilave panelle B-38 nolu Ana
Yol işaret levhası kullanılmalıdır.]] },
    [32] = { ad = "Anayol-tali yol kavşaklarının işaretlenmesi", aciklama = [[Bu işaret levhaları, bir tali yol kavşağına yaklaşılmakta olduğunu, bu işaretin
kullanıldığı yoldaki trafiğin ilk geçiş hakkına sahip bulunduğunu ve tali yoldan
yaklaşmakta olan sürücülerin ana yola girmeden önce yol vermelerinin veya
durmalarının gerekli olduğunu bildirir.
 Bu işaret levhalarının kullanıldığı kavşaklarda, tali yoldaki araç sürücüleri için TT1 nolu Yol Ver veya TT-2 nolu Dur işaret levhalarından uygun olanı konulmalıdır.
 Bu işaret levhaları, aynı zamanda öndeki taşıtı geçmenin yasak olduğunu
belirttiğinden, bu işaret levhaları ile birlikte TT-27 nolu Öndeki Taşıtı Geçmek
Yasaktır işaret levhası kullanılmaz. Ayrıca, ana yol üzerinde B-38 nolu Ana Yol işaret levhası ya da B-1a nolu Kavşak
Öncesi Yön Levhası kullanılmışsa, bu levhaların kullanımına gerek yoktur. Ancak, bu
işaretlerden hangisi kullanılırsa kullanılsın tali yolda TT-1 nolu Yol Ver veya TT-2
nolu Dur işaret levhalarından uygun olanı konulmalıdır.
Ana yol-tali yol kavşaklarının işaretlenmesinde kullanılacak sembol, yoldaki
mevcut durumunu yansıtmalıdır. Yani ana yol, Şekil 10’da olduğu gibi ise bu işaret
levhalarından uygun olanı kullanılabilir. Ancak, ana yolun doğru giden güzergah
olmaması durumunda, bu işaret levhaları yerine uygun ilave panelle B-38 nolu Ana
Yol işaret levhası kullanılmalıdır.]] },
    [33] = { ad = "Anayol-tali yol kavşaklarının işaretlenmesi", aciklama = [[Bu işaret levhaları, bir tali yol kavşağına yaklaşılmakta olduğunu, bu işaretin
kullanıldığı yoldaki trafiğin ilk geçiş hakkına sahip bulunduğunu ve tali yoldan
yaklaşmakta olan sürücülerin ana yola girmeden önce yol vermelerinin veya
durmalarının gerekli olduğunu bildirir.
 Bu işaret levhalarının kullanıldığı kavşaklarda, tali yoldaki araç sürücüleri için TT1 nolu Yol Ver veya TT-2 nolu Dur işaret levhalarından uygun olanı konulmalıdır.
 Bu işaret levhaları, aynı zamanda öndeki taşıtı geçmenin yasak olduğunu
belirttiğinden, bu işaret levhaları ile birlikte TT-27 nolu Öndeki Taşıtı Geçmek
Yasaktır işaret levhası kullanılmaz. Ayrıca, ana yol üzerinde B-38 nolu Ana Yol işaret levhası ya da B-1a nolu Kavşak
Öncesi Yön Levhası kullanılmışsa, bu levhaların kullanımına gerek yoktur. Ancak, bu
işaretlerden hangisi kullanılırsa kullanılsın tali yolda TT-1 nolu Yol Ver veya TT-2
nolu Dur işaret levhalarından uygun olanı konulmalıdır.
Ana yol-tali yol kavşaklarının işaretlenmesinde kullanılacak sembol, yoldaki
mevcut durumunu yansıtmalıdır. Yani ana yol, Şekil 10’da olduğu gibi ise bu işaret
levhalarından uygun olanı kullanılabilir. Ancak, ana yolun doğru giden güzergah
olmaması durumunda, bu işaret levhaları yerine uygun ilave panelle B-38 nolu Ana
Yol işaret levhası kullanılmalıdır.]] },
    [34] = { ad = "Sağdan anayola giriş", aciklama = [[Bu işaretler, tek yönlü ve bölünmüş yola katılan yan yollar veya köprülü
kavşakların bağlantı yollarını bildirmek için kullanılır. Aynı yönde birden fazla şeridi
bulunan yollarda yolun yalnızca kastedilen kenarında kullanılması yeterlidir.]] },
    [35] = { ad = "Soldan anayola giriş", aciklama = [[Bu işaretler, tek yönlü ve bölünmüş yola katılan yan yollar veya köprülü
kavşakların bağlantı yollarını bildirmek için kullanılır. Aynı yönde birden fazla şeridi
bulunan yollarda yolun yalnızca kastedilen kenarında kullanılması yeterlidir.]] },
    [36] = { ad = "Dönel kavşak yaklaşımı", aciklama = [[Bu işaret levhası, ilerideki dönel kavşak olduğunu belirtmek amacı ile
kullanılabilir. Bu tehlike uyarı işareti, görüş olanağının sınırlı olduğu ya da dönel
kavşağın başka bir nedenden dolayı tehlike arz ettiği durumda kullanılabilir. Bu işaret
levhasının kullanılmasının gerekli olup olmadığı değerlendirilirken T-21 nolu
Kontrolsüz Kavşak işaret levhası kapsamındaki tablo haline getirilmiş olan değerler
uygulanabilir.
Ayrıca yön levhalarından yararlanmak sureti ile de bir dönel kavşak hakkında bilgi
verme imkanı göz önünde bulundurulmalıdır. Başka bir değişle dönel kavşak
yaklaşımında kavşak öncesi yön levhası kullanılmış olması halinde bu işaret
levhasının kullanımına gerek yoktur.]] },
    [37] = { ad = "Kontrollü demiryolu geçidi", aciklama = [[Bu işaret levhası, demiryolu hattının her iki tarafında bariyer veya benzeri bir
sistemle kontrol edilen bir hemzemin geçit bulunduğunu bildirir.
Kontrollü Demiryolu Geçidi levhasının “Hemzemin Demiryolu Geçidi Yaklaşım
Levhası” ile birlikte kullanılması gerekir. İlave bir uyarıya gerek görülmediği takdirde
yolun sağında kullanılan T-28a nolu levhanın üstünde kullanılır. (Bkz. Şekil 13)
 Demiryolu geçitlerinde kullanılan bariyer veya benzeri sistemler, münavebeli
kırmızı ve beyaz veya kırmızı ve sarı reflektif şeritlerle açıkça belirlenmelidir.
 Sürücülerin geçitten güvenli bir şekilde geçiş yapmalarını veya durup yol
vermelerini sağlayacak görüş imkanı bulunmayan demiryolu geçitlerinin kontrollü
hale getirilmesi zorunludur. Ancak, trenlerin oldukça yavaş seyrettiği veya
karayolundaki trafiğin yoğun olmadığı geçitler kontrollü hale getirilmeyebilir.]] },
    [38] = { ad = "Kontrolsüz demiryolu geçidi", aciklama = [[Bu işaret levhası, bariyersiz olan hemzemin geçit hakkında uyarıda
bulunmaktadır.
Kontrolsüz Demiryolu Geçidi levhasının Hemzemin Demiryolu Geçidi Yaklaşım
Levhası ile birlikte kullanılması gerekir. İlave bir uyarıya gerek görülmediği takdirde
yolun sağında kullanılan T-28a nolu levhanın üstünde kullanılır.]] },
    [39] = { ad = "Kontrolsüz demiryolu geçidi işaret levhaları", aciklama = [[Bu işaret levhalarının, demiryolu geçidinin tam konumunu göstermek üzere
bariyeri olmayan (kontrolsüz) demiryolu hemzemin geçitlerinin her iki tarafına da
konulması gerekir.
(T-27b) nolu işaret levhası sadece, demiryolu hattının en azından iki hattan
oluşması halinde kullanılacaktır.
 İşaret levhası yolun sağ tarafında kullanılacak ve en yakındaki demiryolu
hattından 5.0 metre uzaklıkta olacaktır. Kaplamanın genişliğinin 5 metreden daha az
olması halinde, işaret levhasının yolun solunda da kullanılmasına gerek yoktur.
Trenlerin yaklaşmakta olduğuna dair uyarıda bulunan bir ışıklı işaret cihazının ya
da DUR levhasının olması halinde, bu işaret levhalarının ışıklı işaret cihazının olduğu
direğe yahut da DUR levhasının olduğu direğe monte edilmesi gerekir. Demiryolu
Hemzemin Geçit İşaret Levhasının montaj yüksekliği 1.20 metreden daha az
olmaması gerekir.
Yeterli yer olmaması halinde, işaret levhası 90º çevrilerek monte edilebilir.]] },
    [40] = { ad = "Kontrolsüz demiryolu geçidi işaret levhaları", aciklama = [[Bu işaret levhalarının, demiryolu geçidinin tam konumunu göstermek üzere
bariyeri olmayan (kontrolsüz) demiryolu hemzemin geçitlerinin her iki tarafına da
konulması gerekir.
(T-27b) nolu işaret levhası sadece, demiryolu hattının en azından iki hattan
oluşması halinde kullanılacaktır.
 İşaret levhası yolun sağ tarafında kullanılacak ve en yakındaki demiryolu
hattından 5.0 metre uzaklıkta olacaktır. Kaplamanın genişliğinin 5 metreden daha az
olması halinde, işaret levhasının yolun solunda da kullanılmasına gerek yoktur.
Trenlerin yaklaşmakta olduğuna dair uyarıda bulunan bir ışıklı işaret cihazının ya
da DUR levhasının olması halinde, bu işaret levhalarının ışıklı işaret cihazının olduğu
direğe yahut da DUR levhasının olduğu direğe monte edilmesi gerekir. Demiryolu
Hemzemin Geçit İşaret Levhasının montaj yüksekliği 1.20 metreden daha az
olmaması gerekir.
Yeterli yer olmaması halinde, işaret levhası 90º çevrilerek monte edilebilir.]] },
    [41] = { ad = "Hemzemin demiryolu geçidi yaklaşım levhaları", aciklama = [[Bu işaret levhaları, uyarı levhalarının görünürlüğünü artırmak ve hemzemin
geçide olan mesafeyi belirtmek amacıyla hemzemin geçitlerin yaklaşımında kullanılır.
(T-28a) ve / veya (T-28b) nolu levhaların, (T-25) nolu Kontrollü Demiryolu Geçidi
ya da (T-26) nolu Kontrolsüz Demiryolu Geçidi işaret levhalarından uygun olan birisi
ile bu işaret levhalarının altında kullanılmaları gerekir.
(T-29a) ve (T-29b) nolu işaret levhaları, (T-27) Kontrolsüz Demiryolu Geçidi uyarı
levhasının bulunduğu yere 200 metre, (T-30a) ve (T-30b) nolu işaret levhaları ise bu
levhaya 100 metre mesafede konulacaktır.
(T-28a), (T-29a) ve (T-30a) nolu işaret levhaları, yolun sağında kullanılacaktır.
(T-28b), (T-29b) ve (T-30b) nolu yolun solunda kullanılacak işaret levhaları, sadece
artırılmış uyarıya lüzum görüldüğünde kullanılmalıdır.]] },
    [42] = { ad = "Hemzemin demiryolu geçidi yaklaşım levhaları", aciklama = [[Bu işaret levhaları, uyarı levhalarının görünürlüğünü artırmak ve hemzemin
geçide olan mesafeyi belirtmek amacıyla hemzemin geçitlerin yaklaşımında kullanılır.
(T-28a) ve / veya (T-28b) nolu levhaların, (T-25) nolu Kontrollü Demiryolu Geçidi
ya da (T-26) nolu Kontrolsüz Demiryolu Geçidi işaret levhalarından uygun olan birisi
ile bu işaret levhalarının altında kullanılmaları gerekir.
(T-29a) ve (T-29b) nolu işaret levhaları, (T-27) Kontrolsüz Demiryolu Geçidi uyarı
levhasının bulunduğu yere 200 metre, (T-30a) ve (T-30b) nolu işaret levhaları ise bu
levhaya 100 metre mesafede konulacaktır.
(T-28a), (T-29a) ve (T-30a) nolu işaret levhaları, yolun sağında kullanılacaktır.
(T-28b), (T-29b) ve (T-30b) nolu yolun solunda kullanılacak işaret levhaları, sadece
artırılmış uyarıya lüzum görüldüğünde kullanılmalıdır.]] },
    [43] = { ad = "Hemzemin demiryolu geçidi yaklaşım levhaları", aciklama = [[Bu işaret levhaları, uyarı levhalarının görünürlüğünü artırmak ve hemzemin
geçide olan mesafeyi belirtmek amacıyla hemzemin geçitlerin yaklaşımında kullanılır.
(T-28a) ve / veya (T-28b) nolu levhaların, (T-25) nolu Kontrollü Demiryolu Geçidi
ya da (T-26) nolu Kontrolsüz Demiryolu Geçidi işaret levhalarından uygun olan birisi
ile bu işaret levhalarının altında kullanılmaları gerekir.
(T-29a) ve (T-29b) nolu işaret levhaları, (T-27) Kontrolsüz Demiryolu Geçidi uyarı
levhasının bulunduğu yere 200 metre, (T-30a) ve (T-30b) nolu işaret levhaları ise bu
levhaya 100 metre mesafede konulacaktır.
(T-28a), (T-29a) ve (T-30a) nolu işaret levhaları, yolun sağında kullanılacaktır.
(T-28b), (T-29b) ve (T-30b) nolu yolun solunda kullanılacak işaret levhaları, sadece
artırılmış uyarıya lüzum görüldüğünde kullanılmalıdır.]] },
    [44] = { ad = "Köprü başı levhaları", aciklama = [[Bu işaret levhaları, köprüleri uyarmak için köprü korkuluklarına monte edilir.
Köprüde otokorkuluk vb. tedbirler ile trafik güvenliği artırılmışsa, bu levhaların
kullanıma gerek yoktur.
Bölünmüş yollarda, refüj aralığında köprü korkuluğu yoksa (T-31b) nolu levha
kullanılmayacaktır.]] },
    [45] = { ad = "Engel", aciklama = [[Bu işaret levhası, yolun geçici olarak tamamen taşıt trafiğine kapatıldığı
durumlarda, TT-5 veya TT-35a ve TT-35b nolu işaret levhaları ile birlikte kullanılır. Bu
işaret levhaları ile birlikte aynı zamanda sarı veya kırmızı renkli flaşörlerin uygun
olanının da kullanımına özen gösterilmelidir.]] },
    [46] = { ad = "Tehlikeli viraj yön levhaları", aciklama = [[Bu işaret levhaları, görüşü artırmak ve sürücülere daha iyi kılavuzluk sağlamak
amacı ile güvenli seyir olasılığı bulunmayan keskin virajlarda, T-1a,b veya T-2a,b
nolu işaret levhalarından sonra kullanılır. Ancak, tehlikeli viraj yön levhaları her
virajda kullanılmamalı, bu işaretler yolun genel yapısına göre kıyaslandığında
özellikle tehlikeli bulunan virajlarda kullanılmalıdır.
 T-33a nolu Tehlikeli Viraj Yön Levhaları, uzun ve tehlikeli virajların dış kenarında
kullanılmalıdır. Bütün viraj boyunca levhanın açısı trafiğin akış yönüne bakıyor
olmalıdır. İki yönlü yollarda, T-33a nolu Tehlikeli Viraj Yön Levhalarının her konumda
çift olarak konulması ve trafiğin her iki istikametine de bakıyor olması gerekir.
T-33b nolu Tehlikeli Viraj Yön Levhaları devlet yollarında kullanılmakla birlikte
yüksek hızlı il yollarında da kullanılabilir. Aynı amaca hizmet eden T-33c nolu
Tehlikeli Viraj Yön Levhaları ise sadece il yollarında kullanılır.
Görüşün kapalı olduğu yatay kurblarda, TT-27 nolu işaret levhası ile geçme
yasağı uygulanır.]] },
    [47] = { ad = "Tehlikeli viraj yön levhaları", aciklama = [[Bu işaret levhaları, görüşü artırmak ve sürücülere daha iyi kılavuzluk sağlamak
amacı ile güvenli seyir olasılığı bulunmayan keskin virajlarda, T-1a,b veya T-2a,b
nolu işaret levhalarından sonra kullanılır. Ancak, tehlikeli viraj yön levhaları her
virajda kullanılmamalı, bu işaretler yolun genel yapısına göre kıyaslandığında
özellikle tehlikeli bulunan virajlarda kullanılmalıdır.
 T-33a nolu Tehlikeli Viraj Yön Levhaları, uzun ve tehlikeli virajların dış kenarında
kullanılmalıdır. Bütün viraj boyunca levhanın açısı trafiğin akış yönüne bakıyor
olmalıdır. İki yönlü yollarda, T-33a nolu Tehlikeli Viraj Yön Levhalarının her konumda
çift olarak konulması ve trafiğin her iki istikametine de bakıyor olması gerekir.
T-33b nolu Tehlikeli Viraj Yön Levhaları devlet yollarında kullanılmakla birlikte
yüksek hızlı il yollarında da kullanılabilir. Aynı amaca hizmet eden T-33c nolu
Tehlikeli Viraj Yön Levhaları ise sadece il yollarında kullanılır.
Görüşün kapalı olduğu yatay kurblarda, TT-27 nolu işaret levhası ile geçme
yasağı uygulanır.]] },
    [48] = { ad = "Tehlikeli viraj yön levhaları", aciklama = [[Bu işaret levhaları, görüşü artırmak ve sürücülere daha iyi kılavuzluk sağlamak
amacı ile güvenli seyir olasılığı bulunmayan keskin virajlarda, T-1a,b veya T-2a,b
nolu işaret levhalarından sonra kullanılır. Ancak, tehlikeli viraj yön levhaları her
virajda kullanılmamalı, bu işaretler yolun genel yapısına göre kıyaslandığında
özellikle tehlikeli bulunan virajlarda kullanılmalıdır.
 T-33a nolu Tehlikeli Viraj Yön Levhaları, uzun ve tehlikeli virajların dış kenarında
kullanılmalıdır. Bütün viraj boyunca levhanın açısı trafiğin akış yönüne bakıyor
olmalıdır. İki yönlü yollarda, T-33a nolu Tehlikeli Viraj Yön Levhalarının her konumda
çift olarak konulması ve trafiğin her iki istikametine de bakıyor olması gerekir.
T-33b nolu Tehlikeli Viraj Yön Levhaları devlet yollarında kullanılmakla birlikte
yüksek hızlı il yollarında da kullanılabilir. Aynı amaca hizmet eden T-33c nolu
Tehlikeli Viraj Yön Levhaları ise sadece il yollarında kullanılır.
Görüşün kapalı olduğu yatay kurblarda, TT-27 nolu işaret levhası ile geçme
yasağı uygulanır.]] },
    [49] = { ad = "Tehlikeli viraj yön levhaları", aciklama = [[Bu işaret levhaları, görüşü artırmak ve sürücülere daha iyi kılavuzluk sağlamak
amacı ile güvenli seyir olasılığı bulunmayan keskin virajlarda, T-1a,b veya T-2a,b
nolu işaret levhalarından sonra kullanılır. Ancak, tehlikeli viraj yön levhaları her
virajda kullanılmamalı, bu işaretler yolun genel yapısına göre kıyaslandığında
özellikle tehlikeli bulunan virajlarda kullanılmalıdır.
 T-33a nolu Tehlikeli Viraj Yön Levhaları, uzun ve tehlikeli virajların dış kenarında
kullanılmalıdır. Bütün viraj boyunca levhanın açısı trafiğin akış yönüne bakıyor
olmalıdır. İki yönlü yollarda, T-33a nolu Tehlikeli Viraj Yön Levhalarının her konumda
çift olarak konulması ve trafiğin her iki istikametine de bakıyor olması gerekir.
T-33b nolu Tehlikeli Viraj Yön Levhaları devlet yollarında kullanılmakla birlikte
yüksek hızlı il yollarında da kullanılabilir. Aynı amaca hizmet eden T-33c nolu
Tehlikeli Viraj Yön Levhaları ise sadece il yollarında kullanılır.
Görüşün kapalı olduğu yatay kurblarda, TT-27 nolu işaret levhası ile geçme
yasağı uygulanır.]] },
    [50] = { ad = "Refüj başı ek levhaları", aciklama = [[ T-34a nolu işaret levhası, yoldaki veya yol kenarındaki (ör: köprü ayakları) bir
engelin önüne, engelin solundan geçilmesi gerektiğini bildirmek için kullanılır.
T-34b nolu işaret levhası ise, yoldaki veya yol kenarındaki (ör: köprü ayakları) bir
engelin önüne, engelin sağından geçilmesi gerektiğini bildirmek için kullanıldığı gibi,
bölünmüş yollarda refüj başlarını uyarmak için TT-36a nolu Sağdan Gidiniz levhaları
altında, bu levhanın anlamını ve etkinliğini artırmak amacıyla da kullanılır.
Refüj Başı Ek Levhası (T-34b), her refüj başında kullanılmamalı, sadece
tehlike arz eden kesimlerde TT-36a nolu levhanın verdiği mesajı güçlendirmek
amacı ile kullanılmalıdır.]] },
    [51] = { ad = "Dönüş adası ek levhası", aciklama = [[Bu işaret levhası, ana güzergahtan sağa dönüşle ayrılan trafiği uyarmak amacı ile
Kavşak İçi Yön Levhaları ve TT-36c nolu Her İki Yandan Gidiniz levhalarının altında
kullanılabileceği gibi yalnız başına da kullanılabilir.
Dönüş Adası Ek levhası, adı geçen levhaların altında, fiziksel buruna çarpma
olasılığını düşürmek amacıyla, yavaşlama şeridi bulunan kesimlerde kullanılmalıdır.
Ancak, çarpma olasılığının zayıf olduğu kesimlerde Kavşak İçi Yön Levhaları ve TT36c nolu Her İki Yandan Gidiniz levhaları yalnız başına kullanılabilir.
TT-36c nolu Her İki Yandan Gidiniz işaret levhasının ana yol ile çıkış rampası
arasındaki dönüş adasının işaretlenmesinde kullanılmaması gerekir. Bu gibi yerlerde,
T-35 nolu Dönüş Adası Ek Levhası ile gerekirse kavşak içi yön levhasının
kullanılması gerekir.]] },
    [52] = { ad = "Düşük banket", aciklama = [[Bu işaret levhası, kaplama ile banket arasındaki trafik güvenliğini tehlikeye atacak
seviye farklarını uyarmak için kullanılır. Bu işaret levhası, ayrıca yumuşak banketi
uyarmak içinde kullanılabilir.
Bu işaret levhası, hiç banket bulunmayan veya çok dar olan banketin
devamındaki dik şevleri işaretlemek amacıyla kullanılmamalıdır.
 Bu işaret levhasının altında kullanılacak süreklilik ilave paneli (PL-1) ile düşük
banket uzunluğu belirtilebilir.]] },
    [53] = { ad = "Gizli buzlanma", aciklama = [[Bu işaret levhası, seyir halinde bulunulan yolun diğer kesimlerine nazaran
önceden beklenilmeyen ve tahmin edilemeyen buzlanmalar olabileceğini bildirir.
 Bu işaret levhası, köprü üstleri, güneş görmeyen yamaçlar ile nemli yerlerde
oluşabilecek ve seyir halinde bulunulan yolun, diğer kesimlerine nazaran önceden
fark edilemeyen kesimlerinde olabilecek gizli buzlanma olasılığı bulunan yol
kesimlerini bildirmek amacıyla kullanılmalıdır. Burada sayılan olumsuz yol koşulların
bulunmadığı yol kesimlerinde, bu işaret levhası kullanılmamalıdır.
 Bu işaret levhasının kullanılması gereken kesimlerinin, yolun yapım ve
bakımından sorumlu kuruluş ilgilileri tarafından, o kesimde yapılan araştırmalara ve
gözlemlere dayalı olarak belirlenmesi gerekmektedir.
 Bu işaret levhasının altında kullanılacak süreklilik ilave paneli (PL-1) ile gizli
buzlanma olasılığı bulunan yol kesiminin uzunluğu belirtilebilir.

 Bu işaret levhaları, tercihen Ekim-Nisan ayları arasında kullanılmalıdır.]] },
}

local function metinOlustur(icerik, ustBosluk)
	if scrollViewMetin then
		scrollViewMetin:removeSelf()
		scrollViewMetin = nil
	end

	local tabBarHeight = sahneDegis.getVariable("tabBarHeight") or 0
	local oy = math.abs(display.screenOriginY)
	local scrollView = widget.newScrollView(
		{
			top = ustBosluk or 230,
			left = 0,
			width = display.contentWidth,
			height = display.contentHeight + oy - (ustBosluk or 230) - tabBarHeight,
			horizontalScrollDisabled = true,
			backgroundColor = { 1, 1, 1 }
		})

	local yStart = 10
	local mainPadding = 10

	for paragraph in string.gmatch(icerik .. "\n", "([^\n]*)\n") do
		local newText = display.newText({
			text = paragraph,
			width = scrollView.width - (mainPadding * 2),
			fontSize = 16,
			font = "Poppins-Medium",
			align = "left"
		})
		newText.anchorX = 0
		newText.anchorY = 0
		newText.x = mainPadding
		newText.y = yStart
		newText:setFillColor(0.2)
		scrollView:insert(newText)
		yStart = yStart + newText.height + 5
	end

	scrollView:setScrollHeight(yStart + (mainPadding * 2))
	scrollViewMetin = scrollView
end

function sahne:create(olay)
	local sceneGroup = self.view
	local sahneGroup = display.newGroup()
	sceneGroup:insert(sahneGroup)


	local ox, oy = math.abs(display.screenOriginX), math.abs(display.screenOriginY)
	local tabBarHeight = sahneDegis.getVariable("tabBarHeight")
	local themeID = sahneDegis.getVariable("themeID")

	-- Açık renkli, projeyle uyumlu liste renkleri (tema ne olursa olsun)
	local tableViewColors = {
		rowColor = { default = { 1 }, over = { 0.92, 0.95, 1 } },
		lineColor = { 220 / 255 },
		catColor = { default = { 0.05, 0.3, 0.55, 0.9 }, over = { 0.05, 0.3, 0.55, 0.9 } },
		defaultLabelColor = { 0.2 },
		catLabelColor = { 1 }
	}

	-- Forward reference for the tableView
	local tableView

	local yeniLevha = display.newSprite(sahneGroup, resimLevha, levhaSpriteKareleri)

	yeniLevha.x = display.contentCenterX - 130
	yeniLevha.y = display.contentCenterY - 130
	yeniLevha.myName = "levha"
	yeniLevha.isVisible = false -- Satır seçilene kadar gizli kalsın (arka planda soluk görünmesin)
	sceneGroup:insert(yeniLevha)

	-- Function to return to the tableView
	local function goBack(event)
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
	local backButton = widget.newButton {
		width = 128,
		height = 32,
		label = "Geri Dön",
		onRelease = goBack
	}
	backButton.x = 100
	backButton.y = 200
	sceneGroup:insert(backButton)

	-- Listen for tableView events
	local function tableViewListener(event)
		local phase = event.phase
		print("Event.phase is:", event.phase)
	end


	-- Handle row rendering
	local function onRowRender(event)
		local phase = event.phase
		local row = event.row
		local groupContentHeight = row.contentHeight

		local kareNo = math.max(1, row.index - 1)
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
		local rowResim = display.newImageRect(row, resimLevha, kareNo, 50, 50)

		rowResim.x = 20
		rowResim.y = groupContentHeight * 0.5
		row:insert(rowResim)
		rowTitle.x = 50
		rowTitle.anchorX = 0
		rowTitle.y = groupContentHeight * 0.5

		if (row.isCategory) then
			rowTitle:setFillColor(unpack(row.params.catLabelColor))
			rowTitle.text = " TEHLİKE UYARI İŞARETLERİ "
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

	-- Handle row updates
	local function onRowUpdate(event)
		local phase = event.phase
		local row = event.row

		print(row.index, ": is now onscreen")
	end

	-- Handle touches on the row
	local function onRowTouch(event)
		local phase = event.phase
		local row = event.target
		if ("release" == phase) and not row.isCategory then
			yeniLevha.isVisible = true -- Satır seçilince levha resmi görünsün
			transition.to(tableView, {
				x = ((display.contentWidth / 2) + ox + ox) * -1,
				time = 600,
				transition = easing
					.outQuint
			})
			transition.to(backButton, { x = display.contentCenterX, time = 750, transition = easing.outQuint })
			transition.to(yeniLevha, { x = display.contentCenterX, time = 480, transition = easing.outQuint })
			yeniLevha:setFrame(row.index - 1) -- Seçilen levhanın resmini göster
			local secilenMetin = levhaDetaylari[row.index].aciklama
			metinOlustur(secilenMetin, 230)
			sceneGroup:insert(scrollViewMetin)
		end
	end
	-- Create a tableView
	tableView = widget.newTableView
		{
			top = -oy,
			left = -ox,
			width = display.contentWidth + ox + ox,
			height = display.contentHeight - tabBarHeight + oy + oy,
			hideBackground = true,
			listener = tableViewListener,
			onRowRender = onRowRender,
			onRowUpdate = onRowUpdate,
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



	print("\n2: create olay")
end

function sahne:show(olay)
	local faz = olay.phase

	if "did" == faz then
		print("2: show olay, faz did")

		-- remove previous scene's view
		collectgarbage("collect")
	end
end

function sahne:hide(olay)
	local faz = olay.phase
	if "will" == faz then
		print("2: hide olay, faz will")
	elseif "did" == faz then
		-- DİKKAT: removeScene("sahne1") KALDIRILDI.
		-- Ana sayfa butonu ile sahne1'e geçilirken hedef sahne yok
		-- ediliyor ve ilk geçişte boş ekran çıkıyordu.
		sahneDegis.removeScene("sahne2")
	end
end

function sahne:destroy(olay)
	print("((sahne 2 yok ediliyor)")
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
