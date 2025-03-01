import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hotel_ui_package/view/favorite_widget.dart';

class MockHotelCardTheme {
  Color get favoriteIconSelectedColor => Colors.red;
  Color get favoriteIconDeselectedColor => Colors.white;
}

extension MockThemeExtension on BuildContext {
  MockHotelCardTheme get hotelCartTheme => MockHotelCardTheme();
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('FavoriteWidget', () {
    Widget buildTestWidget({
      required bool initialState,
      Function(bool)? onLikeChanged,
      double size = 24,
    }) {
      return MaterialApp(
        // Use a basic theme without Google Fonts
        theme: ThemeData(
          colorScheme: const ColorScheme.light(
            primary: Colors.orange,
            secondary: Colors.green,
            surface: Colors.blue,
          ),
        ),
        home: Scaffold(
          body: Center(
            child: FavoriteWidget(
              initialState: initialState,
              onLikeChanged: onLikeChanged,
              size: size,
            ),
          ),
        ),
      );
    }

    testWidgets('initializes with correct icon when liked',
        (WidgetTester tester) async {
      await tester.pumpWidget(buildTestWidget(
        initialState: true,
        onLikeChanged: (_) {},
      ));

      // Short delay for initial rendering
      await tester.pump(const Duration(milliseconds: 50));

      expect(find.byIcon(Icons.favorite), findsOneWidget);
      expect(find.byIcon(Icons.favorite_border), findsNothing);
    });

    testWidgets('initializes with correct icon when not liked',
        (WidgetTester tester) async {
      await tester.pumpWidget(buildTestWidget(
        initialState: false,
        onLikeChanged: (_) {},
      ));

      await tester.pump(const Duration(milliseconds: 50));

      expect(find.byIcon(Icons.favorite_border), findsOneWidget);
      expect(find.byIcon(Icons.favorite), findsNothing);
    });

    testWidgets('calls onLikeChanged with inverted state when tapped',
        (WidgetTester tester) async {
      bool? newState;

      await tester.pumpWidget(buildTestWidget(
        initialState: false,
        onLikeChanged: (value) {
          newState = value;
        },
      ));

      await tester.pump(const Duration(milliseconds: 50));

      await tester.tap(find.byType(InkWell));
      await tester.pump(const Duration(milliseconds: 50));

      expect(newState, true);
    });

    testWidgets('applies custom size correctly', (WidgetTester tester) async {
      const double customSize = 48.0;

      await tester.pumpWidget(buildTestWidget(
        initialState: true,
        onLikeChanged: (_) {},
        size: customSize,
      ));

      await tester.pump(const Duration(milliseconds: 50));

      final iconFinder = find.byType(Icon);
      expect(iconFinder, findsOneWidget);

      final Icon icon = tester.widget<Icon>(iconFinder);
      expect(icon.size, customSize);
    });
  });
}
