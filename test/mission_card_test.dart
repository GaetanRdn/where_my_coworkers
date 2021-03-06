import 'package:where_my_coworkers/models/client.dart';
import 'package:where_my_coworkers/models/coworker.dart';
import 'package:where_my_coworkers/models/mission.dart';
import 'package:where_my_coworkers/ui/cards/mission_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Check widgets', (WidgetTester tester) async {
    // GIVEN
    var mission = Mission('123', '456', '789');
    mission.coWorker = CoWorker('Redin', 'Gaetan', '123');
    mission.client = Client('R&Co', 1.234, 4.567, '345');
    MissionCard card = MissionCard(mission: mission, onRemove: () => {},);

    // WHEN
    await tester.pumpWidget(MaterialApp(
      home: card,
    ));
    await tester.pump(const Duration());

    // THEN
    expect(find.byWidget(card), findsOneWidget);
    expect(
        find.byWidgetPredicate((Widget widget) =>
        widget is Card),
        findsOneWidget);
    expect(
        find.byWidgetPredicate((Widget widget) =>
        widget is ListTile),
        findsOneWidget);
    expect(
        find.widgetWithText(ListTile, 'Gaetan Redin'),
        findsOneWidget);
    expect(
        find.widgetWithText(ListTile, 'R&Co'),
        findsOneWidget);
    expect(
        find.widgetWithIcon(CircleAvatar, Icons.military_tech),
        findsOneWidget);
    expect(
        find.widgetWithIcon(IconButton, Icons.delete_forever),
        findsOneWidget);
  });
}
