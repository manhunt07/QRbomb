#!/bin/bash

# ─────────────────────────────────────────
#  QRbomb - QR Code Generator
#  Dependencies: qrencode
# ─────────────────────────────────────────

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
MAGENTA='\033[0;35m'
BOLD='\033[1m'
NC='\033[0m'

# Default values
OUTPUT_FILE=""
SIZE=10
OUTPUT_FORMAT="PNG"
DISPLAY_TERMINAL=false

# ─────────────────────────────────────────
# ASCII Art - QRbomb Logo
# ─────────────────────────────────────────
print_banner() {
    echo -e "${YELLOW}"
    echo "                                                    * . "
    echo "                                                 .  *   "
    echo "                    ___                        _/       "
    echo "                   /   \          ____________/         "
    echo "                  |     |        /                      "
    echo "                  |  █▀▀█▀▀█  | /                       "
    echo "                  |  █  █  █  |/                        "
    echo "                  |  ▀▀▀█▀▀▀  |                         "
    echo "                  |  █▀▀▀▀▀█  |                         "
    echo "                  |  █ ▀▀▀ █  |                         "
    echo "                  |  ▀▀▀▀▀▀▀  |                         "
    echo "                   \         /                          "
    echo "                    \_______/                           "
    echo -e "${NC}"
    echo -e "${RED}${BOLD}"
    echo "        ██████╗ ██████╗ ██████╗  ██████╗ ███╗   ███╗██████╗ "
    echo "       ██╔═══██╗██╔══██╗██╔══██╗██╔═══██╗████╗ ████║██╔══██╗"
    echo "       ██║   ██║██████╔╝██████╔╝██║   ██║██╔████╔██║██████╔╝"
    echo "       ██║▄▄ ██║██╔══██╗██╔══██╗██║   ██║██║╚██╔╝██║██╔══██╗"
    echo "       ╚██████╔╝██║  ██║██████╔╝╚██████╔╝██║ ╚═╝ ██║██████╔╝"
    echo "        ╚══▀▀═╝ ╚═╝  ╚═╝╚═════╝  ╚═════╝ ╚═╝     ╚═╝╚═════╝ "
    echo -e "${NC}"
    echo -e "${CYAN}           💣  Drop QR codes like bombs. Fast & Simple.  💣${NC}"
    echo -e "${YELLOW}         ──────────────────────────────────────────────────${NC}"
    echo ""
}

# ─────────────────────────────────────────
# Help Menu
# ─────────────────────────────────────────
usage() {
    print_banner
    echo -e "${BOLD}Usage:${NC} ${GREEN}./qrbomb.sh [OPTIONS] \"your text or URL\"${NC}"
    echo ""
    echo -e "${BOLD}Options:${NC}"
    echo -e "  ${YELLOW}-o, --output${NC}    Output filename       (e.g. myqr.png)"
    echo -e "  ${YELLOW}-s, --size${NC}      Module size in pixels (default: 10)"
    echo -e "  ${YELLOW}-f, --format${NC}    Format: PNG, SVG, UTF8 (default: PNG)"
    echo -e "  ${YELLOW}-t, --terminal${NC}  Display QR in terminal"
    echo -e "  ${YELLOW}-i, --interactive${NC} Launch interactive menu"
    echo -e "  ${YELLOW}-h, --help${NC}      Show this help message"
    echo ""
    echo -e "${BOLD}Examples:${NC}"
    echo -e "  ${GREEN}./qrbomb.sh -o myqr.png \"https://github.com\"${NC}"
    echo -e "  ${GREEN}./qrbomb.sh -t \"Hello World\"${NC}"
    echo -e "  ${GREEN}./qrbomb.sh -o myqr.svg -f SVG \"https://github.com\"${NC}"
    echo -e "  ${GREEN}./qrbomb.sh -o myqr.png -s 15 \"Some text\"${NC}"
    echo -e "  ${GREEN}./qrbomb.sh -o mynumber.png \"01234567890\"${NC}          # Numbers"
    echo -e "  ${GREEN}./qrbomb.sh -t \"Drop QR codes like bombs\"${NC}          # Direct text"
    echo -e "  ${GREEN}./qrbomb.sh -i${NC}                                      # Interactive menu"
    echo ""
}

