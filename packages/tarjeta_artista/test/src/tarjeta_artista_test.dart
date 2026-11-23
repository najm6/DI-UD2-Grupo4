import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tarjeta_artista/tarjeta_artista.dart';

/// PNG transparente de 1x1 píxel para probar la foto sin usar la red.
final _pngTransparente = Uint8List.fromList(const [
  0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A, 0x00, 0x00, 0x00, 0x0D, //
  0x49, 0x48, 0x44, 0x52, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x01,
  0x08, 0x06, 0x00, 0x00, 0x00, 0x1F, 0x15, 0xC4, 0x89, 0x00, 0x00, 0x00,
  0x0D, 0x49, 0x44, 0x41, 0x54, 0x78, 0x9C, 0x63, 0x00, 0x01, 0x00, 0x00,
  0x05, 0x00, 0x01, 0x0D, 0x0A, 0x2D, 0xB4, 0x00, 0x00, 0x00, 0x00, 0x49,
  0x45, 0x4E, 0x44, 0xAE, 0x42, 0x60, 0x82,
]);

Future<void> _pintar(WidgetTester tester, Widget tarjeta) {
  return tester.pumpWidget(
    MaterialApp(
      home: Scaffold(body: Center(child: tarjeta)),
    ),
  );
}

void main() {
  group('TarjetaArtista', () {
    testWidgets('muestra nombre, género e iniciales sin foto', (tester) async {
      await _pintar(
        tester,
        const TarjetaArtista(nombre: 'Luna Ferrer', genero: 'Pop'),
      );

      expect(find.text('Luna Ferrer'), findsOneWidget);
      expect(find.text('Pop'), findsOneWidget);
      expect(find.text('LF'), findsOneWidget);
      expect(find.byType(Image), findsNothing);
    });

    testWidgets('muestra la foto cuando se le pasa una imagen', (tester) async {
      await _pintar(
        tester,
        TarjetaArtista(
          nombre: 'Kairo',
          genero: 'Reggaetón',
          imagen: MemoryImage(_pngTransparente),
        ),
      );

      expect(find.byType(Image), findsOneWidget);
      expect(find.text('K'), findsNothing);
    });

    testWidgets('si la foto no se puede cargar muestra las iniciales', (
      tester,
    ) async {
      await _pintar(
        tester,
        TarjetaArtista(
          nombre: 'Mara Sol',
          genero: 'R&B',
          imagen: MemoryImage(Uint8List.fromList(const [0, 1, 2, 3])),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('MS'), findsOneWidget);
    });

    testWidgets('por defecto no está seguido y muestra "Seguir"', (
      tester,
    ) async {
      await _pintar(
        tester,
        const TarjetaArtista(nombre: 'Kairo', genero: 'Reggaetón'),
      );

      expect(find.text('Seguir'), findsOneWidget);
      expect(find.text('Siguiendo'), findsNothing);
    });

    testWidgets(
      'al pulsar el botón cambia el texto y avisa con alCambiarSeguimiento',
      (tester) async {
        final valoresRecibidos = <bool>[];

        await _pintar(
          tester,
          TarjetaArtista(
            nombre: 'Kairo',
            genero: 'Reggaetón',
            alCambiarSeguimiento: valoresRecibidos.add,
          ),
        );

        await tester.tap(find.text('Seguir'));
        await tester.pump();
        expect(find.text('Siguiendo'), findsOneWidget);

        await tester.tap(find.text('Siguiendo'));
        await tester.pump();
        expect(find.text('Seguir'), findsOneWidget);

        expect(valoresRecibidos, [true, false]);
      },
    );

    testWidgets('respeta el estado inicial seguido: true', (tester) async {
      await _pintar(
        tester,
        const TarjetaArtista(
          nombre: 'Luna Ferrer',
          genero: 'Pop',
          seguido: true,
        ),
      );

      expect(find.text('Siguiendo'), findsOneWidget);
    });

    testWidgets('se sincroniza si la app cambia "seguido" desde fuera', (
      tester,
    ) async {
      await _pintar(
        tester,
        const TarjetaArtista(nombre: 'Mara Sol', genero: 'R&B'),
      );
      expect(find.text('Seguir'), findsOneWidget);

      await _pintar(
        tester,
        const TarjetaArtista(nombre: 'Mara Sol', genero: 'R&B', seguido: true),
      );
      expect(find.text('Siguiendo'), findsOneWidget);
    });

    testWidgets('llama a alPulsar al tocar la tarjeta', (tester) async {
      var pulsaciones = 0;

      await _pintar(
        tester,
        TarjetaArtista(
          nombre: 'Los Faros',
          genero: 'Indie rock',
          alPulsar: () => pulsaciones++,
        ),
      );

      await tester.tap(find.text('Los Faros'));
      expect(pulsaciones, 1);
    });

    testWidgets('usa textos personalizados del botón', (tester) async {
      await _pintar(
        tester,
        const TarjetaArtista(
          nombre: 'Kairo',
          genero: 'Reggaetón',
          textoSeguir: 'Follow',
          textoSiguiendo: 'Following',
        ),
      );

      await tester.tap(find.text('Follow'));
      await tester.pump();
      expect(find.text('Following'), findsOneWidget);
    });
  });

  group('TarjetaArtista.iniciales', () {
    test('coge como máximo dos iniciales en mayúscula', () {
      expect(TarjetaArtista.iniciales('Luna Ferrer'), 'LF');
      expect(TarjetaArtista.iniciales('kairo'), 'K');
      expect(TarjetaArtista.iniciales('  Los   Faros del Sur '), 'LF');
      expect(TarjetaArtista.iniciales(''), '');
    });
  });
}
