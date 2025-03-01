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
  State<FavoriteWidget> createState() => _FavoriteWidgetState();
}

class _FavoriteWidgetState extends State<FavoriteWidget>
    with TickerProviderStateMixin {
  late AnimationController _vibrationController;
  late Animation<double> _vibrationAnimation;
  late AnimationController _circleController;
  late Animation<double> _circleAnimation;

  @override
  void initState() {
    _initVibrationAnimation();
    _initCircleAnimation();
    super.initState();
  }

  @override
  void dispose() {
    _vibrationController.dispose();
    _circleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onLikeChanged != null
          ? () {
              if (!widget.initialState) {
                _runLikeAnimation();
              }
              widget.onLikeChanged!(!widget.initialState);
            }
          : null,
      child: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedBuilder(
              animation: _vibrationAnimation,
              builder: (context, build) {
                return Transform.scale(
                  scale: _vibrationAnimation.value,
                  child: Icon(
                    widget.initialState
                        ? Icons.favorite
                        : Icons.favorite_border,
                    size: widget.size,
                    color: widget.initialState
                        ? context.hotelCartTheme.favoriteIconSelectedColor
                        : context.hotelCartTheme.favoriteIconSelectedColor,
                  ),
                );
              }),
          AnimatedBuilder(
            animation: _circleAnimation,
            builder: (context, build) {
              return Container(
                width: _circleAnimation.value,
                height: _circleAnimation.value,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.fromBorderSide(BorderSide(
                      color: context.hotelCartTheme.favoriteIconSelectedColor,
                      width: 3,
                    )),
                    color: context.hotelCartTheme.favoriteIconSelectedColor),
              );
            },
          ),
        ],
      ),
    );
  }

  void _runLikeAnimation() async {
    await _circleController.forward();
    await _circleController.reverse();

    for (int i = 0; i < 3; i++) {
      await _vibrationController.forward();
      await _vibrationController.reverse();
    }
  }

  void _initVibrationAnimation() {
    _vibrationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );

    _vibrationAnimation =
        Tween<double>(begin: 1.0, end: 1.1).animate(_vibrationController);
  }

  void _initCircleAnimation() {
    _circleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _circleAnimation =
        Tween<double>(begin: 0, end: 30).animate(_circleController);
  }
}
