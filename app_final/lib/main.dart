import 'package:flutter/material.dart';
import 'package:promo_desplegable/promo_desplegable.dart';
import 'package:tarjeta_artista/tarjeta_artista.dart';
import 'package:tarjeta_cancion/tarjeta_cancion.dart';
import 'package:valoracion_estrellas/valoracion_estrellas.dart';

void main() => runApp(const AppSonora());

/// Colores compartidos de la pantalla (los del diseño en Figma).
class ColoresSonora {
  static const fondo = Color(0xFF0E0E10);
  static const superficie = Color(0xFF1C1C1E);
  static const acento = Color(0xFFD4FF3A);
  static const textoSecundario = Color(0xFF9A9A9E);
}

class AppSonora extends StatelessWidget {
  const AppSonora({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sonora',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: ColoresSonora.fondo,
        colorScheme: const ColorScheme.dark(primary: ColoresSonora.acento),
      ),
      home: const PantallaInicio(),
    );
  }
}

/// Datos de ejemplo de un artista.
class Artista {
  const Artista(this.nombre, this.genero, this.foto, {this.seguido = false});

  final String nombre;
  final String genero;

  /// Ruta de la foto dentro de assets/artistas.
  final String foto;
  final bool seguido;
}

const artistas = [
  Artista(
    'Taylor Swift',
    'Pop',
    'assets/artistas/taylor_swift.jpeg',
    seguido: true,
  ),
  Artista('Bad Bunny', 'Reggaetón', 'assets/artistas/bad_bunny.jpeg'),
  Artista('Young Thug', 'Rap', 'assets/artistas/young_thug.jpeg'),
  Artista('The Weeknd', 'R&B', 'assets/artistas/the_weeknd.jpeg'),
];

/// Datos de ejemplo de una canción.
class Cancion {
  const Cancion(this.titulo, this.artistas, this.duracion, this.portada);

  final String titulo;
  final List<String> artistas;
  final Duration duracion;
  final String portada;
}

const canciones = [
  Cancion(
    'Fortnight',
    ['Taylor Swift', 'Post Malone'],
    Duration(minutes: 3, seconds: 48),
    'assets/artistas/taylor_swift.jpeg',
  ),
  Cancion(
    'DtMF',
    ['Bad Bunny'],
    Duration(minutes: 3, seconds: 57),
    'assets/artistas/bad_bunny.jpeg',
  ),
  Cancion(
    'Timeless',
    ['The Weeknd', 'Playboi Carti'],
    Duration(minutes: 4, seconds: 16),
    'assets/artistas/the_weeknd.jpeg',
  ),
  Cancion(
    'Lifestyle',
    ['Young Thug', 'Rich Homie Quan'],
    Duration(minutes: 4, seconds: 9),
    'assets/artistas/young_thug.jpeg',
  ),
];

class PantallaInicio extends StatefulWidget {
  const PantallaInicio({super.key});

  @override
  State<PantallaInicio> createState() => _PantallaInicioState();
}

class _PantallaInicioState extends State<PantallaInicio> {
  /// Artistas que sigue el usuario (evento de TarjetaArtista).
  final Set<String> _seguidos = {
    for (final a in artistas)
      if (a.seguido) a.nombre,
  };

  /// Valoración de la canción (evento de ValoracionEstrellas).
  int _valoracion = 0;

  /// Si el usuario ha descartado la promo del lanzamiento (evento de
  /// PromoDesplegable).
  bool _promoDescartada = false;

