<p align="center">
    <img src="Readme Files/logo.png" alt="Arch Linux Logo" width="120" height="120"/>
</p>

---

**sucu** is a command-line assistant for new Arch Linux users that simplifies access to essential system information, package management, monitoring tools, and basic tutorials. It provides a structured and user-friendly interface for navigating common administrative tasks in the terminal.

## 🚀 Features

- 🔧 **System Overview**: View host information using tools like `neofetch`, `uptime`, `lsblk`, and more.
- 📈 **Monitoring Tools**: Access live monitoring interfaces such as `htop`, `iotop`, and `top`.
- 🌐 **Network Info**: Check IP addresses, connectivity, and interface stats.
- 📦 **Package Management**: Simplified access to `pacman`, `yay`, and related operations.
- 🧹 **System Maintenance**: Clean orphan packages, cache, and logs with ease.
- 👤 **User and Group Management**: Add, remove, and modify users interactively.
- 🔐 **Security & Permissions**: Inspect user rights, file permissions, and basic hardening tools.
- 📚 **Interactive Tutorials**: Learn basic Linux commands and system structure from inside the CLI.
- 🩺 **System Doctor**: Diagnose common issues and get actionable suggestions.

## ❓ Why sucu ?

New users often feel overwhelmed when transitioning to Arch Linux due to its minimalism and command-line centric nature. `sucu` was created as a lightweight, CLI-based companion that offers clarity, ease of use, and helpful shortcuts to everyday system management tasks — all in one script.

It’s not a full-featured desktop environment tool or a system control center. It’s a purposeful, minimal interface to give users an intuitive entry point into their systems without sacrificing transparency or learning opportunity.

## 📸 Screenshot

Below is a preview of the main menu interface:

<p align="center">
    <img src="Readme Files/sucu_main_menu.png" alt="sucu main menu screenshot" width="600"/>
</p>

## 🧰 Dependencies

**Required:**

- `bash`
- `neofetch`
- `htop`
- `iotop-c`
- `util-linux`
- `procps-ng`
- `systemd`
- `iproute2`
- `iputils`
- `shadow`
- `pacman`
- `coreutils`
- `gawk`, `sed`, `grep`

**Optional:**

- `yay` – AUR helper (if available)
- `dialog` – For interactive UI elements
- `tree` – File system tree viewer

All required dependencies are managed automatically during installation.

## 📦 Installation

### 📁 From source:

```bash
git clone https://github.com/alihaydarsucu/sucu.git
cd sucu
makepkg -si
```

### 💻 Manual (Fallback Only):

> **Note:** You usually do **not** need this step. Use it **only if** `makepkg -si` fails or is unavailable.

```bash
chmod +x sucu
sudo cp sucu /usr/bin/sucu
```

### 🧪 Test:

```bash
sucu
```

## 🔧 Usage

Once installed, just run:

```bash
sucu
```

Type `sucu` for main menu, or type `sucu [command]` just like the example in the main menu image above. Add `-tr` to see the Turkish versions. Navigation is done by typing numbers or commands.

## 🛡️ License

MIT License — feel free to use, modify, and contribute.

## 🤝 Contributing

Issues, feedback, and pull requests are welcome! Please open an [issue](https://github.com/alihaydarsucu/sucu/issues) or create a [PR](https://github.com/alihaydarsucu/sucu/pulls) on GitHub.
