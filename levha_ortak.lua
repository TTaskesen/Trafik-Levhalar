--------------------------------------------------------------------------------
-- Levha sahnelerinde ortak kullanılan liste ve detay yardımcıları.
--------------------------------------------------------------------------------
local widget = require("widget")
local json = require("json")
local dil = require("dil")

local ortak = {}
local BASLIK_MAVI = { 0.05, 0.30, 0.55 }
local BASLIK_MAVI_ACIK = { 0.08, 0.40, 0.68 }
local BASLIK_BEYAZ = { 1, 1, 1 }

-- Çevrilen ad varsa onu kullanır; eksik çevirilerde Türkçe ad korunur.
local yerelLevhaAdlari = {
    de = {
        ["Park etmek yasaktır"] = "Parken verboten",
        ["Duraklamak ve park etmek yasaktır"] = "Halten und Parken verboten",
        ["Park yeri"] = "Parkplatz",
        ["Yaya geçidi"] = "Fußgängerüberweg",
        ["Okul geçidi"] = "Schulübergang",
        ["Hastane"] = "Krankenhaus",
        ["Tek yönlü yol"] = "Einbahnstraße",
        ["Akaryakıt istasyonu"] = "Tankstelle",
        ["Otel veya motel"] = "Hotel oder Motel"
    },
    fr = {
        ["Park etmek yasaktır"] = "Stationnement interdit",
        ["Duraklamak ve park etmek yasaktır"] = "Arrêt et stationnement interdits",
        ["Park yeri"] = "Parking",
        ["Yaya geçidi"] = "Passage pour piétons",
        ["Okul geçidi"] = "Passage scolaire",
        ["Hastane"] = "Hôpital",
        ["Tek yönlü yol"] = "Sens unique",
        ["Akaryakıt istasyonu"] = "Station-service",
        ["Otel veya motel"] = "Hôtel ou motel"
    },
    ko = {
        ["Park etmek yasaktır"] = "주차 금지",
        ["Duraklamak ve park etmek yasaktır"] = "정차 및 주차 금지",
        ["Park yeri"] = "주차장",
        ["Yaya geçidi"] = "보행자 횡단보도",
        ["Okul geçidi"] = "학교 앞 횡단보도",
        ["Hastane"] = "병원",
        ["Tek yönlü yol"] = "일방통행",
        ["Akaryakıt istasyonu"] = "주유소",
        ["Otel veya motel"] = "호텔 또는 모텔"
    }
}

local yerelLevhaAciklamalari = {
    de = {
        ["Park yeri"] = "Dieses Zeichen weist auf einen ausgewiesenen Parkplatz hin. Parken Sie nur innerhalb der markierten Fläche und beachten Sie die örtlichen Regeln.",
        ["Yaya geçidi"] = "Dieses Zeichen weist auf einen Fußgängerüberweg hin. Fahrer müssen langsamer fahren und Fußgängern das sichere Überqueren ermöglichen.",
        ["Okul geçidi"] = "Dieses Zeichen warnt vor einem Schulübergang. Fahren Sie besonders vorsichtig und achten Sie auf Kinder, die die Straße überqueren können."
    },
    fr = {
        ["Park yeri"] = "Ce panneau indique une place de stationnement aménagée. Garez-vous uniquement dans la zone prévue et respectez les règles locales.",
        ["Yaya geçidi"] = "Ce panneau indique un passage pour piétons. Les conducteurs doivent ralentir et permettre aux piétons de traverser en sécurité.",
        ["Okul geçidi"] = "Ce panneau avertit de la présence d’un passage scolaire. Conduisez avec une attention particulière et surveillez les enfants."
    },
    ko = {
        ["Park yeri"] = "이 표지는 지정된 주차 장소를 나타냅니다. 표시된 구역 안에 주차하고 현지 규정을 지켜야 합니다.",
        ["Yaya geçidi"] = "이 표지는 보행자 횡단보도를 나타냅니다. 운전자는 속도를 줄이고 보행자가 안전하게 건너도록 해야 합니다.",
        ["Okul geçidi"] = "이 표지는 학교 앞 횡단보도를 알립니다. 어린이가 건널 수 있으므로 특히 주의해서 운전해야 합니다."
    }
}

