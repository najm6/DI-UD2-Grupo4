import 'package:app_demo/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('seguir a un artista actualiza el contador', (tester) async {
    await tester.pumpWidget(const AppDemo());

    expect(find.text('Sigues a 1 artista'), findsOneWidget);

    // La primera tarjeta sin seguir es la de Kairo.
    await tester.tap(find.text('Seguir').first);
    await tester.pump();

    expect(find.text('Sigues a 2 artistas'), findsOneWidget);
    expect(find.text('Ahora sigues a Kairo'), findsOneWidget);
  });
}
