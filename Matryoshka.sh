#! /usr/bin/env bash

# *фс - фаловая система

# создаем sparse файл с названием datafile
dd if=/dev/zero of=datafile bs=1 count=0 seek=512M
# выводим память, физически занимаемую файлом: 0
du -h ./datafile
# выводим память, доступную файлу: 512M
du -h --apparent-size datafile
# создаем в файле ext2 фс: размер файла вырос до 8.3M
mke2fs datafile
# создаем точку монтирования
mkdir mntpt
# монтируем datafile на mntpt/ (datafile будет автоматически подключен к одному из доступных loop псевдоустройств)
sudo mount -o loop datafile mntpt/
# проверяем, что наша фс перечислена среди других смонтированных фс
df -h
# меняем для пользователя права принадлежности точки монтирования
sudo chown -vR dkaganovich mntpt/
# создаем простую файловую структуру
cd mntpt/
echo "Just created" > new.txt
mkdir -p a/b/
# размонтируем устройство
cd ..
sudo umount mntpt/
