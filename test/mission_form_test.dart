import 'package:where_my_coworkers/models/client.dart';
import 'package:where_my_coworkers/models/coworker.dart';
import 'package:where_my_coworkers/ui/forms/mission_form.dart';
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
            widget is DropdownButtonFormField<CoWorker> &&
            widget.decoration.labelText == 'Co-worker *'),
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