local levhaTerimleri = {
    de = {
        { "Sağa Tehlikeli Devamlı Virajlar", "Aufeinanderfolgende gefährliche Rechtskurven" },
        { "Sola Tehlikeli Devamlı Virajlar", "Aufeinanderfolgende gefährliche Linkskurven" },
        { "Sağa Tehlikeli Viraj", "Gefährliche Rechtskurve" },
        { "Sola Tehlikeli Viraj", "Gefährliche Linkskurve" },
        { "Tehlikeli Eğim (Çıkış)", "Gefährliches Gefälle (Steigung)" },
        { "Tehlikeli Eğim (İniş)", "Gefährliches Gefälle (Abfahrt)" },
        { "Girişi olmayan yol", "Straße ohne Einfahrt" },
        { "Girişi Olmayan Yol Kavşağı", "Kreuzung ohne Einfahrt" },
        { "Kontrollü demiryolu geçidi", "Bahnübergang mit Schranken" },
        { "Kontrolsüz demiryolu geçidi", "Bahnübergang ohne Schranken" },
        { "Yol ver", "Vorfahrt gewähren" },
        { "Dur", "Halt" },
        { "Dikkat", "Achtung" },
        { "Azami hız sınırlaması", "Höchstgeschwindigkeit" },
        { "Hız sınırlaması sonu", "Ende der Geschwindigkeitsbegrenzung" },
        { "Yaya giremez", "Fußgänger verboten" },
        { "Bisiklet giremez", "Fahrräder verboten" },
        { "Motosiklet giremez", "Motorräder verboten" },
        { "Kamyon giremez", "Lastwagen verboten" },
        { "Otobüs giremez", "Busse verboten" },
        { "Taşıt giremez", "Fahrzeuge verboten" },
        { "Öndeki taşıtı geçmek yasaktır", "Überholen verboten" },
        { "Sağa dönülmez", "Rechtsabbiegen verboten" },
        { "Sola dönülmez", "Linksabbiegen verboten" },
        { "U dönüşü yapılmaz", "Wenden verboten" },
        { "Yolda çalışma", "Baustelle" },
        { "Kaygan yol", "Rutschige Fahrbahn" },
        { "Yandan rüzgar", "Seitenwind" },
        { "Gizli buzlanma", "Glatteis" },
        { "Açılan köprü", "Bewegliche Brücke" },
        { "Yaya geçidi", "Fußgängerüberweg" },
        { "Okul geçidi", "Schulübergang" },
        { "Kavşak isim levhası", "Kreuzungsname" },
        { "Tünel", "Tunnel" },
        { "Hastane", "Krankenhaus" },
        { "Polis", "Polizei" },
        { "Jandarma", "Gendarmerie" },
        { "Telefon", "Telefon" },
        { "Çeşme", "Brunnen" },
        { "Piknik yeri", "Picknickplatz" },
        { "Kamp yeri", "Campingplatz" },
        { "Park alanı levhası", "Parkplatzzeichen" },
        { "Servis alanı levhaları", "Servicebereich-Zeichen" },
        { "Acil durum levhaları", "Notfallzeichen" },
        { "Otoyol rejimi levhası", "Autobahnzeichen" },
        { "Trafik Sıkışıklığı", "Verkehrsstau" },
        { "İstasyon", "Bahnhof" },
        { "Tramvay Durağı", "Straßenbahnhaltestelle" },
        { "Yaya Öncelikli Yol", "Fußgängerbevorzugte Straße" },
        { "Yaya Öncelikli Yolun Sonu", "Ende der fußgängerbevorzugten Straße" }
    },
    fr = {
        { "Sağa Tehlikeli Devamlı Virajlar", "Virages dangereux successifs à droite" },
        { "Sola Tehlikeli Devamlı Virajlar", "Virages dangereux successifs à gauche" },
        { "Sağa Tehlikeli Viraj", "Virage dangereux à droite" },
        { "Sola Tehlikeli Viraj", "Virage dangereux à gauche" },
        { "Tehlikeli Eğim (Çıkış)", "Pente dangereuse (montée)" },
        { "Tehlikeli Eğim (İniş)", "Pente dangereuse (descente)" },
        { "Girişi olmayan yol", "Route sans accès" },
        { "Girişi Olmayan Yol Kavşağı", "Carrefour sans accès" },
        { "Kontrollü demiryolu geçidi", "Passage à niveau gardé" },
        { "Kontrolsüz demiryolu geçidi", "Passage à niveau non gardé" },
        { "Yol ver", "Cédez le passage" },
        { "Dur", "Stop" },
        { "Dikkat", "Attention" },
        { "Azami hız sınırlaması", "Limitation de vitesse maximale" },
        { "Hız sınırlaması sonu", "Fin de la limitation de vitesse" },
        { "Yaya giremez", "Accès interdit aux piétons" },
        { "Bisiklet giremez", "Accès interdit aux vélos" },
        { "Motosiklet giremez", "Accès interdit aux motos" },
        { "Kamyon giremez", "Accès interdit aux camions" },
        { "Otobüs giremez", "Accès interdit aux autobus" },
        { "Taşıt giremez", "Accès interdit aux véhicules" },
        { "Öndeki taşıtı geçmek yasaktır", "Interdiction de dépasser" },
        { "Sağa dönülmez", "Interdiction de tourner à droite" },
        { "Sola dönülmez", "Interdiction de tourner à gauche" },
        { "U dönüşü yapılmaz", "Demi-tour interdit" },
        { "Yolda çalışma", "Travaux" },
        { "Kaygan yol", "Chaussée glissante" },
        { "Yandan rüzgar", "Vent latéral" },
        { "Gizli buzlanma", "Verglas possible" },
        { "Açılan köprü", "Pont mobile" },
        { "Yaya geçidi", "Passage pour piétons" },
        { "Okul geçidi", "Passage scolaire" },
        { "Kavşak isim levhası", "Nom du carrefour" },
        { "Tünel", "Tunnel" },
        { "Hastane", "Hôpital" },
        { "Polis", "Police" },
        { "Jandarma", "Gendarmerie" },
        { "Telefon", "Téléphone" },
        { "Çeşme", "Fontaine" },
        { "Piknik yeri", "Aire de pique-nique" },
        { "Kamp yeri", "Camping" },
        { "Park alanı levhası", "Panneau de parking" },
        { "Servis alanı levhaları", "Panneaux d’aire de service" },
        { "Acil durum levhaları", "Panneaux d’urgence" },
        { "Otoyol rejimi levhası", "Panneau d’autoroute" },
        { "Trafik Sıkışıklığı", "Embouteillage" },
        { "İstasyon", "Gare" },
        { "Tramvay Durağı", "Arrêt de tramway" },
        { "Yaya Öncelikli Yol", "Rue prioritaire aux piétons" },
        { "Yaya Öncelikli Yolun Sonu", "Fin de la rue prioritaire aux piétons" }
    },
    ko = {
        { "Sağa Tehlikeli Viraj", "위험한 우회전 커브" },
        { "Sola Tehlikeli Viraj", "위험한 좌회전 커브" },
        { "Sağa Tehlikeli Devamlı Virajlar", "연속 위험 우회전 커브" },
        { "Sola Tehlikeli Devamlı Virajlar", "연속 위험 좌회전 커브" },
        { "Tehlikeli Eğim (Çıkış)", "위험한 오르막" },
        { "Tehlikeli Eğim (İniş)", "위험한 내리막" },
        { "Girişi olmayan yol", "진입 금지 도로" },
        { "Girişi Olmayan Yol Kavşağı", "진입 금지 도로 교차로" },
        { "Kontrollü demiryolu geçidi", "차단기 있는 철도 건널목" },
        { "Kontrolsüz demiryolu geçidi", "차단기 없는 철도 건널목" },
        { "Yol ver", "양보" },
        { "Dur", "정지" },
        { "Dikkat", "주의" },
        { "Azami hız sınırlaması", "최고 속도 제한" },
        { "Hız sınırlaması sonu", "속도 제한 해제" },
        { "Yaya giremez", "보행자 통행 금지" },
        { "Bisiklet giremez", "자전거 통행 금지" },
        { "Motosiklet giremez", "오토바이 통행 금지" },
        { "Kamyon giremez", "트럭 통행 금지" },
        { "Otobüs giremez", "버스 통행 금지" },
        { "Taşıt giremez", "차량 통행 금지" },
        { "Öndeki taşıtı geçmek yasaktır", "추월 금지" },
        { "Sağa dönülmez", "우회전 금지" },
        { "Sola dönülmez", "좌회전 금지" },
        { "U dönüşü yapılmaz", "유턴 금지" },
        { "Yolda çalışma", "도로 공사" },
        { "Kaygan yol", "미끄러운 도로" },
        { "Yandan rüzgar", "측풍" },
        { "Gizli buzlanma", "결빙 주의" },
        { "Açılan köprü", "개폐교" },
        { "Yaya geçidi", "보행자 횡단보도" },
        { "Okul geçidi", "학교 앞 횡단보도" },
        { "Kavşak isim levhası", "교차로 이름 표지" },
        { "Tünel", "터널" },
        { "Hastane", "병원" },
        { "Polis", "경찰" },
        { "Jandarma", "헌병" },
        { "Telefon", "전화" },
        { "Çeşme", "식수대" },
        { "Piknik yeri", "피크닉 장소" },
        { "Kamp yeri", "캠핑장" },
        { "Park alanı levhası", "주차장 표지" },
        { "Servis alanı levhaları", "서비스 구역 표지" },
        { "Acil durum levhaları", "비상 표지" },
        { "Otoyol rejimi levhası", "고속도로 표지" },
        { "Trafik Sıkışıklığı", "교통 체증" },
        { "İstasyon", "역" },
        { "Tramvay Durağı", "트램 정류장" },
        { "Yaya Öncelikli Yol", "보행자 우선 도로" },
        { "Yaya Öncelikli Yolun Sonu", "보행자 우선 도로 끝" }
    }
}