# ─────────────────────────────────────────
# Check Dependencies
# ─────────────────────────────────────────
check_dependencies() {
    if ! command -v qrencode &> /dev/null; then
        echo -e "${RED}[ERROR] qrencode is not installed.${NC}"
        echo ""
        echo "Install it with:"
        echo -e "  ${YELLOW}Ubuntu/Debian :${NC} sudo apt install qrencode"
        echo -e "  ${YELLOW}MacOS         :${NC} brew install qrencode"
        echo -e "  ${YELLOW}Arch          :${NC} sudo pacman -S qrencode"
        echo -e "  ${YELLOW}Fedora        :${NC} sudo dnf install qrencode"
        exit 1
    fi
}

# ─────────────────────────────────────────
# Interactive Menu
# ─────────────────────────────────────────
interactive_menu() {
    print_banner
    echo -e "${BOLD}${CYAN}  ┌─────────────────────────────────────────┐${NC}"
    echo -e "${BOLD}${CYAN}  │         SELECT A QR TYPE TO GENERATE    │${NC}"
    echo -e "${BOLD}${CYAN}  └─────────────────────────────────────────┘${NC}"
    echo ""
    echo -e "  ${YELLOW}[1]${NC}  🌐  Website / URL"
    echo -e "  ${YELLOW}[2]${NC}  📝  Plain Text"
    echo -e "  ${YELLOW}[3]${NC}  🔢  Number / PIN / Code"
    echo -e "  ${YELLOW}[4]${NC}  📧  Email Address"
    echo -e "  ${YELLOW}[5]${NC}  📞  Phone Number"
    echo -e "  ${YELLOW}[6]${NC}  💬  SMS Message"
    echo -e "  ${YELLOW}[7]${NC}  📶  WiFi Credentials"
    echo -e "  ${YELLOW}[8]${NC}  👤  vCard / Contact"
    echo -e "  ${YELLOW}[9]${NC}  🐙  GitHub Profile"
    echo -e "  ${YELLOW}[10]${NC} 📍  Google Maps Location"
    echo -e "  ${YELLOW}[11]${NC} 💸  PayPal.me Link"
    echo -e "  ${YELLOW}[0]${NC}  ❌  Exit"
    echo ""
    echo -e "${YELLOW}  ──────────────────────────────────────────────${NC}"
    echo -ne "  ${BOLD}Select an option [0-11]:${NC} "
    read -r CHOICE

    echo ""

    case "$CHOICE" in
        1)
            echo -ne "  ${CYAN}Enter URL (e.g. https://github.com):${NC} "
            read -r USER_INPUT
            LABEL="website"
            ;;
        2)
            echo -ne "  ${CYAN}Enter your text:${NC} "
            read -r USER_INPUT
            LABEL="text"
            ;;
        3)
            echo -ne "  ${CYAN}Enter number / PIN / code:${NC} "
            read -r USER_INPUT
            LABEL="number"
            ;;
        4)
            echo -ne "  ${CYAN}Enter email address:${NC} "
            read -r EMAIL
            USER_INPUT="mailto:$EMAIL"
            LABEL="email"
            ;;
        5)
            echo -ne "  ${CYAN}Enter phone number (e.g. +447911123456):${NC} "
            read -r PHONE
            USER_INPUT="tel:$PHONE"
            LABEL="phone"
            ;;
        6)
            echo -ne "  ${CYAN}Enter phone number for SMS:${NC} "
            read -r SMS_NUM
            echo -ne "  ${CYAN}Enter SMS message:${NC} "
            read -r SMS_MSG
            USER_INPUT="SMSTO:$SMS_NUM:$SMS_MSG"
            LABEL="sms"
            ;;
        7)
            echo -ne "  ${CYAN}Enter WiFi SSID (network name):${NC} "
            read -r WIFI_SSID
            echo -ne "  ${CYAN}Enter WiFi Password:${NC} "
            read -rs WIFI_PASS
            echo ""
            echo -ne "  ${CYAN}Encryption type (WPA/WEP/nopass):${NC} "
            read -r WIFI_ENC
            USER_INPUT="WIFI:T:${WIFI_ENC};S:${WIFI_SSID};P:${WIFI_PASS};;"
            LABEL="wifi"
            ;;
        8)
            echo -ne "  ${CYAN}Full Name:${NC} "
            read -r VC_NAME
            echo -ne "  ${CYAN}Phone:${NC} "
            read -r VC_PHONE
            echo -ne "  ${CYAN}Email:${NC} "
            read -r VC_EMAIL
            echo -ne "  ${CYAN}Website:${NC} "
            read -r VC_WEB
            USER_INPUT="BEGIN:VCARD\nVERSION:3.0\nFN:$VC_NAME\nTEL:$VC_PHONE\nEMAIL:$VC_EMAIL\nURL:$VC_WEB\nEND:VCARD"
            LABEL="vcard"
            ;;
        9)
            echo -ne "  ${CYAN}Enter GitHub username:${NC} "
            read -r GH_USER
            USER_INPUT="https://github.com/$GH_USER"
            LABEL="github"
            ;;
        10)
            echo -ne "  ${CYAN}Enter location (e.g. London, UK or coordinates):${NC} "
            read -r LOCATION
            ENCODED_LOC=$(python3 -c "import urllib.parse; print(urllib.parse.quote('$LOCATION'))" 2>/dev/null || echo "$LOCATION")
            USER_INPUT="https://maps.google.com/?q=$ENCODED_LOC"
            LABEL="maps"
            ;;
        11)
            echo -ne "  ${CYAN}Enter your PayPal.me username:${NC} "
            read -r PP_USER
            USER_INPUT="https://paypal.me/$PP_USER"
            LABEL="paypal"
            ;;
        0)
            echo -e "  ${RED}💣 QRbomb out. Goodbye!${NC}"
            exit 0
            ;;
        *)
            echo -e "  ${RED}[ERROR] Invalid option.${NC}"
            exit 1
            ;;
    esac

    # ── Output options ──────────────────────
    echo ""
    echo -e "${YELLOW}  ──────────────────────────────────────────────${NC}"
    echo -e "  ${BOLD}Output Options:${NC}"
    echo -e "  ${YELLOW}[1]${NC}  Display in terminal only"
    echo -e "  ${YELLOW}[2]${NC}  Save as PNG file"
    echo -e "  ${YELLOW}[3]${NC}  Save as SVG file"
    echo -e "  ${YELLOW}[4]${NC}  Display in terminal AND save as PNG"
    echo ""
    echo -ne "  ${BOLD}Select output [1-4]:${NC} "
    read -r OUT_CHOICE

    echo ""

    # Default filename
    DEFAULT_FILE="qrbomb_${LABEL}_$(date +%Y%m%d_%H%M%S)"

    case "$OUT_CHOICE" in
        1)
            echo -e "${CYAN}  [*] Generating QR code...${NC}"
            qrencode -t UTF8 "$USER_INPUT"
            echo -e "${GREEN}  [✔] Done!${NC}"
            ;;
        2)
            echo -ne "  ${CYAN}Enter filename (default: ${DEFAULT_FILE}.png):${NC} "
            read -r FNAME
            FNAME="${FNAME:-$DEFAULT_FILE}.png"
            echo -e "${CYAN}  [*] Generating QR code...${NC}"
            qrencode -t PNG -s "$SIZE" -o "$FNAME" "$USER_INPUT"
            echo -e "${GREEN}  [✔] Saved to: ${YELLOW}$FNAME${NC}"
            ;;
        3)
            echo -ne "  ${CYAN}Enter filename (default: ${DEFAULT_FILE}.svg):${NC} "
            read -r FNAME
            FNAME="${FNAME:-$DEFAULT_FILE}.svg"
            echo -e "${CYAN}  [*] Generating QR code...${NC}"
            qrencode -t SVG -s "$SIZE" -o "$FNAME" "$USER_INPUT"
            echo -e "${GREEN}  [✔] Saved to: ${YELLOW}$FNAME${NC}"
            ;;
        4)
            echo -ne "  ${CYAN}Enter filename (default: ${DEFAULT_FILE}.png):${NC} "
            read -r FNAME
            FNAME="${FNAME:-$DEFAULT_FILE}.png"
            echo -e "${CYAN}  [*] Generating QR code...${NC}"
            qrencode -t UTF8 "$USER_INPUT"
            qrencode -t PNG -s "$SIZE" -o "$FNAME" "$USER_INPUT"
            echo -e "${GREEN}  [✔] Displayed above & saved to: ${YELLOW}$FNAME${NC}"
            ;;
        *)
            echo -e "  ${RED}[ERROR] Invalid output option.${NC}"
            exit 1
            ;;
    esac

    echo ""
    echo -e "${RED}  💣 QRbomb detonated successfully!${NC}"
    echo ""
}

