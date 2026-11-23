# TarjetaArtista

Componente visual de Flutter que muestra la tarjeta de un artista musical:
**foto** (o sus iniciales si no hay foto), **nombre**, **género** que
predomina en él y un botón **Seguir / Siguiendo**.

El botón cambia de aspecto al pulsarlo y avisa a la aplicación del nuevo
estado mediante un callback. También se puede pulsar la tarjeta entera, por
ejemplo para abrir el perfil del artista.

## Propiedades

| Propiedad | Tipo | Obligatoria | Valor por defecto | Descripción |
|---|---|---|---|---|
| `nombre` | `String` | ✅ | — | Nombre del artista. |
| `genero` | `String` | ✅ | — | Género musical predominante. |
| `imagen` | `ImageProvider?` | | `null` | Foto del artista. Si es `null` o falla al cargar, se muestran las iniciales. |
| `seguido` | `bool` | | `false` | Estado inicial del botón. |
| `colorAvatar` | `Color` | | `Color(0xFF4338CA)` | Fondo del círculo cuando no hay foto. |
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

En el `pubspec.yaml` de la aplicación que lo vaya a usar (la ruta es relativa
a la carpeta de esa app; por ejemplo, desde una app en la raíz del repositorio):

```yaml
dependencies:
  tarjeta_artista:
    path: ../packages/tarjeta_artista
```

Después ejecuta `flutter pub get`.

## App de demostración

En `example/` hay una app Flutter que importa el paquete (`path: ../`) y muestra
la sección "Artistas para ti" con varias tarjetas. Al seguir o dejar de seguir
a un artista se actualiza un contador y aparece un aviso; al pulsar la tarjeta
se muestra "Abrir perfil de …".

```sh
cd example
flutter run -d linux
```

## Ejemplo de uso

```dart
import 'package:flutter/material.dart';
import 'package:tarjeta_artista/tarjeta_artista.dart';

class ArtistasParaTi extends StatelessWidget {
  const ArtistasParaTi({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          TarjetaArtista(
            nombre: 'Luna Ferrer',
            genero: 'Pop',
            seguido: true,
            alCambiarSeguimiento: (siguiendo) =>
                debugPrint('Luna Ferrer → $siguiendo'),
          ),
          const SizedBox(width: 16),
          TarjetaArtista(
            nombre: 'Kairo',
            genero: 'Reggaetón',
            colorAvatar: const Color(0xFFC2410C),
            imagen: const NetworkImage('https://ejemplo.com/kairo.jpg'),
            alPulsar: () => debugPrint('Abrir perfil de Kairo'),
          ),
        ],
      ),
    );
  }
}
```

## Pruebas

```sh
flutter test
```

Los tests de `test/src/tarjeta_artista_test.dart` comprueban:

- que se muestran el nombre, el género y las iniciales cuando no hay foto;
- que se muestra la foto cuando se pasa una, y que se vuelve a las iniciales si la foto falla al cargar;
- que el botón alterna entre "Seguir" y "Siguiendo" y que `alCambiarSeguimiento` recibe `true` y después `false`;
- que se respetan el valor inicial de `seguido` y los cambios que hace la app desde fuera;
- que `alPulsar` se lanza al tocar la tarjeta;
- que se pueden personalizar los textos del botón;
- que las iniciales se calculan bien (como máximo dos letras y en mayúscula).
