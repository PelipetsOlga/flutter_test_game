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
      color: AppTheme.white,
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
      color: AppTheme.white,
    );
  }

  static TextStyle spinnerTitle(BuildContext context) {
    return TextStyle(
      fontFamily: 'Proxima Nova',
      fontWeight: FontWeight.w600,
      fontSize: FigmaHelper.px(context, 52),
      height: 1.0,
      letterSpacing: -0.02,
      color: Colors.white,
    );
  }

  static TextStyle primaryButtonTitle(BuildContext context) {
    return TextStyle(
      color: Colors.white,
      fontSize: FigmaHelper.px(context, 100),
      fontWeight: FontWeight.w600,
      fontStyle: FontStyle.italic,
      height: 1.0,
      letterSpacing: -2.0,
    );
  }

  static TextStyle toolbarText(BuildContext context) {
    return TextStyle(
      fontFamily: _fontFamily,
      fontWeight: FontWeight.w600,
      fontSize: FigmaHelper.px(context, 52),
      height: 48.25 / 52, // line-height: 48.25px / font-size: 52px
      letterSpacing: 0.0, // letter-spacing: 0px
      color: AppTheme.white,
    );
  }
}
