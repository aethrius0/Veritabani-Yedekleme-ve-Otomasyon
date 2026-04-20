-- ================================================
-- PROJE 7: Veritabanı Yedekleme ve Otomasyon
-- Veritabanı: WideWorldImporters
-- Sunucu: SRC\SQLEXPRESS
-- ================================================

-- Recovery Model'i FULL olarak ayarla
ALTER DATABASE [WideWorldImporters]
SET RECOVERY FULL;

-- 1. TAM (FULL) YEDEKLEME
BACKUP DATABASE [WideWorldImporters]
TO DISK = 'C:\Backup\Proje-7\WWI_Full.bak'
WITH FORMAT,
     MEDIANAME = 'WWIBackup',
     NAME = 'WideWorldImporters Full Backup',
     STATS = 10;

-- 2. FARK (DIFFERENTIAL) YEDEKLEME
BACKUP DATABASE [WideWorldImporters]
TO DISK = 'C:\Backup\Proje-7\WWI_Diff.bak'
WITH DIFFERENTIAL,
     NAME = 'WideWorldImporters Differential Backup',
     STATS = 10;

-- 3. FULL BACKUP (Recovery Model degisince tekrar gerekli)
BACKUP DATABASE [WideWorldImporters]
TO DISK = 'C:\Backup\Proje-7\WWI_Full_2.bak'
WITH FORMAT,
     MEDIANAME = 'WWIBackup',
     NAME = 'WideWorldImporters Full Backup 2',
     STATS = 10;

-- 4. LOG YEDEKLEME
BACKUP LOG [WideWorldImporters]
TO DISK = 'C:\Backup\Proje-7\WWI_Log.bak'
WITH NAME = 'WideWorldImporters Log Backup',
     STATS = 10;
