# Google Play release hazırlığı

## Sabit release bilgileri

- Paket adı: `com.taskesen.trafiklevhalari`
- Sürüm adı: `1.0.0`
- Sürüm kodu: `6`
- Hedef: Google Play, `targetSdk=36`
- Release davranışı: statik hikâye okuyucu açıktır. Kullanıcı hikâyesi yazma, Supabase, içerik bildirimi ve yazar engelleme kaynakları yalnız debug içindir ve release AAB'den çıkarılır.

`targetSdk` değeri `build.settings` içinde ayarlanmaz; kullanılan Solar2D sürümünün oluşturduğu AAB manifestinde doğrulanır. Google Play'e yüklemeden önce AAB'nin gerçekten API 36 hedeflediğini kontrol edin.

## 1. Upload keystore'u güvenle oluşturun

Bu adımı Terminal'de, proje klasörü dışında ve yedeklenen özel bir dizinde uygulayın. Keystore veya parolalarını Git'e, e-postaya ya da ekran görüntüsüne koymayın.

```sh
keytool -genkeypair -v \
  -keystore "/guvenli/klasor/trafik-levhalari-upload.jks" \
  -alias trafik-levhalari-upload \
  -keyalg RSA -keysize 2048 -validity 10000
```

Komutun istediği keystore ve anahtar parolalarını bir parola yöneticisine kaydedin. Oluşturduğunuz `.jks` dosyasını bu çalışma ağacına kopyalamayın. `.gitignore` zaten `*.jks`, `*.keystore`, `key.properties` ve `signing.properties` dosyalarını dışlar; yine de `git status` ile kontrol edin.

## 2. Solar2D ile imzalı release AAB oluşturun

1. Solar2D Simulator'da bu proje klasörünü açın.
2. **File → Build → Android** seçin.
3. Application Name için `Trafik Levhaları` yazın.
4. Package alanına tam olarak `com.taskesen.trafiklevhalari` girin. İlk Play yüklemesinden sonra bu ad değiştirilemez.
5. Version Name `1.0.0`, Version Code `6` olmalı. Yeni bir Play yüklemesinde versionCode artırılmalıdır.
6. Target App Store olarak **Google Play** seçin.
7. Keystore menüsünde **Debug** seçmeyin. Özel upload `.jks` dosyasını, parolasını ve `trafik-levhalari-upload` alias'ını seçin.
8. **Create Live Build** kutusunu işaretlemeyin; Live Build yalnızca debug keystore ile kullanılmalıdır.
9. Boş ve proje dışındaki bir çıktı klasörünü seçin, ardından Build çalıştırın. Solar2D hem `.apk` hem `.aab` üretebilir; Play'e yalnızca `.aab` yükleyin.

## 3. AAB'yi yüklemeden önce doğrulayın

Terminal'de çıktı dosyasının bulunduğu klasörde aşağıdaki komutu çalıştırın:

```sh
jarsigner -verify -verbose -certs "Trafik Levhaları.aab"
```

Komut imza doğrulamasını başarılı göstermelidir. Sertifika bölümünde `CN=Android Debug` veya `androiddebugkey` görünüyorsa dosya test paketidir: silmeden saklayabilir, fakat Play Console'a yüklemeyin. Gerekirse aynı AAB'nin kimliğini ayrıca kontrol edin:

```sh
keytool -printcert -jarfile "Trafik Levhaları.aab"
```

Projede bulunan aşağıdaki kontrol betiği aynı `jarsigner` doğrulamasını yapar ve debug sertifikası bulursa hata koduyla durur:

```sh
bash scripts/verify_release_aab.sh "/tam/yol/Trafik Levhaları.aab"
```

Son kontrol: Play Console'un yükleme ekranında paket adını, versionCode'u ve hedef API bilgisini AAB'den okuduğu değerlerle karşılaştırın. Bu üç değer uyuşmuyorsa yayına devam etmeyin.

## 4. Play App Signing

1. Play Console'da yeni uygulamayı yukarıdaki paket adıyla oluşturun.
2. İlk imzalı AAB'yi önce internal test kanalına yükleyin.
3. Play App Signing kurulumu ekranında Google'ın uygulama imzalama anahtarını yönetmesine izin verin.
4. Yerel upload keystore yalnızca gelecek AAB yüklemelerini imzalamak için saklanır; kaybolursa Play Console üzerinden upload key sıfırlama süreci gerekir.
5. Test başarılı olduktan sonra kapalı test ve ardından production akışına ilerleyin. Yeni kişisel geliştirici hesaplarında production erişimi için Play'in güncel kapalı test koşulları ayrıca uygulanabilir.

## 5. Gizlilik politikasını GitHub Pages ile yayınlayın

Bu repoda Pages kaynağı için hazır dosya `docs/privacy/index.html` konumundadır. Yayın yapılmamıştır.

1. Değişiklikleri ancak gözden geçirip commit/push onayı verdikten sonra GitHub'a gönderin.
2. GitHub deposunda **Settings → Pages** açın.
3. **Build and deployment / Source** alanında **Deploy from a branch** seçin.
4. Yayınlanacak dalı ve klasör olarak `/docs` seçin; Save'e basın.
5. GitHub'ın gösterdiği HTTPS URL'nin, örneğin `https://ttaskesen.github.io/Trafik-Levhalar-/privacy/`, açıldığını gizli pencere ve mobil ağ üzerinden doğrulayın.
6. Bu HTTPS adresini Play Console'daki Privacy policy alanına girin. İstenirse uygulama içindeki politika metni ile URL'deki metnin aynı release'i anlattığını tekrar karşılaştırın.

Pages herkese açıktır; `docs/` altına anahtar, test verisi veya kişisel belge koymayın. Özel alan adı kullanılacaksa GitHub Pages ayarlarından ekleyin, DNS kaydını doğrulayın ve alan adını GitHub'da doğrulayın; rastgele bir `CNAME` dosyası eklemek yeterli değildir.

## 6. Yayın öncesi zorunlu kontrol

- Güncel AAB'de release sertifikası, paket adı, `versionCode=6` ve `targetSdk=36` doğrulandı.
- Release AAB'de hikâye yazma girişinin görünmediği, `INTERNET` izninin bulunmadığı ve statik hikâye okuyucunun çevrimdışı çalıştığı Android cihazda test edildi.
- Gizlilik URL'si HTTPS üzerinde herkese açık, uygulama içi metinle ve Data Safety ile uyumlu.
- Gerçek Android cihazdan ekran görüntüleri alındı ve tüm gezinme test edildi.
- Play Console'daki Data Safety, reklamlar, hedef kitle, içerik derecelendirmesi ve mağaza listesi son AAB davranışına göre dolduruldu.
