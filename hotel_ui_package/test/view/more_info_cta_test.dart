import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hotel_ui_package/view/more_info_cta.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('InfoWidget', () {
    testWidgets('displays help icon with default size',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: MoreInfoCta(),
          ),
        ),
      );

      final icon = tester.widget<Icon>(find.byType(Icon));
      expect(icon.icon, Icons.help_outline);
      expect(icon.size, isNull); // Default size
    });

    testWidgets('displays help icon with custom size',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: MoreInfoCta(size: 30.0),
          ),
        ),
      );

      final icon = tester.widget<Icon>(find.byType(Icon));
      expect(icon.icon, Icons.help_outline);
      expect(icon.size, 30.0);
    });

    testWidgets('calls onTap callback when pressed',
        (WidgetTester tester) async {
      bool tapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MoreInfoCta(
              onTap: () {
                tapped = true;
              },
            ),
          ),
        ),
      );

      await tester.tap(find.byType(InkWell));
      await tester.pump();

      expect(tapped, isTrue);
    });
  });
}