local function tamCeviriBul(ad, kod)
    for _, eslesme in ipairs(levhaTerimleri[kod] or {}) do
        if eslesme[1] == ad then
            return eslesme[2]
        end
    end
    return nil
end

local genelLevhaTerimleri = {
    de = {
        { "Meskun mahal sonu", "Ende des Ortes" }, { "Meskun mahal", "Ort" },
        { "il merkezi", "Stadtzentrum" }, { "ilçe merkezi", "Kreiszentrum" },
        { "Coğrafi bilgi levhası", "Geografisches Informationszeichen" }, { "dağ geçidi", "Bergpass" },
        { "köprü-nehir", "Brücke-Fluss" }, { "Yaya bölgesi", "Fußgängerzone" },
        { "Tek yönlü yol", "Einbahnstraße" }, { "İleri çıkmaz yol", "Sackgasse voraus" },
        { "Otoyol başlangıcı", "Beginn der Autobahn" }, { "Otoyol sonu", "Ende der Autobahn" },
        { "Kavşak öncesi yön levhası", "Wegweiser vor der Kreuzung" }, { "Kaplama üstü yön levhası", "Wegweiser über der Fahrbahn" },
        { "Motorlu taşıt yolu başlangıcı", "Beginn der Kraftfahrstraße" }, { "Motorlu taşıt yolu sonu", "Ende der Kraftfahrstraße" },
        { "İlk yardım", "Erste Hilfe" }, { "Tamirhane", "Werkstatt" }, { "Akaryakıt istasyonu", "Tankstelle" },
        { "Otel veya motel", "Hotel oder Motel" }, { "Lokanta veya kafeterya", "Restaurant oder Cafeteria" },
        { "Çayhane", "Teehaus" }, { "Girişi olmayan yol kavşağı", "Kreuzung ohne Einfahrt" },
        { "İleriki kavşakta sola dönüş yasağını gösteren işaret levhası", "Verbot des Linksabbiegens an der nächsten Kreuzung" },
        { "Yürüyüş başlangıcı", "Beginn des Wanderwegs" }, { "Karavanlı kampı", "Camping mit Wohnwagen" },
        { "Gençlik kampı", "Jugendlager" }, { "Önceliği olan yön", "Vorrangige Richtung" },
        { "Anayol sonu", "Ende der Vorfahrtsstraße" }, { "Anayol", "Vorfahrtsstraße" },
        { "Şerit düzenleme levhaları", "Fahrstreifenführungszeichen" }, { "İki yönlü yol", "Zweirichtungsstraße" },
        { "U dönüşü levhası", "Wendezeichen" }, { "Kaçış rampası", "Notausfahrt" },
        { "Kavşak içi yön levhası", "Wegweiser in der Kreuzung" }, { "Türkiye devlet sınırı levhası", "Staatsgrenze der Türkei" },
        { "İl sınırı levhası", "Provinzgrenze" }, { "Türkiye hız sınırları levhası", "Geschwindigkeitsgrenzen der Türkei" },
        { "Park etmek yasaktır", "Parken verboten" }, { "Duraklamak ve park etmek yasaktır", "Halten und Parken verboten" },
        { "Park yeri", "Parkplatz" }, { "Ada etrafında dönünüz", "Kreisverkehr" },
        { "Araç Çekilir", "Abschleppzone" }, { "At arabası giremez", "Pferdefuhrwerke verboten" },
        { "Ağaç Engeli", "Baumhindernis" }, { "Bisiklet geçebilir", "Fahrräder erlaubt" },
        { "sadece ileri seyir", "nur geradeaus" }, { "sağa dönüş içindir", "für Rechtsabbieger" },
        { "sola dönüş içindir", "für Linksabbieger" }, { "yasaklama ve kısıtlamaların sonu", "Ende aller Verbote und Beschränkungen" },
        { "Deniz veya nehir kıyısında biten yol", "Straße endet am Meer oder Fluss" }, { "Dönel kavşak yaklaşımı", "Annäherung an einen Kreisverkehr" },
        { "Düşük banket", "Niedriger Seitenstreifen" }, { "Engel", "Hindernis" }, { "Gevşek Malzemeli zemin", "Lose Fahrbahn" },
        { "Geçme yasağı sonu", "Ende des Überholverbots" }, { "Gümrük", "Zoll" }, { "HGS levhası", "HGS-Zeichen" },
        { "Havaalanı-havalimanı", "Flughafen" }, { "Her iki yandan gidiniz", "Beidseitig vorbeifahren" },
        { "Işıklı işaret cihazı", "Lichtsignalanlage" }, { "Kapalı Park Yeri", "Überdachter Parkplatz" },
        { "Karşıdan gelene yol ver", "Gegenverkehr Vorfahrt gewähren" }, { "Kontrolsüz kavşak", "Ungeregelte Kreuzung" },
        { "Mecburi asgari hız", "Mindestgeschwindigkeit vorgeschrieben" }, { "Mecburi bisiklet yolu", "Radweg vorgeschrieben" },
        { "Mecburi yaya yolu", "Fußweg vorgeschrieben" }, { "Motorlu taşıt giremez", "Kraftfahrzeuge verboten" },
        { "Motorlu bisiklet giremez", "Mopeds verboten" }, { "Taşıt trafiğine kapalı yol", "Für Fahrzeugverkehr gesperrte Straße" },
        { "Tehlikeli madde taşıyan taşıt giremez", "Fahrzeuge mit gefährlichen Gütern verboten" },
        { "Traktör giremez", "Traktoren verboten" }, { "Treyler giremez", "Anhänger verboten" },
        { "Vahşi hayvanlar geçebilir", "Wildwechsel" }, { "Yüksek Gerilim Hattı", "Hochspannungsleitung" },
        { "Yol ver", "Vorfahrt gewähren" }
    },
    fr = {
        { "Meskun mahal sonu", "Fin d’agglomération" }, { "Meskun mahal", "Agglomération" },
        { "il merkezi", "centre-ville" }, { "ilçe merkezi", "centre de district" },
        { "Coğrafi bilgi levhası", "panneau d’information géographique" }, { "dağ geçidi", "col de montagne" },
        { "köprü-nehir", "pont-fleuve" }, { "Yaya bölgesi", "zone piétonne" },
        { "Tek yönlü yol", "rue à sens unique" }, { "İleri çıkmaz yol", "impasse en avant" },
        { "Otoyol başlangıcı", "début de l’autoroute" }, { "Otoyol sonu", "fin de l’autoroute" },
        { "Kavşak öncesi yön levhası", "panneau directionnel avant le carrefour" }, { "Kaplama üstü yön levhası", "panneau directionnel au-dessus de la chaussée" },
        { "Motorlu taşıt yolu başlangıcı", "début de la voie pour véhicules motorisés" }, { "Motorlu taşıt yolu sonu", "fin de la voie pour véhicules motorisés" },
        { "İlk yardım", "premiers secours" }, { "Tamirhane", "atelier de réparation" }, { "Akaryakıt istasyonu", "station-service" },
        { "Otel veya motel", "hôtel ou motel" }, { "Lokanta veya kafeterya", "restaurant ou cafétéria" },
        { "Çayhane", "salon de thé" }, { "Girişi olmayan yol kavşağı", "carrefour sans accès" },
        { "Yürüyüş başlangıcı", "début du sentier" }, { "Gençlik kampı", "camp de jeunes" },
        { "Önceliği olan yön", "direction prioritaire" }, { "Anayol sonu", "fin de la route prioritaire" },
        { "Anayol", "route prioritaire" }, { "Şerit düzenleme levhaları", "panneaux de guidage des voies" },
        { "İki yönlü yol", "route à double sens" }, { "U dönüşü levhası", "panneau de demi-tour" },
        { "Kaçış rampası", "rampe de secours" }, { "Kavşak içi yön levhası", "panneau directionnel dans le carrefour" },
        { "İl sınırı levhası", "limite de province" }, { "Park etmek yasaktır", "stationnement interdit" },
        { "Duraklamak ve park etmek yasaktır", "arrêt et stationnement interdits" }, { "Park yeri", "parking" },
        { "Araç Çekilir", "zone d’enlèvement" }, { "At arabası giremez", "accès interdit aux véhicules hippomobiles" },
        { "Bisiklet geçebilir", "vélos autorisés" }, { "sadece ileri seyir", "tout droit uniquement" },
        { "sağa dönüş içindir", "pour tourner à droite" }, { "sola dönüş içindir", "pour tourner à gauche" },
        { "yasaklama ve kısıtlamaların sonu", "fin de toutes les interdictions et restrictions" },
        { "Deniz veya nehir kıyısında biten yol", "route se terminant au bord de la mer ou d’un fleuve" },
        { "Dönel kavşak yaklaşımı", "approche d’un rond-point" }, { "Düşük banket", "accotement bas" },
        { "Gevşek Malzemeli zemin", "chaussée à matériaux meubles" }, { "Geçme yasağı sonu", "fin de l’interdiction de dépasser" },
        { "Gümrük", "douane" }, { "HGS levhası", "panneau HGS" }, { "Her iki yandan gidiniz", "passage des deux côtés" },
        { "Işıklı işaret cihazı", "feux de signalisation" }, { "Kapalı Park Yeri", "parking couvert" },
        { "Karşıdan gelene yol ver", "priorité au véhicule venant en sens inverse" }, { "Kontrolsüz kavşak", "carrefour non réglementé" },
        { "Mecburi asgari hız", "vitesse minimale obligatoire" }, { "Mecburi bisiklet yolu", "piste cyclable obligatoire" },
        { "Mecburi yaya yolu", "chemin obligatoire pour piétons" }, { "Motorlu taşıt giremez", "accès interdit aux véhicules motorisés" },
        { "Motorlu bisiklet giremez", "accès interdit aux cyclomoteurs" }, { "Taşıt trafiğine kapalı yol", "route interdite à la circulation des véhicules" },
        { "Tehlikeli madde taşıyan taşıt giremez", "accès interdit aux véhicules transportant des matières dangereuses" },
        { "Traktör giremez", "accès interdit aux tracteurs" }, { "Treyler giremez", "accès interdit aux remorques" },
        { "Vahşi hayvanlar geçebilir", "passage d’animaux sauvages" }, { "Yüksek Gerilim Hattı", "ligne à haute tension" }
    },
    ko = {
        { "Meskun mahal sonu", "도시 구역 끝" }, { "Meskun mahal", "도시 구역" }, { "il merkezi", "도시 중심" },
        { "ilçe merkezi", "구역 중심" }, { "Coğrafi bilgi levhası", "지리 안내 표지" }, { "dağ geçidi", "산길 고개" },
        { "köprü-nehir", "다리-강" }, { "Yaya bölgesi", "보행자 구역" }, { "Tek yönlü yol", "일방통행 도로" },
        { "İleri çıkmaz yol", "앞 막다른 길" }, { "Otoyol başlangıcı", "고속도로 시작" }, { "Otoyol sonu", "고속도로 끝" },
        { "İlk yardım", "응급 처치" }, { "Tamirhane", "정비소" }, { "Akaryakıt istasyonu", "주유소" },
        { "Otel veya motel", "호텔 또는 모텔" }, { "Lokanta veya kafeterya", "식당 또는 카페" }, { "Çayhane", "찻집" },
        { "Yürüyüş başlangıcı", "산책로 시작" }, { "Gençlik kampı", "청소년 캠프" }, { "Önceliği olan yön", "우선 방향" },
        { "Anayol sonu", "주도로 끝" }, { "Anayol", "주도로" }, { "Şerit düzenleme levhaları", "차로 안내 표지" },
        { "İki yönlü yol", "양방향 도로" }, { "U dönüşü levhası", "유턴 표지" }, { "Kaçış rampası", "비상 탈출 램프" },
        { "Kavşak içi yön levhası", "교차로 방향 표지" }, { "İl sınırı levhası", "도 경계 표지" },
        { "Park etmek yasaktır", "주차 금지" }, { "Duraklamak ve park etmek yasaktır", "정차 및 주차 금지" }, { "Park yeri", "주차장" },
        { "Araç Çekilir", "견인 구역" }, { "At arabası giremez", "마차 통행 금지" }, { "Bisiklet geçebilir", "자전거 통행 가능" },
        { "sadece ileri seyir", "직진만 가능" }, { "sağa dönüş içindir", "우회전용" }, { "sola dönüş içindir", "좌회전용" },
        { "yasaklama ve kısıtlamaların sonu", "모든 금지 및 제한 해제" }, { "Dönel kavşak yaklaşımı", "회전교차로 접근" },
        { "Düşük banket", "낮은 갓길" }, { "Gevşek Malzemeli zemin", "느슨한 노면" }, { "Geçme yasağı sonu", "추월 금지 해제" },
        { "Gümrük", "세관" }, { "HGS levhası", "HGS 표지" }, { "Her iki yandan gidiniz", "양쪽으로 통과" },
        { "Işıklı işaret cihazı", "신호등" }, { "Kapalı Park Yeri", "실내 주차장" }, { "Kontrolsüz kavşak", "무신호 교차로" },
        { "Mecburi asgari hız", "최저 속도 의무" }, { "Mecburi bisiklet yolu", "자전거 전용 도로" }, { "Mecburi yaya yolu", "보행자 전용 도로" },
        { "Motorlu taşıt giremez", "자동차 통행 금지" }, { "Motorlu bisiklet giremez", "원동기 자전거 통행 금지" },
        { "Taşıt trafiğine kapalı yol", "차량 통행 금지 도로" }, { "Tehlikeli madde taşıyan taşıt giremez", "위험물 운반 차량 통행 금지" },
        { "Traktör giremez", "트랙터 통행 금지" }, { "Treyler giremez", "트레일러 통행 금지" }, { "Vahşi hayvanlar geçebilir", "야생동물 횡단" },
        { "Yüksek Gerilim Hattı", "고압선" }
    }
}

