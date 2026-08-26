# Trafik Levhaları

Türkiye'deki trafik levhalarını tanımaya ve anlamlarını öğrenmeye yardımcı, Solar2D ile hazırlanmış çevrimdışı eğitim uygulaması.

## İçerik

- Tehlike ve uyarı, trafik tanzim, bilgi, duraklama/park etme, yatay işaretler ve otoyol levhaları
- Levha açıklamaları ve trafik levhalarının tarihçesi
- Türkçe, Almanca, Fransızca ve Korece arayüz seçenekleri
- Uygulama içi statik hikâye okuyucu

## Çalıştırma

1. Solar2D Simulator'ı açın.
2. Bu klasörü proje olarak açın.
3. Simulator'dan çalıştırın ve karşılama ekranından bir dil seçin.

## Hikâye yazma debug akışı

Normal release'te **Bana Bir Hikâye Yaz** görünmez. Yerel debug testinde açmak için örnek ayarı kopyalayın:

```sh
cp uygulama_ayar.local.example.lua uygulama_ayar.local.lua
```

`uygulama_ayar.local.lua` Git tarafından yok sayılır ve release AAB'ye dahil edilmez. `hikayeSunucuAktif = false` iken yazılan hikâyeler yalnız cihazda saklanır. Supabase projesi yeniden açılmadan bu değeri `true` yapmayın.

## Google Play release

- Paket: `com.taskesen.trafiklevhalari`
- Sürüm: `1.0.0` (`versionCode=6`)
- Release AAB'de kullanıcı hikâyesi yazma, Supabase ve UGC kaynakları hariç tutulur; ağ izni istenmez.
- Hedef API seviyesi, kullanılan Solar2D sürümünün oluşturduğu AAB manifestinden yayın öncesinde doğrulanmalıdır.

İmzalama, AAB doğrulama, Play App Signing ve GitHub Pages gizlilik politikası adımları için [GOOGLE_PLAY_RELEASE.md](GOOGLE_PLAY_RELEASE.md) dosyasına bakın. Play Console metin taslağı [PLAY_CONSOLE_LISTING.md](PLAY_CONSOLE_LISTING.md) dosyasındadır.

## Güvenlik ve gizlilik

Keystore, imza dosyaları, Supabase yapılandırması ve yerel debug ayarları Git'e eklenmez. Release gizlilik politikası kaynağı `docs/privacy/index.html` dosyasındadır; GitHub Pages üzerinden HTTPS ile yayınlanmadan önce gözden geçirilmelidir.

## Kontroller

Lua kaynaklarını denetlemek için:

```sh
find . -type f -name '*.lua' -not -path './.git/*' -print0 | xargs -0 -n1 luac -p
```

JSON dosyalarını denetlemek için:

```sh
find . -type f -name '*.json' -not -path './.git/*' -print0 | xargs -0 -n1 jq empty
```

Bu statik kontroller, gerçek Android cihazdaki safe-area, dokunma, tabbar ve kaydırma testlerinin yerine geçmez.
