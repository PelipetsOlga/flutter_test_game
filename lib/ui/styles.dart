import 'package:flutter/material.dart';

import 'app_theme.dart';

class AppTypography {
  static const String _fontFamily = 'Proxima Nova';

  static TextStyle rootTabScreenTitle(BuildContext context) {
    return TextStyle(
      fontFamily: _fontFamily,
      fontWeight: FontWeight.w600,
      fontSize: FigmaHelper.px(context, 70),
      height: 1.0,
      // 100% line height
      letterSpacing: -0.02,
      // -2% letter spacing
      color: Colors.white,
    );
  }

  static TextStyle formLabel(BuildContext context) {
    return TextStyle(
      fontFamily: _fontFamily,
      fontWeight: FontWeight.w400,
      fontSize: FigmaHelper.px(context, 38),
      height: 1.0,
      // 100% line height
      letterSpacing: -0.02,
      // -2% letter spacing
      color: Colors.white,
    );
  }
}
