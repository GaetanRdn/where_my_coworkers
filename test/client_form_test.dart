import 'package:easymakers_tracker/client_form.dart';
import 'package:easymakers_tracker/client_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Check widgets', (WidgetTester tester) async {
    // GIVEN
    ClientStorage storage = ClientStorage();

    ClientFormPage form = ClientFormPage(storage: storage);

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
            widget.decoration?.labelText == 'Name'),
        findsOneWidget);
    expect(
        find.byWidgetPredicate((Widget widget) =>
            widget is TextField && widget.decoration?.labelText == 'Street'),
        findsOneWidget);
    expect(
        find.byWidgetPredicate((Widget widget) =>
        widget is TextField && widget.decoration?.labelText == 'City'),
        findsOneWidget);
    expect(
        find.byWidgetPredicate((Widget widget) =>
        widget is TextField && widget.decoration?.labelText == 'Zip Code'),
        findsOneWidget);
    expect(
        find.byWidgetPredicate((Widget widget) =>
        widget is TextField && widget.decoration?.labelText == 'Country'),
        findsOneWidget);
    expect(
        find.widgetWithIcon(FloatingActionButton, Icons.add),
        findsOneWidget);
  });
}
