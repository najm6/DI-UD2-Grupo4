import 'package:app_final/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('la pantalla integra los componentes y reacciona a sus eventos', (
    tester,
  ) async {
    // Ventana de 600 x 1400 puntos para que quepa toda la pantalla.
    tester.view.physicalSize = const Size(1200, 2800);
    tester.view.devicePixelRatio = 2;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(const AppSonora());

    // PromoDesplegable
    expect(find.text('Lanzamiento destacado'), findsOneWidget);
    // TarjetaCancion
    expect(find.text('Canciones populares'), findsOneWidget);
    // TarjetaArtista: seguir a un artista actualiza el contador
    expect(find.text('Sigues a 1 artista'), findsOneWidget);
    await tester.tap(find.text('Seguir').first);
    await tester.pump();
    expect(find.text('Sigues a 2 artistas'), findsOneWidget);

    // ValoracionEstrellas: pulsar la cuarta estrella guarda la valoración
    await tester.scrollUntilVisible(
      find.text('Sin valorar'),
      200,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.tap(find.byIcon(Icons.star_border).at(3));
    await tester.pump();
    expect(find.text('Tu valoración: 4/5'), findsOneWidget);
  });
}
