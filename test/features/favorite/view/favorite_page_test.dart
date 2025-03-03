import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hotel_booking/core/data/favorite_repository.dart';
import 'package:hotel_booking/features/favorite/cubit/favorite_cubit.dart';
import 'package:hotel_booking/features/favorite/data/hotel_favorite.dart';
import 'package:hotel_booking/features/favorite/view/favorite_list_view.dart';
import 'package:hotel_booking/features/favorite/view/favorite_page.dart';
import 'package:hotel_booking/features/favorite/view/widgets/favorite_empty_view.dart';
import 'package:hotel_ui_package/theme/theme.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'favorite_page_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<FavoriteCubit>(),
  MockSpec<FavoriteRepository>(),
])
void main() {
  // Define a simple SVG string for testing
  const mockSvgString = '''
    <svg width="100" height="100" xmlns="http://www.w3.org/2000/svg">
      <rect width="100" height="100" fill="red"/>
    </svg>
  ''';

  // Helper to wrap widget with providers and theme
  Widget buildTestableWidget(Widget child, FavoriteCubit mockFavoriteCubit) {
    return MaterialApp(
      theme: HotelBookingTheme.lightTheme,
      home: BlocProvider<FavoriteCubit>.value(
        value: mockFavoriteCubit,
        child: child,
      ),
    );
  }

  // Sample favorite data
  final testFavorite = HotelFavorite(
    name: 'Test Hotel',
    destination: 'Test City',
    hotelId: '123',
    ratingInfo: HotelRatingInfo(
      score: 4.5,
      reviewCount: 100,
      scoreDescription: 'Excellent',
    ),
    image: 'image1.jpg',
    createdAt: DateTime(2023, 1, 1),
  );

  testWidgets('FavoritePage shows FavoriteEmptyView when state is empty',
      (WidgetTester tester) async {
    final mockCubit = MockFavoriteCubit();
    // Arrange
    when(mockCubit.state).thenReturn([]);

    // Act
    await tester.pumpWidget(
      buildTestableWidget(
          FavoritePage(
            emptyImage: SvgPicture.string(mockSvgString),
          ),
          mockCubit),
    );
    await tester.pump(); // Ensure SVG renders

    // Assert
    expect(find.byType(FavoriteEmptyView), findsOneWidget);
    expect(find.byType(FavoriteListView), findsNothing);
    expect(find.byType(SvgPicture), findsOneWidget);
  });

  testWidgets('FavoritePage shows FavoriteListView when state has favorites',
      (WidgetTester tester) async {
    final mockFavoriteCubit = MockFavoriteCubit();

    // Arrange
    when(mockFavoriteCubit.state).thenReturn([testFavorite]);

    // Act
    await tester.pumpWidget(
      buildTestableWidget(
          FavoritePage(
            emptyImage: SvgPicture.string(mockSvgString),
          ),
          mockFavoriteCubit),
    );
    await tester.pump();
    mockFavoriteCubit.emit([testFavorite]); // This line is problematic

    // Assert
    expect(find.byType(FavoriteListView), findsOneWidget);
    expect(find.byType(FavoriteEmptyView), findsNothing);
  });
}
