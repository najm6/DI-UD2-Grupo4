# Sonora · DI UD2 · Grupo 4

Proyecto de la UD2 de Desarrollo de Interfaces: **componentes, pruebas y documentación**.

Sonora es una app de música hecha con Flutter. Cada miembro del grupo ha creado un componente visual reutilizable, empaquetado como paquete de Flutter con sus propiedades, eventos, pruebas y documentación. Después los cuatro componentes se juntan en una pantalla final (`app_final`).

## Estructura del repositorio

```
DI-UD2-Grupo4/
├── packages/
│   ├── tarjeta_artista/       Componente 1
│   ├── tarjeta_cancion/       Componente 2
│   ├── promo_desplegable/     Componente 3
│   └── valoracion_estrellas/  Componente 4
└── app_final/                 App que integra los 4 componentes
```

## Componentes

| # | Componente | Qué hace | Autor | Documentación |
|---|---|---|---|---|
| 1 | `TarjetaArtista` | Tarjeta con foto, nombre y género de un artista y un botón Seguir / Siguiendo | AlejandroTamayo7 | [README](packages/tarjeta_artista/README.md) |
| 2 | `TarjetaCancion` | Tarjeta con portada, título, artistas, duración y botón de reproducir | najm6 | [README](packages/tarjeta_cancion/README.md) |
| 3 | `PromoDesplegable` | Banner que se despliega con animación y muestra contenido y botones de acción | skullbyte (Jamie) | [README](packages/promo_desplegable/README.md) |
| 4 | `ValoracionEstrellas` | Muestra y permite elegir una valoración con estrellas | Angel C.J. | [README](packages/valoracion_estrellas/README.md) |

En el README de cada componente están sus propiedades, sus eventos y un ejemplo de uso.

## App final

`app_final` es la pantalla "Descubre música" de Sonora. Usa los cuatro componentes y reacciona a sus eventos: seguir a un artista, reproducir una canción, desplegar o descartar una promoción y valorar una canción.

Los componentes **no se copian** dentro de la app. Se añaden como dependencias locales en `app_final/pubspec.yaml`:

```yaml
dependencies:
  tarjeta_artista:
    path: ../packages/tarjeta_artista
  tarjeta_cancion:
    path: ../packages/tarjeta_cancion
  promo_desplegable:
    path: ../packages/promo_desplegable
  valoracion_estrellas:
    path: ../packages/valoracion_estrellas
```

### Ejecutar la app

```bash
cd app_final
flutter pub get
flutter run
```

## Pruebas

Cada paquete y la app final tienen pruebas de widget. Para ejecutarlas, entra en su carpeta y lanza `flutter test`:

```bash
cd packages/promo_desplegable   # o cualquier otro paquete, o app_final
flutter test
```

| Carpeta | Pruebas |
|---|---|
| packages/tarjeta_artista | 4 |
| packages/tarjeta_cancion | 5 |
| packages/promo_desplegable | 3 |
| packages/valoracion_estrellas | 3 |
| app_final | 1 (integración de los 4 componentes) |

## Organización del grupo

- **GitHub**: una rama por componente (`tarjeta-artista`, `tarjeta-cancion`, `valoEstrellas`), fusionadas en `main`.
- **Trello**: tablero con las tareas del proyecto y su reparto.
- **Figma**: guía de estilo de Sonora (colores, radios y tipografía) que siguen los componentes.
