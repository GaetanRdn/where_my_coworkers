import 'package:where_my_coworkers/models/coworker.dart';
import 'package:where_my_coworkers/ui/cards/coworker_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Check widgets', (WidgetTester tester) async {
    // GIVEN
    CoWorkerCard card = CoWorkerCard(coWorker: CoWorker('Redin', 'Gaetan', '123'), onRemove: () => {},);

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
        find.widgetWithIcon(CircleAvatar, Icons.account_circle),
        findsOneWidget);
    expect(
        find.widgetWithIcon(IconButton, Icons.delete_forever),
        findsOneWidget);
  });
}