# ─────────────────────────────────────────
# Parse Arguments
# ─────────────────────────────────────────
parse_args() {
    while [[ $# -gt 0 ]]; do
        case "$1" in
            -o|--output)
                OUTPUT_FILE="$2"
                shift 2
                ;;
            -s|--size)
                SIZE="$2"
                shift 2
                ;;
            -f|--format)
                OUTPUT_FORMAT="${2^^}"
                shift 2
                ;;
            -t|--terminal)
                DISPLAY_TERMINAL=true
                shift
                ;;
            -i|--interactive)
                check_dependencies
                interactive_menu
                exit 0
                ;;
            -h|--help)
                usage
                exit 0
                ;;
            -*)
                echo -e "${RED}[ERROR] Unknown option: $1${NC}"
                usage
                exit 1
                ;;
            *)
                INPUT_DATA="$1"
                shift
                ;;
        esac
    done
}

# ─────────────────────────────────────────
# Generate QR Code (flag mode)
# ─────────────────────────────────────────
generate_qr() {
    echo -e "${CYAN}[*] Generating QR code...${NC}"

    if [ "$DISPLAY_TERMINAL" = true ]; then
        qrencode -t UTF8 "$INPUT_DATA"
        echo -e "${GREEN}[✔] QR code displayed above.${NC}"
    fi

    if [ -n "$OUTPUT_FILE" ]; then
        case "$OUTPUT_FORMAT" in
            PNG)
                qrencode -t PNG -s "$SIZE" -o "$OUTPUT_FILE" "$INPUT_DATA"
                ;;
            SVG)
                qrencode -t SVG -s "$SIZE" -o "$OUTPUT_FILE" "$INPUT_DATA"
                ;;
            UTF8)
                qrencode -t UTF8 "$INPUT_DATA" > "$OUTPUT_FILE"
                ;;
            *)
                echo -e "${RED}[ERROR] Unsupported format: $OUTPUT_FORMAT${NC}"
                echo "Supported formats: PNG, SVG, UTF8"
                exit 1
                ;;
        esac
        echo -e "${GREEN}[✔] QR code saved to: ${YELLOW}$OUTPUT_FILE${NC}"
    fi

    echo -e "${RED}💣 QRbomb detonated!${NC}"
}

# ─────────────────────────────────────────
# Validate Inputs
# ─────────────────────────────────────────
validate_inputs() {
    if [ -z "$INPUT_DATA" ]; then
        echo -e "${RED}[ERROR] No input text or URL provided.${NC}"
        usage
        exit 1
    fi

    if [ "$DISPLAY_TERMINAL" = false ] && [ -z "$OUTPUT_FILE" ]; then
        echo -e "${YELLOW}[!] No output specified. Displaying in terminal.${NC}"
        DISPLAY_TERMINAL=true
    fi

    if ! [[ "$SIZE" =~ ^[0-9]+$ ]]; then
        echo -e "${RED}[ERROR] Size must be a number.${NC}"
        exit 1
    fi
}

# ─────────────────────────────────────────
# Main
# ─────────────────────────────────────────
main() {
    # If no args given, launch interactive menu
    if [[ $# -eq 0 ]]; then
        check_dependencies
        interactive_menu
        exit 0
    fi

    check_dependencies
    parse_args "$@"
    validate_inputs
    generate_qr
}

main "$@"
