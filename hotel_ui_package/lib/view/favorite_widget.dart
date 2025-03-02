import 'package:flutter/material.dart';
import 'package:hotel_ui_package/extensions/theme_ext.dart';

class FavoriteWidget extends StatefulWidget {
  final bool initialState;
  final Function(bool)? onLikeChanged;
  final double size;
  const FavoriteWidget({
    super.key,
    required this.initialState,
    required this.onLikeChanged,
    this.size = 24,
  });

  @override
  State<FavoriteWidget> createState() => FavoriteWidgetState();
}

class FavoriteWidgetState extends State<FavoriteWidget>
    with TickerProviderStateMixin {
  late AnimationController vibrationController;
  late Animation<double> vibrationAnimation;
  late AnimationController circleController;
  late Animation<double> circleAnimation;

  @override
  void initState() {
    _initVibrationAnimation();
    _initCircleAnimation();
    super.initState();
  }

  @override
  void dispose() {
    vibrationController.dispose();
    circleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onLikeChanged != null
          ? () {
              if (!widget.initialState) {
                runLikeAnimation();
              }
              widget.onLikeChanged!(!widget.initialState);
            }
          : null,
      child: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedBuilder(
              animation: vibrationAnimation,
              builder: (context, build) {
                return Transform.scale(
                  scale: vibrationAnimation.value,
                  child: Icon(
                    widget.initialState
                        ? Icons.favorite
                        : Icons.favorite_border,
                    size: widget.size,
                    color: widget.initialState
                        ? context.hotelCardTheme.favoriteIconSelectedColor
                        : context.hotelCardTheme.favoriteIconDeselectedColor,
                  ),
                );
              }),
          AnimatedBuilder(
            animation: circleAnimation,
            builder: (context, build) {
              return Container(
                width: circleAnimation.value,
                height: circleAnimation.value,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.fromBorderSide(BorderSide(
                      color: context.hotelCardTheme.favoriteIconSelectedColor,
                      width: 3,
                    )),
                    color: context.hotelCardTheme.favoriteIconSelectedColor),
              );
            },
          ),
        ],
      ),
    );
  }

  void runLikeAnimation() async {
    await circleController.forward();
    await circleController.reverse();

    for (int i = 0; i < 3; i++) {
      await vibrationController.forward();
      await vibrationController.reverse();
    }
  }

  void _initVibrationAnimation() {
    vibrationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );

    vibrationAnimation =
        Tween<double>(begin: 1.0, end: 1.1).animate(vibrationController);
  }

  void _initCircleAnimation() {
    circleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    circleAnimation =
        Tween<double>(begin: 0, end: 30).animate(circleController);
  }
}
