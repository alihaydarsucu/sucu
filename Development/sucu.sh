#!/bin/bash

# SUCU - Gelişmiş Sistem Yönetim Aracı
# Versiyon: 0.3
# Arch Linux tabanlı sistemler için yazılmıştır

# Renkler ve Stil Tanımları
declare -A COLORS=(
    [RED]='\033[0;31m'
    [GREEN]='\033[0;32m'
    [YELLOW]='\033[1;33m'
    [BLUE]='\033[0;34m'
    [PURPLE]='\033[0;35m'
    [CYAN]='\033[0;36m'
    [WHITE]='\033[1;37m'
    [BOLD]='\033[1m'
    [DIM]='\033[2m'
    [RESET]='\033[0m'
)

# Unicode Semboller
declare -A ICONS=(
    [SUCCESS]='✅'
    [ERROR]='❌'
    [WARNING]='⚠️'
    [INFO]='ℹ️'
    [ROCKET]='🚀'
    [GEAR]='⚙️'
    [MONITOR]='📊'
    [NETWORK]='🌐'
    [DISK]='💾'
    [SHIELD]='🛡️'
    [UPDATE]='🔄'
    [CLEAN]='🧹'
    [BACKUP]='💼'
    [USER]='👤'
    [LOG]='📝'
    [FIRE]='🔥'
    [HEART]='❤️'
    [DOCTOR]='👨‍⚕️'
    [SEARCH]='🔍'
    [PACKAGE]='📦'
    [TUTORIAL]='📚'
    [GAMING]='🎮'
    [SECURITY]='🔒'
    [TIMER]='⏱️'
    [CONFIG]='⚙️'
)

# Dil sistemi
declare -A LANG_STRINGS
SUCU_LANG="en"  # Varsayılan dil İngilizce

# Dil dosyalarını yükle
load_language() {
    case "$1" in
        "tr")
            LANG_STRINGS=(
                [WELCOME]="SUCU Gelişmiş Sistem Yönetim Aracı"
                [SUBTITLE]="Arch Linux tabanlı sistem yönetimi için tasarlandı"
                [SYSTEM_INFO]="SİSTEM BİLGİLERİ"
                [SYSTEM_MONITOR]="SİSTEM İZLEME"
                [NETWORK_INFO]="AĞ BİLGİLERİ"
                [SYSTEM_UPDATE]="SİSTEM GÜNCELLEMESİ"
                [DISK_INFO]="DİSK BİLGİLERİ"
                [SYSTEM_CLEAN]="SİSTEM TEMİZLEME"
                [USER_MGMT]="KULLANICI YÖNETİMİ"
                [SERVICE_MGMT]="SERVİS YÖNETİMİ"
                [SYSTEM_DOCTOR]="SİSTEM DOKTORU"
                [PACKAGE_MGMT]="PAKET YÖNETİMİ"
                [TUTORIAL]="ÖĞRETİCİ"
                [SECURITY]="GÜVENLİK"
                [COMPLETED]="tamamlandı!"
                [USAGE]="KULLANIM"
                [MAIN_COMMANDS]="TEMEL KOMUTLAR"
                [HELP_INFO]="YARDIM VE BİLGİ"
                [EXAMPLES]="ÖRNEKLER"
                [INVALID_CHOICE]="Geçersiz seçim!"
                [INTERNET_ACTIVE]="İnternet bağlantısı aktif"
                [NO_INTERNET]="İnternet bağlantısı yok"
                [CLEAN_CACHE]="Önbellek temizlendi"
                [REMOVE_UNUSED]="Kullanılmayan paketler kaldırıldı"
                [CLEAN_ORPHANS]="Dağıtılmış paketler temizlendi"
                [ALL_CLEANED]="Tüm temizlik işlemleri tamamlandı"
            )
            ;;
        "en"|*)
            LANG_STRINGS=(
                [WELCOME]="SUCU Advanced System Management Tool"
                [SUBTITLE]="Designed for Arch Linux based system management"
                [SYSTEM_INFO]="SYSTEM INFORMATION"
                [SYSTEM_MONITOR]="SYSTEM MONITORING"
                [NETWORK_INFO]="NETWORK INFORMATION"
                [SYSTEM_UPDATE]="SYSTEM UPDATE"
                [DISK_INFO]="DISK INFORMATION"
                [SYSTEM_CLEAN]="SYSTEM CLEANUP"
                [USER_MGMT]="USER MANAGEMENT"
                [SERVICE_MGMT]="SERVICE MANAGEMENT"
                [SYSTEM_DOCTOR]="SYSTEM DOCTOR"
                [PACKAGE_MGMT]="PACKAGE MANAGEMENT"
                [TUTORIAL]="TUTORIAL"
                [SECURITY]="SECURITY"
                [COMPLETED]="completed!"
                [USAGE]="USAGE"
                [MAIN_COMMANDS]="MAIN COMMANDS"
                [HELP_INFO]="HELP & INFO"
                [EXAMPLES]="EXAMPLES"
                [INVALID_CHOICE]="Invalid choice!"
                [INTERNET_ACTIVE]="Internet connection is active"
                [NO_INTERNET]="No internet connection"
                [CLEAN_CACHE]="Cache cleared"
                [REMOVE_UNUSED]="Unused packages removed"
                [CLEAN_ORPHANS]="Orphaned packages cleaned"
                [ALL_CLEANED]="All cleaning operations completed"
            )
            ;;
    esac
}

# Yapılandırma
SUCU_VERSION="0.3"
SUCU_CONFIG_DIR="$HOME/.config/sucu"
SUCU_LOG_FILE="$SUCU_CONFIG_DIR/sucu.log"
SUCU_CONFIG_FILE="$SUCU_CONFIG_DIR/config"

# Yapılandırma dizinini oluştur
mkdir -p "$SUCU_CONFIG_DIR"

# Varsayılan yapılandırmayı yükle
load_config() {
    if [[ -f "$SUCU_CONFIG_FILE" ]]; then
        source "$SUCU_CONFIG_FILE"
    else
        # Varsayılan yapılandırma oluştur
        cat > "$SUCU_CONFIG_FILE" << EOF
# SUCU Yapılandırma Dosyası
SUCU_DEFAULT_LANG="en"
SUCU_AUTO_UPDATE_CHECK="true"
SUCU_SHOW_TIPS="true"
SUCU_LOG_LEVEL="info"
EOF
        SUCU_DEFAULT_LANG="en"
    fi
    
    # Dil argümanı kontrolü
    if [[ "$1" == "-tr" ]]; then
        SUCU_LANG="tr"
    elif [[ -n "$SUCU_DEFAULT_LANG" ]]; then
        SUCU_LANG="$SUCU_DEFAULT_LANG"
    fi
    
    load_language "$SUCU_LANG"
}

