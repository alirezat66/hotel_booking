import 'package:hotel_booking/features/hotels/data/models/hotel.dart';
import 'package:hotel_ui_package/hotel_ui_package.dart';

extension HotelExtension on Hotel {
  HotelData toHotelData() {
    return HotelData(
      score: ratingInfo.score,
      reviewCount: ratingInfo.reviewCount,
      scoreDescription: ratingInfo.scoreDescription,
      name: name,
      destination: destination,
      days: bestOffer.travelDate.days,
      nights: bestOffer.travelDate.nights,
      kids: bestOffer.roomsOverall.childrenCount,
      adults: bestOffer.roomsOverall.adultCount,
      overallName: bestOffer.roomsOverall.name,
      overallBoarding: bestOffer.roomsOverall.boarding,
      travelPrice: bestOffer.travelPrice,
      pricePerPerson: bestOffer.pricePerPerson,
      imageUrl: images.isNotEmpty ? images[0] : '',
    );
  }
}
