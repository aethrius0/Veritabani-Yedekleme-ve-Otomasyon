$tarih = Get-Date -Format "yyyy-MM-dd_HH-mm"
$logDosya = "C:\Backup\Proje-7\yedekleme_log.txt"

try {
    Invoke-Sqlcmd -ServerInstance "SRC\SQLEXPRESS" -Query "
    BACKUP DATABASE [YanlisDB]
    TO DISK = 'C:\Backup\Proje-7\test.bak'
    WITH FORMAT;
    " -ErrorAction Stop
} catch {
    "$tarih - HATA: Yedekleme basarisiz! Hata: $_" | Out-File -Append $logDosya
    Write-Host "HATA: Yedekleme basarisiz!"
}