# Logo ve Banner Fonksiyonu
show_banner() {
    clear
    echo -e "${COLORS[CYAN]}${COLORS[BOLD]}"
    cat << 'EOF'
 ____  _   _  ____ _   _ 
/ ___|| | | |/ ___| | | |
\___ \| | | | |   | | | |
 ___) | |_| | |___| |_| |
|____/ \___/ \____|\___/ 
                         
EOF
    echo -e "${COLORS[WHITE]}${LANG_STRINGS[WELCOME]} v${SUCU_VERSION}${COLORS[RESET]}"
    echo -e "${COLORS[DIM]}${LANG_STRINGS[SUBTITLE]}${COLORS[RESET]}\n"
}

# Çıktı formatı fonksiyonları
print_success() { echo -e "${COLORS[GREEN]}${ICONS[SUCCESS]} $1${COLORS[RESET]}"; }
print_error() { echo -e "${COLORS[RED]}${ICONS[ERROR]} $1${COLORS[RESET]}"; }
print_warning() { echo -e "${COLORS[YELLOW]}${ICONS[WARNING]} $1${COLORS[RESET]}"; }
print_info() { echo -e "${COLORS[BLUE]}${ICONS[INFO]} $1${COLORS[RESET]}"; }

# Başlık yazdırma
print_header() {
    echo -e "\n${COLORS[CYAN]}${COLORS[BOLD]}═══ $1 ═══${COLORS[RESET]}"
}

# İpucu gösterme
show_tip() {
    if [[ "$SUCU_SHOW_TIPS" == "true" ]]; then
        local tips=()
        if [[ "$SUCU_LANG" == "tr" ]]; then
            tips=(
                "💡 İpucu: 'sucu sistem-doktoru' ile sistem sağlığınızı kontrol edin!"
                "💡 İpucu: 'sucu ogretici' ile Linux komutlarını öğrenin!"
                "💡 İpucu: 'sucu paket-yonetimi' ile paket arayabilirsiniz!"
                "💡 İpucu: Günlük sistem temizliği için 'sucu sistem-temizle' kullanın!"
                "💡 İpucu: 'sucu guvenlik-kontrol' ile sistemi güvenlik açıklarına karşı tarayın!"
            )
        else
            tips=(
                "💡 Tip: Use 'sucu doctor' to check your system health!"
                "💡 Tip: Learn Linux commands with 'sucu tutorial'!"
                "💡 Tip: Search packages with 'sucu pkg'!"
                "💡 Tip: Use 'sucu clean' for daily system cleanup!"
                "💡 Tip: Scan for security issues with 'sucu security'!"
            )
        fi
        echo -e "${COLORS[YELLOW]}${tips[$((RANDOM % ${#tips[@]}))]}\n${COLORS[RESET]}"
    fi
}

# Yükleme animasyonu
loading_animation() {
    local msg="$1"
    local duration=${2:-2}
    local chars="⠋⠙⠹⠸⠼⠴⠦⠧⠇⠏"
    local i=0
    
    while [ $i -lt $((duration * 10)) ]; do
        printf "\r${COLORS[YELLOW]}${chars:$((i%10)):1} $msg${COLORS[RESET]}"
        sleep 0.1
        ((i++))
    done
    printf "\r${COLORS[GREEN]}${ICONS[SUCCESS]} $msg ${LANG_STRINGS[COMPLETED]}${COLORS[RESET]}\n"
}

# Log fonksiyonu
log_action() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" >> "$SUCU_LOG_FILE"
}

# Sistem bilgisi fonksiyonu
cmd_system_info() {
    show_banner
    print_header "${LANG_STRINGS[SYSTEM_INFO]} ${ICONS[MONITOR]}"
    
    # Temel sistem bilgileri
    echo -e "${COLORS[BOLD]}${ICONS[GEAR]} $(if [[ "$SUCU_LANG" == "tr" ]]; then echo "İşletim Sistemi:"; else echo "Operating System:"; fi)${COLORS[RESET]}"
    if command -v neofetch >/dev/null 2>&1; then
        neofetch --disable packages
    else
        hostnamectl
    fi
    
    echo -e "\n${COLORS[BOLD]}${ICONS[FIRE]} $(if [[ "$SUCU_LANG" == "tr" ]]; then echo "Sistem Durumu:"; else echo "System Status:"; fi)${COLORS[RESET]}"
    if [[ "$SUCU_LANG" == "tr" ]]; then
        uptime -p | sed 's/up /Çalışma süresi: /'
    else
        uptime -p | sed 's/up /Uptime: /'
    fi
    
    echo -e "\n${COLORS[BOLD]}${ICONS[MONITOR]} $(if [[ "$SUCU_LANG" == "tr" ]]; then echo "Kaynak Kullanımı:"; else echo "Resource Usage:"; fi)${COLORS[RESET]}"
    
    # CPU Kullanımı
    cpu_usage=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')
    echo -e "CPU: ${COLORS[YELLOW]}%${cpu_usage}${COLORS[RESET]}"
    
    # Bellek kullanımı
    mem_info=$(free | grep Mem)
    mem_total=$(echo $mem_info | awk '{printf "%.1f", $2/1024}')
    mem_used=$(echo $mem_info | awk '{printf "%.1f", $3/1024}')
    mem_percent=$(echo $mem_info | awk '{printf "%.0f", $3/$2 * 100.0}')
    echo -e "RAM: ${COLORS[YELLOW]}${mem_used}GB / ${mem_total}GB (${mem_percent}%)${COLORS[RESET]}"
    
    # Disk kullanımı
    disk_info=$(df -h / | tail -1)
    disk_total=$(echo $disk_info | awk '{print $2}')
    disk_used=$(echo $disk_info | awk '{print $3}')
    disk_percent=$(echo $disk_info | awk '{print $5}')
    echo -e "Disk: ${COLORS[YELLOW]}${disk_used} / ${disk_total} (${disk_percent})${COLORS[RESET]}"
    
    # Sıcaklık bilgisi (varsa)
    if [[ -f /sys/class/thermal/thermal_zone0/temp ]]; then
        temp=$(cat /sys/class/thermal/thermal_zone0/temp | awk '{print $1/1000}')
        echo -e "Sıcaklık: ${COLORS[YELLOW]}${temp}°C${COLORS[RESET]}"
    fi
    
    # İnternet bağlantısı kontrolü
    if ping -c 1 google.com &> /dev/null; then
        print_success "${LANG_STRINGS[INTERNET_ACTIVE]}"
    else
        print_warning "${LANG_STRINGS[NO_INTERNET]}"
    fi
    
    log_action "System information displayed"
}

