import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:valoracion_estrellas/valoracion_estrellas.dart';

void main() {
  testWidgets('muestra cinco estrellas por defecto', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(body: ValoracionEstrellas()),
      ),
    );

    expect(find.byIcon(Icons.star_border), findsNWidgets(5));
    expect(find.byIcon(Icons.star), findsNothing);
  });

  testWidgets('notifica el valor de la estrella pulsada', (tester) async {
    int? nuevaValoracion;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ValoracionEstrellas(
            onValoracionCambiada: (valor) => nuevaValoracion = valor,
          ),
        ),
      ),
    );

    await tester.tap(find.byIcon(Icons.star_border).at(2));
    expect(nuevaValoracion, 3);
  });

  testWidgets('no permite interacción en modo solo lectura', (tester) async {
    int? nuevaValoracion;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ValoracionEstrellas(
            valor: 2,
            soloLectura: true,
            onValoracionCambiada: (valor) => nuevaValoracion = valor,
          ),
        ),
      ),
    );

    await tester.tap(find.byIcon(Icons.star).first);
    expect(nuevaValoracion, isNull);
    expect(find.byIcon(Icons.star), findsNWidgets(2));
  });
}
