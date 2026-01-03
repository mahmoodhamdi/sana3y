import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:sana3y/main.dart';

void main() {
  testWidgets('App loads successfully', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: Sana3yApp(),
      ),
    );

    // Verify the app builds without errors
    expect(find.byType(Sana3yApp), findsOneWidget);
  });
}
