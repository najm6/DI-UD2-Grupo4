import 'package:flutter/material.dart';
import 'package:tarjeta_artista/tarjeta_artista.dart';

void main() => runApp(const AppDemo());

/// Colores compartidos de la pantalla (los del diseño en Figma).
class ColoresApp {
  static const fondo = Color(0xFF0E0E10);
  static const acento = Color(0xFFD4FF3A);
  static const textoSecundario = Color(0xFF6E6E73);
}

class AppDemo extends StatelessWidget {
  const AppDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Demo TarjetaArtista',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: ColoresApp.fondo,
        colorScheme: const ColorScheme.dark(primary: ColoresApp.acento),
      ),
      home: const PantallaInicio(),
    );
  }
}

/// Datos de ejemplo de un artista.
class Artista {
  const Artista(this.nombre, this.genero, this.color, {this.seguido = false});

  final String nombre;
  final String genero;
  final Color color;
  final bool seguido;
}

const artistas = [
  Artista('Luna Ferrer', 'Pop', Color(0xFF4338CA), seguido: true),
  Artista('Kairo', 'Reggaetón', Color(0xFFC2410C)),
  Artista('Los Faros', 'Indie rock', Color(0xFF0F766E)),
  Artista('Mara Sol', 'R&B', Color(0xFFB45309)),
];

class PantallaInicio extends StatefulWidget {
  const PantallaInicio({super.key});

  @override
  State<PantallaInicio> createState() => _PantallaInicioState();
}

class _PantallaInicioState extends State<PantallaInicio> {
  /// Artistas que el usuario sigue. Se actualiza con los eventos de las tarjetas.
  final Set<String> _seguidos = {
    for (final a in artistas)
      if (a.seguido) a.nombre,
  };

  void _mostrarAviso(String mensaje) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(content: Text(mensaje), duration: const Duration(seconds: 2)),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 24),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Artistas para ti',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () => _mostrarAviso('Ver todos los artistas'),
                    child: const Text(
                      'Ver todos',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 4, 20, 16),
              child: Text(
                'Sigues a ${_seguidos.length} '
                '${_seguidos.length == 1 ? 'artista' : 'artistas'}',
                style: const TextStyle(color: ColoresApp.textoSecundario),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (final artista in artistas) ...[
                    TarjetaArtista(
                      nombre: artista.nombre,
                      genero: artista.genero,
                      colorAvatar: artista.color,
                      seguido: artista.seguido,
                      alCambiarSeguimiento: (siguiendo) {
                        setState(() {
                          if (siguiendo) {
                            _seguidos.add(artista.nombre);
                          } else {
                            _seguidos.remove(artista.nombre);
                          }
                        });
                        _mostrarAviso(
                          siguiendo
                              ? 'Ahora sigues a ${artista.nombre}'
                              : 'Has dejado de seguir a ${artista.nombre}',
                        );
                      },
                      alPulsar: () =>
                          _mostrarAviso('Abrir perfil de ${artista.nombre}'),
                    ),
                    const SizedBox(width: 16),
                  ],
                ],
              ),
            ),
            // Aquí irán los componentes del resto del grupo:
            // TarjetaCancion, PromoDesplegable y ValoracionEstrellas.
          ],
        ),
      ),
    );
  }
}