# Sistem izleme fonksiyonu
cmd_system_monitor() {
    show_banner
    print_header "${LANG_STRINGS[SYSTEM_MONITOR]} ${ICONS[MONITOR]}"
    
    if [[ "$SUCU_LANG" == "tr" ]]; then
        echo -e "${COLORS[CYAN]}Sistem izleme araçları:${COLORS[RESET]}"
        echo -e "1) ${COLORS[GREEN]}Genel sistem durumu (top)${COLORS[RESET]}"
        echo -e "2) ${COLORS[GREEN]}Disk kullanımı (iotop)${COLORS[RESET]}"
        echo -e "3) ${COLORS[GREEN]}Ağ trafiği (nload)${COLORS[RESET]}"
        echo -e "4) ${COLORS[GREEN]}İşlemci kullanımı (htop)${COLORS[RESET]}"
    else
        echo -e "${COLORS[CYAN]}System monitoring tools:${COLORS[RESET]}"
        echo -e "1) ${COLORS[GREEN]}System overview (top)${COLORS[RESET]}"
        echo -e "2) ${COLORS[GREEN]}Disk activity (iotop)${COLORS[RESET]}"
        echo -e "3) ${COLORS[GREEN]}Network traffic (nload)${COLORS[RESET]}"
        echo -e "4) ${COLORS[GREEN]}CPU usage (htop)${COLORS[RESET]}"
    fi
    echo
    
    read -p "$(if [[ "$SUCU_LANG" == "tr" ]]; then echo "Seçiminiz (1-4): "; else echo "Your choice (1-4): "; fi)" choice
    
    case $choice in
        1)
            if command -v top &>/dev/null; then
                top
            else
                print_error "$(if [[ "$SUCU_LANG" == "tr" ]]; then echo "top komutu bulunamadı"; else echo "top command not found"; fi)"
            fi
            ;;
        2)
            if command -v iotop &>/dev/null; then
                sudo iotop
            else
                print_error "$(if [[ "$SUCU_LANG" == "tr" ]]; then echo "iotop yüklü değil"; else echo "iotop not installed"; fi)"
            fi
            ;;
        3)
            if command -v nload &>/dev/null; then
                nload
            else
                print_error "$(if [[ "$SUCU_LANG" == "tr" ]]; then echo "nload yüklü değil"; else echo "nload not installed"; fi)"
            fi
            ;;
        4)
            if command -v htop &>/dev/null; then
                htop
            else
                print_error "$(if [[ "$SUCU_LANG" == "tr" ]]; then echo "htop yüklü değil"; else echo "htop not installed"; fi)"
            fi
            ;;
        *) print_error "${LANG_STRINGS[INVALID_CHOICE]}" ;;
    esac
    
    log_action "System monitoring performed: choice $choice"
}

# Ağ bilgisi fonksiyonu
cmd_network_info() {
    show_banner
    print_header "${LANG_STRINGS[NETWORK_INFO]} ${ICONS[NETWORK]}"
    
    if [[ "$SUCU_LANG" == "tr" ]]; then
        echo -e "${COLORS[BOLD]}${ICONS[NETWORK]} Ağ Bağlantıları:${COLORS[RESET]}"
    else
        echo -e "${COLORS[BOLD]}${ICONS[NETWORK]} Network Connections:${COLORS[RESET]}"
    fi
    ip -c addr show
    
    echo -e "\n${COLORS[BOLD]}${ICONS[NETWORK]} $(if [[ "$SUCU_LANG" == "tr" ]]; then echo "Ağ Trafiği:"; else echo "Network Traffic:"; fi)${COLORS[RESET]}"
    ip -s link
    
    echo -e "\n${COLORS[BOLD]}${ICONS[NETWORK]} $(if [[ "$SUCU_LANG" == "tr" ]]; then echo "Yönlendirme Tablosu:"; else echo "Routing Table:"; fi)${COLORS[RESET]}"
    ip route show
    
    log_action "Network information displayed"
}

# Sistem güncelleme fonksiyonu
cmd_system_update() {
    show_banner
    print_header "${LANG_STRINGS[SYSTEM_UPDATE]} ${ICONS[UPDATE]}"
    
    if [[ "$SUCU_LANG" == "tr" ]]; then
        print_info "Sistem güncellemeleri kontrol ediliyor..."
    else
        print_info "Checking for system updates..."
    fi
    
    if sudo pacman -Syu; then
        print_success "$(if [[ "$SUCU_LANG" == "tr" ]]; then echo "Sistem başarıyla güncellendi"; else echo "System updated successfully"; fi)"
    else
        print_error "$(if [[ "$SUCU_LANG" == "tr" ]]; then echo "Güncelleme sırasında hata oluştu"; else echo "Error during update"; fi)"
    fi
    
    log_action "System update performed"
}

# Disk bilgisi fonksiyonu
cmd_disk_info() {
    show_banner
    print_header "${LANG_STRINGS[DISK_INFO]} ${ICONS[DISK]}"
    
    if [[ "$SUCU_LANG" == "tr" ]]; then
        echo -e "${COLORS[BOLD]}${ICONS[DISK]} Disk Kullanımı:${COLORS[RESET]}"
    else
        echo -e "${COLORS[BOLD]}${ICONS[DISK]} Disk Usage:${COLORS[RESET]}"
    fi
    df -h
    
    echo -e "\n${COLORS[BOLD]}${ICONS[DISK]} $(if [[ "$SUCU_LANG" == "tr" ]]; then echo "Disk Bölümleri:"; else echo "Disk Partitions:"; fi)${COLORS[RESET]}"
    lsblk -o NAME,SIZE,TYPE,MOUNTPOINT,FSTYPE
    
    log_action "Disk information displayed"
}

