import 'package:easymakers_tracker/easymaker_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Check widgets', (WidgetTester tester) async {
    // GIVEN
    const form = EasymakerFormPage();

    // WHEN
    await tester.pumpWidget(const MaterialApp(
      home: form,
    ));
    await tester.pump(const Duration());

    // THEN
    expect(find.byWidget(form), findsOneWidget);
    expect(find.widgetWithText(AppBar, 'New Easymaker'), findsOneWidget);
    expect(
        find.byWidgetPredicate((Widget widget) =>
            widget is TextField &&
            widget.decoration?.labelText == 'First name'),
        findsOneWidget);
    expect(
        find.byWidgetPredicate((Widget widget) =>
            widget is TextField && widget.decoration?.labelText == 'Last name'),
        findsOneWidget);
    expect(
        find.byWidgetPredicate((Widget widget) =>
            widget is FloatingActionButton &&
            widget.isExtended &&
            widget.child != null &&
            widget.child is Icon &&
            (widget.child as Icon).icon == Icons.add),
        findsOneWidget);
  });
}
