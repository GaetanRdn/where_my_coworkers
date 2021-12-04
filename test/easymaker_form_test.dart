import 'package:where_my_coworkers/ui/forms/coworker_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Check widgets', (WidgetTester tester) async {
    // GIVEN
    CoWorkerFormPage form = CoWorkerFormPage();

    // WHEN
    await tester.pumpWidget(MaterialApp(
      home: form,
    ));
    await tester.pump(const Duration());

    // THEN
    expect(find.byWidget(form), findsOneWidget);
    expect(find.widgetWithText(AppBar, 'New co-worker'), findsOneWidget);
    expect(
        find.byWidgetPredicate((Widget widget) =>
            widget is TextField &&
            widget.decoration?.labelText == 'First name *'),
        findsOneWidget);
    expect(
        find.byWidgetPredicate((Widget widget) =>
            widget is TextField && widget.decoration?.labelText == 'Last name *'),
        findsOneWidget);
    expect(
        find.widgetWithIcon(FloatingActionButton, Icons.add),
        findsOneWidget);
  });
}