# Sistem temizleme fonksiyonu
cmd_system_clean() {
    show_banner
    print_header "${LANG_STRINGS[SYSTEM_CLEAN]} ${ICONS[CLEAN]}"
    
    if [[ "$SUCU_LANG" == "tr" ]]; then
        echo -e "${COLORS[CYAN]}Temizleme seçenekleri:${COLORS[RESET]}"
        echo -e "1) ${COLORS[GREEN]}Önbellekleri temizle${COLORS[RESET]}"
        echo -e "2) ${COLORS[GREEN]}Kullanılmayan paketleri kaldır${COLORS[RESET]}"
        echo -e "3) ${COLORS[GREEN]}Dağıtılmış paketleri temizle${COLORS[RESET]}"
        echo -e "4) ${COLORS[GREEN]}Tümünü temizle${COLORS[RESET]}"
    else
        echo -e "${COLORS[CYAN]}Cleaning options:${COLORS[RESET]}"
        echo -e "1) ${COLORS[GREEN]}Clear package cache${COLORS[RESET]}"
        echo -e "2) ${COLORS[GREEN]}Remove unused packages${COLORS[RESET]}"
        echo -e "3) ${COLORS[GREEN]}Clean orphaned packages${COLORS[RESET]}"
        echo -e "4) ${COLORS[GREEN]}Clean all${COLORS[RESET]}"
    fi
    echo
    
    read -p "$(if [[ "$SUCU_LANG" == "tr" ]]; then echo "Seçiminiz (1-4): "; else echo "Your choice (1-4): "; fi)" choice
    
    case $choice in
        1)
            sudo pacman -Sc
            print_success "${LANG_STRINGS[CLEAN_CACHE]}"
            ;;
        2)
            sudo pacman -Rns $(pacman -Qdtq)
            print_success "${LANG_STRINGS[REMOVE_UNUSED]}"
            ;;
        3)
            sudo pacman -Rns $(pacman -Qqtd)
            print_success "${LANG_STRINGS[CLEAN_ORPHANS]}"
            ;;
        4)
            sudo pacman -Sc
            sudo pacman -Rns $(pacman -Qdtq)
            sudo pacman -Rns $(pacman -Qqtd)
            print_success "${LANG_STRINGS[ALL_CLEANED]}"
            ;;
        *) print_error "${LANG_STRINGS[INVALID_CHOICE]}" ;;
    esac
    
    log_action "System cleanup performed: choice $choice"
}

# Kullanıcı yönetimi fonksiyonu
cmd_user_management() {
    show_banner
    print_header "${LANG_STRINGS[USER_MGMT]} ${ICONS[USER]}"
    
    if [[ "$SUCU_LANG" == "tr" ]]; then
        echo -e "${COLORS[CYAN]}Kullanıcı yönetimi seçenekleri:${COLORS[RESET]}"
        echo -e "1) ${COLORS[GREEN]}Kullanıcı ekle${COLORS[RESET]}"
        echo -e "2) ${COLORS[GREEN]}Kullanıcı sil${COLORS[RESET]}"
        echo -e "3) ${COLORS[GREEN]}Kullanıcı listesi${COLORS[RESET]}"
        echo -e "4) ${COLORS[GREEN]}Grupları yönet${COLORS[RESET]}"
    else
        echo -e "${COLORS[CYAN]}User management options:${COLORS[RESET]}"
        echo -e "1) ${COLORS[GREEN]}Add user${COLORS[RESET]}"
        echo -e "2) ${COLORS[GREEN]}Remove user${COLORS[RESET]}"
        echo -e "3) ${COLORS[GREEN]}List users${COLORS[RESET]}"
        echo -e "4) ${COLORS[GREEN]}Manage groups${COLORS[RESET]}"
    fi
    echo
    
    read -p "$(if [[ "$SUCU_LANG" == "tr" ]]; then echo "Seçiminiz (1-4): "; else echo "Your choice (1-4): "; fi)" choice
    
    case $choice in
        1)
            read -p "$(if [[ "$SUCU_LANG" == "tr" ]]; then echo "Kullanıcı adı: "; else echo "Username: "; fi)" username
            sudo useradd -m "$username"
            print_success "$(if [[ "$SUCU_LANG" == "tr" ]]; then echo "Kullanıcı eklendi: $username"; else echo "User added: $username"; fi)"
            ;;
        2)
            read -p "$(if [[ "$SUCU_LANG" == "tr" ]]; then echo "Silinecek kullanıcı adı: "; else echo "Username to remove: "; fi)" username
            sudo userdel -r "$username"
            print_success "$(if [[ "$SUCU_LANG" == "tr" ]]; then echo "Kullanıcı silindi: $username"; else echo "User removed: $username"; fi)"
            ;;
        3)
            cut -d: -f1 /etc/passwd | sort
            ;;
        4)
            if [[ "$SUCU_LANG" == "tr" ]]; then
                echo -e "\nMevcut gruplar:"
            else
                echo -e "\nAvailable groups:"
            fi
            cut -d: -f1 /etc/group | sort
            ;;
        *) print_error "${LANG_STRINGS[INVALID_CHOICE]}" ;;
    esac
    
    log_action "User management operation performed: choice $choice"
}

# Servis yönetimi fonksiyonu
cmd_service_management() {
    show_banner
    print_header "${LANG_STRINGS[SERVICE_MGMT]} ${ICONS[GEAR]}"
    
    if [[ "$SUCU_LANG" == "tr" ]]; then
        echo -e "${COLORS[CYAN]}Servis yönetimi seçenekleri:${COLORS[RESET]}"
        echo -e "1) ${COLORS[GREEN]}Servis başlat${COLORS[RESET]}"
        echo -e "2) ${COLORS[GREEN]}Servis durdur${COLORS[RESET]}"
        echo -e "3) ${COLORS[GREEN]}Servis yeniden başlat${COLORS[RESET]}"
        echo -e "4) ${COLORS[GREEN]}Servis durumunu göster${COLORS[RESET]}"
        echo -e "5) ${COLORS[GREEN]}Tüm servisleri listele${COLORS[RESET]}"
    else
        echo -e "${COLORS[CYAN]}Service management options:${COLORS[RESET]}"
        echo -e "1) ${COLORS[GREEN]}Start service${COLORS[RESET]}"
        echo -e "2) ${COLORS[GREEN]}Stop service${COLORS[RESET]}"
        echo -e "3) ${COLORS[GREEN]}Restart service${COLORS[RESET]}"
        echo -e "4) ${COLORS[GREEN]}Show service status${COLORS[RESET]}"
        echo -e "5) ${COLORS[GREEN]}List all services${COLORS[RESET]}"
    fi
    echo
    
    read -p "$(if [[ "$SUCU_LANG" == "tr" ]]; then echo "Seçiminiz (1-5): "; else echo "Your choice (1-5): "; fi)" choice
    
    case $choice in
        1)
            read -p "$(if [[ "$SUCU_LANG" == "tr" ]]; then echo "Başlatılacak servis adı: "; else echo "Service name to start: "; fi)" service
            sudo systemctl start "$service"
            print_success "$(if [[ "$SUCU_LANG" == "tr" ]]; then echo "Servis başlatıldı: $service"; else echo "Service started: $service"; fi)"
            ;;
        2)
            read -p "$(if [[ "$SUCU_LANG" == "tr" ]]; then echo "Durdurulacak servis adı: "; else echo "Service name to stop: "; fi)" service
            sudo systemctl stop "$service"
            print_success "$(if [[ "$SUCU_LANG" == "tr" ]]; then echo "Servis durduruldu: $service"; else echo "Service stopped: $service"; fi)"
            ;;
        3)
            read -p "$(if [[ "$SUCU_LANG" == "tr" ]]; then echo "Yeniden başlatılacak servis adı: "; else echo "Service name to restart: "; fi)" service
            sudo systemctl restart "$service"
            print_success "$(if [[ "$SUCU_LANG" == "tr" ]]; then echo "Servis yeniden başlatıldı: $service"; else echo "Service restarted: $service"; fi)"
            ;;
        4)
            read -p "$(if [[ "$SUCU_LANG" == "tr" ]]; then echo "Durumu gösterilecek servis adı: "; else echo "Service name to check: "; fi)" service
            systemctl status "$service"
            ;;
        5)
            systemctl list-unit-files --type=service
            ;;
        *) print_error "${LANG_STRINGS[INVALID_CHOICE]}" ;;
    esac
    
    log_action "Service management operation performed: choice $choice"
}

