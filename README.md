# YOUTUBE LİNKİ:
https://youtu.be/tIIYdr4S6JI

# ⚙️ Veritabanı Yedekleme ve Otomasyon Çalışması

![SQL Server](https://img.shields.io/badge/SQL%20Server-2022-CC2927?style=for-the-badge&logo=microsoft-sql-server&logoColor=white)
![PowerShell](https://img.shields.io/badge/PowerShell-5.1-5391FE?style=for-the-badge&logo=powershell&logoColor=white)
![Platform](https://img.shields.io/badge/Platform-Windows-0078D6?style=for-the-badge&logo=windows)

> BLM4522 Ağ Tabanlı Paralel Dağıtım Sistemleri — Proje 7

## 📌 Proje Hakkında

Bu projede **WideWorldImporters** veritabanı üzerinde yedekleme işlemleri otomatikleştirilmiş, hata durumlarında alert sistemi kurulmuş ve yedekleme geçmişi raporlanmıştır.

---

## 📁 Dosya Yapısı
📦 BLM4522-Proje7/
┣ 📜 01_yedekleme_scriptleri.sql
┣ 📜 02_yedekleme_raporu.sql
┣ 📜 yedekleme.ps1
┗ 📜 hata_test.ps1

---

## 🔄 Uygulanan Adımlar

### 1️⃣ Veritabanı Kurulumu
WideWorldImporters Microsoft'un resmi reposundan indirildi ve SSMS üzerinden restore edildi.

### 2️⃣ Recovery Model Ayarı
```sql
ALTER DATABASE [WideWorldImporters]
SET RECOVERY FULL;
```

### 3️⃣ Yedekleme Stratejileri

| Tür | Dosya | Boyut |
|-----|-------|-------|
| 🟢 Full | WWI_Full.bak | ~460 MB |
| 🟡 Differential | WWI_Diff.bak | ~34 MB |
| 🔵 Log | WWI_Log.bak | ~2 MB |

### 4️⃣ PowerShell Otomasyonu
SQL Server Agent olmadığından PowerShell scripti yazıldı. Try-catch ile hata yönetimi sağlandı.

```powershell
try {
    Invoke-Sqlcmd -ServerInstance "DESKTOP-VMGDL0B\SQLEXPRESS01" -Query "
    BACKUP DATABASE [WideWorldImporters]
    TO DISK = 'C:\Backup\Proje-7\WWI_Otomatik.bak'
    WITH FORMAT, STATS = 10;"
    Write-Host "Yedekleme basarili"
} catch {
    Write-Host "HATA: Yedekleme basarisiz!"
}
```

### 5️⃣ Windows Task Scheduler
Her gece **02:00**'de otomatik çalışacak görev oluşturuldu.

```cmd
schtasks /create /tn "WWI_Otomatik_Yedekleme"
/tr "powershell -ExecutionPolicy Bypass -File C:\Backup\Proje-7\yedekleme.ps1"
/sc daily /st 02:00 /ru SYSTEM
```

### 6️⃣ Alert ve Hata Loglama

Yedekleme sonuçları `yedekleme_log.txt` dosyasına kaydedilir:
✅ 2026-05-02_15-30 - BASARILI: Yedekleme tamamlandi
❌ 2026-05-02_15-33 - HATA: Yedekleme basarisiz!

### 7️⃣ Yedekleme Geçmişi Raporu
msdb üzerinden Full, Differential ve Log yedeklemeleri listelendi.

---

## ⚠️ Notlar

- SQL Server **Express Edition**'da SQL Server Agent bulunmamaktadır
- Otomasyon **PowerShell + Windows Task Scheduler** ile sağlandı
- Log yedekleme için Recovery Model **FULL** olmalıdır
