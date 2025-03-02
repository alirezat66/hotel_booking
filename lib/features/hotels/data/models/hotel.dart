class Hotel {
  final String name;
  final String destination;
  final String hotelId;
  HotelRatingInfo ratingInfo;
  HotelBestOffer bestOffer;
  List<String> images;

  Hotel({
    required this.name,
    required this.destination,
    required this.hotelId,
    required this.ratingInfo,
    required this.bestOffer,
    required this.images,
  });

  factory Hotel.fromJson(Map<String, dynamic> json) {
    return Hotel(
      name: json['name'],
      destination: json['destination'],
      hotelId: json['hotel-id'],
      ratingInfo: HotelRatingInfo.fromJson(json['rating-info']),
      bestOffer: HotelBestOffer.fromJson(json['best-offer']),
      images: (json['images'] as List<dynamic>)
          .map((image) => (image['large'] as String).split('?')[0])
          .toList(),
    );
  }
}

class HotelRatingInfo {
  final double score;
  final int reviewCount;
  final String scoreDescription;

  HotelRatingInfo({
    required this.score,
    required this.reviewCount,
    required this.scoreDescription,
  });

  factory HotelRatingInfo.fromJson(Map<String, dynamic> json) {
    return HotelRatingInfo(
      score: double.tryParse(json['score'].toString()) ?? 0.0,
      reviewCount: json['reviews-count'],
      scoreDescription: json['score-description'],
    );
  }
}

class HotelBestOffer {
  final bool isFlightIncluded;
  final double travelPrice;
  final double pricePerPerson;
  final bool hasMoreOneOffer;
  final TravelDate travelDate;
  final RoomsOverall roomsOverall;

  HotelBestOffer({
    required this.isFlightIncluded,
    required this.travelPrice,
    required this.pricePerPerson,
    required this.hasMoreOneOffer,
    required this.travelDate,
    required this.roomsOverall,
  });

  factory HotelBestOffer.fromJson(Map<String, dynamic> json) {
    return HotelBestOffer(
      isFlightIncluded: json['flight-included'],
      travelPrice:double.tryParse(json['travel-price'].toString()) ?? 0.0 ,
      pricePerPerson:double.tryParse(json['simple-price-per-person'].toString()) ?? 0.0,
      hasMoreOneOffer:
          (json['rooms']['prices-and-occupancy'] as List<dynamic>).length > 1,
      travelDate: TravelDate.fromJson(json['travel-date']),
      roomsOverall: RoomsOverall.fromJson(json['rooms']['overall']),
    );
  }
}

class TravelDate {
  final int days;
  final int nights;
  final String departureDate;
  final String returnDate;

  TravelDate({
    required this.days,
    required this.nights,
    required this.departureDate,
    required this.returnDate,
  });

  factory TravelDate.fromJson(Map<String, dynamic> json) {
    return TravelDate(
      days: json['days'],
      nights: json['nights'],
      departureDate: json['departure-date'],
      returnDate: json['return-date'],
    );
  }
}

class RoomsOverall {
  final String name;
  final String boarding;
  final int childrenCount;
  final int adultCount;

  RoomsOverall({
    required this.name,
    required this.boarding,
    required this.childrenCount,
    required this.adultCount,
  });

  factory RoomsOverall.fromJson(Map<String, dynamic> json) {
    return RoomsOverall(
      name: json['name'],
      boarding: json['boarding'],
      childrenCount: json['children-count'],
      adultCount: json['adult-count'],
    );
  }
}
