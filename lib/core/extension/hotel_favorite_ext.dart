import 'package:hotel_booking/features/favorite/data/hotel_favorite.dart';
import 'package:hotel_ui_package/models/hotel_data.dart';

extension HotelFavoriteExtension on HotelFavorite {
  HotelData toHotelData() {
    return HotelData(
      isLiked: true,
      score: ratingInfo.score,
      reviewCount: ratingInfo.reviewCount,
      scoreDescription: ratingInfo.scoreDescription,
      name: name,
      destination: destination,
      days: 0,
      nights: 0,
      kids: 0,
      adults: 0,
      overallName: '',
      overallBoarding: '',
      travelPrice: 0,
      pricePerPerson: 0,
      imageUrl: image,
    );
  }
}