local function genelTerimlerleCevir(ad, kod)
    local sonuc = ad
    for _, eslesme in ipairs(genelLevhaTerimleri[kod] or {}) do
        local desen = eslesme[1]:gsub("([%(%)%.%+%-%?%[%]%^%$%%])", "%%%1")
        sonuc = sonuc:gsub(desen, eslesme[2])
    end
    return sonuc
end

function ortak.levhaAdi(ad)
    if type(ad) ~= "string" or ad == "" then
        return ad or ""
    end
    local ceviriler = yerelLevhaAdlari[dil.kodu()]
    return (ceviriler and ceviriler[ad]) or tamCeviriBul(ad, dil.kodu()) or genelTerimlerleCevir(ad, dil.kodu())
end

function ortak.levhaAciklamasi(kayit)
    if type(kayit) ~= "table" then
        return ""
    end
    local ceviriler = yerelLevhaAciklamalari[dil.kodu()]
    return (ceviriler and ceviriler[kayit.ad]) or kayit.aciklama or ""
end

function ortak.listeBasligi(kod, adet)
    return string.format(dil.metin("liste_" .. kod), adet)
end

-- Levha açıklamalarını sahnelerden ayırıp ilgili JSON dosyasından okur.
function ortak.levhaAciklamalariniOku(dosyaYolu, beklenenAdet)
    local function guvenliYedek()
        local yedek = {}
        for index = 1, (beklenenAdet or 0) do
            yedek[index] = {
                ad = index == 1 and "" or "Levha açıklaması kullanılamıyor",
                aciklama = index == 1
                    and ""
                    or "Bu levhanın açıklama metni şu anda yüklenemedi."
            }
        end
        return yedek
    end

    local dosya = io.open(
        system.pathForFile(dosyaYolu, system.ResourceDirectory),
        "r"
    )

    if not dosya then
        print("Levha açıklama dosyası okunamadı: " .. tostring(dosyaYolu))
        return guvenliYedek()
    end

    local icerik = dosya:read("*a")
    dosya:close()

    local basarili, tablo = pcall(json.decode, icerik)
    if not basarili or type(tablo) ~= "table" then
        print("Levha JSON dosyası çözülemedi: " .. tostring(dosyaYolu))
        return guvenliYedek()
    end

    return tablo
