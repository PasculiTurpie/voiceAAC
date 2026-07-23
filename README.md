# 🗣️ VocesFluidez AAC

Sistema de Comunicación Aumentativa y Alternativa con Optimización Gestual

📌 Índice de Contenidos

Descripción General

Fundamentos y Filosofía de Diseño

Modelo Matemático de Ahorro Motor

Arquitectura de la Interfaz de Usuario

Flujo Conversacional Adaptativo

Módulos Principales del Sistema

Stack Tecnológico

Instalación y Despliegue

📘 Descripción General

VocesFluidez AAC es un comunicador adaptativo multiplataforma diseñado para personas con movilidad reducida o afecciones del habla (Esclerosis Lateral Amiotrófica - ELA, Parálisis Cerebral, Disartria, Secuelas de ACV).

El objetivo primordial del sistema es reducir drásticamente la fatiga muscular sustituyendo el tecleo letra por letra por una estructura combinatoria eficiente basada en Vocabulario Núcleo Fijo, Vocabulario Periférico Temático y Conectores Gramaticales de un solo toque.

💡 Fundamentos y Filosofía de Diseño

Para una persona con limitaciones motoras en miembros superiores o fatiga rápida, utilizar un teclado QWERTY estándar para redactar una oración requiere un promedio de 25 a 35 interacciones táctiles continuas.

┌──────────────────────────────────────────────────────────────────────────┐
│                           ENFOQUE TRADICIONAL                            │
│  **M - e   g - u - s - t - a   l - a   p - e - l - í - c - u - l - a**     │
│  ➜ Total de toques necesarios: 28 toques                                 │
└──────────────────────────────────────────────────────────────────────────┘

- ▼

┌──────────────────────────────────────────────────────────────────────────┐
│                        ENFOQUE VOCESFLUIDEZ AAC                          │
│  [ Me gusta ]  +  [ Conectores ]  +  [ la película ]                     │
│  ➜ Total de toques necesarios: 3 toques                                  │
└──────────────────────────────────────────────────────────────────────────┘

📐 Modelo Matemático de Ahorro Motor

El sistema calcula dinámicamente la eficiencia conversacional y la reducción de la carga física del usuario mediante la siguiente fórmula:

$$\text{Ahorro Motor (\%)} = \left( \frac{L - T}{L} \right) \times 100$$

- Donde:

$L$ representa la cantidad total de caracteres equivalentes de la oración construida.

$T$ representa el número real de selecciones táctiles (toques) efectuadas en la pantalla.

### Ejemplo de cálculo

Para la oración **¿Viste el partido de fútbol?** ($L = 29$ caracteres):

### Con 2 toques táctiles ($T = 2$)

$$> \text{Ahorro Motor (\%)} = \left( \frac{29 - 2}{29} \right) \times 100 = 93.10\% >$$

🎨 Arquitectura de la Interfaz de Usuario

Diseñada para dispositivos en orientación horizontal (Landscape) o tablets de 10 pulgadas o superior, separando la memoria espacial del vocabulario fijo de la exploración temática.

+-----------------------------------------------------------------------------------------+
| 🗣️ VocesFluidez AAC                      [🧠 **Dame un momento...**]  [🌗 Contraste] [⚙️]  |
+-----------------------------------------------------------------------------------------+
| 💬 CONTEXTO DIÁLOGO: **¿Qué quieres cenar hoy o hacer en la tarde?**                      |
+-----------------------------------------------------------------------------------------+
| TIRA DE FRASE: **Yo quiero ir a descansar al jardín...**                      [🔊 HABLAR] |
| 📊 Ahorro Motor: 82% (4 toques vs 32 letras)                                [⌫]  [🗑️]  |
+-----------------------------------------------------------------------------------------+
| ❓ PREGUNTAR:  [¿Cómo está] [¿Dónde queda] [¿Viste el/la] [¿Cuándo es]                  |
| 🔗 CONECTORES: [y] [porque] [pero] [para] [con] [en el/la] [que] [también]              |
+-----------------------------------------------------------------------------------------+
| ✨ RESPUESTAS SUGERIDAS: [ al jardín ] [ ver el partido ] [ tomar café ]                |
+-------------------------------------------+---------------------------------------------+
| VOCABULARIO NÚCLEO (Físicamente Fijo):    | PESTAÑAS DINÁMICAS Y HISTORIAL:             |
| ┌─────────────┬─────────────┬───────────┐ | ┌──────────┬──────────┬──────────┬────────┐ |
| │ [ Yo ]      │ [ Quiero ]  │[No quiero]│ | │  Temas   │  Social  │ Diálogo  │ Favor. │ |
| ├─────────────┼─────────────┼───────────┤ | └──────────┴──────────┴──────────┴────────┘ |
| │ [ Me gusta ]│ [Necesito]  │[Me siento]│ | ┌─────────────────────────────────────────┐ |
| ├─────────────┼─────────────┼───────────┤ | │ 📁 👋 Saludos     📁 👨‍👩‍👧‍👦 Familia     │ |
| │ [ Dónde ]   │ [ Cuándo ]  │ [Por qué ]│ | │ 📁 ⚽ Deportes    📁 🏥 Lugares     │ |
| ├─────────────┼─────────────┼───────────┤ | │ 📁 👥 Personas    📁 ☀️ Clima       │ |
| │ [ Gracias ] │ [ Ayuda ]   │  [ Sí ]   │ | └─────────────────────────────────────────┘ |
| └─────────────┴─────────────┴───────────┘ |                                             |
+-------------------------------------------+---------------------------------------------+