# Sistem doktoru fonksiyonu
cmd_system_doctor() {
    show_banner
    print_header "${LANG_STRINGS[SYSTEM_DOCTOR]} ${ICONS[DOCTOR]}"
    
    local issues=0
    
    if [[ "$SUCU_LANG" == "tr" ]]; then
        print_info "Sistem sağlığı kontrol ediliyor..."
    else
        print_info "Checking system health..."
    fi
    
    echo
    
    # Disk alanı kontrolü
    local disk_usage=$(df / | tail -1 | awk '{print $5}' | sed 's/%//')
    if [[ $disk_usage -gt 90 ]]; then
        print_error "$(if [[ "$SUCU_LANG" == "tr" ]]; then echo "Disk alanı kritik seviyede: %$disk_usage"; else echo "Disk space critical: %$disk_usage"; fi)"
        ((issues++))
    elif [[ $disk_usage -gt 80 ]]; then
        print_warning "$(if [[ "$SUCU_LANG" == "tr" ]]; then echo "Disk alanı düşük: %$disk_usage"; else echo "Low disk space: %$disk_usage"; fi)"
        ((issues++))
    else
        print_success "$(if [[ "$SUCU_LANG" == "tr" ]]; then echo "Disk alanı: %$disk_usage"; else echo "Disk space: %$disk_usage"; fi)"
    fi
    
    # RAM kullanımı kontrolü
    local mem_usage=$(free | grep Mem | awk '{printf("%.0f", $3/$2 * 100.0)}')
    if [[ $mem_usage -gt 90 ]]; then
        print_error "$(if [[ "$SUCU_LANG" == "tr" ]]; then echo "RAM kullanımı yüksek: %$mem_usage"; else echo "High RAM usage: %$mem_usage"; fi)"
        ((issues++))
    elif [[ $mem_usage -gt 80 ]]; then
        print_warning "$(if [[ "$SUCU_LANG" == "tr" ]]; then echo "RAM kullanımı: %$mem_usage"; else echo "RAM usage: %$mem_usage"; fi)"
    else
        print_success "$(if [[ "$SUCU_LANG" == "tr" ]]; then echo "RAM kullanımı: %$mem_usage"; else echo "RAM usage: %$mem_usage"; fi)"
    fi
    
    # Başarısız servisler
    local failed_services=$(systemctl --failed --no-legend | wc -l)
    if [[ $failed_services -gt 0 ]]; then
        print_error "$(if [[ "$SUCU_LANG" == "tr" ]]; then echo "$failed_services başarısız servis bulundu"; else echo "$failed_services failed services found"; fi)"
        systemctl --failed --no-legend
        ((issues++))
    else
        print_success "$(if [[ "$SUCU_LANG" == "tr" ]]; then echo "Tüm servisler çalışıyor"; else echo "All services running"; fi)"
    fi
    
    # Güncelleme kontrolü
    local updates=$(pacman -Qu 2>/dev/null | wc -l)
    if [[ $updates -gt 50 ]]; then
        print_warning "$(if [[ "$SUCU_LANG" == "tr" ]]; then echo "$updates güncelleme mevcut (yüksek)"; else echo "$updates updates available (high)"; fi)"
        ((issues++))
    elif [[ $updates -gt 0 ]]; then
        print_info "$(if [[ "$SUCU_LANG" == "tr" ]]; then echo "$updates güncelleme mevcut"; else echo "$updates updates available"; fi)"
    else
        print_success "$(if [[ "$SUCU_LANG" == "tr" ]]; then echo "Sistem güncel"; else echo "System up to date"; fi)"
    fi
    
    # Genel değerlendirme
    echo
    if [[ $issues -eq 0 ]]; then
        print_success "$(if [[ "$SUCU_LANG" == "tr" ]]; then echo "Sistem sağlığı mükemmel! ${ICONS[HEART]}"; else echo "System health excellent! ${ICONS[HEART]}"; fi)"
    elif [[ $issues -lt 3 ]]; then
        print_warning "$(if [[ "$SUCU_LANG" == "tr" ]]; then echo "Sistem sağlığı iyi, küçük sorunlar var"; else echo "System health good, minor issues found"; fi)"
    else
        print_error "$(if [[ "$SUCU_LANG" == "tr" ]]; then echo "Sistem sağlığında ciddi sorunlar tespit edildi!"; else echo "Serious system health issues detected!"; fi)"
    fi
    
    log_action "System doctor check performed - $issues issues found"
}

