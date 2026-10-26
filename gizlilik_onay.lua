--------------------------------------------------------------------------------
-- İlk kullanımda gizlilik politikasını açıp okuma seçeneği sunar.
-- Politika bağlantısını açıp devam etme seçimi yalnızca bu uygulamanın
-- cihazdaki tercih alanına yazılır; kişisel veri işleme izni değildir.
--------------------------------------------------------------------------------
local composer = require("composer")
local widget = require("widget")
local scene = composer.newScene()

local POLITIKA_URL = "https://ttaskesen.github.io/Trafik-Levhalar/privacy/"
local OKUMA_ANAHTARI = "privacyPolicyRead"

local metinler = {
	tr = {
		baslik = "GİZLİLİK POLİTİKASI",
		aciklama = "Devam etmeden önce gizlilik politikasını açıp inceleyin. Uygulama sınav puanınızı, tamamlanan sınav sayısını, yanlış cevapları ve seçtiğiniz dili yalnızca bu cihazda saklar; bu kayıtlar sunucuya gönderilmez.",
		politika = "Gizlilik politikasını aç",
		onay = "Okudum, devam et",
		cikis = "Uygulamadan çık",
		onayUyarisi = "Devam etmek için önce gizlilik politikasını açın.",
	},
	de = {
		baslik = "DATENSCHUTZ",
		aciklama = "Bitte öffnen und lesen Sie die Datenschutzerklärung, bevor Sie fortfahren. Prüfungsergebnisse, abgeschlossene Prüfungen, falsche Antworten und die gewählte Sprache werden nur auf diesem Gerät gespeichert und nicht an einen Server gesendet.",
		politika = "Datenschutzerklärung öffnen",
		onay = "Gelesen, weiter",
		cikis = "App beenden",
		onayUyarisi = "Öffnen Sie zuerst die Datenschutzerklärung.",
	},
	fr = {
		baslik = "CONFIDENTIALITÉ",
		aciklama = "Veuillez ouvrir et lire la politique de confidentialité avant de continuer. Les scores, les examens terminés, les réponses incorrectes et la langue choisie sont enregistrés uniquement sur cet appareil et ne sont pas envoyés à un serveur.",
		politika = "Ouvrir la politique",
		onay = "Lu, continuer",
		cikis = "Quitter l’application",
		onayUyarisi = "Veuillez d’abord ouvrir la politique de confidentialité.",
	},
	ko = {
		baslik = "개인정보 처리방침",
		aciklama = "계속하기 전에 개인정보 처리방침을 열어 확인해 주세요. 시험 점수, 완료한 시험 수, 오답 및 선택한 언어는 이 기기에만 저장되며 서버로 전송되지 않습니다.",
		politika = "개인정보 처리방침 열기",
		onay = "읽었으며 계속하기",
		cikis = "앱 종료",
		onayUyarisi = "먼저 개인정보 처리방침을 열어 주세요.",
	},
	zh = {
		baslik = "隐私政策",
		aciklama = "继续前，请打开并阅读隐私政策。测验分数、已完成测验数量、错误答案和所选语言仅保存在本设备上，不会发送到服务器。",
		politika = "打开隐私政策",
		onay = "已阅读，继续",
		cikis = "退出应用",
		onayUyarisi = "请先打开隐私政策。",
	},
}

local function dilMetinleri()
	local kod = system.getPreference("ui", "language", "string") or "tr"
	kod = kod:lower()
	if kod:find("^zh") then
		return metinler.zh
	end
	local dilKodu = require("dil").kodu()
	return metinler[dilKodu] or metinler.tr
end

function scene.gerekli()
	return system.getPreference("app", OKUMA_ANAHTARI, "boolean") ~= true
end

function scene:create()
	local grup = self.view
	local m = dilMetinleri()
	local guvenliUst = display.safeScreenOriginY or display.screenOriginY or 0
	local guvenliAlt = guvenliUst + (display.safeActualContentHeight or display.actualContentHeight or display.contentHeight)

	local zemin = display.newRect(grup, display.contentCenterX, display.contentCenterY,
		display.contentWidth, display.contentHeight)
	zemin:setFillColor(0.84, 0.91, 0.97)

	local baslik = display.newText(grup, m.baslik, display.contentCenterX,
		guvenliUst + 32, "Poppins-Bold", 20)
	baslik:setFillColor(0.05, 0.3, 0.55)

	local aciklama = display.newText({
		parent = grup,
		text = m.aciklama,
		x = display.contentCenterX,
		y = guvenliUst + 142,
		width = display.contentWidth - 36,
		font = "Poppins-Medium",
		fontSize = 14,
		align = "left",
	})
	aciklama:setFillColor(0.08, 0.08, 0.08)

	local politikaAcildi = false
	local onayDugmesi

	local politikaDugmesi = widget.newButton({
		label = m.politika,
		shape = "roundedRect",
		width = display.contentWidth - 48,
		height = 48,
		cornerRadius = 10,
		font = "Poppins-Bold",
		fontSize = 14,
		fillColor = { default = { 0.05, 0.3, 0.55 }, over = { 0.03, 0.23, 0.43 } },
		labelColor = { default = { 1, 1, 1 } },
		onRelease = function()
			local acildi = pcall(system.openURL, POLITIKA_URL)
			if acildi then
				politikaAcildi = true
				onayDugmesi:setEnabled(true)
			end
			return true
		end,
	})
	politikaDugmesi.x = display.contentCenterX
	politikaDugmesi.y = guvenliAlt - 126
	grup:insert(politikaDugmesi)

	onayDugmesi = widget.newButton({
		label = m.onay,
		shape = "roundedRect",
		width = display.contentWidth - 48,
		height = 48,
		cornerRadius = 10,
		font = "Poppins-Bold",
		fontSize = 14,
		fillColor = { default = { 0.05, 0.3, 0.55 }, over = { 0.03, 0.23, 0.43 } },
		labelColor = { default = { 1, 1, 1 } },
		onRelease = function()
			if not politikaAcildi then
				native.showAlert(m.baslik, m.onayUyarisi, { "OK" })
				return true
			end
			local kaydedildi = pcall(system.setPreferences, "app", { [OKUMA_ANAHTARI] = true })
			if not kaydedildi or scene.gerekli() then
				native.showAlert(m.baslik, "Seçiminiz bu cihazda kaydedilemedi. Lütfen yeniden deneyin.", { "OK" })
				return true
			end
			composer.gotoScene("giris", "fade", 350)
			return true
		end,
	})
	onayDugmesi.x = display.contentCenterX
	onayDugmesi.y = guvenliAlt - 70
	onayDugmesi:setEnabled(false)
	grup:insert(onayDugmesi)

	local cikisDugmesi = widget.newButton({
		label = m.cikis,
		shape = "roundedRect",
		width = display.contentWidth - 48,
		height = 40,
		cornerRadius = 10,
		font = "Poppins-Medium",
		fontSize = 12,
		fillColor = { default = { 0.32, 0.38, 0.43 }, over = { 0.25, 0.3, 0.35 } },
		labelColor = { default = { 1, 1, 1 } },
		onRelease = function()
			if native.requestExit then
				pcall(native.requestExit)
			else
				native.showAlert(m.baslik, m.cikis .. ".", { "OK" })
			end
			return true
		end,
	})
	cikisDugmesi.x = display.contentCenterX
	cikisDugmesi.y = guvenliAlt - 24
	grup:insert(cikisDugmesi)
end

function scene:show(event)
	if event.phase == "did" then
		local tabBar = composer.getVariable("tabBar")
		if tabBar then
			tabBar.isVisible = false
		end
	end
end

scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
return scene
