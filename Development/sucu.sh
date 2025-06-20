#!/bin/bash

# SUCU - Advanced System Management Tool
# Version: 0.2
# Designed for Arch Linux based systems

# Color and Style Definitions
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

# Unicode Symbols
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

# Language system
declare -A LANG_STRINGS
SUCU_LANG="en"  # Default language is English

# Load language files
load_language() {
    case "$1" in
        "tr")
            LANG_STRINGS=(
                [WELCOME]="SUCU-OS Gelişmiş Sistem Yönetim Aracı"
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
            )
            ;;
        "en"|*)
            LANG_STRINGS=(
                [WELCOME]="SUCU-OS Advanced System Management Tool"
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
            )
            ;;
    esac
}

# Configuration
SUCU_VERSION="2.1"
SUCU_CONFIG_DIR="$HOME/.config/sucu"
SUCU_LOG_FILE="$SUCU_CONFIG_DIR/sucu.log"
SUCU_CONFIG_FILE="$SUCU_CONFIG_DIR/config"

# Create configuration directory
mkdir -p "$SUCU_CONFIG_DIR"

# Load default configuration
load_config() {
    if [[ -f "$SUCU_CONFIG_FILE" ]]; then
        source "$SUCU_CONFIG_FILE"
    else
        # Create default configuration
        cat > "$SUCU_CONFIG_FILE" << EOF
# SUCU Configuration File
SUCU_DEFAULT_LANG="en"
SUCU_AUTO_UPDATE_CHECK="true"
SUCU_SHOW_TIPS="true"
SUCU_LOG_LEVEL="info"
EOF
        SUCU_DEFAULT_LANG="en"
    fi
    
    # Language argument check
    if [[ "$1" == "-tr" ]]; then
        SUCU_LANG="tr"
    elif [[ -n "$SUCU_DEFAULT_LANG" ]]; then
        SUCU_LANG="$SUCU_DEFAULT_LANG"
    fi
    
    load_language "$SUCU_LANG"
}

# Logo and Banner Function
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

# Output formatting functions
print_success() { echo -e "${COLORS[GREEN]}${ICONS[SUCCESS]} $1${COLORS[RESET]}"; }
print_error() { echo -e "${COLORS[RED]}${ICONS[ERROR]} $1${COLORS[RESET]}"; }
print_warning() { echo -e "${COLORS[YELLOW]}${ICONS[WARNING]} $1${COLORS[RESET]}"; }
print_info() { echo -e "${COLORS[BLUE]}${ICONS[INFO]} $1${COLORS[RESET]}"; }

# Print header
print_header() {
    echo -e "\n${COLORS[CYAN]}${COLORS[BOLD]}═══ $1 ═══${COLORS[RESET]}"
}

# Show tip
show_tip() {
    if [[ "$SUCU_SHOW_TIPS" == "true" ]]; then
        local tips=()
        if [[ "$SUCU_LANG" == "tr" ]]; then
            tips=(
                "💡 İpucu: 'sucu sistem-doktoru' ile sistem sağlığınızı kontrol edin!"
                "💡 İpucu: 'sucu ogretici' ile Linux komutlarını öğrenin!"
                "💡 İpucu: 'sucu paket-ara [kelime]' ile paket arayabilirsiniz!"
                "💡 İpucu: Günlük sistem temizliği için 'sucu sistem-temizle' kullanın!"
                "💡 İpucu: 'sucu guvenlik-kontrol' ile sistemi güvenlik açıklarına karşı tarayın!"
            )
        else
            tips=(
                "💡 Tip: Use 'sucu doctor' to check your system health!"
                "💡 Tip: Learn Linux commands with 'sucu tutorial'!"
                "💡 Tip: Search packages with 'sucu search [keyword]'!"
                "💡 Tip: Use 'sucu clean' for daily system cleanup!"
                "💡 Tip: Scan for security issues with 'sucu security'!"
            )
        fi
        echo -e "${COLORS[YELLOW]}${tips[$((RANDOM % ${#tips[@]}))]}\n${COLORS[RESET]}"
    fi
}

# Loading animation
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

# Log function
log_action() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" >> "$SUCU_LOG_FILE"
}

