<p align="center">
  <img src="assets/banner.png" width="300" alt="QRbomb Logo"/>
</p>

<h1 align="center">💣 QRbomb</h1>

<p align="center">
  <b>Drop QR codes like bombs. Fast & Simple.</b>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Made%20with-Bash-1f425f.svg"/>
  <img src="https://img.shields.io/badge/License-MIT-yellow.svg"/>
  <img src="https://img.shields.io/badge/Platform-Linux%20%7C%20MacOS-blue"/>
</p>

---

## 📦 Installation

### 1. Clone the repo
```bash
git clone [https://github.com/Manasseh-code/QRbomb.git](https://github.com/Manasseh-code/QRbomb.git)
cd QRbomb
```

### 2. Make it executable
```bash
chmod +x qrbomb.sh
```

### 3. Install dependency
| OS | Command |
|---|---|
| Ubuntu/Debian | `sudo apt install qrencode` |
| MacOS | `brew install qrencode` |
| Arch | `sudo pacman -S qrencode` |
| Fedora | `sudo dnf install qrencode` |

---

## 🚀 Usage
### Interactive Menu (recommended)
```bash
./qrbomb.sh
```

### Flag Mode
```bash
./qrbomb.sh [OPTIONS] "your text or URL"
```

| Flag | Description |
|---|---|
| `-o, --output` | Output filename (e.g. myqr.png) |
| `-s, --size` | Module size in pixels (default: 10) |
| `-f, --format` | Format: PNG, SVG, UTF8 (default: PNG) |
| `-t, --terminal` | Display QR in terminal |
| `-i, --interactive` | Launch interactive menu |
| `-h, --help` | Show help message |

### Examples
```bash
# Interactive menu
./qrbomb.sh

# URL to PNG
./qrbomb.sh -o myqr.png "https://github.com"

# Plain text in terminal
./qrbomb.sh -t "Drop QR codes like bombs"

# Number / PIN
./qrbomb.sh -o pin.png "094521"

# SVG format
./qrbomb.sh -o myqr.svg -f SVG "https://github.com"

# Display AND save
./qrbomb.sh -t -o myqr.png "Hello World"
```

---

## 📋 Interactive Menu Options

```
  [1]  🌐  Website / URL
  [2]  📝  Plain Text
  [3]  🔢  Number / PIN / Code
  [4]  📧  Email Address
  [5]  📞  Phone Number
  [6]  💬  SMS Message
  [7]  📶  WiFi Credentials
  [8]  👤  vCard / Contact
  [9]  🐙  GitHub Profile
  [10] 📍  Google Maps Location
  [11] 💸  PayPal.me Link
  [0]  ❌  Exit
```

---

## 📋 Requirements
- `bash`
- `qrencode`

---

## 📄 License
MIT © Manasseh-code
