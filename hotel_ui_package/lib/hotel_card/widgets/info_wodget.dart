import 'package:flutter/material.dart';

class InfoWidget extends StatelessWidget {
  final VoidCallback? onTap;
  final double? size;
  const InfoWidget({super.key, this.onTap, this.size});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Icon(
        Icons.help_outline,
        size: size,
      ),
    );
  }
}