# System information function
cmd_system_info() {
    show_banner
    print_header "${LANG_STRINGS[SYSTEM_INFO]} ${ICONS[MONITOR]}"
    
    # Basic system information
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
    
    # CPU Usage
    cpu_usage=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')
    echo -e "CPU: ${COLORS[YELLOW]}%${cpu_usage}${COLORS[RESET]}"
    
    # Memory usage
    mem_info=$(free | grep Mem)
    mem_total=$(echo $mem_info | awk '{printf "%.1f", $2/1024}')
    mem_used=$(echo $mem_info | awk '{printf "%.1f", $3/1024}')
    mem_percent=$(echo $mem_info | awk '{printf "%.0f", $3/$2 * 100.0}')
    echo -e "RAM: ${COLORS[YELLOW]}${mem_used}GB / ${mem_total}GB (${mem_percent}%)${COLORS[RESET]}"
    
    # Disk usage
    disk_info=$(df -h / | tail -1)
    disk_total=$(echo $disk_info | awk '{print $2}')
    disk_used=$(echo $disk_info | awk '{print $3}')
    disk_percent=$(echo $disk_info | awk '{print $5}')
    echo -e "Disk: ${COLORS[YELLOW]}${disk_used} / ${disk_total} (${disk_percent})${COLORS[RESET]}"
    
    # Temperature info (if available)
    if [[ -f /sys/class/thermal/thermal_zone0/temp ]]; then
        temp=$(cat /sys/class/thermal/thermal_zone0/temp | awk '{print $1/1000}')
        echo -e "Temperature: ${COLORS[YELLOW]}${temp}°C${COLORS[RESET]}"
    fi
    
    # Internet connection check
    if ping -c 1 google.com &> /dev/null; then
        print_success "${LANG_STRINGS[INTERNET_ACTIVE]}"
    else
        print_warning "${LANG_STRINGS[NO_INTERNET]}"
    fi
    
    log_action "System information displayed"
}
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

# Tutorial function
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

# Security check function
cmd_security_check() {
    show_banner
    print_header "${LANG_STRINGS[SECURITY]} ${ICONS[SECURITY]}"
    
    if [[ "$SUCU_LANG" == "tr" ]]; then
        print_info "Güvenlik kontrolü başlatılıyor..."
    else
        print_info "Starting security check..."
    fi
    
    echo
    
    # SSH configuration check
    if [[ -f /etc/ssh/sshd_config ]]; then
        if grep -q "PermitRootLogin yes" /etc/ssh/sshd_config; then
            print_warning "SSH root login enabled - security risk!"
        else
            print_success "SSH root login disabled"
        fi
    fi
    
    # Firewall status
    if systemctl is-active --quiet ufw; then
        print_success "UFW firewall active"
    elif systemctl is-active --quiet iptables; then
        print_success "iptables firewall active"
    else
        print_warning "Firewall not active"
    fi
    
    # Sudo configuration
    if [[ -f /etc/sudoers ]]; then
        if grep -q "NOPASSWD" /etc/sudoers; then
            print_warning "Passwordless sudo configuration found"
        else
            print_success "Sudo configuration is secure"
        fi
    fi
    
    # Automatic updates
    if systemctl is-enabled --quiet archlinux-keyring-wkd-sync; then
        print_success "Key update service active"
    else
        print_warning "Key update service disabled"
    fi
    
    log_action "Security check performed"
}

# Help function
cmd_help() {
    show_banner
    print_header "${LANG_STRINGS[HELP_INFO]}"
    echo -e "${COLORS[BOLD]}${LANG_STRINGS[USAGE]}:${COLORS[RESET]}"
    echo -e "  sucu [command] [options]"
    
    echo -e "\n${COLORS[BOLD]}${LANG_STRINGS[MAIN_COMMANDS]}:${COLORS[RESET]}"
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
    
    echo -e "\n${COLORS[BOLD]}${LANG_STRINGS[EXAMPLES]}:${COLORS[RESET]}"
    echo -e "  sucu tutorial"
    echo -e "  sucu -tr update"

    show_tip
}

# Main function
main() {
    load_config "$@"
    
    # Command check
    case "$1" in
        "-tr")
            shift
            SUCU_LANG="tr"
            load_language "tr"
            ;;
        "--help"|"-h"|"help")
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

# Run main function
main "$@"