#!/bin/bash

# GRUB güncelleme fonksiyonu
update_grub() {
    echo "GRUB güncelleniyor..."
    sudo update-grub
}

# GRUB'ı yeniden yükleme fonksiyonu
reinstall_grub() {
    echo "GRUB sıfırlanıyor ve yeniden yükleniyor..."
    sudo grub-install /dev/sda  # /dev/sda, sabit diskiniz olmalı. Eğer farklıysa, uygun diski belirtin.
    update_grub
}

# GRUB'a Windows'u ekleme fonksiyonu
add_windows_to_grub() {
    echo "Windows tespit ediliyor ve GRUB'a ekleniyor..."
    # Windows'ı GRUB'a eklemek için os-prober'ı kullanacağız
    sudo os-prober
    update_grub
}

# Windows'un varlığını kontrol etme fonksiyonu
check_windows() {
    # Eğer Windows sistemine ait bir bölüm bulunuyorsa, GRUB'da bu Windows'u eklemeyi başarmalıyız
    if sudo blkid | grep -i "ntfs" > /dev/null; then
        echo "Windows bölümü bulundu. GRUB'a ekleniyor..."
        add_windows_to_grub
    else
        echo "Windows bölümü bulunamadı. Lütfen kontrol edin."
        exit 1
    fi
}

# GRUB'un kaybolduğunu kontrol etme fonksiyonu
check_grub() {
    # Eğer GRUB yoksa, yeniden yükle
    if ! sudo grub-install --version > /dev/null 2>&1; then
        echo "GRUB tespit edilemedi. GRUB sıfırlanıyor..."
        reinstall_grub
    else
        echo "GRUB mevcut."
    fi
}

# Kullanıcıdan yeniden başlatma onayı alma fonksiyonu
ask_for_reboot() {
    read -p "Değişiklikler tamamlandı. Sistemi yeniden başlatmak ister misiniz? (Evet/Hayır): " answer
    case "$answer" in
        [Ee][Vv][Ee][Tt] | [Ee]) 
            echo "Sistem yeniden başlatılıyor..."
            sudo reboot
            ;;
        [Hh][Aa][Yy][Ii][Rr] | [Hh]) 
            echo "Yeniden başlatma iptal edildi."
            ;;
        *)
            echo "Geçersiz giriş. Yeniden başlatma iptal edildi."
            ;;
    esac
}

# Ana fonksiyon
main() {
    # GRUB'u kontrol et ve gerekirse yeniden yükle
    check_grub

    # Windows tespiti yapılıyor
    echo "Windows tespiti yapılıyor..."
    if ! sudo os-prober | grep -i "Windows" > /dev/null; then
        check_windows
    else
        echo "Windows zaten GRUB menüsünde mevcut."
        update_grub
    fi

    # Kullanıcıdan yeniden başlatma onayı al
    ask_for_reboot
}

# Script çalıştırma
main

