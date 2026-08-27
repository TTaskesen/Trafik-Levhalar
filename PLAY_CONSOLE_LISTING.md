# Google Play Console giriş taslağı

Bu taslak, kullanıcı hikâyesi yazma ve Supabase kaynakları release AAB'den çıkarılmış sürüm içindir. Play Console'a girmeden önce üretilen nihai AAB'nin davranışını tekrar doğrulayın.

## Uygulama bilgisi

- Uygulama adı: Trafik Levhaları
- Uygulama türü: Uygulama
- Paket adı: `com.taskesen.trafiklevhalaritr`
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

Gizlilik politikası URL'si `https://ttaskesen.github.io/Trafik-Levhalar/privacy/` olmalıdır. Data Safety beyanı ve nihai AAB aynı release davranışını anlatmalıdır.

## Mağaza varlıkları

- 512 × 512 mağaza simgesi: `Icon.png` (alfa kanallı PNG) yüklenmeye hazırdır.
- Feature graphic: `store-assets/feature-graphic.png` (1024 × 500, alfa kanalsız PNG) **Main store listing → Graphics → Feature graphic** alanına yüklenmeye hazırdır.
- Yayın için en az iki gerçek Android uygulama ekran görüntüsü yükleyin. Güncel imzalı AAB'den alınmış, cihaz çerçevesi veya yanıltıcı ek metin içermeyen görseller kullanın.
- Önerilen dört dikey ekran: karşılama, kategori menüsü, levha listesi/açıklaması ve gizlilik politikası. 1080 × 1920 çözünürlük iyi bir başlangıçtır.
- Açıklama ve ekran görüntülerinde uygulamada olmayan çevrimiçi işlev veya kullanıcı hikâyesi yazma özelliği vaat etmeyin.

## Play Console'da ayrıca doğrulanacak beyanlar

- **Uygulama erişimi:** Normal eğitim akışı giriş hesabı istemiyorsa, incelemeci için oturum açma veya özel erişim talimatı gerekmez. İmzalı AAB'de bunun hâlâ geçerli olduğunu kontrol edin.
- **Reklamlar:** Son AAB'de reklam SDK'sı veya reklam gösterimi yoksa “Uygulamam reklam içermiyor” beyanı seçilebilir. AAB oluşturulduktan sonra tekrar doğrulayın.
- **Hedef API:** `targetSdk=36` olarak ayarlı. Console gönderiminden hemen önce Google Play'in geçerli hedef API şartını tekrar kontrol edin.

## Supabase yeniden açılırsa: UGC kontrol listesi

1. Kullanıcı içerik göndermeden önce ayrı, açık kullanım şartları onayı ekleyin.
2. Yasak içerik ve davranışları tanımlayan erişilebilir topluluk/UGC politikası yayınlayın.
3. Her görünür hikâye için uygulama içinden içerik bildirme işlevi sağlayın.
4. Kullanıcı veya içerik engelleme işlevini gerçek kullanıcı akışında test edin.
5. Belgelenmiş moderasyon kuyruğu, yanıt süresi, yaptırım ve itiraz süreci oluşturun.
6. Sunucu tarafında oran sınırlama, içerik uzunluğu/doğrulama ve denetim kaydı sağlayın.
7. Gizlilik politikası ve Data Safety beyanını yeni veri akışına göre güncelleyin; ancak ardından release AAB'ye Supabase/UGC kaynaklarını dahil edin.