# Paket yönetimi fonksiyonu
cmd_package_management() {
    show_banner
    print_header "${LANG_STRINGS[PACKAGE_MGMT]} ${ICONS[PACKAGE]}"
    
    if [[ "$SUCU_LANG" == "tr" ]]; then
        echo -e "${COLORS[CYAN]}Paket yönetimi seçenekleri:${COLORS[RESET]}"
        echo -e "1) ${COLORS[GREEN]}Paket ara${COLORS[RESET]}"
        echo -e "2) ${COLORS[GREEN]}Paket yükle${COLORS[RESET]}"
        echo -e "3) ${COLORS[GREEN]}Paket kaldır${COLORS[RESET]}"
        echo -e "4) ${COLORS[GREEN]}Yüklü paketleri listele${COLORS[RESET]}"
        echo -e "5) ${COLORS[GREEN]}Paket bilgisi göster${COLORS[RESET]}"
        echo -e "6) ${COLORS[GREEN]}AUR paket ara${COLORS[RESET]}"
    else
        echo -e "${COLORS[CYAN]}Package management options:${COLORS[RESET]}"
        echo -e "1) ${COLORS[GREEN]}Search package${COLORS[RESET]}"
        echo -e "2) ${COLORS[GREEN]}Install package${COLORS[RESET]}"
        echo -e "3) ${COLORS[GREEN]}Remove package${COLORS[RESET]}"
        echo -e "4) ${COLORS[GREEN]}List installed packages${COLORS[RESET]}"
        echo -e "5) ${COLORS[GREEN]}Show package info${COLORS[RESET]}"
        echo -e "6) ${COLORS[GREEN]}Search AUR packages${COLORS[RESET]}"
    fi
    echo
    
    read -p "$(if [[ "$SUCU_LANG" == "tr" ]]; then echo "Seçiminiz (1-6): "; else echo "Your choice (1-6): "; fi)" choice
    
    case $choice in
        1)
            read -p "$(if [[ "$SUCU_LANG" == "tr" ]]; then echo "Aranacak paket: "; else echo "Package to search: "; fi)" package
            pacman -Ss "$package"
            ;;
        2)
            read -p "$(if [[ "$SUCU_LANG" == "tr" ]]; then echo "Yüklenecek paket: "; else echo "Package to install: "; fi)" package
            sudo pacman -S "$package"
            ;;
        3)
            read -p "$(if [[ "$SUCU_LANG" == "tr" ]]; then echo "Kaldırılacak paket: "; else echo "Package to remove: "; fi)" package
            sudo pacman -Rs "$package"
            ;;
        4)
            pacman -Q | less
            ;;
        5)
            read -p "$(if [[ "$SUCU_LANG" == "tr" ]]; then echo "Bilgisi gösterilecek paket: "; else echo "Package for info: "; fi)" package
            pacman -Qi "$package" 2>/dev/null || pacman -Si "$package"
            ;;
        6)
            if command -v yay >/dev/null 2>&1; then
                read -p "$(if [[ "$SUCU_LANG" == "tr" ]]; then echo "AUR'da aranacak paket: "; else echo "Package to search in AUR: "; fi)" package
                yay -Ss "$package"
            else
                print_error "$(if [[ "$SUCU_LANG" == "tr" ]]; then echo "AUR helper (yay) yüklü değil"; else echo "AUR helper (yay) not installed"; fi)"
            fi
            ;;
        *) print_error "${LANG_STRINGS[INVALID_CHOICE]}" ;;
    esac
    
    log_action "Package management operation performed: choice $choice"
}

# Öğretici fonksiyonu
cmd_tutorial() {
    show_banner
    print_header "${LANG_STRINGS[TUTORIAL]} ${ICONS[TUTORIAL]}"
    
    if [[ "$SUCU_LANG" == "tr" ]]; then
        echo -e "${COLORS[CYAN]}Linux öğretici konuları:${COLORS[RESET]}"
        echo -e "1) ${COLORS[GREEN]}Temel komutlar${COLORS[RESET]} (ls, cd, mkdir, vs.)"
        echo -e "2) ${COLORS[GREEN]}Dosya yönetimi${COLORS[RESET]} (cp, mv, rm, find)"
        echo -e "3) ${COLORS[GREEN]}Metin editörleri${COLORS[RESET]} (nano, vim)"
        echo -e "4) ${COLORS[GREEN]}Sistem bilgileri${COLORS[RESET]} (ps, top, df, free)"
        echo -e "5) ${COLORS[GREEN]}Ağ komutları${COLORS[RESET]} (ping, wget, curl)"
        echo -e "6) ${COLORS[GREEN]}Izinler${COLORS[RESET]} (chmod, chown)"
        echo -e "7) ${COLORS[GREEN]}Pacman kullanımı${COLORS[RESET]} (paket yöneticisi)"
    else
        echo -e "${COLORS[CYAN]}Linux tutorial topics:${COLORS[RESET]}"
        echo -e "1) ${COLORS[GREEN]}Basic commands${COLORS[RESET]} (ls, cd, mkdir, etc.)"
        echo -e "2) ${COLORS[GREEN]}File management${COLORS[RESET]} (cp, mv, rm, find)"
        echo -e "3) ${COLORS[GREEN]}Text editors${COLORS[RESET]} (nano, vim)"
        echo -e "4) ${COLORS[GREEN]}System information${COLORS[RESET]} (ps, top, df, free)"
        echo -e "5) ${COLORS[GREEN]}Network commands${COLORS[RESET]} (ping, wget, curl)"
        echo -e "6) ${COLORS[GREEN]}Permissions${COLORS[RESET]} (chmod, chown)"
        echo -e "7) ${COLORS[GREEN]}Pacman usage${COLORS[RESET]} (package manager)"
    fi
    echo
    
    read -p "$(if [[ "$SUCU_LANG" == "tr" ]]; then echo "Öğrenmek istediğiniz konu (1-7): "; else echo "Topic to learn (1-7): "; fi)" choice
    
    case $choice in
        1)
            if [[ "$SUCU_LANG" == "tr" ]]; then
                echo -e "${COLORS[YELLOW]}📚 TEMEL KOMUTLAR:${COLORS[RESET]}"
                echo -e "• ${COLORS[GREEN]}ls${COLORS[RESET]} - Dosyaları listele"
                echo -e "• ${COLORS[GREEN]}cd${COLORS[RESET]} - Dizin değiştir"
                echo -e "• ${COLORS[GREEN]}pwd${COLORS[RESET]} - Mevcut dizini göster"
                echo -e "• ${COLORS[GREEN]}mkdir${COLORS[RESET]} - Yeni dizin oluştur"
                echo -e "• ${COLORS[GREEN]}touch${COLORS[RESET]} - Boş dosya oluştur"
                echo -e "\n${COLORS[CYAN]}Örnek kullanım:${COLORS[RESET]}"
                echo -e "ls -la          # Detaylı liste"
                echo -e "cd /home        # Home dizinine git"
                echo -e "mkdir yeni_klasor # Yeni klasör oluştur"
            else
                echo -e "${COLORS[YELLOW]}📚 BASIC COMMANDS:${COLORS[RESET]}"
                echo -e "• ${COLORS[GREEN]}ls${COLORS[RESET]} - List files"
                echo -e "• ${COLORS[GREEN]}cd${COLORS[RESET]} - Change directory" 
                echo -e "• ${COLORS[GREEN]}pwd${COLORS[RESET]} - Show current directory"
                echo -e "• ${COLORS[GREEN]}mkdir${COLORS[RESET]} - Create new directory"
                echo -e "• ${COLORS[GREEN]}touch${COLORS[RESET]} - Create empty file"
                echo -e "\n${COLORS[CYAN]}Example usage:${COLORS[RESET]}"
                echo -e "ls -la          # Detailed list"
                echo -e "cd /home        # Go to home directory"
                echo -e "mkdir new_folder # Create new folder"
            fi
            ;;
        2)
            if [[ "$SUCU_LANG" == "tr" ]]; then
                echo -e "${COLORS[YELLOW]}📁 DOSYA YÖNETİMİ:${COLORS[RESET]}"
                echo -e "• ${COLORS[GREEN]}cp${COLORS[RESET]} - Dosya kopyala"
                echo -e "• ${COLORS[GREEN]}mv${COLORS[RESET]} - Dosya taşı/yeniden adlandır"
                echo -e "• ${COLORS[GREEN]}rm${COLORS[RESET]} - Dosya sil"
                echo -e "• ${COLORS[GREEN]}find${COLORS[RESET]} - Dosya ara"
                echo -e "\n${COLORS[CYAN]}Örnek kullanım:${COLORS[RESET]}"
                echo -e "cp dosya.txt kopya.txt    # Dosya kopyala"
                echo -e "mv eski.txt yeni.txt      # Yeniden adlandır"
                echo -e "rm dosya.txt              # Dosya sil"
                echo -e "find . -name '*.txt'      # txt dosyalarını ara"
            else
                echo -e "${COLORS[YELLOW]}📁 FILE MANAGEMENT:${COLORS[RESET]}"
                echo -e "• ${COLORS[GREEN]}cp${COLORS[RESET]} - Copy file"
                echo -e "• ${COLORS[GREEN]}mv${COLORS[RESET]} - Move/rename file"
                echo -e "• ${COLORS[GREEN]}rm${COLORS[RESET]} - Remove file"
                echo -e "• ${COLORS[GREEN]}find${COLORS[RESET]} - Search files"
                echo -e "\n${COLORS[CYAN]}Example usage:${COLORS[RESET]}"
                echo -e "cp file.txt copy.txt      # Copy file"
                echo -e "mv old.txt new.txt        # Rename"
                echo -e "rm file.txt               # Delete file"
                echo -e "find . -name '*.txt'      # Find txt files"
            fi
            ;;
        7)
            if [[ "$SUCU_LANG" == "tr" ]]; then
                echo -e "${COLORS[YELLOW]}📦 PACMAN KULLANIMI:${COLORS[RESET]}"
                echo -e "• ${COLORS[GREEN]}pacman -S paket${COLORS[RESET]} - Paket yükle"
                echo -e "• ${COLORS[GREEN]}pacman -R paket${COLORS[RESET]} - Paket kaldır"
                echo -e "• ${COLORS[GREEN]}pacman -Syu${COLORS[RESET]} - Sistem güncelle"
                echo -e "• ${COLORS[GREEN]}pacman -Ss arama${COLORS[RESET]} - Paket ara"
                echo -e "• ${COLORS[GREEN]}pacman -Q${COLORS[RESET]} - Yüklü paketleri listele"
                echo -e "\n${COLORS[CYAN]}Güvenlik:${COLORS[RESET]}"
                echo -e "Paket yüklerken her zaman güvenilir kaynaklardan yükleyin!"
            else
                echo -e "${COLORS[YELLOW]}📦 PACMAN USAGE:${COLORS[RESET]}"
                echo -e "• ${COLORS[GREEN]}pacman -S package${COLORS[RESET]} - Install package"
                echo -e "• ${COLORS[GREEN]}pacman -R package${COLORS[RESET]} - Remove package"
                echo -e "• ${COLORS[GREEN]}pacman -Syu${COLORS[RESET]} - Update system"
                echo -e "• ${COLORS[GREEN]}pacman -Ss search${COLORS[RESET]} - Search package"
                echo -e "• ${COLORS[GREEN]}pacman -Q${COLORS[RESET]} - List installed packages"
                echo -e "\n${COLORS[CYAN]}Security:${COLORS[RESET]}"
                echo -e "Always install packages from trusted sources!"
            fi
            ;;
        *) print_error "${LANG_STRINGS[INVALID_CHOICE]}" ;;
    esac
    
    log_action "Tutorial used: topic $choice"
}

