# iOS yayın hazırlığı

Bu proje için iOS App Store hazırlık durumu:

- Uygulama sürümü: `1.0.2`
- İlk iOS derleme numarası: `9`
- Uygulama simgeleri: `Images.xcassets/AppIcon.appiconset`
- Açılış ekranı: `LaunchScreen.storyboardc`
- Gizlilik politikası: `https://ttaskesen.github.io/Trafik-Levhalar/privacy/`

Apple Developer Program üyeliği etkin olduğundan aşağıdaki adımlar uygulanabilir:

1. Apple Developer hesabında benzersiz Bundle ID oluşturun. Android paket adını kullanmak istenirse `com.taskesen.trafiklevhalaritr` seçilebilir; kullanılabilirlik hesabın içinde doğrulanmalıdır.
2. Solar2D Build iletişim kutusunda aynı Bundle ID, sürüm `1.0.2` ve derleme numarası `9` ile iOS/Xcode projesi üretin.
3. Xcode'da Apple Distribution sertifikası ve App Store provisioning profile ile Archive oluşturun.
4. Archive doğrulamasını tamamlayıp TestFlight'a yükleyin.
5. App Store Connect'te mağaza metinleri, yaş derecelendirmesi, gizlilik beyanı ve iPhone ekran görüntülerini tamamlayın.
6. Fiziksel iPhone/iPad üzerinde ana ekran, levha listesi, geri dönüş düğmesi, hikâye ekranı ve gizlilik bağlantısını test edin.

Her yeni yüklemede `CFBundleVersion` artırılmalıdır. Uygulamanın sürümü değişirse `CFBundleShortVersionString` de güncellenmelidir.