🗺️ Flujo Conversacional Adaptativo

graph TD

```
A[Inicio de Conversación] --> B{¿El interlocutor realiza una pregunta?}
```

```
B -- Sí --> C[Ingresar pregunta en la Barra de Diálogo]
B -- No --> D[Seleccionar Sujeto/Verbo en Vocabulario Núcleo Fijo]
```

```
C --> E[El Motor de Predicción analiza Contexto y Gramática]
E --> F[Muestra Sugerencias Dinámicas en 1 Toque]
```

```
D --> G{¿Requiere estructurar conector o pregunta?}
G -- Sí --> H[Seleccionar Conector: 'porque', 'pero', 'y', etc.]
G -- No --> I[Navegar en Categoría Periférica / Temática]
```

```
F --> J[Insertar en Tira de Frase Construida]
H --> I
I --> J
```

```
J --> K[Presionar Botón HABLAR / Sintetizador TTS]
K --> L[Registar en Historial de Diálogo]
```

📦 Módulos Principales del Sistema

## 1. Vocabulario Núcleo Fijo (Core Vocabulary)

Posiciones físicas inalterables para desarrollar memoria muscular.

Incluye sujetos (Yo), verbos esenciales (Quiero, Necesito, Me gusta), preguntas básicas (Dónde, Cuándo, Por qué) y respuestas de emergencia (Ayuda, Sí, No, Gracias).

## 2. Vocabulario Periférico Adaptativo (Fringe Vocabulary)

Organizado por pestañas y categorías temáticas configurables:

👋 Saludos y Despedidas: **¡Hola! Buenos días**, **Cuídate mucho**, **Hasta luego**.

👨‍👩‍👧‍👦 Familia y Amigos: **tu familia**, **tus hijos**, **mis nietos**, **mi cuidador/a**.

⚽ Deportes: **el partido de fútbol**, **el campeonato**, **¿quién va ganando?**.

🏥 Lugares: **la casa**, **el jardín**, **el hospital**, **la farmacia**, **la cocina**.

👥 Personas: **el doctor**, **el kinesiólogo**, **el enfermero/a**, **mi amigo/a**.

☀️ Clima: **hace mucho frío**, **está lloviendo**, **está muy lindo el día**.

## 3. Conectores Gramaticales e Iniciadores de Preguntas

### Permiten encadenar ideas complejas en formato Wrap fluido

Iniciadores: ¿Cómo está...?, ¿Dónde queda...?, ¿Viste el/la...?, ¿Vamos a ir a...?

Conectores: y, porque, pero, para, con, en el/la, que, también, después.

## 4. Herramientas de Reducción de Ansiedad Social

Botón **Dame un momento...**: Emite de forma inmediata la locución **Dame un momento, estoy armando mi respuesta**, evitando que el interlocutor interrumpa o responda prematuramente.

🛠️ Stack Tecnológico

- Módulo

- Tecnología

- Propósito

Framework UI

Flutter 3.x / Dart

Interfaz gráfica reactiva para Android, iOS y Web.

Sintetizador de Voz

flutter_tts / Web Speech API

Emisión de voz offline con parámetros de velocidad y tono.

Persistencia Local

shared_preferences / LocalStorage

Almacenamiento seguro de frases favoritas e historial de conversación.

Motor Predictivo AI (Opcional)

REST API (Gemini / OpenAI)

Generación asistida de respuestas dinámicas contextuales.

Diseño y Accesibilidad

Material Design 3 / Tailwind CSS

Soporte para temas Claro, Oscuro y Alto Contraste.

🚀 Instalación y Despliegue

Ejecución en Entorno Flutter

### Clonar el repositorio

```
git clone https://github.com/tu-usuario/voces-fluidez-app.git
cd voces-fluidez-app
```

### Obtener dependencias

flutter pub get

### Ejecutar la aplicación

# Probar en navegador Web

flutter run -d chrome

# Probar en dispositivo o emulador Android

flutter run -d android

Desarrollado con orientación en accesibilidad para promover una comunicación libre, autónoma y sin barreras.
=======
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