end

function ortak.ekranBilgileri()
    local originX = display.screenOriginX or 0
    local originY = display.screenOriginY or 0
    local safeOriginY = display.safeScreenOriginY or originY
    local safeHeight = display.safeActualContentHeight or display.actualContentHeight or display.contentHeight
    local bottomInset = 0

    if display.getSafeAreaInsets then
        local _, _, bottom = display.getSafeAreaInsets()
        bottomInset = math.max(0, bottom or 0)
    end

    return {
        letterboxX = math.abs(originX),
        letterboxY = math.abs(originY),
        safeBottom = safeOriginY + safeHeight,
        bottomInset = math.max(8, bottomInset)
    }
end

function ortak.metinOlustur(icerik, ustBosluk, tabBarHeight)
    local oy = math.abs(display.screenOriginY)
    local scrollView = widget.newScrollView({
        top = ustBosluk or 230,
        left = 0,
        width = display.contentWidth,
        height = display.contentHeight + oy - (ustBosluk or 230) - (tabBarHeight or 0),
        horizontalScrollDisabled = true,
        backgroundColor = { 1, 1, 1 }
    })

    local yStart = 10
    local mainPadding = 10
    for paragraph in string.gmatch((icerik or "") .. "\n", "([^\n]*)\n") do
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
    return scrollView
