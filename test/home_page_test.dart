import 'package:easymakers_tracker/easymakers_page.dart';
import 'package:easymakers_tracker/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Check widgets', (WidgetTester tester) async {
    // WHEN
    await tester.pumpWidget(const MaterialApp(
      home: HomePage(),
    ));

    // THEN
    expect(find.widgetWithText(AppBar, 'Home'), findsOneWidget);
    expect(
        find.byWidgetPredicate((widget) => widget is PageView), findsOneWidget);
    expect(find.byWidgetPredicate((widget) => widget is EasymakersPage),
        findsOneWidget);

    expect(find.byWidgetPredicate((widget) => widget is BottomNavigationBar),
        findsOneWidget);
  });
}
