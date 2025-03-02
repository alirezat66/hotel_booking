import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:hotel_booking/features/hotels/data/models/hotel.dart';

part 'hotel_favorite.g.dart'; // Generated file after running build_runner

@HiveType(typeId: 0)
// ignore: must_be_immutable
class HotelFavorite extends Equatable {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String destination;

  @HiveField(2)
  final String hotelId;

  @HiveField(3)
  HotelRatingInfo ratingInfo;

  @HiveField(4)
  String image;

  HotelFavorite({
    required this.name,
    required this.destination,
    required this.hotelId,
    required this.ratingInfo,
    required this.image,
  });

  factory HotelFavorite.fromHotel(Hotel hotel) {
    return HotelFavorite(
      name: hotel.name,
      destination: hotel.destination,
      hotelId: hotel.hotelId,
      ratingInfo: hotel.ratingInfo,
      image: hotel.images.first,
    );
  }
  @override
  List<Object?> get props => [hotelId, name, destination];
}

@HiveType(typeId: 1)
class HotelRatingInfo {
  @HiveField(0)
  final double score;

  @HiveField(1)
  final int reviewCount;

  @HiveField(2)
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
