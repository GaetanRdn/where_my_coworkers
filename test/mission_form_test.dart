import 'package:easymakers_tracker/client.dart';
import 'package:easymakers_tracker/client_storage.dart';
import 'package:easymakers_tracker/easymaker.dart';
import 'package:easymakers_tracker/easymaker_storage.dart';
import 'package:easymakers_tracker/mission_form.dart';
import 'package:easymakers_tracker/mission_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Check widgets', (WidgetTester tester) async {
    // GIVEN
    EasymakerStorage easymakerStorage = EasymakerStorage();
    ClientStorage clientStorage = ClientStorage();
    MissionStorage missionStorage = MissionStorage();

    MissionFormPage form = MissionFormPage(
      easymakerStorage: easymakerStorage,
      clientStorage: clientStorage,
      missionStorage: missionStorage,
    );

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
            widget.decoration.labelText == 'Easymaker'),
        findsOneWidget);
    expect(
        find.byWidgetPredicate((Widget widget) =>
            widget is DropdownButtonFormField<Client> &&
            widget.decoration.labelText == 'Client'),
        findsOneWidget);
    expect(
        find.widgetWithIcon(FloatingActionButton, Icons.add), findsOneWidget);
  });
}
