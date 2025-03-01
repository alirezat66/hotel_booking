import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HotelImageView extends StatelessWidget {
  final String url;
  final double aspectRatio;
  final Widget? errorWidget;
  final Widget? loadingWidget;
  const HotelImageView(
      {super.key,
      required this.url,
      this.aspectRatio = 343 / 186,
      this.errorWidget,
      this.loadingWidget});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: aspectRatio,
      child: CachedNetworkImage(
        imageUrl: url,
        progressIndicatorBuilder: (context, url, downloadProgress) =>
            loadingWidget ??
            CircularProgressIndicator(value: downloadProgress.progress),
        errorWidget: (context, url, error) =>
            errorWidget ?? const Icon(Icons.error),
      ),
    );
  }
}
