#!/usr/bin/env bash
set -euo pipefail

if [[ $# -ne 1 ]]; then
  echo "Kullanım: $0 /tam/yol/Trafik-Levhalari.aab" >&2
  exit 64
fi

aab_path=$1
if [[ ! -f "$aab_path" ]]; then
  echo "AAB dosyası bulunamadı: $aab_path" >&2
  exit 66
fi

if ! command -v jarsigner >/dev/null 2>&1; then
  echo "jarsigner bulunamadı. Java JDK kurulumunu kontrol edin." >&2
  exit 69
fi

output_file=$(mktemp)
trap 'rm -f "$output_file"' EXIT

if ! jarsigner -verify -verbose -certs "$aab_path" >"$output_file" 2>&1; then
  cat "$output_file" >&2
  echo "AAB imza doğrulaması başarısız." >&2
  exit 1
fi

cat "$output_file"

if grep -Eiq 'CN=Android Debug|androiddebugkey' "$output_file"; then
  echo "HATA: AAB debug sertifikasıyla imzalı. Play Console'a yüklemeyin." >&2
  exit 1
fi

echo "İmza doğrulandı ve debug sertifikası bulunmadı."
echo "Paket adı, versionCode ve targetSdk=36 değerini Play Console yükleme sonucundan ayrıca doğrulayın."
