import 'package:flutter/material.dart';

import 'di/injection_container.dart' as di;
import 'ui/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.initializeDependencies();
  runApp(const MyApp());
}
