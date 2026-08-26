# Google Play Console giriş taslağı

Bu taslak, kullanıcı hikâyesi yazma ve Supabase kaynakları release AAB'den çıkarılmış sürüm içindir. Play Console'a girmeden önce üretilen nihai AAB'nin davranışını tekrar doğrulayın.

## Uygulama bilgisi

- Uygulama adı: Trafik Levhaları
- Uygulama türü: Uygulama
- Paket adı: `com.taskesen.trafiklevhalari`
- Kategori önerisi: Eğitim
- İletişim e-postası: `turguttaskesen@gmail.com`

## Kısa açıklama

Türkiye'deki trafik levhalarını öğrenmeye yardımcı çevrimdışı eğitim uygulaması.

## Uzun açıklama

Trafik Levhaları, karayolu işaretlerini tanımayı ve anlamlarını öğrenmeyi kolaylaştıran bir eğitim uygulamasıdır.

Uygulamada tehlike ve uyarı, trafik tanzim, bilgi, duraklama ve park etme, yatay işaretler, yeni standart levhalar ve otoyol levhaları bulunur. Statik hikâye okuyucu da uygulama içeriğinin parçasıdır.

- Levhaları kategori kategori inceleme
- Her levha için açıklama ve bilgi
- Trafik levhalarının tarihçesi
- Sade ve öğrenmeye odaklı arayüz
- Temel içeriklere çevrimdışı erişim

## Hedef kitle beyanı taslağı

Uygulama trafik levhalarını tanıtan genel eğitim içeriğidir. Play Console'da yalnızca gerçekten hedeflediğiniz yaş gruplarını seçin. Uygulama özellikle çocuklara yöneltilmiyorsa, ilgili beyan ancak mağaza metni, görseller ve dağıtım tercihi bunu destekliyorsa verilmelidir. İçerik derecelendirmesi anketi nihai yaş derecesini belirler.

## Data Safety taslağı

Nihai release AAB; kullanıcı hikâyesi yazma, Supabase, raporlama, reklam SDK'sı ve `INTERNET` izni içermez. Dil tercihi gibi sınırlı teknik ayarlar yalnız cihazdaki uygulama alanında saklanabilir. Bu teknik inceleme aynı kalırsa aşağıdaki taslak uygundur:

| Play Console sorusu | Taslak yanıt |
|---|---|
| Uygulama kullanıcı verisi topluyor veya paylaşıyor mu? | Hayır. Nihai AAB ve kullanılan tüm SDK'lar yeniden kontrol edilmeden bu yanıt kesinleştirilmemelidir. |
| Veriler aktarım sırasında şifreleniyor mu? | Uygulanamaz; bu release kullanıcı verisi aktarmıyor. |
| Kullanıcı veri silme isteğinde bulunabilir mi? | Uygulama hesap veya kişisel veri tutmuyor. Gizlilik soruları destek e-postasından alınır. |
| Reklam içeriyor mu? | Hayır; nihai AAB'de reklam SDK'sı veya reklam gösterimi bulunmadığı doğrulanırsa. |

Gizlilik politikası URL'si, Data Safety beyanı ve nihai AAB aynı release davranışını anlatmalıdır.

## Mağaza varlıkları

- 512 × 512 mağaza simgesi: gerçek final simgeyi yükleyin.
- Feature graphic: Play Console'un güncel boyut/biçim kuralına uygun ve uygulamayı dürüstçe temsil eden görsel hazırlayın.
- Gerçek Android release veya test AAB'sinden ekran görüntüleri: karşılama, kategori menüsü, levha listesi, levha açıklaması ve tarih/bilgi ekranı.
- Açıklama ve ekran görüntülerinde uygulamada olmayan çevrimiçi işlev veya kullanıcı hikâyesi yazma özelliği vaat etmeyin.

## Supabase yeniden açılırsa: UGC kontrol listesi

1. Kullanıcı içerik göndermeden önce ayrı, açık kullanım şartları onayı ekleyin.
2. Yasak içerik ve davranışları tanımlayan erişilebilir topluluk/UGC politikası yayınlayın.
3. Her görünür hikâye için uygulama içinden içerik bildirme işlevi sağlayın.
4. Kullanıcı veya içerik engelleme işlevini gerçek kullanıcı akışında test edin.
5. Belgelenmiş moderasyon kuyruğu, yanıt süresi, yaptırım ve itiraz süreci oluşturun.
6. Sunucu tarafında oran sınırlama, içerik uzunluğu/doğrulama ve denetim kaydı sağlayın.
7. Gizlilik politikası ve Data Safety beyanını yeni veri akışına göre güncelleyin; ancak ardından release AAB'ye Supabase/UGC kaynaklarını dahil edin.
