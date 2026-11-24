import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tarjeta_cancion/tarjeta_cancion.dart';

Widget _envolver(Widget hijo) =>
    MaterialApp(home: Scaffold(body: Center(child: hijo)));

void main() {
  testWidgets('muestra título, artistas unidos y duración formateada',
      (tester) async {
    await tester.pumpWidget(_envolver(const TarjetaCancion(
      titulo: 'Noches de Neón',
      artistas: ['Luna Ferrer', 'Kairo'],
      duracion: Duration(minutes: 3, seconds: 24),
    )));

    expect(find.text('Noches de Neón'), findsOneWidget);
    expect(find.text('Luna Ferrer, Kairo'), findsOneWidget);
    expect(find.text('3:24'), findsOneWidget);
  });

  testWidgets('al pulsar el botón de play se lanza onPlay', (tester) async {
    var pulsaciones = 0;
    await tester.pumpWidget(_envolver(TarjetaCancion(
      titulo: 'Marea Alta',
      artistas: const ['Los Faros'],
      duracion: const Duration(minutes: 4, seconds: 5),
      onPlay: () => pulsaciones++,
    )));

    await tester.tap(find.byKey(const Key('tarjetaCancion_botonPlay')));
    await tester.pump();

    expect(pulsaciones, 1);
  });

  testWidgets('mostrarPlay es true por defecto y false oculta el botón',
      (tester) async {
    await tester.pumpWidget(_envolver(const TarjetaCancion(
      titulo: 'Seda',
      artistas: ['Mara Sol'],
      duracion: Duration(minutes: 2, seconds: 58),
    )));
    expect(find.byKey(const Key('tarjetaCancion_botonPlay')), findsOneWidget);

    await tester.pumpWidget(_envolver(const TarjetaCancion(
      titulo: 'Seda',
      artistas: ['Mara Sol'],
      duracion: Duration(minutes: 2, seconds: 58),
      mostrarPlay: false,
    )));
    expect(find.byKey(const Key('tarjetaCancion_botonPlay')), findsNothing);
  });

  test('formatearDuracion rellena segundos y soporta horas', () {
    expect(TarjetaCancion.formatearDuracion(const Duration(seconds: 65)), '1:05');
    expect(TarjetaCancion.formatearDuracion(Duration.zero), '0:00');
    expect(
      TarjetaCancion.formatearDuracion(
          const Duration(hours: 1, minutes: 2, seconds: 3)),
      '1:02:03',
    );
  });

  test('unirArtistas ignora vacíos y tiene texto por defecto', () {
    expect(TarjetaCancion.unirArtistas(['Kairo', ' ', 'Luna Ferrer']),
        'Kairo, Luna Ferrer');
    expect(TarjetaCancion.unirArtistas([]), 'Artista desconocido');
  });
}