end

function ortak.levhaBoyut(kare, maxWidth, maxHeight, maxScale)
    -- Sahne tasarım genişliği cihazdan büyük olsa bile detay görseli
    -- güvenli yatay kenar boşluklarının dışına taşmasın.
    local ekranMaxGenislik = math.max(1, (display.contentWidth or 320) - 20)
    local kullanilabilirGenislik = math.min(maxWidth or 380, ekranMaxGenislik)
    local olcek = math.min(
        kullanilabilirGenislik / kare.width,
        (maxHeight or 220) / kare.height,
        maxScale or 2.5
    )
    return kare.width * olcek, kare.height * olcek
end

-- Detay ekranında levha ve Geri Dön düğmesini birlikte ortalar.
-- Görsel boyutu değişse bile düğme görselin altında kalır ve güvenli
-- ekran alanının dışına taşmaması için konum sınırlandırılır.
function ortak.detayYerlesimi(gorselYuksekligi)
    local ekran = ortak.ekranBilgileri()
    -- Action barın altından 30 px boşluk bırak.
    local ustSinir = (display.safeScreenOriginY or display.screenOriginY or 0) + 70 + 30
    local altSinir = ekran.safeBottom - 20
    local gorselYuksekligi = math.max(1, gorselYuksekligi or 140)
    local dugmeYuksekligi = 32
    local bosluk = 24
    local resimY = ustSinir + (gorselYuksekligi / 2)
    local enAzResimY = ustSinir + (gorselYuksekligi / 2)
    local enFazlaResimY = altSinir - (gorselYuksekligi / 2) - bosluk - dugmeYuksekligi

    if enFazlaResimY >= enAzResimY then
        resimY = math.max(enAzResimY, math.min(resimY, enFazlaResimY))
    end

    local dugmeY = math.min(
        resimY + (gorselYuksekligi / 2) + bosluk,
        altSinir - (dugmeYuksekligi / 2)
    )
    local metinY = dugmeY + (dugmeYuksekligi / 2) + 26
    return resimY, dugmeY, metinY
