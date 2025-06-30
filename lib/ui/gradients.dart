import 'package:flutter/material.dart';

import 'app_theme.dart';

const orangeVerticalGradient =  LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [
    AppTheme.warmOrange,  // #FE8D3B
    AppTheme.brightOrange, // #F01515
  ],
);

const spinnerGradient = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [
    AppTheme.lightBlue,  // #003B7C
    Color(0xFF043872),   // #043872
  ],
);