🚀 Guía de Subida a GitHub: VocesFluidez AAC

Sigue estos pasos en tu terminal de VS Code para inicializar el repositorio y subir todo el código de VocesFluidez AAC a GitHub.

1. Archivo .gitignore

Crea un archivo llamado .gitignore en la raíz de tu proyecto voces_fluidez_app y pega el siguiente contenido para evitar subir archivos temporales pesados de Flutter:

# Archivos de compilación y caché de Flutter / Dart
.dart_tool/
.flutter-plugins
.flutter-plugins-dependencies
.packages
.pub-cache/
.pub/
build/

# Archivos de configuración de IDE / Entorno
.idea/
.vscode/
*.iml
*.iws
*.ipr

# Android y iOS temporales
android/.gradle/
android/captures/
android/gradlew
android/gradlew.bat
android/local.properties
ios/Pods/
ios/.symlinks/
ios/Runner/GeneratedPluginRegistrant.h
ios/Runner/GeneratedPluginRegistrant.m

# Logs y SO
*.log
.DS_Store
Thumbs.db


2. Archivo pubspec.yaml

Asegúrate de que tu archivo pubspec.yaml en la raíz del proyecto contenga las dependencias necesarias:

name: voces_fluidez_app
description: "Sistema de Comunicación Aumentativa y Alternativa (CAA) con Optimización Gestual."
publish_to: 'none'
version: 1.0.0+1

environment:
  sdk: '>=3.0.0 <4.0.0'

dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.8
  flutter_tts: ^4.0.2
  shared_preferences: ^2.2.2
  http: ^1.2.0

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^3.0.0

flutter:
  uses-material-design: true


3. Comandos para copiar y pegar en la terminal de VS Code

Abre la terminal integrada en VS Code (Ctrl + ~ o Cmd + ~) en la carpeta voces_fluidez_app y ejecuta los siguientes comandos uno a uno:

Paso A: Inicializar Git Local

# 1. Inicializar repositorio Git
git init

# 2. Agregar todos los archivos al área de preparación (stage)
git add .

# 3. Crear el primer commit
git commit -m "feat: Versión inicial de VocesFluidez AAC en Flutter"

# 4. Cambiar el nombre de la rama principal a main
git branch -M main


Paso B: Conectar con GitHub

Ve a GitHub.com y crea un nuevo repositorio llamado voces-fluidez-aac (deja desmarcadas las opciones de crear README, .gitignore o licencia).

Copia la URL de tu repositorio (ejemplo: https://github.com/tu-usuario/voces-fluidez-aac.git).

Ejecuta los siguientes comandos reemplazando la URL por la tuya:

# 1. Vincular el repositorio local con el remoto de GitHub
git remote add origin https://github.com/TU_USUARIO/voces-fluidez-aac.git

# 2. Subir el código a GitHub
git push -u origin main


4. Estructura Final del Repositorio en GitHub

Una vez completado el proceso, tu repositorio en GitHub tendrá la siguiente estructura organizada:

voces-fluidez-aac/
├── .gitignore
├── README.md
├── pubspec.yaml
├── lib/
│   └── main.dart
├── android/
├── ios/
└── web/
