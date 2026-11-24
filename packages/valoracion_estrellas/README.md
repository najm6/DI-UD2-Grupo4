# valoracion_estrellas

Widget personalizado de Flutter para mostrar y seleccionar una valoración con estrellas.

## Propiedades

| Propiedad | Tipo | Valor por defecto | Descripción |
|---|---|---:|---|
| `valor` | `int` | `0` | Valoración actual |
| `maxEstrellas` | `int` | `5` | Número máximo de estrellas |
| `tamano` | `double` | `28` | Tamaño de cada estrella |
| `colorActivo` | `Color` | `Color(0xFFFBBF24)` | Color de las estrellas seleccionadas |
| `soloLectura` | `bool` | `false` | Desactiva la interacción |
| `onValoracionCambiada` | `ValueChanged<int>?` | `null` | Notifica el nuevo valor al pulsar una estrella |
| `colorInactivo` | `Color` | `Color(0xFFBDBDBD)` | Color de las estrellas no seleccionadas |
| `separacion` | `double` | `2` | Separación horizontal entre estrellas |

## Ejemplo de uso

```dart
import 'package:flutter/material.dart';
import 'package:valoracion_estrellas/valoracion_estrellas.dart';

class EjemploValoracion extends StatefulWidget {
  const EjemploValoracion({super.key});

  @override
  State<EjemploValoracion> createState() => _EjemploValoracionState();
}

class _EjemploValoracionState extends State<EjemploValoracion> {
  int valoracion = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ValoracionEstrellas(
          valor: valoracion,
          maxEstrellas: 5,
          tamano: 28,
          colorActivo: const Color(0xFFFBBF24),
          soloLectura: false,
          onValoracionCambiada: (nuevoValor) {
            setState(() => valoracion = nuevoValor);
          },
        ),
        Text('Valoración: $valoracion/5'),
      ],
    );
  }
}
```

## Modo de solo lectura

```dart
const ValoracionEstrellas(
  valor: 4,
  soloLectura: true,
)
```

## Ejecutar las pruebas

Desde la raíz del paquete:

```bash
flutter pub get
flutter test
```

## Exportación

El widget queda exportado desde `lib/valoracion_estrellas.dart`.
Para utilizarlo desde otro proyecto, añade el paquete como dependencia local o publícalo
en el repositorio de paquetes que utilice tu equipo.