# Güvenlik kontrolü fonksiyonu
cmd_security_check() {
    show_banner
    print_header "${LANG_STRINGS[SECURITY]} ${ICONS[SECURITY]}"
    
    if [[ "$SUCU_LANG" == "tr" ]]; then
        print_info "Güvenlik kontrolü başlatılıyor..."
    else
        print_info "Starting security check..."
    fi
    
    echo
    
    # SSH yapılandırma kontrolü
    if [[ -f /etc/ssh/sshd_config ]]; then
        if grep -q "PermitRootLogin yes" /etc/ssh/sshd_config; then
            print_warning "$(if [[ "$SUCU_LANG" == "tr" ]]; then echo "SSH root girişi etkin - güvenlik riski!"; else echo "SSH root login enabled - security risk!"; fi)"
        else
            print_success "$(if [[ "$SUCU_LANG" == "tr" ]]; then echo "SSH root girişi devre dışı"; else echo "SSH root login disabled"; fi)"
        fi
    fi
    
    # Firewall durumu
    if systemctl is-active --quiet ufw; then
        print_success "$(if [[ "$SUCU_LANG" == "tr" ]]; then echo "UFW firewall aktif"; else echo "UFW firewall active"; fi)"
    elif systemctl is-active --quiet iptables; then
        print_success "$(if [[ "$SUCU_LANG" == "tr" ]]; then echo "iptables firewall aktif"; else echo "iptables firewall active"; fi)"
    else
        print_warning "$(if [[ "$SUCU_LANG" == "tr" ]]; then echo "Firewall aktif değil"; else echo "Firewall not active"; fi)"
    fi
    
    # Sudo yapılandırması
    if [[ -f /etc/sudoers ]]; then
        if grep -q "NOPASSWD" /etc/sudoers; then
            print_warning "$(if [[ "$SUCU_LANG" == "tr" ]]; then echo "Şifresiz sudo yapılandırması bulundu"; else echo "Passwordless sudo configuration found"; fi)"
        else
            print_success "$(if [[ "$SUCU_LANG" == "tr" ]]; then echo "Sudo yapılandırması güvenli"; else echo "Sudo configuration secure"; fi)"
        fi
    fi
    
    # Otomatik güncellemeler
    if systemctl is-enabled --quiet archlinux-keyring-wkd-sync; then
        print_success "$(if [[ "$SUCU_LANG" == "tr" ]]; then echo "Anahtar güncelleme servisi aktif"; else echo "Key update service active"; fi)"
    else
        print_warning "$(if [[ "$SUCU_LANG" == "tr" ]]; then echo "Anahtar güncelleme servisi devre dışı"; else echo "Key update service inactive"; fi)"
    fi
    
    log_action "Security check performed"
}

