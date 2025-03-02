// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hotel_favorite.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HotelFavoriteAdapter extends TypeAdapter<HotelFavorite> {
  @override
  final int typeId = 0;

  @override
  HotelFavorite read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HotelFavorite(
      name: fields[0] as String,
      destination: fields[1] as String,
      hotelId: fields[2] as String,
      ratingInfo: fields[3] as HotelRatingInfo,
      image: fields[4] as String,
      createdAt: fields[5] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, HotelFavorite obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.destination)
      ..writeByte(2)
      ..write(obj.hotelId)
      ..writeByte(3)
      ..write(obj.ratingInfo)
      ..writeByte(4)
      ..write(obj.image)
      ..writeByte(5)
      ..write(obj.createdAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HotelFavoriteAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class HotelRatingInfoAdapter extends TypeAdapter<HotelRatingInfo> {
  @override
  final int typeId = 1;

  @override
  HotelRatingInfo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HotelRatingInfo(
      score: fields[0] as double,
      reviewCount: fields[1] as int,
      scoreDescription: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, HotelRatingInfo obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.score)
      ..writeByte(1)
      ..write(obj.reviewCount)
      ..writeByte(2)
      ..write(obj.scoreDescription);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HotelRatingInfoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
