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