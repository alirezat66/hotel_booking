import 'package:easy_localization/easy_localization.dart';
import 'package:hotel_booking/features/hotels/data/models/hotel_model.dart';
import 'package:hotel_ui_package/hotel_ui_package.dart';
import 'package:hotel_ui_package/models/translate_strings.dart';

extension HotelExtension on HotelModel {
  HotelData toHotelData(bool isFavorite) {
    return HotelData(
        isLiked: isFavorite,
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
        translateStrings: TranslateStrings(
          fromText: 'from'.tr(),
          flightText: 'flight'.tr(),
          kinderText: 'children'.tr(),
          adultText: 'adults'.tr(),
          nightText: 'nights'.tr(),
          dayText: 'days'.tr(),
        ));
  }
}
