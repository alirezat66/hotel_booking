import 'package:hotel_ui_package/models/translate_strings.dart';

class HotelData {
  final double score;
  final int reviewCount;
  final String scoreDescription;
  final String name;
  final String destination;
  final int days;
  final int nights;

  final int kids;
  final int adults;
  final String overallName;
  final String overallBoarding;
  final bool isFlightIncluded;
  final double travelPrice;
  final double pricePerPerson;
  final bool hasMoreOneOffer;
  final String imageUrl;
  final TranslateStrings? translateStrings;
  final bool isLiked;
  HotelData({
    required this.score,
    required this.reviewCount,
    required this.scoreDescription,
    required this.name,
    required this.destination,
    required this.days,
    required this.nights,
    required this.kids,
    required this.adults,
    required this.overallName,
    required this.overallBoarding,
    this.isFlightIncluded = false,
    required this.travelPrice,
    required this.pricePerPerson,
    this.hasMoreOneOffer = false,
    required this.imageUrl,
    this.translateStrings,
    this.isLiked = false,
  });
}
