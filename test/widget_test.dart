import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cardon_ai/main.dart';

void main() {
  testWidgets('Cardon AI app test', (WidgetTester tester) async {
    await tester.pumpWidget(const CardonAIApp());

    // Verify the main title
    expect(find.text('CARDON-AI'), findsOneWidget);

    // Verify some navigation items
    expect(find.text('About'), findsOneWidget);
    expect(find.text('Team'), findsOneWidget);
    expect(find.text('Contact'), findsOneWidget);
  });
}
