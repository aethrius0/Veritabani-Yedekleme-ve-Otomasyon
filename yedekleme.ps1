$tarih = Get-Date -Format "yyyy-MM-dd_HH-mm"
$logDosya = "C:\Backup\Proje-7\yedekleme_log.txt"

Invoke-Sqlcmd -ServerInstance "SRC\SQLEXPRESS" -Query "
BACKUP DATABASE [WideWorldImporters]
TO DISK = 'C:\Backup\Proje-7\WWI_Otomatik_$tarih.bak'
WITH FORMAT, NAME = 'Otomatik Yedekleme $tarih', STATS = 10;
"

"$tarih - Yedekleme basarili" | Out-File -Append $logDosya
Write-Host "Yedekleme tamamlandi: $tarih"