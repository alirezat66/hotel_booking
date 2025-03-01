import 'package:hotel_ui_package/view/hotel_card/card_strategy/card_strategy.dart';
import 'package:hotel_ui_package/view/hotel_card/card_strategy/compact_card_strategy.dart';
import 'package:hotel_ui_package/view/hotel_card/card_strategy/detailed_card_strategy.dart';
import 'package:hotel_ui_package/view/hotel_card/hotel_card_type.dart';

class HotelCardFactory {
  static Map<HotelCardType, CardStrategy> strategies = {
    HotelCardType.compact: CompactCardStrategy(),
    HotelCardType.detailed: DetailedCardStrategy(),
  };

  static CardStrategy getStrategy(HotelCardType type) {
    return strategies[type]!;
  }
}
