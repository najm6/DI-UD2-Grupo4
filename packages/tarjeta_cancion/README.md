# tarjeta_cancion

Componente 2 de la app **Sonora**: tarjeta para la sección *Canciones populares*.

Muestra la portada, el título, los artistas (unidos por comas), la duración en formato `m:ss` y un botón circular de reproducir que avisa a la aplicación cuando se pulsa.

## Propiedades

| Propiedad      | Tipo             | Obligatoria | Valor por defecto        | Descripción |
|----------------|------------------|-------------|--------------------------|-------------|
| `titulo`       | `String`         | Sí          | —                        | Título de la canción. |
| `artistas`     | `List<String>`   | Sí          | —                        | Artistas; se muestran como `"A, B"`. Si la lista está vacía se muestra "Artista desconocido". |
| `duracion`     | `Duration`       | Sí          | —                        | Se formatea como `3:24` (o `1:02:03` si supera la hora). |
| `portada`      | `ImageProvider?` | No          | `null`                   | Imagen de portada (`AssetImage`, `NetworkImage`…). |
| `colorPortada` | `Color`          | No          | `#3F3F46` (Inactivo)     | Color de la portada cuando no hay imagen. |
| `mostrarPlay`  | `bool`           | No          | `true`                   | Muestra u oculta el botón de reproducir. |

## Eventos

| Evento   | Tipo            | Cuándo se lanza |
|----------|-----------------|-----------------|
| `onPlay` | `VoidCallback?` | Al pulsar el botón de reproducir. Si es `null`, el botón aparece en gris y desactivado. |

## Instalación (dependencia local)

En el `pubspec.yaml` de la app que lo use:

```yaml
dependencies:
  tarjeta_cancion:
    path: ../tarjeta_cancion
```

## Ejemplo de uso

```dart
import 'package:tarjeta_cancion/tarjeta_cancion.dart';

TarjetaCancion(
  titulo: 'Noches de Neón',
  artistas: ['Luna Ferrer', 'Kairo'],
  duracion: Duration(minutes: 3, seconds: 24),
  colorPortada: Color(0xFF4F3FD9),
  onPlay: () => print('Reproducir Noches de Neón'),
)
```

Hay un ejemplo completo en `example/lib/main.dart` (`cd example && flutter run`).

## Pruebas

```bash
flutter test
```

Comprueban que:
- se muestran título, artistas unidos y duración formateada;
- al pulsar el botón se llama a `onPlay`;
- `mostrarPlay` vale `true` por defecto y con `false` el botón desaparece;
- el formateo de duración y la unión de artistas funcionan en casos límite.

## Estilo

Sigue la guía Sonora: superficie `#1A1A1A`, primario `#D4F73F`, texto `#FAFAFA`, texto 2 `#A1A1AA`, radio 10, espaciado 8/12, tipografía Nombre 14 SemiBold y Secundario 12 Regular.
