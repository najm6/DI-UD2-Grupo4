# promo_desplegable

Componente 3 de la app **Sonora** (proyecto DI UD2, Grupo 4). Autor: Jamie Tanner Rodríguez.

`PromoDesplegable` es un banner que enseña un título y un subtítulo. Al pulsarlo se despliega con una animación y muestra más contenido y un botón de acción. En la pantalla "Descubre música" se usa para el **lanzamiento destacado** y para el **top de la semana**.

## Propiedades

| Propiedad | Tipo | Por defecto | Para qué sirve |
|---|---|---|---|
| `titulo` | `String` | obligatoria | Texto principal de la cabecera |
| `subtitulo` | `String` | obligatoria | Texto pequeño debajo del título |
| `contenido` | `Widget?` | `null` | Lo que aparece al desplegar |
| `icono` | `IconData` | `Icons.local_fire_department` | Icono de la cabecera |
| `expandido` | `bool` | `false` | Si empieza abierto o cerrado |
| `colorAcento` | `Color` | `Color(0xFFFF7849)` | Color del icono y del botón |
| `textoAccion` | `String` | `'Escuchar ahora'` | Texto del botón de acción |

## Eventos

| Evento | Tipo | Cuándo se llama |
|---|---|---|
| `onExpandidoCambiado` | `ValueChanged<bool>?` | Al abrir o cerrar; recibe `true` si queda abierto |
| `onAccion` | `VoidCallback?` | Al pulsar el botón de acción. Si es `null` el botón no se muestra |
| `onDescartar` | `VoidCallback?` | Al pulsar "Descartar". Si es `null` no se muestra |

## Instalación

En el `pubspec.yaml` de la app, como dependencia local:

```yaml
dependencies:
  promo_desplegable:
    path: ../packages/promo_desplegable
```

## Ejemplo de uso

```dart
import 'package:promo_desplegable/promo_desplegable.dart';

PromoDesplegable(
  titulo: 'Lanzamiento destacado',
  subtitulo: 'Nuevo single · Ya disponible',
  contenido: const Text('Fuego Lento · Kairo, Luna Ferrer'),
  onExpandidoCambiado: (abierto) => print('Abierto: $abierto'),
  onAccion: () => print('Reproducir Fuego Lento'),
  onDescartar: () => print('Promo descartada'),
)
```

## Pruebas

```bash
flutter test
```

Hay tres pruebas de widget en `test/promo_desplegable_test.dart`:

1. Empieza cerrado; al pulsarlo se abre, enseña el contenido y `onExpandidoCambiado` recibe `true`. Al pulsar otra vez se cierra y recibe `false`.
2. El botón "Escuchar ahora" (texto por defecto) llama a `onAccion`.
3. Si no se pasan `onAccion` ni `onDescartar`, no aparece ningún botón.
