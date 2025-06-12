// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:image_360_viewer/image_360_viewer.dart';

void main() {
  testWidgets('Image360Viewer widget test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Image360Viewer.asset(
            imageAssetList: [
              'assets/test/1.png',
              'assets/test/2.png',
              'assets/test/3.png',
            ],
            autoRotate: false,
            zoomEnabled: true,
          ),
        ),
      ),
    );

    // Verify that the widget is created
    expect(find.byType(Image360Viewer), findsOneWidget);
  });
}
