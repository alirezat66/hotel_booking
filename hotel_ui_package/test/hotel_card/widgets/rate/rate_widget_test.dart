import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gap/gap.dart';
import 'package:hotel_ui_package/extensions/score_ext.dart';
import 'package:hotel_ui_package/hotel_card/widgets/rate/rate_widget.dart';
import 'package:hotel_ui_package/hotel_card/widgets/rate/rating_badge.dart';
import 'package:hotel_ui_package/hotel_card/widgets/rate/rating_description.dart';
import 'package:hotel_ui_package/models/satisfaction/satisfaction_level.dart';
import 'package:hotel_ui_package/theme/rating_badge_theme.dart';
import 'package:hotel_ui_package/theme/theme.dart';

// Mock extensions used in the widgets
extension ThemeExtensions on BuildContext {
  RatingBadgeTheme get ratingBadgeTheme => const RatingBadgeTheme(
        verySatisfiedColor: Colors.blue,
        satisfiedColor: Colors.green,
        neutralColor: Colors.yellow,
        dissatisfiedColor: Colors.orange,
        veryDissatisfiedColor: Colors.red,
      );

  Color get onSurface => Colors.white;

  TextStyle get titleMedium => const TextStyle(fontSize: 14);

  TextStyle get bodySmall => const TextStyle(fontSize: 12);
}

void main() {
  // Ensure SatisfactionLevel is initialized
  setUpAll(() {
    // Ensure levels are initialized before testing
    SatisfactionLevel.fromScore(2.5);
  });

  testWidgets('RateWidget renders with correct score and review count',
      (WidgetTester tester) async {
    // Define test data
    const double testScore = 4.5;
    const int testReviewCount = 123;

    // Build the widget tree
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: Center(
            child: RateWidget(
              score: testScore,
              reviewCount: testReviewCount,
            ),
          ),
        ),
      ),
    );

    // Verify the RateWidget structure
    expect(find.byType(RateWidget), findsOneWidget);
    expect(find.byType(RatingBadge), findsOneWidget);
    expect(find.byType(Gap), findsOneWidget);
    expect(find.byType(RatingDescription), findsOneWidget);

    // Verify RatingBadge
    final ratingBadge = tester.widget<RatingBadge>(find.byType(RatingBadge));
    expect(ratingBadge.score, testScore);

    // Verify the score display in the RatingBadge
    expect(find.text('${testScore.toStringAsFixed(1)} / 5.0'), findsOneWidget);

    // Verify the face icon is present
    expect(find.byType(Icon), findsOneWidget);

    // Verify RatingDescription
    final ratingDescription =
        tester.widget<RatingDescription>(find.byType(RatingDescription));
    expect(ratingDescription.reviewCount, testReviewCount);
    expect(ratingDescription.scoreText, testScore.scoreText);

    // Verify the formatted text in RatingDescription
    expect(find.text('${testScore.scoreText} ($testReviewCount Bew)'),
        findsOneWidget);
  });

  testWidgets('RatingBadge shows correct color based on score',
      (WidgetTester tester) async {
    // Test various scores to verify color changes
    for (final scoreData in [
      {'score': 4.5, 'expectedColor': Colors.green}, // Very Satisfied
      {'score': 3.5, 'expectedColor': const Color(0xFF85BC39)}, // Satisfied
      {'score': 2.5, 'expectedColor': Colors.yellow}, // Neutral
      {'score': 1.5, 'expectedColor': Colors.orange}, // Dissatisfied
      {'score': 0.5, 'expectedColor': Colors.red}, // Very Dissatisfied
    ]) {
      final score = scoreData['score'] as double;
      final expectedColor = scoreData['expectedColor'] as Color;

      // Build the widget with the test score
      await tester.pumpWidget(
        MaterialApp(
          theme: HotelBookingTheme.lightTheme,
          home: Scaffold(
            body: Center(
              child: RatingBadge(score: score),
            ),
          ),
        ),
      );

      // Find the Container and verify its color
      final container = tester.widget<Container>(find.byType(Container));
      final decoration = container.decoration as BoxDecoration;
      expect(decoration.color, expectedColor);

      // Verify the correct score text is displayed
      expect(find.text('${score.toStringAsFixed(1)} / 5.0'), findsOneWidget);
    }
  });

  testWidgets('RatingDescription displays correct text format',
      (WidgetTester tester) async {
    const String testScoreText = 'Sehr gut';
    const int testReviewCount = 456;

    await tester.pumpWidget(
      MaterialApp(
        theme: HotelBookingTheme.lightTheme,
        home: const Scaffold(
          body: Center(
            child: RatingDescription(
              scoreText: testScoreText,
              reviewCount: testReviewCount,
            ),
          ),
        ),
      ),
    );

    // Verify the text is formatted correctly
    expect(find.text('$testScoreText ($testReviewCount Bew)'), findsOneWidget);

    // Verify the Text widget has the expected style properties
    final textWidget = tester.widget<Text>(find.byType(Text));
    final style = textWidget.style as TextStyle;
    expect(style.fontWeight, FontWeight.w700);
    expect(style.color, Colors.white); // From the mock extension
  });

  testWidgets('RateWidget handles edge case with 0.0 score',
      (WidgetTester tester) async {
    const double testScore = 0.0;
    const int testReviewCount = 10;

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: Center(
            child: RateWidget(
              score: testScore,
              reviewCount: testReviewCount,
            ),
          ),
        ),
      ),
    );

    // Verify the score displays correctly as 0.0
    expect(find.text('${testScore.toStringAsFixed(1)} / 5.0'), findsOneWidget);

    // Verify the right satisfaction level text is used (should be "Mangelhaft" or similar)
    expect(find.textContaining(testScore.scoreText), findsOneWidget);
  });
}
