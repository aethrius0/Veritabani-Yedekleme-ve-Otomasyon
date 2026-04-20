$tarih = Get-Date -Format "yyyy-MM-dd_HH-mm"
$logDosya = "C:\Backup\Proje-7\yedekleme_log.txt"

try {
    Invoke-Sqlcmd -ServerInstance "SRC\SQLEXPRESS" -Query "
    BACKUP DATABASE [WideWorldImporters]
    TO DISK = 'C:\Backup\Proje-7\WWI_Otomatik_$tarih.bak'
    WITH FORMAT, NAME = 'Otomatik Yedekleme $tarih', STATS = 10;
    " -ErrorAction Stop

    "$tarih - BASARILI: Yedekleme tamamlandi" | Out-File -Append $logDosya
    Write-Host "Yedekleme basarili: $tarih"
}
catch {
    "$tarih - HATA: Yedekleme basarisiz! Hata: $_" | Out-File -Append $logDosya
    Write-EventLog -LogName Application -Source "WWI_Yedekleme" -EntryType Error -EventId 1001 -Message "Yedekleme basarisiz: $_"
    Write-Host "HATA: Yedekleme basarisiz!"
}