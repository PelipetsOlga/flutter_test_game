import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../app_theme.dart';

void showToast(String message, BuildContext context){
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.CENTER,
    backgroundColor: AppTheme.accentOrange,
    textColor: AppTheme.white,
    fontSize: 16,
  );
}