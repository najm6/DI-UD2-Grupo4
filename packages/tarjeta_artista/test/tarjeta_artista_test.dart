import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tarjeta_artista/tarjeta_artista.dart';

/// PNG transparente de 1x1 píxel para probar la foto sin usar archivos.
final _foto = MemoryImage(
  Uint8List.fromList(const [
    0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A, 0x00, 0x00, 0x00, 0x0D, //
    0x49, 0x48, 0x44, 0x52, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x01,
    0x08, 0x06, 0x00, 0x00, 0x00, 0x1F, 0x15, 0xC4, 0x89, 0x00, 0x00, 0x00,
    0x0D, 0x49, 0x44, 0x41, 0x54, 0x78, 0x9C, 0x63, 0x00, 0x01, 0x00, 0x00,
    0x05, 0x00, 0x01, 0x0D, 0x0A, 0x2D, 0xB4, 0x00, 0x00, 0x00, 0x00, 0x49,
    0x45, 0x4E, 0x44, 0xAE, 0x42, 0x60, 0x82,
  ]),
);

Future<void> _pintar(WidgetTester tester, Widget tarjeta) {
  return tester.pumpWidget(
    MaterialApp(
      home: Scaffold(body: Center(child: tarjeta)),
    ),
  );
}

void main() {
  testWidgets('muestra la foto, el nombre y el género', (tester) async {
    await _pintar(
      tester,
      TarjetaArtista(nombre: 'Taylor Swift', genero: 'Pop', imagen: _foto),
    );

    expect(find.text('Taylor Swift'), findsOneWidget);
    expect(find.text('Pop'), findsOneWidget);
    expect(find.bySemanticsLabel('Foto de Taylor Swift'), findsOneWidget);
  });

  testWidgets('el botón alterna Seguir/Siguiendo y avisa a la app', (
    tester,
  ) async {
    final valores = <bool>[];

    await _pintar(
      tester,
      TarjetaArtista(
        nombre: 'Bad Bunny',
        genero: 'Reggaetón',
        imagen: _foto,
        alCambiarSeguimiento: valores.add,
      ),
    );

    // Valor por defecto: no seguido.
    expect(find.text('Seguir'), findsOneWidget);

    await tester.tap(find.text('Seguir'));
    await tester.pump();
    expect(find.text('Siguiendo'), findsOneWidget);

    await tester.tap(find.text('Siguiendo'));
    await tester.pump();
    expect(find.text('Seguir'), findsOneWidget);

    expect(valores, [true, false]);
  });

  testWidgets('respeta el estado inicial seguido: true', (tester) async {
    await _pintar(
      tester,
      TarjetaArtista(
        nombre: 'The Weeknd',
        genero: 'R&B',
        imagen: _foto,
        seguido: true,
      ),
    );

    expect(find.text('Siguiendo'), findsOneWidget);
  });

  testWidgets('llama a alPulsar al tocar la tarjeta', (tester) async {
    var pulsaciones = 0;

    await _pintar(
      tester,
      TarjetaArtista(
        nombre: 'Young Thug',
        genero: 'Rap',
        imagen: _foto,
        alPulsar: () => pulsaciones++,
      ),
    );

    await tester.tap(find.text('Young Thug'));
    expect(pulsaciones, 1);
  });
}
