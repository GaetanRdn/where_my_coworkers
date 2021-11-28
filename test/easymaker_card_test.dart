import 'package:easymakers_tracker/models/easymaker.dart';
import 'package:easymakers_tracker/ui/cards/easymaker_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Check widgets', (WidgetTester tester) async {
    // GIVEN
    EasymakerCard card = EasymakerCard(easymaker: Easymaker('Redin', 'Gaetan', '123'), onRemove: () => {},);

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
