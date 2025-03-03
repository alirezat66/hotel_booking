import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:hotel_ui_package/hotel_ui_package.dart';

class FavoriteEmptyView extends StatelessWidget {
  final Widget? emptyImage;
  const FavoriteEmptyView({super.key, this.emptyImage});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          emptyImage ??
              SvgPicture.network(
                'https://www.ab-in-den-urlaub.de/merkzettel/assets/heartInhands-BtEsFis3.svg',
              ),
          const Gap(24),
          Text(
            'emptyFavorites'.tr(),
            style: context.titleLarge.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          const Gap(16),
          Text(
            'singUpNow'.tr(),
            textAlign: TextAlign.center,
            style: context.titleSmall.copyWith(),
          )
        ],
      ),
    );
  }
}
