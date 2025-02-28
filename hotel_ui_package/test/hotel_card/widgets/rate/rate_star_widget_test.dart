import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hotel_ui_package/hotel_ui_package.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('RateStarWidget', () {
    testWidgets('displays correct number of stars for a given score',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: RateStarWidget(score: 3.5),
          ),
        ),
      );

      expect(find.byIcon(Icons.star), findsNWidgets(3));
      expect(find.byIcon(Icons.star_half), findsOneWidget);
      expect(find.byIcon(Icons.star_border), findsNWidgets(1));
    });

    testWidgets('displays correct number of stars for a perfect score',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: RateStarWidget(score: 5.0),
          ),
        ),
      );

      expect(find.byIcon(Icons.star), findsNWidgets(5));
      expect(find.byIcon(Icons.star_half), findsNothing);
      expect(find.byIcon(Icons.star_border), findsNothing);
    });

    testWidgets('displays correct number of stars for a zero score',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: RateStarWidget(score: 0.0),
          ),
        ),
      );

      expect(find.byIcon(Icons.star), findsNothing);
      expect(find.byIcon(Icons.star_half), findsNothing);
      expect(find.byIcon(Icons.star_border), findsNWidgets(5));
    });

    testWidgets('uses custom star color if provided',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: RateStarWidget(score: 4.0, starColor: Colors.red),
          ),
        ),
      );

      final stars = tester.widgetList<Icon>(find.byIcon(Icons.star));
      for (var star in stars) {
        expect(star.color, Colors.red);
      }
    });

    testWidgets('uses default star color if not provided',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: HotelBookingTheme.lightTheme,
          home: const Scaffold(
            body: RateStarWidget(score: 4.0),
          ),
        ),
      );

      final stars = tester.widgetList<Icon>(find.byIcon(Icons.star));
      for (var star in stars) {
        expect(star.color, Colors.black); // Assuming default color is black
      }
    });

    testWidgets('displays InfoWidget when onMoreInfoTab is provided',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: RateStarWidget(score: 4.0, onMoreInfoTab: null),
          ),
        ),
      );

      expect(find.byIcon(Icons.help_outline), findsNothing);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: RateStarWidget(score: 4.0, onMoreInfoTab: () {}),
          ),
        ),
      );

      expect(find.byIcon(Icons.help_outline), findsOneWidget);
    });

    testWidgets('throws assertion error for invalid score',
        (WidgetTester tester) async {
      expect(
        () async {
          await tester.pumpWidget(
             MaterialApp(
              home: Scaffold(
                body: RateStarWidget(score: -1.0),
              ),
            ),
          );
        },
        throwsAssertionError,
      );

      expect(
        () async {
          await tester.pumpWidget(
             MaterialApp(
              home: Scaffold(
                body: RateStarWidget(score: 6.0),
              ),
            ),
          );
        },
        throwsAssertionError,
      );
    });
  });
}
