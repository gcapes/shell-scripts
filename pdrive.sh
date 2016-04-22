#Mount p drive at /mnt/p-drive
sudo mount -t cifs -o gid=1000,uid=1000,user=mbexegc2,domain=ds.man.ac.uk,sec=ntlmsspi //nask.man.ac.uk/home$ /mnt/p-drive/