end

function ortak.listeRenkleri()
    return {
        rowColor = { default = { 1 }, over = { 0.92, 0.95, 1 } },
        lineColor = { 220 / 255 },
        catColor = {
            default = { 0.05, 0.3, 0.55, 0.9 },
            over = { 0.05, 0.3, 0.55, 0.9 }
        },
        defaultLabelColor = { 0.2 },
        catLabelColor = { 1 }
    }
end

function ortak.sabitListeBasligi(sceneGroup, baslik, ox, oy)
    local y = -(oy or 0) + 35
    local sabitBaslik = display.newRect(
        sceneGroup,
        display.contentCenterX,
        y,
        display.contentWidth + (ox or 0) + (ox or 0),
        70
    )
    sabitBaslik:setFillColor(0.05, 0.3, 0.55, 0.9)
    sabitBaslik:addEventListener("touch", function()
        return true
    end)

    local sabitBaslikMetni = display.newText({
        parent = sceneGroup,
        text = baslik,
        x = display.contentCenterX,
        y = y,
        font = "Poppins-Bold",
        fontSize = 16,
        width = math.max(1, display.contentWidth - 20),
        align = "center"
    })
    sabitBaslikMetni:setFillColor(1)
end

function ortak.geriDonButonu(onRelease, genislik, yukseklik)
    local genislik = genislik or 160
    local yukseklik = yukseklik or 40
    local buton = display.newGroup()
    local zemin = display.newRoundedRect(buton, 0, 0, genislik, yukseklik, 6)
    zemin:setFillColor(unpack(BASLIK_MAVI))

    local yazi = display.newText({
        parent = buton,
        text = "Geri Dön",
        x = 0,
        y = 0,
        font = "Poppins-Bold",
        fontSize = 17,
        align = "center"
    })
    yazi:setFillColor(unpack(BASLIK_BEYAZ))

    function buton:touch(event)
        if event.phase == "began" then
            display.getCurrentStage():setFocus(self)
            self.isFocus = true
            zemin:setFillColor(unpack(BASLIK_MAVI_ACIK))
            return true
        elseif self.isFocus and (event.phase == "ended" or event.phase == "cancelled") then
            display.getCurrentStage():setFocus(nil)
            self.isFocus = false
            zemin:setFillColor(unpack(BASLIK_MAVI))
            if event.phase == "ended" and onRelease then
                onRelease(event)
            end
            return true
        end
        return true
    end

    buton:addEventListener("touch")
    return buton
end

function ortak.listeGeriDonButonu(sceneGroup, onRelease)
    local ekran = ortak.ekranBilgileri()
    local buton = ortak.geriDonButonu(onRelease)
    buton.x = display.contentCenterX
    buton.y = ekran.safeBottom - 28
    sceneGroup:insert(buton)
    return buton
end

function ortak.tabBarGizle(tabBar, sure)
    if not tabBar then return end
    transition.cancel(tabBar)
    -- Görsel gizleme animasyonu sürerken tabbar alttaki açıklama
    -- dokunuşlarını yakalayıp başka bir sayfaya geçirmemeli.
    tabBar.isHitTestable = false
    tabBar.isVisible = true
    tabBar.alpha = 1
    transition.to(tabBar, {
        alpha = 0,
        time = sure or 150,
        onComplete = function()
            if tabBar then tabBar.isVisible = false end
        end
    })
end

function ortak.tabBarGoster(tabBar, sure)
    if not tabBar then return end
    transition.cancel(tabBar)
    tabBar.isHitTestable = true
    tabBar.isVisible = true
    tabBar.alpha = 0
    tabBar:toFront()
    transition.to(tabBar, { alpha = 1, time = sure or 150 })
end

return ortak
