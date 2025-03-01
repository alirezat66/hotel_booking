import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:hotel_ui_package/extensions/theme_ext.dart';

class AppImageView extends StatelessWidget {
  final String url;
  final double aspectRatio;
  final Widget? errorWidget;
  final Widget? loadingWidget;
  final double boarderRadius;
  const AppImageView(
      {super.key,
      required this.url,
      this.aspectRatio = 343 / 186,
      this.errorWidget,
      this.boarderRadius = 4,
      this.loadingWidget});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: aspectRatio,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(boarderRadius),
        child: CachedNetworkImage(
          imageUrl: url,
          fit: BoxFit.cover,
          progressIndicatorBuilder: (context, url, downloadProgress) => SizedBox(
            width: 48,
            height: 48,
            child: loadingWidget ??
                CircularProgressIndicator.adaptive(
                    value: downloadProgress.progress),
          ),
          errorWidget: (context, url, error) => Column(
            children: [
              errorWidget ?? const Icon(Icons.error),
              Text(
                error.toString(),
                style: context.bodySmall.copyWith(color: Colors.black),
              )
            ],
          ),
        ),
      ),
    );
  }
}