  void _aviso(String mensaje) {
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
            // ---------- Cabecera ----------
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 4),
                  Text(
                    'Descubre música',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // ---------- Componente 3: PromoDesplegable ----------
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  if (!_promoDescartada) ...[
                    PromoDesplegable(
                      titulo: 'Lanzamiento destacado',
                      subtitulo: 'Nuevo single · Ya disponible',
                      expandido: true,
                      contenido: const _ContenidoPromo(
                        titulo: 'Timeless',
                        artistas: 'The Weeknd',
                        foto: 'assets/artistas/the_weeknd.jpeg',
                      ),
                      onAccion: () => _aviso('Reproduciendo "Timeless"'),
                      onDescartar: () {
                        setState(() => _promoDescartada = true);
                        _aviso('Promoción descartada');
                      },
                    ),
                    const SizedBox(height: 12),
                  ],
                  PromoDesplegable(
                    titulo: 'Top de la semana',
                    subtitulo: 'Bad Bunny entra en el nº 1',
                    icono: Icons.star,
                    colorAcento: ColoresSonora.acento,
                    contenido: const _ContenidoPromo(
                      titulo: 'DtMF',
                      artistas: 'Bad Bunny',
                      foto: 'assets/artistas/bad_bunny.jpeg',
                    ),
                    onExpandidoCambiado: (abierto) =>
                        _aviso(abierto ? 'Top desplegado' : 'Top plegado'),
                    onAccion: () => _aviso('Reproduciendo "DtMF"'),
                  ),
                ],
              ),
            ),

            // ---------- Componente 1: TarjetaArtista ----------
            _Seccion(
              titulo: 'Artistas para ti',
              subtitulo:
                  'Sigues a ${_seguidos.length} '
                  '${_seguidos.length == 1 ? 'artista' : 'artistas'}',
              accion: 'Ver todos',
              alPulsarAccion: () => _aviso('Ver todos los artistas'),
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
                      imagen: AssetImage(artista.foto),
                      seguido: artista.seguido,
                      alCambiarSeguimiento: (siguiendo) {
                        setState(() {
                          if (siguiendo) {
                            _seguidos.add(artista.nombre);
                          } else {
                            _seguidos.remove(artista.nombre);
                          }
                        });
                        _aviso(
                          siguiendo
                              ? 'Ahora sigues a ${artista.nombre}'
                              : 'Has dejado de seguir a ${artista.nombre}',
                        );
                      },
                      alPulsar: () =>
                          _aviso('Abrir perfil de ${artista.nombre}'),
                    ),
                    const SizedBox(width: 16),
                  ],
                ],
              ),
            ),

            // ---------- Componente 2: TarjetaCancion ----------
            _Seccion(
              titulo: 'Canciones populares',
              accion: 'Ver todas',
              alPulsarAccion: () => _aviso('Ver todas las canciones'),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  for (final c in canciones) ...[
                    TarjetaCancion(
                      titulo: c.titulo,
                      artistas: c.artistas,
                      duracion: c.duracion,
                      portada: AssetImage(c.portada),
                      onPlay: () => _aviso('Reproduciendo "${c.titulo}"'),
                    ),
                    const SizedBox(height: 10),
                  ],
                ],
              ),
            ),

            // ---------- Componente 4: ValoracionEstrellas ----------
            const _Seccion(titulo: '¿Qué te ha parecido?'),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: ColoresSonora.superficie,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(14),
                      child: Image.asset(
                        'assets/artistas/taylor_swift.jpeg',
                        width: 72,
                        height: 72,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Fortnight',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const Text(
                            'Taylor Swift',
                            style: TextStyle(
                              color: ColoresSonora.textoSecundario,
                            ),
                          ),
                          const SizedBox(height: 6),
                          ValoracionEstrellas(
                            valor: _valoracion,
                            colorInactivo: const Color(0xFF3A3A3C),
                            onValoracionCambiada: (valor) {
                              setState(() => _valoracion = valor);
                              _aviso('Has valorado con $valor/5');
                            },
                          ),
                          Text(
                            _valoracion == 0
                                ? 'Sin valorar'
                                : 'Tu valoración: $_valoracion/5',
                            style: const TextStyle(
                              color: ColoresSonora.textoSecundario,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Título de sección con texto secundario y acción opcionales.
class _Seccion extends StatelessWidget {
  const _Seccion({
    required this.titulo,
    this.subtitulo,
    this.accion,
    this.alPulsarAccion,
  });

  final String titulo;
  final String? subtitulo;
  final String? accion;
  final VoidCallback? alPulsarAccion;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 28, 20, 14),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  titulo,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (subtitulo != null)
                  Text(
                    subtitulo!,
                    style: const TextStyle(
                      color: ColoresSonora.textoSecundario,
                    ),
                  ),
              ],
            ),
          ),
          if (accion != null)
            TextButton(onPressed: alPulsarAccion, child: Text(accion!)),
        ],
      ),
    );
  }
}

/// Contenido que se ve al desplegar una promo: portada + canción.
class _ContenidoPromo extends StatelessWidget {
  const _ContenidoPromo({
    required this.titulo,
    required this.artistas,
    required this.foto,
  });

  final String titulo;
  final String artistas;
  final String foto;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.asset(foto, width: 64, height: 64, fit: BoxFit.cover),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                titulo,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                artistas,
                style: const TextStyle(color: ColoresSonora.textoSecundario),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
