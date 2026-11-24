import 'package:flutter/material.dart';

/// Colores de la guía de estilo Sonora que usa este componente.
class SonoraColores {
  SonoraColores._();

  static const Color superficie = Color(0xFF1A1A1A);
  static const Color primario = Color(0xFFD4F73F);
  static const Color texto = Color(0xFFFAFAFA);
  static const Color texto2 = Color(0xFFA1A1AA);
  static const Color inactivo = Color(0xFF3F3F46);
  static const Color fondo = Color(0xFF0A0A0A);
}

/// Tarjeta que muestra una canción en una lista ("Canciones populares").
///
/// Muestra la portada, el título, los artistas separados por comas, la
/// duración en formato `m:ss` y, opcionalmente, un botón de reproducir que
/// notifica a la aplicación mediante [onPlay].
class TarjetaCancion extends StatelessWidget {
  const TarjetaCancion({
    super.key,
    required this.titulo,
    required this.artistas,
    required this.duracion,
    this.portada,
    this.colorPortada = SonoraColores.inactivo,
    this.mostrarPlay = true,
    this.onPlay,
  });

  /// Título de la canción.
  final String titulo;

  /// Lista de artistas. Se muestran unidos por ", ".
  final List<String> artistas;

  /// Duración de la canción. Se muestra como `m:ss` (o `h:mm:ss`).
  final Duration duracion;

  /// Imagen de portada (asset, red, memoria...). Opcional.
  final ImageProvider? portada;

  /// Color de la portada cuando no hay imagen. Por defecto, gris "Inactivo".
  final Color colorPortada;

  /// Si es `true` (valor por defecto) se muestra el botón de reproducir.
  final bool mostrarPlay;

  /// Se llama al pulsar el botón de reproducir.
  final VoidCallback? onPlay;

  /// Convierte una [Duration] en texto `m:ss` (o `h:mm:ss` si dura 1 h o más).
  static String formatearDuracion(Duration d) {
    final total = d.isNegative ? 0 : d.inSeconds;
    final horas = total ~/ 3600;
    final minutos = (total % 3600) ~/ 60;
    final segundos = (total % 60).toString().padLeft(2, '0');
    if (horas > 0) {
      return '$horas:${minutos.toString().padLeft(2, '0')}:$segundos';
    }
    return '$minutos:$segundos';
  }

  /// Une la lista de artistas en un único texto.
  static String unirArtistas(List<String> artistas) {
    final limpios =
        artistas.map((a) => a.trim()).where((a) => a.isNotEmpty).toList();
    return limpios.isEmpty ? 'Artista desconocido' : limpios.join(', ');
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: SonoraColores.superficie,
      borderRadius: BorderRadius.circular(10),
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Row(
          children: [
            _Portada(imagen: portada, color: colorPortada),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    titulo,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: SonoraColores.texto,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    unirArtistas(artistas),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: SonoraColores.texto2,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Text(
              formatearDuracion(duracion),
              style: const TextStyle(color: SonoraColores.texto2, fontSize: 12),
            ),
            if (mostrarPlay) ...[
              const SizedBox(width: 12),
              _BotonPlay(titulo: titulo, onPlay: onPlay),
            ],
          ],
        ),
      ),
    );
  }
}

class _Portada extends StatelessWidget {
  const _Portada({required this.imagen, required this.color});

  final ImageProvider? imagen;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const Key('tarjetaCancion_portada'),
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(4),
        image: imagen == null
            ? null
            : DecorationImage(image: imagen!, fit: BoxFit.cover),
      ),
    );
  }
}

class _BotonPlay extends StatelessWidget {
  const _BotonPlay({required this.titulo, required this.onPlay});

  final String titulo;
  final VoidCallback? onPlay;

  @override
  Widget build(BuildContext context) {
    final activo = onPlay != null;
    return Tooltip(
      message: 'Reproducir $titulo',
      child: Material(
        key: const Key('tarjetaCancion_botonPlay'),
        color: activo ? SonoraColores.primario : SonoraColores.inactivo,
        shape: const CircleBorder(),
        child: InkWell(
          customBorder: const CircleBorder(),
          onTap: onPlay,
          child: const SizedBox(
            width: 28,
            height: 28,
            child: CustomPaint(
              key: Key('tarjetaCancion_iconoPlay'),
              painter: _TrianguloPlay(SonoraColores.fondo),
            ),
          ),
        ),
      ),
    );
  }
}

/// Dibuja el triángulo de "play" sin depender de la fuente de iconos,
/// así el componente se ve igual en cualquier app que lo importe.
class _TrianguloPlay extends CustomPainter {
  const _TrianguloPlay(this.color);

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    // Triángulo desplazado un poco a la derecha para que se vea centrado.
    final path = Path()
      ..moveTo(w * 0.40, h * 0.30)
      ..lineTo(w * 0.72, h * 0.50)
      ..lineTo(w * 0.40, h * 0.70)
      ..close();
    canvas.drawPath(path, Paint()..color = color);
  }

  @override
  bool shouldRepaint(_TrianguloPlay oldDelegate) => oldDelegate.color != color;
}
