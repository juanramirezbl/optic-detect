optic/
├── App
│   ├── opticApp.swift
│   └── Info.plist
│
├── Models                 // (M) Datos puros (SwiftData)
│   ├── Route.swift           // Clase Route
│   └── Detection.swift       // Clase Detection
│
├── Views
│   ├── DashboardView.swift   // Pantalla principal de conducción
│   ├── HistoryView.swift     // Pantalla de historial
│   ├── LoginView.swift       // (Si añades login más tarde)
│   └── Components/           // Piezas reutilizables
│       ├── DetectionBox.swift    // El recuadro verde que pinta la señal
│       └── CustomButton.swift    // Botones con estilo propio
│
├── ViewModels             // (VM)
│   ├── DashboardViewModel.swift  // Lógica de conducción
│   └── HistoryViewModel.swift    // Lógica para cargar rutas
│
├── Services               // Lógica "pesada" e Infraestructura
│   ├── CameraManager.swift   // AVFoundation (Cámara)
│   ├── YOLOService.swift     // Core ML + Vision (IA)
│   ├── AudioService.swift    // AVSpeechSynthesizer (Voz)
│   └── DataManager.swift     // Gestión de SwiftData
│
├── Resources              // Archivos externos
│   ├── Assets.xcassets       // Imágenes e Iconos
│   └── YOLOv8n.mlpackage     // Tu modelo de IA
│
└── Helpers                // Utilidades extras (Opcional)
    └── Extensions.swift      // Ej: Extensión para formatear fechas
