// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:broker/main.dart';
import 'package:broker/presentation/screen/broker.dart';

void main() {
  group('MyApp Widget Tests', () {
    testWidgets('MyApp should render without errors', (
      WidgetTester tester,
    ) async {
      // Build our app and trigger a frame
      await tester.pumpWidget(const MyApp());

      // Verify that the app renders without errors
      expect(find.byType(GetMaterialApp), findsOneWidget);
      expect(find.byType(BrokerSelectionScreen), findsOneWidget);
    });

    testWidgets('MyApp should not show debug banner', (
      WidgetTester tester,
    ) async {
      // Build our app and trigger a frame
      await tester.pumpWidget(const MyApp());

      // Get the GetMaterialApp widget
      final GetMaterialApp materialApp = tester.widget(
        find.byType(GetMaterialApp),
      );

      // Verify debug banner is disabled
      expect(materialApp.debugShowCheckedModeBanner, false);
    });
  });

  group('BrokerSelectionScreen Tests', () {
    testWidgets('BrokerSelectionScreen should render', (
      WidgetTester tester,
    ) async {
      // Build just the BrokerSelectionScreen widget
      await tester.pumpWidget(GetMaterialApp(home: BrokerSelectionScreen()));

      // Verify that the BrokerSelectionScreen is present
      expect(find.byType(BrokerSelectionScreen), findsOneWidget);
    });
  });
}
