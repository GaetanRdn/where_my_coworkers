import 'package:where_my_coworkers/models/coworker.dart';
import 'package:where_my_coworkers/ui/forms/coworker_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Check widgets for create', (WidgetTester tester) async {
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

  testWidgets('Check widgets for update', (WidgetTester tester) async {
    // GIVEN
    CoWorkerFormPage form = CoWorkerFormPage(coWorker: CoWorker('Redin', 'Gaetan', '123'));

    // WHEN
    await tester.pumpWidget(MaterialApp(
      home: form,
    ));
    await tester.pump(const Duration());

    // THEN
    expect(find.byWidget(form), findsOneWidget);
    expect(find.widgetWithText(AppBar, 'Update co-worker'), findsOneWidget);
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
        find.widgetWithIcon(FloatingActionButton, Icons.save),
        findsOneWidget);
  });
}
