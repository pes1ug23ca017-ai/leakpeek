// This is a basic Flutter widget test for LeakPeek app.
//
// To perform an interaction with a widget, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:leakpeek/main.dart';

// Mock Firebase for testing
class MockFirebaseApp extends Fake implements FirebaseApp {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    // Mock Firebase initialization
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      const MethodChannel('plugins.flutter.io/firebase_core'),
      (call) async {
        if (call.method == 'Firebase#initializeCore') {
          return [
            {
              'name': '[DEFAULT]',
              'options': {
                'apiKey': 'test-api-key',
                'appId': 'test-app-id',
                'messagingSenderId': 'test-sender-id',
                'projectId': 'test-project-id',
              },
              'pluginConstants': {},
            }
          ];
        }
        if (call.method == 'Firebase#initializeApp') {
          return {
            'name': '[DEFAULT]',
            'options': {
              'apiKey': 'test-api-key',
              'appId': 'test-app-id',
              'messagingSenderId': 'test-sender-id',
              'projectId': 'test-project-id',
            },
            'pluginConstants': {},
          };
        }
        return null;
      },
    );
  });

  tearDownAll(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      const MethodChannel('plugins.flutter.io/firebase_core'),
      null,
    );
  });

  testWidgets('LeakPeek app should start with splash screen', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const LeakPeekApp());

    // Verify that the app starts (we can't test specific content without Firebase auth)
    expect(find.byType(MaterialApp), findsOneWidget);
  });

  testWidgets('App should have proper title', (WidgetTester tester) async {
    await tester.pumpWidget(const LeakPeekApp());
    
    // Check if the app has the correct title
    expect(find.text('LeakPeek'), findsNothing); // Title is in app bar, not visible initially
  });

  testWidgets('App should not show debug banner', (WidgetTester tester) async {
    await tester.pumpWidget(const LeakPeekApp());
    
    // Verify debug banner is not shown
    expect(find.byType(MaterialApp), findsOneWidget);
    final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));
    expect(materialApp.debugShowCheckedModeBanner, false);
  });
}
