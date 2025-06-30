import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomSvgIcon extends StatelessWidget {
  final String assetPath;
  final double? size;
  final Color? color;
  final bool isSelected;

  const CustomSvgIcon({
    super.key,
    required this.assetPath,
    this.size,
    this.color,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      assetPath,
      width: size,
      height: size,
      colorFilter:
          color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
    );
  }
}
