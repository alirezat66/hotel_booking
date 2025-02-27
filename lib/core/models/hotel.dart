class Hotel {
  BestOffer bestOffer;
  String destination;
  String hotelId;
  List<Image> images;
  double latitude;
  double longitude;
  String name;
  RatingInfo ratingInfo;

  Hotel({
    required this.bestOffer,
    required this.destination,
    required this.hotelId,
    required this.images,
    required this.latitude,
    required this.longitude,
    required this.name,
    required this.ratingInfo,
  });
}

class BestOffer {
  int includedTravelDiscount;
  int originalTravelPrice;
  int simplePricePerPerson;
  int total;
  int travelPrice;
  List<String> availableSpecialGroups;
  bool flightIncluded;
  Rooms rooms;
  TravelDate travelDate;

  BestOffer({
    required this.includedTravelDiscount,
    required this.originalTravelPrice,
    required this.simplePricePerPerson,
    required this.total,
    required this.travelPrice,
    required this.availableSpecialGroups,
    required this.flightIncluded,
    required this.rooms,
    required this.travelDate,
  });
}

class Rooms {
  Overall overall;
  List<PricesAndOccupancy> pricesAndOccupancy;
  List<RoomGroup> roomGroups;

  Rooms({
    required this.overall,
    required this.pricesAndOccupancy,
    required this.roomGroups,
  });
}

class Overall {
  String boarding;
  String name;
  int adultCount;
  List<dynamic> childrenAges;
  int childrenCount;
  int quantity;
  bool sameBoarding;
  bool sameRoomGroups;

  Overall({
    required this.boarding,
    required this.name,
    required this.adultCount,
    required this.childrenAges,
    required this.childrenCount,
    required this.quantity,
    required this.sameBoarding,
    required this.sameRoomGroups,
  });
}

class PricesAndOccupancy {
  int adultCount;
  int childrenCount;
  String groupIdentifier;
  int simplePricePerPerson;
  int total;

  PricesAndOccupancy({
    required this.adultCount,
    required this.childrenCount,
    required this.groupIdentifier,
    required this.simplePricePerPerson,
    required this.total,
  });
}

class RoomGroup {
  String boarding;
  String name;
  String groupIdentifier;
  int quantity;

  RoomGroup({
    required this.boarding,
    required this.name,
    required this.groupIdentifier,
    required this.quantity,
  });
}

class TravelDate {
  int days;
  DateTime departureDate;
  int nights;
  DateTime returnDate;

  TravelDate({
    required this.days,
    required this.departureDate,
    required this.nights,
    required this.returnDate,
  });
}

class Image {
  String large;
  String small;

  Image({
    required this.large,
    required this.small,
  });
}

class RatingInfo {
  int recommendationRate;
  int reviewsCount;
  double score;
  String scoreDescription;

  RatingInfo({
    required this.recommendationRate,
    required this.reviewsCount,
    required this.score,
    required this.scoreDescription,
  });
}
