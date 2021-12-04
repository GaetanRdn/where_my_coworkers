import 'package:where_my_coworkers/ui/pages/coworkers_page.dart';
import 'package:where_my_coworkers/ui/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Check widgets', (WidgetTester tester) async {
    // WHEN
    await tester.pumpWidget(const MaterialApp(
      home: HomePage(),
    ));

    // THEN
    expect(find.widgetWithText(AppBar, 'Where my Co-workers'), findsOneWidget);
    expect(
        find.byWidgetPredicate((widget) => widget is PageView), findsOneWidget);
    expect(find.byWidgetPredicate((widget) => widget is CoWorkersPage),
        findsOneWidget);

    expect(find.byWidgetPredicate((widget) => widget is BottomNavigationBar),
        findsOneWidget);
  });
}
