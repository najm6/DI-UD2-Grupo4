import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:promo_desplegable/promo_desplegable.dart';

void main() {
  // Monta el componente dentro de una app mínima.
  Widget montar(PromoDesplegable promo) {
    return MaterialApp(home: Scaffold(body: promo));
  }

  testWidgets('empieza cerrado y al pulsar se abre y avisa con true', (tester) async {
    bool? estado;

    await tester.pumpWidget(montar(PromoDesplegable(
      titulo: 'Lanzamiento destacado',
      subtitulo: 'Nuevo single',
      contenido: const Text('Fuego Lento'),
      onExpandidoCambiado: (valor) => estado = valor,
    )));

    // Cerrado por defecto: el contenido no se ve.
    expect(find.text('Fuego Lento'), findsNothing);

    await tester.tap(find.text('Lanzamiento destacado'));
    await tester.pumpAndSettle();

    expect(find.text('Fuego Lento'), findsOneWidget);
    expect(estado, isTrue);

    // Al pulsar otra vez se cierra y avisa con false.
    await tester.tap(find.text('Lanzamiento destacado'));
    await tester.pumpAndSettle();

    expect(find.text('Fuego Lento'), findsNothing);
    expect(estado, isFalse);
  });

  testWidgets('el botón de acción llama a onAccion', (tester) async {
    var pulsado = 0;

    await tester.pumpWidget(montar(PromoDesplegable(
      titulo: 'Lanzamiento destacado',
      subtitulo: 'Nuevo single',
      expandido: true,
      onAccion: () => pulsado++,
    )));

    // Texto del botón por defecto.
    await tester.tap(find.text('Escuchar ahora'));
    expect(pulsado, 1);
  });

  testWidgets('sin onAccion ni onDescartar no se muestran botones', (tester) async {
    await tester.pumpWidget(montar(const PromoDesplegable(
      titulo: 'Top de la semana',
      subtitulo: 'Los 10 más escuchados',
      expandido: true,
    )));

    expect(find.byType(FilledButton), findsNothing);
    expect(find.text('Descartar'), findsNothing);
  });
}
