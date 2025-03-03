import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hotel_booking/features/favorite/presentation/cubit/favorite_cubit.dart';
import 'package:hotel_booking/features/favorite/data/model/hotel_favorite.dart';
import 'package:hotel_booking/features/hotels/presentation/cubit/hotel_cubit.dart';
import 'package:hotel_booking/features/hotels/data/models/hotel_model.dart';
import 'package:hotel_booking/features/hotels/presentation/view/hotel_page.dart';
import 'package:hotel_booking/features/hotels/presentation/view/widgets/hotel_failure_widget.dart';
import 'package:hotel_booking/features/hotels/presentation/view/widgets/hotel_loading_widget.dart';
import 'package:hotel_booking/features/hotels/presentation/view/widgets/hotel_success_widget.dart';
import 'package:hotel_ui_package/hotel_ui_package.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../favorite/presentation/view/favorite_page_test.mocks.dart';
import 'hotel_page_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<HotelCubit>(),
])
void main() {
  late MockHotelCubit mockHotelCubit;
  late MockFavoriteCubit mockFavoriteCubit;
  late List<HotelModel> testHotels;

  setUp(() {
    mockHotelCubit = MockHotelCubit();
    mockFavoriteCubit = MockFavoriteCubit();
    _setupMockitoDummies();

    // Create test hotel data
    testHotels = [
      HotelModel(
        name: 'Hotel A',
        destination: 'City A',
        hotelId: '1',
        ratingInfo: HotelRatingInfo(
          score: 4.0,
          reviewCount: 50,
          scoreDescription: 'Good',
        ),
        bestOffer: HotelBestOffer(
          isFlightIncluded: false,
          travelPrice: 100.0,
          pricePerPerson: 50.0,
          hasMoreOneOffer: false,
          travelDate: TravelDate(
            days: 2,
            nights: 1,
            departureDate: '2025-03-10',
            returnDate: '2025-03-11',
          ),
          roomsOverall: RoomsOverall(
            name: 'Basic Room',
            boarding: 'None',
            childrenCount: 0,
            adultCount: 1,
          ),
        ),
        images: ['image_a.jpg'],
      ),
    ];

    // Setup default mocks
    when(mockFavoriteCubit.state).thenReturn(const []);
  });

  Widget buildTestableWidget(Widget child) {
    return MaterialApp(
      theme: HotelBookingTheme.lightTheme,
      home: MultiBlocProvider(
        providers: [
          BlocProvider<HotelCubit>.value(
            value: mockHotelCubit,
          ),
          BlocProvider<FavoriteCubit>.value(
            value: mockFavoriteCubit,
          ),
        ],
        child: child,
      ),
    );
  }

  testWidgets('HotelPage shows HotelLoadingWidget when state is HotelLoading',
      (WidgetTester tester) async {
    // Arrange - Set up the mock to return a loading state
    final loadingState = HotelLoading();
    when(mockHotelCubit.state).thenReturn(loadingState);

    // Act - Build our widget
    await tester.pumpWidget(buildTestableWidget(const HotelPage()));

    // Assert - Verify the correct widget is shown
    expect(find.byType(HotelLoadingWidget), findsOneWidget);
    expect(find.byType(HotelSuccessWidget), findsNothing);
    expect(find.byType(HotelFailureWidget), findsNothing);
  });

  testWidgets('HotelPage shows HotelSuccessWidget when state is HotelSuccess',
      (WidgetTester tester) async {
    // Arrange - Set up the mock to return a success state
    final successState = HotelSuccess(testHotels, testHotels.length);
    when(mockHotelCubit.state).thenReturn(successState);

    // Act - Build our widget
    await tester.pumpWidget(buildTestableWidget(const HotelPage()));

    // Give it a frame to process
    await tester.pump();

    // Assert - Verify the correct widget is shown
    expect(find.byType(HotelSuccessWidget), findsOneWidget);
    expect(find.byType(HotelLoadingWidget), findsNothing);
    expect(find.byType(HotelFailureWidget), findsNothing);

    // Verify hotel data is displayed
    expect(find.text('Hotel A'), findsOneWidget);
  });

  testWidgets('HotelPage shows HotelFailureWidget when state is HotelFailure',
      (WidgetTester tester) async {
    // Arrange - Set up the mock to return a failure state
    const errorMessage = 'Failed to load hotels';
    final failureState = HotelFailure(errorMessage);
    when(mockHotelCubit.state).thenReturn(failureState);

    // Act - Build our widget
    await tester.pumpWidget(buildTestableWidget(const HotelPage()));

    // Give it a frame to process
    await tester.pump();

    // Assert - Verify the correct widget is shown
    expect(find.byType(HotelFailureWidget), findsOneWidget);
    expect(find.byType(HotelLoadingWidget), findsNothing);
    expect(find.byType(HotelSuccessWidget), findsNothing);

    // Verify error message is displayed
    expect(find.text(errorMessage), findsOneWidget);
  });
}

void _setupMockitoDummies() {
  // Provide dummy for the abstract HotelState class
  provideDummy<HotelState>(HotelLoading());

  // Provide dummies for concrete state classes
  final dummyHotels = <HotelModel>[];
  provideDummy<HotelSuccess>(HotelSuccess(dummyHotels, 0));
  provideDummy<HotelFailure>(HotelFailure('dummy error'));
}
