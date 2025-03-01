import 'package:flutter/material.dart';
import 'package:hotel_ui_package/view/more_info_cta.dart';
import 'package:hotel_ui_package/extensions/theme_ext.dart';

class RateStarWidget extends StatelessWidget {
  final double score;
  final Color? starColor;
  final double size;
  final double spacing;
  final VoidCallback? onMoreInfoTab;
  const RateStarWidget({
    super.key,
    required this.score,
    this.starColor,
    this.size = 16.0,
    this.spacing = 0.0,
    this.onMoreInfoTab,
  }) : assert(score >= 0.0 && score <= 5.0, 'Score must be between 0 and 5');

  @override
  Widget build(BuildContext context) {
    final int fullStars = score.floor();
    final bool hasHalfStar = (score - fullStars) >= 0.5;
    final int emptyStars = 5 - fullStars - (hasHalfStar ? 1 : 0);
    final Color effectiveColor =
        starColor ?? context.hotelCardTheme.titleTextColor;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ...List.generate(
          fullStars,
          (index) => Padding(
            padding: EdgeInsets.only(right: spacing),
            child: Icon(Icons.star, color: effectiveColor, size: size),
          ),
        ),
        if (hasHalfStar)
          Padding(
            padding: EdgeInsets.only(right: spacing),
            child: Icon(Icons.star_half, color: effectiveColor, size: size),
          ),
        ...List.generate(
          emptyStars,
          (index) => Padding(
            padding:
                EdgeInsets.only(right: index < emptyStars - 1 ? spacing : 0),
            child: Icon(Icons.star_border, color: effectiveColor, size: size),
          ),
        ),
        Offstage(
          offstage: onMoreInfoTab == null,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 4,
            ),
            child: MoreInfoCta(
              size: size,
              onTap: onMoreInfoTab,
            ),
          ),
        )
      ],
    );
  }
}
