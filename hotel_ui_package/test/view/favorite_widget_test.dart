import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hotel_ui_package/view/favorite_widget.dart';

class MockHotelCardTheme {
  Color get favoriteIconSelectedColor => Colors.red;
  Color get favoriteIconDeselectedColor => Colors.white;
}

extension MockThemeExtension on BuildContext {
  MockHotelCardTheme get hotelCardTheme => MockHotelCardTheme();
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final theme = ThemeData(
    colorScheme: const ColorScheme.light(
      primary: Colors.orange,
      secondary: Colors.green,
      surface: Colors.blue,
    ),
  );
  group('FavoriteWidget', () {
    Widget buildTestWidget({
      required bool initialState,
      Function(bool)? onLikeChanged,
      double size = 24,
    }) {
      return MaterialApp(
        // Use a basic theme without Google Fonts
        theme: theme,
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

    testWidgets('animation controllers are properly initialized',
        (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: Scaffold(
            body: FavoriteWidget(
              initialState: false,
              onLikeChanged: (_) {},
            ),
          ),
        ),
      );

      // Get the state
      final State state = tester.state(find.byType(FavoriteWidget));
      expect(state, isA<FavoriteWidgetState>());

      final FavoriteWidgetState widgetState = state as FavoriteWidgetState;

      // Assert
      expect(widgetState.vibrationController.isDismissed, true);
      expect(widgetState.circleController.isDismissed, true);
    });

  
    testWidgets('animations do not run when tapping on already liked widget',
        (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: Scaffold(
            body: FavoriteWidget(
              initialState: true,
              onLikeChanged: (_) {},
            ),
          ),
        ),
      );

      // Get the state
      final FavoriteWidgetState widgetState =
          tester.state(find.byType(FavoriteWidget)) as FavoriteWidgetState;

      // Spy on controllers
      bool circleAnimationStarted = false;
      bool vibrationAnimationStarted = false;

      widgetState.circleController.addStatusListener((status) {
        if (status == AnimationStatus.forward) {
          circleAnimationStarted = true;
        }
      });

      widgetState.vibrationController.addStatusListener((status) {
        if (status == AnimationStatus.forward) {
          vibrationAnimationStarted = true;
        }
      });

      // Act
      await tester.tap(find.byType(InkWell));
      await tester.pump(
          const Duration(milliseconds: 600)); // Give enough time for animations

      // Assert
      expect(circleAnimationStarted, false);
      expect(vibrationAnimationStarted, false);
    });

    testWidgets('custom size is applied correctly',
        (WidgetTester tester) async {
      // Arrange
      const double customSize = 48.0;

      // Act
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: Scaffold(
            body: FavoriteWidget(
              initialState: true,
              onLikeChanged: (_) {},
              size: customSize,
            ),
          ),
        ),
      );

      // Assert
      final Icon icon = tester.widget<Icon>(find.byType(Icon));
      expect(icon.size, customSize);
    });

    testWidgets('does not throw when onLikeChanged is null',
        (WidgetTester tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: FavoriteWidget(
              initialState: true,
              onLikeChanged: null,
            ),
          ),
        ),
      );

      // Assert - should not throw when tapped
      await tester.tap(find.byType(InkWell));
      await tester.pump();
      // No assertion needed - test passes if no exception is thrown
    });
  });
}
