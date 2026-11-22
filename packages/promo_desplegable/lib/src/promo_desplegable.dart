import 'package:flutter/material.dart';

/// Banner que muestra un título y un subtítulo y, al pulsarlo,
/// se despliega para enseñar más contenido y un botón de acción.
///
/// Se usa en la pantalla "Descubre música" para el lanzamiento destacado
/// y para el top de la semana.
class PromoDesplegable extends StatefulWidget {
  const PromoDesplegable({
    super.key,
    required this.titulo,
    required this.subtitulo,
    this.contenido,
    this.icono = Icons.local_fire_department,
    this.expandido = false,
    this.colorAcento = const Color(0xFFFF7849),
    this.textoAccion = 'Escuchar ahora',
    this.onExpandidoCambiado,
    this.onAccion,
    this.onDescartar,
  });

  /// Texto principal de la cabecera, por ejemplo "Lanzamiento destacado".
  final String titulo;

  /// Texto pequeño debajo del título.
  final String subtitulo;

  /// Lo que se ve al desplegar (portada, nombre de la canción...).
  final Widget? contenido;

  /// Icono de la cabecera.
  final IconData icono;

  /// Si empieza abierto o cerrado.
  final bool expandido;

  /// Color del icono y del botón de acción.
  final Color colorAcento;

  /// Texto del botón de acción.
  final String textoAccion;

  /// Se llama cada vez que se abre o se cierra, con el estado nuevo.
  final ValueChanged<bool>? onExpandidoCambiado;

  /// Se llama al pulsar el botón de acción. Si es null no se muestra el botón.
  final VoidCallback? onAccion;

  /// Se llama al pulsar "Descartar". Si es null no se muestra.
  final VoidCallback? onDescartar;

  @override
  State<PromoDesplegable> createState() => _PromoDesplegableState();
}

class _PromoDesplegableState extends State<PromoDesplegable> {
  late bool _abierto;

  @override
  void initState() {
    super.initState();
    _abierto = widget.expandido;
  }

  @override
  void didUpdateWidget(PromoDesplegable oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Si la app cambia el valor desde fuera, lo respetamos.
    if (oldWidget.expandido != widget.expandido) {
      _abierto = widget.expandido;
    }
  }

  void _cambiar() {
    setState(() => _abierto = !_abierto);
    widget.onExpandidoCambiado?.call(_abierto);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1C1C1E),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: _cambiar,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 16,
                    backgroundColor: widget.colorAcento.withValues(alpha: 0.2),
                    child: Icon(widget.icono, color: widget.colorAcento, size: 18),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.titulo,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          widget.subtitulo,
                          style: const TextStyle(color: Color(0xFF9E9EA6), fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  AnimatedRotation(
                    turns: _abierto ? 0.5 : 0,
                    duration: const Duration(milliseconds: 200),
                    child: const Icon(Icons.expand_more, color: Color(0xFF9E9EA6)),
                  ),
                ],
              ),
            ),
          ),
          // AnimatedSize hace que el cambio de altura sea suave.
          AnimatedSize(
            duration: const Duration(milliseconds: 200),
            child: _abierto ? _parteDesplegada() : const SizedBox(width: double.infinity),
          ),
        ],
      ),
    );
  }

  Widget _parteDesplegada() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.contenido != null) widget.contenido!,
          if (widget.onAccion != null || widget.onDescartar != null) const SizedBox(height: 10),
          Row(
            children: [
              if (widget.onAccion != null)
                FilledButton.icon(
                  onPressed: widget.onAccion,
                  style: FilledButton.styleFrom(backgroundColor: widget.colorAcento),
                  icon: const Icon(Icons.play_arrow, size: 18),
                  label: Text(widget.textoAccion),
                ),
              const SizedBox(width: 8),
              if (widget.onDescartar != null)
                TextButton(
                  onPressed: widget.onDescartar,
                  child: const Text('Descartar', style: TextStyle(color: Color(0xFF9E9EA6))),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
