import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:hotel_ui_package/view/app_image_view.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'app_image_view_test.mocks.dart';

// Create a mock implementation

@GenerateMocks([CachedNetworkImageProvider])
late MockCachedNetworkImageProvider mockImageProvider;
void main() {
  setUp(() {
    // Set up a fake implementation to avoid actual network requests
    mockImageProvider = MockCachedNetworkImageProvider();
    // Configure the mock to throw an error when loading
    when(mockImageProvider.loadImage(any, any))
        .thenThrow(Exception('Image loading failed'));
  });

  testWidgets('AppImageView displays image with border radius',
      (WidgetTester tester) async {
    const testUrl = 'https://example.com/image.jpg';
    const testBorderRadius = 8.0;

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: AppImageView(
            url: testUrl,
            boarderRadius: BorderRadius.all(Radius.circular(testBorderRadius)),
          ),
        ),
      ),
    );

    final clipRRectFinder = find.byType(ClipRRect);
    expect(clipRRectFinder, findsOneWidget);

    final clipRRectWidget = tester.widget<ClipRRect>(clipRRectFinder);
    expect(
        clipRRectWidget.borderRadius, BorderRadius.circular(testBorderRadius));

    final cachedNetworkImageFinder = find.byType(CachedNetworkImage);
    expect(cachedNetworkImageFinder, findsOneWidget);
  });

  testWidgets('AppImageView displays placeholder widget',
      (WidgetTester tester) async {
    const testUrl = 'https://example.com/image.jpg';

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: AppImageView(
            url: testUrl,
            loadingWidget: CircularProgressIndicator(),
          ),
        ),
      ),
    );

    final loadingWidgetFinder = find.byType(CircularProgressIndicator);
    expect(loadingWidgetFinder, findsOneWidget);
  });
}
