# TarjetaArtista

Componente visual de Flutter (componente 1 de la app Sonora) que muestra la
tarjeta de un artista musical: **foto**, **nombre**, **género** que
predomina en él y un botón **Seguir / Siguiendo**.

El botón cambia de aspecto al pulsarlo y avisa a la aplicación del nuevo
estado mediante un callback. También se puede pulsar la tarjeta entera, por
ejemplo para abrir el perfil del artista.

## Propiedades

| Propiedad | Tipo | Obligatoria | Valor por defecto | Descripción |
|---|---|---|---|---|
| `nombre` | `String` | ✅ | — | Nombre del artista. |
| `genero` | `String` | ✅ | — | Género musical predominante. |
| `imagen` | `ImageProvider` | ✅ | — | Foto del artista. Si falla al cargar, se muestra un icono de persona. |
| `seguido` | `bool` | | `false` | Estado inicial del botón. |
| `colorAcento` | `Color` | | `Color(0xFFD4FF3A)` | Color del botón "Seguir". |
| `colorFondo` | `Color` | | `Color(0xFF1C1C1E)` | Fondo de la tarjeta. |
| `ancho` | `double` | | `160` | Ancho de la tarjeta. |
| `textoSeguir` | `String` | | `'Seguir'` | Texto del botón sin seguir. |
| `textoSiguiendo` | `String` | | `'Siguiendo'` | Texto del botón siguiendo. |

## Eventos

| Evento | Tipo | Cuándo se lanza |
|---|---|---|
| `alCambiarSeguimiento` | `ValueChanged<bool>?` | Al pulsar el botón. Recibe `true` si ahora se sigue al artista y `false` si se deja de seguir. |
| `alPulsar` | `VoidCallback?` | Al pulsar la tarjeta fuera del botón. |

## Instalación (dependencia local)

En el `pubspec.yaml` de la aplicación que lo use (ruta relativa a esa app):

```yaml
dependencies:
  tarjeta_artista:
    path: ../packages/tarjeta_artista
```

Después ejecuta `flutter pub get`.

## Ejemplo de uso

```dart
import 'package:flutter/material.dart';
import 'package:tarjeta_artista/tarjeta_artista.dart';

TarjetaArtista(
  nombre: 'Bad Bunny',
  genero: 'Reggaetón',
  imagen: const AssetImage('assets/artistas/bad_bunny.jpeg'),
  alCambiarSeguimiento: (siguiendo) => debugPrint('Siguiendo: $siguiendo'),
  alPulsar: () => debugPrint('Abrir perfil de Bad Bunny'),
)
```

La app que lo usa debe declarar sus imágenes en su propio `pubspec.yaml`:

```yaml
flutter:
  assets:
    - assets/artistas/
```

## App de ejemplo

En `example/` hay una app que importa el paquete y muestra varias tarjetas:

```sh
cd example
flutter run -d linux
```

## Pruebas

```sh
flutter test
```

Los tests de `test/tarjeta_artista_test.dart` comprueban que se muestran la
foto, el nombre y el género, que el botón alterna entre "Seguir" y
"Siguiendo" avisando con `alCambiarSeguimiento`, que se respeta el valor
inicial de `seguido` y que `alPulsar` se lanza al tocar la tarjeta.
