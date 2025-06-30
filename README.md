# README.md
# Transvip - Driver App

Una aplicación Flutter para conductores de Transvip.

## Descripción

La aplicación Transvip Driver permite a los conductores gestionar sus viajes, ver ganancias y mantenerse conectados con pasajeros.

## Características

- 🚗 Dashboard del conductor con estado en línea/desconectado
- 📱 Interfaz completamente en español
- 🎯 Indicador de estado compacto (barra verde/roja)
- 📊 Seguimiento de ganancias y estadísticas
- 🗺️ Gestión de ubicación y GPS
- 🔔 Solicitudes de viaje en tiempo real
- 📍 Navegación inferior para mejor accesibilidad

## Instalación

1. Asegúrate de tener Flutter instalado
2. Clona este repositorio
3. Ejecuta `flutter pub get`
4. Ejecuta `flutter run`

## Requisitos del Sistema

- Flutter SDK: >=3.10.0
- Dart: >=3.0.0

## Estructura del Proyecto

```
lib/
├── main.dart
├── core/
│   └── app_export.dart
├── localization/
│   └── app_localizations.dart
├── presentation/
│   ├── dashboard/
│   ├── splash_screen/
│   ├── driver_login/
│   ├── driver_registration/
│   ├── trip_request/
│   └── earnings_dashboard/
├── routes/
│   └── app_routes.dart
├── theme/
│   └── app_theme.dart
└── widgets/
    ├── custom_icon_widget.dart
    └── custom_image_widget.dart
```

## Funcionalidades Principales

### Dashboard del Conductor
- Indicador de estado compacto (barra verde para en línea, roja para desconectado)
- Toggle de estado en línea/desconectado
- Información de ubicación actual
- Resumen de ganancias diarias
- Lista de viajes recientes

### Navegación
- Navegación inferior con 4 pestañas principales:
  - Panel (Dashboard)
  - Viajes
  - Ganancias
  - Perfil

### Localización
- Completamente traducido al español
- Textos y etiquetas adaptados para conductores hispanohablantes

## Configuración

La aplicación utiliza el logo de Transvip ubicado en `assets/images/transvip-1750650661506.jpg`.

## Contribución

1. Fork el proyecto
2. Crea una rama para tu feature (`git checkout -b feature/AmazingFeature`)
3. Commit tus cambios (`git commit -m 'Add some AmazingFeature'`)
4. Push a la rama (`git push origin feature/AmazingFeature`)
5. Abre un Pull Request

## Licencia

Este proyecto está bajo la Licencia MIT - ver el archivo [LICENSE](LICENSE) para detalles.

## Contacto

Para soporte técnico o consultas sobre la aplicación, contacta al equipo de desarrollo de Transvip.