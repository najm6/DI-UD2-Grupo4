import 'package:flutter/material.dart';

/// Selector de valoración mediante estrellas.
///
/// Permite configurar el valor inicial, el número máximo de estrellas,
/// el tamaño, el color activo y el modo de solo lectura.
class ValoracionEstrellas extends StatelessWidget {
  const ValoracionEstrellas({
    super.key,
    this.valor = 0,
    this.maxEstrellas = 5,
    this.tamano = 28,
    this.colorActivo = const Color(0xFFFBBF24),
    this.soloLectura = false,
    this.onValoracionCambiada,
    this.colorInactivo = const Color(0xFFBDBDBD),
    this.separacion = 2,
  }) : assert(maxEstrellas > 0, 'maxEstrellas debe ser mayor que cero'),
       assert(tamano > 0, 'tamano debe ser mayor que cero'),
       assert(separacion >= 0, 'separacion no puede ser negativa');

  /// Valor actual de la valoración. Se limita visualmente entre 0 y
  /// [maxEstrellas].
  final int valor;

  /// Número total de estrellas que se muestran.
  final int maxEstrellas;

  /// Tamaño, en píxeles lógicos, de cada estrella.
  final double tamano;

  /// Color de las estrellas seleccionadas.
  final Color colorActivo;

  /// Si es `true`, no permite modificar la valoración.
  final bool soloLectura;

  /// Se ejecuta al pulsar una estrella. Devuelve el nuevo valor entero.
  final ValueChanged<int>? onValoracionCambiada;

  /// Color de las estrellas que todavía no están seleccionadas.
  final Color colorInactivo;

  /// Espacio horizontal entre estrellas.
  final double separacion;

  @override
  Widget build(BuildContext context) {
    final valorVisible = valor.clamp(0, maxEstrellas);

    return Semantics(
      label: 'Valoración: $valorVisible de $maxEstrellas estrellas',
      readOnly: soloLectura,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(maxEstrellas, (indice) {
          final numeroEstrella = indice + 1;
          final seleccionada = numeroEstrella <= valorVisible;

          final estrella = Icon(
            seleccionada ? Icons.star : Icons.star_border,
            size: tamano,
            color: seleccionada ? colorActivo : colorInactivo,
          );

          return Padding(
            padding: EdgeInsets.symmetric(horizontal: separacion / 2),
            child: soloLectura
                ? estrella
                : InkResponse(
                    onTap: () => onValoracionCambiada?.call(numeroEstrella),
                    radius: tamano,
                    containedInkWell: true,
                    child: Padding(
                      padding: const EdgeInsets.all(2),
                      child: estrella,
                    ),
                  ),
          );
        }),
      ),
    );
  }
}
