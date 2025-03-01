import 'package:flutter/material.dart';
import 'package:hotel_ui_package/models/hotel_data.dart';

abstract class CardStrategy {
  Widget build(HotelData hotel,
      {Function(bool)? onFavoriteChanged,
      VoidCallback? onActionPressed,
      VoidCallback? onMoreInfoTab});
}
