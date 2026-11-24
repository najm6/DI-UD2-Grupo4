import 'package:flutter/material.dart';

/// Tarjeta que muestra a un artista: foto, nombre,
/// género musical y un botón para seguirlo.
class TarjetaArtista extends StatefulWidget {
  /// Crea una tarjeta de artista.
  const TarjetaArtista({
    required this.nombre,
    required this.genero,
    required this.imagen,
    super.key,
    this.seguido = false,
    this.colorAcento = const Color(0xFFD4FF3A),
    this.colorFondo = const Color(0xFF1C1C1E),
    this.ancho = 160,
    this.textoSeguir = 'Seguir',
    this.textoSiguiendo = 'Siguiendo',
    this.alCambiarSeguimiento,
    this.alPulsar,
  });

  /// Nombre del artista.
  final String nombre;

  /// Género musical que predomina en el artista.
  final String genero;

  /// Foto del artista, por ejemplo `AssetImage('assets/artista.jpeg')`.
  /// Si no se puede cargar, se muestra un icono de persona.
  final ImageProvider imagen;

  /// Estado inicial del botón de seguir. Por defecto `false`.
  final bool seguido;

  /// Color del botón "Seguir" cuando el artista aún no se sigue.
  final Color colorAcento;

  /// Color de fondo de la tarjeta.
  final Color colorFondo;

  /// Ancho de la tarjeta. Por defecto 160.
  final double ancho;

  /// Texto del botón cuando el artista no se sigue.
  final String textoSeguir;

  /// Texto del botón cuando el artista ya se sigue.
  final String textoSiguiendo;

  /// Se llama al pulsar el botón, con el nuevo estado (`true` = siguiendo).
  final ValueChanged<bool>? alCambiarSeguimiento;

  /// Se llama al pulsar la tarjeta (fuera del botón).
  final VoidCallback? alPulsar;

  @override
  State<TarjetaArtista> createState() => _TarjetaArtistaState();
}

class _TarjetaArtistaState extends State<TarjetaArtista> {
  static const _colorTexto = Color(0xFFFFFFFF);
  static const _colorTextoSecundario = Color(0xFF9A9A9E);
  static const _colorChip = Color(0xFF2A2A2C);
  static const _colorBotonSiguiendo = Color(0xFF2C2C2E);

  late bool _seguido = widget.seguido;

  void _alternarSeguimiento() {
    setState(() => _seguido = !_seguido);
    widget.alCambiarSeguimiento?.call(_seguido);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.ancho,
      child: Material(
        color: widget.colorFondo,
        borderRadius: BorderRadius.circular(24),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: widget.alPulsar,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _avatar(),
                const SizedBox(height: 16),
                Text(
                  widget.nombre,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: _colorTexto,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 10),
                _txtGenero(),
                const SizedBox(height: 14),
                _botonSeguir(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _avatar() {
    return AspectRatio(
      aspectRatio: 1,
      child: ClipOval(
        child: Image(
          image: widget.imagen,
          fit: BoxFit.cover,
          semanticLabel: 'Foto de ${widget.nombre}',
          errorBuilder: (_, _, _) => const ColoredBox(
            color: _colorChip,
            child: Center(
              child: Icon(
                Icons.person,
                size: 56,
                color: _colorTextoSecundario,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _txtGenero() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: const ShapeDecoration(
        color: _colorChip,
        shape: StadiumBorder(),
      ),
      child: Text(
        widget.genero,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(color: _colorTextoSecundario, fontSize: 14),
      ),
    );
  }

  Widget _botonSeguir() {
    return SizedBox(
      width: double.infinity,
      height: 44,
      child: FilledButton(
        onPressed: _alternarSeguimiento,
        style: FilledButton.styleFrom(
          backgroundColor: _seguido ? _colorBotonSiguiendo : widget.colorAcento,
          foregroundColor: _seguido ? _colorTexto : Colors.black,
          shape: const StadiumBorder(),
          padding: EdgeInsets.zero,
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        child: Text(_seguido ? widget.textoSiguiendo : widget.textoSeguir),
      ),
    );
  }
}
