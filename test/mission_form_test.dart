import 'package:easymakers_tracker/models/client.dart';
import 'package:easymakers_tracker/models/easymaker.dart';
import 'package:easymakers_tracker/ui/forms/mission_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Check widgets', (WidgetTester tester) async {
    // GIVEN
    MissionFormPage form = MissionFormPage();

    // WHEN
    await tester.pumpWidget(MaterialApp(
      home: form,
    ));

    // THEN
    expect(find.byWidget(form), findsOneWidget);
    expect(find.widgetWithText(AppBar, 'New Mission'), findsOneWidget);
    expect(
        find.byWidgetPredicate((Widget widget) =>
            widget is DropdownButtonFormField<Easymaker> &&
            widget.decoration.labelText == 'Easymaker *'),
        findsOneWidget);
    expect(
        find.byWidgetPredicate((Widget widget) =>
            widget is DropdownButtonFormField<Client> &&
            widget.decoration.labelText == 'Client *'),
        findsOneWidget);
    expect(
        find.widgetWithIcon(FloatingActionButton, Icons.add), findsOneWidget);
  });
}
