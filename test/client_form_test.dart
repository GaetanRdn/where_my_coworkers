import 'package:where_my_coworkers/models/client.dart';
import 'package:where_my_coworkers/ui/forms/client_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Check widgets for create', (WidgetTester tester) async {
    // GIVEN
    ClientFormPage form = ClientFormPage();

    // WHEN
    await tester.pumpWidget(MaterialApp(
      home: form,
    ));
    await tester.pump(const Duration());

    // THEN
    expect(find.byWidget(form), findsOneWidget);
    expect(find.widgetWithText(AppBar, 'New Client'), findsOneWidget);
    expect(
        find.byWidgetPredicate((Widget widget) =>
            widget is TextField &&
            widget.decoration?.labelText == 'Name *'),
        findsOneWidget);
    expect(
        find.byWidgetPredicate((Widget widget) =>
            widget is TextField && widget.decoration?.labelText == 'Latitude *'),
        findsOneWidget);
    expect(
        find.byWidgetPredicate((Widget widget) =>
        widget is TextField && widget.decoration?.labelText == 'Longitude *'),
        findsOneWidget);
    expect(
        find.widgetWithIcon(FloatingActionButton, Icons.add),
        findsOneWidget);
  });

  testWidgets('Check widgets for update', (WidgetTester tester) async {
    // GIVEN
    ClientFormPage form = ClientFormPage(client: Client('test', 1.11, 4.44, '123'));

    // WHEN
    await tester.pumpWidget(MaterialApp(
      home: form,
    ));
    await tester.pump(const Duration());

    // THEN
    expect(find.byWidget(form), findsOneWidget);
    expect(find.widgetWithText(AppBar, 'Update Client'), findsOneWidget);
    expect(
        find.byWidgetPredicate((Widget widget) =>
        widget is TextField &&
            widget.decoration?.labelText == 'Name *'),
        findsOneWidget);
    expect(
        find.byWidgetPredicate((Widget widget) =>
        widget is TextField && widget.decoration?.labelText == 'Latitude *'),
        findsOneWidget);
    expect(
        find.byWidgetPredicate((Widget widget) =>
        widget is TextField && widget.decoration?.labelText == 'Longitude *'),
        findsOneWidget);
    expect(
        find.widgetWithIcon(FloatingActionButton, Icons.save),
        findsOneWidget);
  });
}
