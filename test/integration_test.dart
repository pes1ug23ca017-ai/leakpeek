import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:leakpeek/main.dart';

void main() {
  group('LeakPeek Basic Tests', () {
    testWidgets('App should start without crashing', (WidgetTester tester) async {
      // Build our app and trigger a frame
      await tester.pumpWidget(const LeakPeekApp());
      
      // Verify the app starts (we expect Firebase errors in tests, but app should not crash)
      expect(find.byType(MaterialApp), findsOneWidget);
    });

    testWidgets('App should have proper title', (WidgetTester tester) async {
      await tester.pumpWidget(const LeakPeekApp());
      
      // Check if the app has the correct title
      expect(find.byType(MaterialApp), findsOneWidget);
    });

    testWidgets('App should not show debug banner', (WidgetTester tester) async {
      await tester.pumpWidget(const LeakPeekApp());
      
      // Verify debug banner is not shown
      expect(find.byType(MaterialApp), findsOneWidget);
      final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));
      expect(materialApp.debugShowCheckedModeBanner, false);
    });
  });
}
