import 'package:flutter/material.dart';
import 'package:tarjeta_cancion/tarjeta_cancion.dart';

void main() => runApp(const EjemploApp());

class EjemploApp extends StatelessWidget {
  const EjemploApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sonora · TarjetaCancion',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: SonoraColores.fondo,
        colorScheme: const ColorScheme.dark(primary: SonoraColores.primario),
      ),
      home: const PantallaEjemplo(),
    );
  }
}

/// Datos de prueba sacados del diseño de Figma.
class Cancion {
  const Cancion(this.titulo, this.artistas, this.duracion, this.color);

  final String titulo;
  final List<String> artistas;
  final Duration duracion;
  final Color color;
}

const _canciones = [
  Cancion('Noches de Neón', ['Luna Ferrer', 'Kairo'],
      Duration(minutes: 3, seconds: 24), Color(0xFF4F3FD9)),
  Cancion('Marea Alta', ['Los Faros'], Duration(minutes: 4, seconds: 5),
      Color(0xFF14776A)),
  Cancion('Seda', ['Mara Sol'], Duration(minutes: 2, seconds: 58),
      Color(0xFFA0660E)),
  Cancion('Fuego Lento', ['Kairo', 'Luna Ferrer'],
      Duration(minutes: 3, seconds: 12), Color(0xFFC2410C)),
];

class PantallaEjemplo extends StatefulWidget {
  const PantallaEjemplo({super.key});

  @override
  State<PantallaEjemplo> createState() => _PantallaEjemploState();
}

class _PantallaEjemploState extends State<PantallaEjemplo> {
  Cancion? _sonando;
  bool _mostrarPlay = true;

  void _reproducir(Cancion c) {
    setState(() => _sonando = c);
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(
        content: Text('onPlay → ${c.titulo}'),
        duration: const Duration(seconds: 1),
      ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            // Cabecera de la sección, como en el Figma
            Row(
              children: [
                const Expanded(
                  child: Text(
                    'Canciones populares',
                    style: TextStyle(
                      color: SonoraColores.texto,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text('Ver todas',
                      style: TextStyle(color: SonoraColores.primario)),
                ),
              ],
            ),
            const SizedBox(height: 4),
            const Text(
              'COMPONENTE 2 · TARJETA CANCIÓN',
              style: TextStyle(
                color: SonoraColores.texto2,
                fontSize: 10,
                letterSpacing: 1,
              ),
            ),
            const SizedBox(height: 12),

            // El componente
            for (final c in _canciones) ...[
              TarjetaCancion(
                titulo: c.titulo,
                artistas: c.artistas,
                duracion: c.duracion,
                colorPortada: c.color,
                mostrarPlay: _mostrarPlay,
                onPlay: () => _reproducir(c),
              ),
              const SizedBox(height: 8),
            ],

            const SizedBox(height: 16),
            const Text(
              'Casos especiales',
              style: TextStyle(color: SonoraColores.texto2, fontSize: 12),
            ),
            const SizedBox(height: 8),

            // Sin onPlay → botón gris desactivado
            const TarjetaCancion(
              titulo: 'Sin evento onPlay (botón desactivado)',
              artistas: ['Demo'],
              duracion: Duration(minutes: 1, seconds: 5),
            ),
            const SizedBox(height: 8),

            // Lista vacía de artistas + duración larga + título largo
            const TarjetaCancion(
              titulo: 'Un título larguísimo que no cabe en una sola línea',
              artistas: [],
              duracion: Duration(hours: 1, minutes: 2, seconds: 3),
              colorPortada: Color(0xFF6D28D9),
            ),

            const SizedBox(height: 16),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('mostrarPlay',
                  style: TextStyle(color: SonoraColores.texto)),
              value: _mostrarPlay,
              activeColor: SonoraColores.primario,
              onChanged: (v) => setState(() => _mostrarPlay = v),
            ),
          ],
        ),
      ),

      // Mini reproductor para comprobar el evento
      bottomNavigationBar: _sonando == null
          ? null
          : Container(
              color: SonoraColores.superficie,
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
              child: Row(
                children: [
                  const Icon(Icons.graphic_eq, color: SonoraColores.primario),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Sonando: ${_sonando!.titulo}',
                      style: const TextStyle(color: SonoraColores.texto),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.stop, color: SonoraColores.texto2),
                    onPressed: () => setState(() => _sonando = null),
                  ),
                ],
              ),
            ),
    );
  }
}
