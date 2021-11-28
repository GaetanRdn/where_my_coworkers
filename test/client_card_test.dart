import 'package:easymakers_tracker/models/client.dart';
import 'package:easymakers_tracker/ui/cards/client_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Check widgets', (WidgetTester tester) async {
    // GIVEN
    ClientCard card = ClientCard(client: Client('CBP', 4.11111, 1.2345, '12345'));

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
        find.widgetWithText(ListTile, 'CBP'),
        findsOneWidget);
    expect(
        find.widgetWithIcon(CircleAvatar, Icons.business),
        findsOneWidget);
  });
}
