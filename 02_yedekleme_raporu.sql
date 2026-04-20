SELECT 
    database_name AS 'Veritabani',
    backup_start_date AS 'Baslangic',
    backup_finish_date AS 'Bitis',
    DATEDIFF(SECOND, backup_start_date, backup_finish_date) AS 'Sure(sn)',
    CASE type 
        WHEN 'D' THEN 'Tam Yedekleme'
        WHEN 'I' THEN 'Fark Yedekleme'
        WHEN 'L' THEN 'Log Yedekleme'
    END AS 'Yedekleme Turu',
    CAST(backup_size/1024/1024 AS INT) AS 'Boyut(MB)',
    physical_device_name AS 'Dosya Yolu'
FROM msdb.dbo.backupset bs
JOIN msdb.dbo.backupmediafamily bmf 
    ON bs.media_set_id = bmf.media_set_id
WHERE database_name = 'WideWorldImporters'
ORDER BY backup_start_date DESC;