# Yardım fonksiyonu
cmd_help() {
    show_banner
    print_header "${LANG_STRINGS[HELP_INFO]}"
    
    echo -e "${COLORS[BOLD]}${LANG_STRINGS[USAGE]}:${COLORS[RESET]}"
    echo -e "  sucu [komut] [seçenekler]"
    
    echo -e "\n${COLORS[BOLD]}${LANG_STRINGS[MAIN_COMMANDS]}:${COLORS[RESET]}"
    if [[ "$SUCU_LANG" == "tr" ]]; then
        echo -e "  ${COLORS[GREEN]}sistem-bilgisi${COLORS[RESET]}   - ${LANG_STRINGS[SYSTEM_INFO]}"
        echo -e "  ${COLORS[GREEN]}sistem-izle${COLORS[RESET]}      - ${LANG_STRINGS[SYSTEM_MONITOR]}"
        echo -e "  ${COLORS[GREEN]}ag-bilgisi${COLORS[RESET]}       - ${LANG_STRINGS[NETWORK_INFO]}"
        echo -e "  ${COLORS[GREEN]}sistem-guncelle${COLORS[RESET]}  - ${LANG_STRINGS[SYSTEM_UPDATE]}"
        echo -e "  ${COLORS[GREEN]}disk-bilgisi${COLORS[RESET]}     - ${LANG_STRINGS[DISK_INFO]}"
        echo -e "  ${COLORS[GREEN]}sistem-temizle${COLORS[RESET]}   - ${LANG_STRINGS[SYSTEM_CLEAN]}"
        echo -e "  ${COLORS[GREEN]}kullanici-yonetimi${COLORS[RESET]} - ${LANG_STRINGS[USER_MGMT]}"
        echo -e "  ${COLORS[GREEN]}servis-yonetimi${COLORS[RESET]}  - ${LANG_STRINGS[SERVICE_MGMT]}"
        echo -e "  ${COLORS[GREEN]}sistem-doktoru${COLORS[RESET]}   - ${LANG_STRINGS[SYSTEM_DOCTOR]}"
        echo -e "  ${COLORS[GREEN]}paket-yonetimi${COLORS[RESET]}   - ${LANG_STRINGS[PACKAGE_MGMT]}"
        echo -e "  ${COLORS[GREEN]}ogretici${COLORS[RESET]}         - ${LANG_STRINGS[TUTORIAL]}"
        echo -e "  ${COLORS[GREEN]}guvenlik-kontrol${COLORS[RESET]} - ${LANG_STRINGS[SECURITY]}"
    else
        echo -e "  ${COLORS[GREEN]}system-info${COLORS[RESET]}    - ${LANG_STRINGS[SYSTEM_INFO]}"
        echo -e "  ${COLORS[GREEN]}monitor${COLORS[RESET]}        - ${LANG_STRINGS[SYSTEM_MONITOR]}"
        echo -e "  ${COLORS[GREEN]}netinfo${COLORS[RESET]}       - ${LANG_STRINGS[NETWORK_INFO]}"
        echo -e "  ${COLORS[GREEN]}update${COLORS[RESET]}        - ${LANG_STRINGS[SYSTEM_UPDATE]}"
        echo -e "  ${COLORS[GREEN]}diskinfo${COLORS[RESET]}      - ${LANG_STRINGS[DISK_INFO]}"
        echo -e "  ${COLORS[GREEN]}clean${COLORS[RESET]}         - ${LANG_STRINGS[SYSTEM_CLEAN]}"
        echo -e "  ${COLORS[GREEN]}usermgmt${COLORS[RESET]}      - ${LANG_STRINGS[USER_MGMT]}"
        echo -e "  ${COLORS[GREEN]}servicemgmt${COLORS[RESET]}   - ${LANG_STRINGS[SERVICE_MGMT]}"
        echo -e "  ${COLORS[GREEN]}doctor${COLORS[RESET]}        - ${LANG_STRINGS[SYSTEM_DOCTOR]}"
        echo -e "  ${COLORS[GREEN]}pkg${COLORS[RESET]}          - ${LANG_STRINGS[PACKAGE_MGMT]}"
        echo -e "  ${COLORS[GREEN]}tutorial${COLORS[RESET]}      - ${LANG_STRINGS[TUTORIAL]}"
        echo -e "  ${COLORS[GREEN]}security${COLORS[RESET]}      - ${LANG_STRINGS[SECURITY]}"
    fi
    
    echo -e "\n${COLORS[BOLD]}${LANG_STRINGS[EXAMPLES]}:${COLORS[RESET]}"
    if [[ "$SUCU_LANG" == "tr" ]]; then
        echo -e "  sucu sistem-bilgisi"
        echo -e "  sucu -tr sistem-guncelle"
        echo -e "  sucu ogretici"
    else
        echo -e "  sucu system-info"
        echo -e "  sucu update"
        echo -e "  sucu tutorial"
    fi
    
    show_tip
}

# Ana fonksiyon
main() {
    load_config "$@"
    
    # Komut kontrolü
    case "$1" in
        "-tr")
            shift
            SUCU_LANG="tr"
            load_language "tr"
            ;;
        "--help"|"-h"|"yardim")
            cmd_help
            exit 0
            ;;
        "--version"|"-v")
            echo "SUCU v${SUCU_VERSION}"
            exit 0
            ;;
    esac
    
    case "$1" in
        "system-info"|"sistem-bilgisi")
            cmd_system_info
            ;;
        "monitor"|"sistem-izle")
            cmd_system_monitor
            ;;
        "netinfo"|"ag-bilgisi")
            cmd_network_info
            ;;
        "update"|"sistem-guncelle")
            cmd_system_update
            ;;
        "diskinfo"|"disk-bilgisi")
            cmd_disk_info
            ;;
        "clean"|"sistem-temizle")
            cmd_system_clean
            ;;
        "usermgmt"|"kullanici-yonetimi")
            cmd_user_management
            ;;
        "servicemgmt"|"servis-yonetimi")
            cmd_service_management
            ;;
        "doctor"|"sistem-doktoru")
            cmd_system_doctor
            ;;
        "pkg"|"paket-yonetimi")
            cmd_package_management
            ;;
        "tutorial"|"ogretici")
            cmd_tutorial
            ;;
        "security"|"guvenlik-kontrol")
            cmd_security_check
            ;;
        "")
            cmd_help
            ;;
        *)
            print_error "${LANG_STRINGS[INVALID_CHOICE]}"
            cmd_help
            exit 1
            ;;
    esac
}

# Ana fonksiyonu çalıştır
main "$@"