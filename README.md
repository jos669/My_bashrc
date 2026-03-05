# 💀 ElXD502 - Guía de Supervivencia en la Terminal (Bash Edition)

Este archivo detalla todas las funciones y mejoras aplicadas a tu entorno de Termux. Tu terminal ahora está optimizado para **Productividad, Pentesting y Desarrollo**.

---

## 🎨 Aspecto Visual (Kali Skull Edition)
- **Prompt Multilínea:** 
  - `┌──[💀 ElXD502㉿ANDROID]──[~]`
  - `└─❯`
- **Colores Inteligentes:** El nombre de usuario está en **Cian**, el host en **Azul** y el directorio en **Verde**.
- **Indicador de Error:** Si un comando falla, verás automáticamente un `[✗ Código]` en rojo antes de la flecha.
- **Integración Git:** Si estás en un repositorio, verás la rama actual (ej: `(main*)`) en color púrpura.

---

## 🚀 Funciones de Navegación "Automática"
- **Auto-LS:** Cada vez que uses el comando `cd`, se ejecutará automáticamente un listado de archivos (`ls` o `eza`).
- **Auto-Git Status:** Al entrar en un repositorio de Git, verás un resumen rápido (`git status -sb`) sin escribir nada.
- **Auto-Venv:** Si entras en una carpeta con un entorno virtual de Python (`venv` o `.venv`), se activará solo. Al salir, se desactivará solo.
- **Zoxide (z):** En lugar de `cd`, puedes usar `z` para saltar a carpetas frecuentes (ej: `z mi_app` te llevará directamente sin importar dónde estés).

---

## 🛠️ Alias Esenciales (Atajos Rápidos)

### Gestión de Paquetes (Termux)
- `update`: Actualiza y mejora todos los paquetes del sistema.
- `install`: Atajo para `pkg install`.
- `psearch`: Busca paquetes en los repositorios.
- `list`: Lista todos los paquetes instalados.

### Navegación y Listado
- `..`, `...`, `....`: Sube uno, dos o tres niveles de carpetas.
- `ls`, `ll`, `la`: Listados con iconos (usa `eza` si está instalado).
- `tree`, `t2`, `t3`: Muestra la estructura de carpetas en árbol (niveles 1, 2 o 3).

### Seguridad y Edición
- `v`: Abre tu editor predeterminado (**Neovim**).
- `rm`, `cp`, `mv`: Ahora piden confirmación antes de borrar o sobreescribir para evitar errores.
- `grep`: Siempre muestra los resultados con colores resaltados.

---

## 🛡️ Herramientas de Pentesting y Análisis
- `nmap`: Escaneo de redes.
- `ports`: Muestra todos los puertos abiertos en tu dispositivo.
- `myip`: Muestra tu IP pública actual.
- `listen`: Abre un escuchador de Netcat en el puerto 4444 (o el que elijas).
- `scan <host>`: Ejecuta un escaneo rápido y agresivo con Nmap.
- `extract <archivo>`: Extractor universal que detecta el formato (.zip, .rar, .tar, etc.) automáticamente.

---

## ⌨️ Atajos de Teclado (Magic Keys)
- `Ctrl + R`: Abre un buscador interactivo de tu historial de comandos (usa `fzf`).
- `Flecha Arriba/Abajo`: Busca en el historial comandos que empiecen con lo que ya escribiste.
- `Ctrl + L`: Limpia la pantalla.

---

## 📂 Archivos de Configuración
- **Configuración Principal:** `~/.bashrc`
- **Manual de Usuario:** `~/MANUAL_BASHRC.md`

> "The quieter you become, the more you can hear." — **ElXD502 @ Android Termux**
> 
