import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khata_mitra/main.dart';

void main() {
  testWidgets('KhataMitraApp smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const ProviderScope(child: KhataMitraApp()));

    // Verify that the splash/main message is shown.
    expect(find.text('KhataMitra — Coming soon!'), findsOneWidget);
  });
}
