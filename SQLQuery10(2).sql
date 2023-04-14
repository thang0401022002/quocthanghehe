DROP database QLBanHang
------
RESTORE DATABASE QLBanHang
FROM DISK = 'D:\QLBH.bak'
WITH STANDBY = 'D:\QLBH_undoFile.undo';