// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:el_open_file/constants/constants.dart';
import 'package:el_open_file/constants/keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:el_open_file/main.dart';

void main() {
  group('the app should have predefined widgets', () {
    testWidgets('the app should have predefined title body text',
        (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(const MyApp());

      Text titleBodyTextWidget =
          find.byKey(Keys.titleBodyKey).evaluate().single.widget as Text;
      expect(titleBodyTextWidget.data, Constants.titleBodyTx);
    });
    testWidgets('the app should have predefined button and label',
        (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(const MyApp());

      final buttonDownloadOpenWidget =
          find.byKey(Keys.downloadAndOpenPDFButtonKey);
      expect(buttonDownloadOpenWidget, findsOneWidget);

      ElevatedButton button =
          buttonDownloadOpenWidget.evaluate().single.widget as ElevatedButton;
      Text buttonLabel = button.child as Text;
      expect(buttonLabel.data, Constants.downloadAndOpenPDFTx);
    });
  });

  testWidgets('user can pressed the button', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    final buttonDownloadOpenWidget =
        find.byKey(Keys.downloadAndOpenPDFButtonKey);
    ElevatedButton button =
        buttonDownloadOpenWidget.evaluate().single.widget as ElevatedButton;
    button.onPressed!();

    await tester.pumpAndSettle();
    expect(buttonDownloadOpenWidget, findsOneWidget);
  });
}
