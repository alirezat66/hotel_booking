import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:hotel_ui_package/hotel_ui_package.dart';

class FavoriteEmptyPage extends StatelessWidget {
  const FavoriteEmptyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.network(
            'https://www.ab-in-den-urlaub.de/merkzettel/assets/heartInhands-BtEsFis3.svg',
          ),
          const Gap(24),
          Text(
            'Deine Favoriten - Immer zur Hand',
            style: context.titleLarge.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          const Gap(16),
          Text(
            'Melde dich jetzt an, um deine Favoriten auf allen Geräten zu synchronisieren und einzusehen.',
            textAlign: TextAlign.center,
            style: context.titleSmall.copyWith(),
          )
        ],
      ),
    );
  }
}
