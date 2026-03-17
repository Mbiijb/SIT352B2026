// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_application_1/views/login.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() {
  testWidgets('Login screen shows on startup', (WidgetTester tester) async {
    await tester.pumpWidget(GetMaterialApp(home: const LoginScreen()));

    expect(find.text('Login'), findsWidgets);
  });
}
