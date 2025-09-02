import 'package:client/app/core/router/router.dart';
import 'package:client/app/core/theme/light_theme.dart';
import 'package:client/binding_injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:client/injection.dart' as di;

void main() async {
  // WidgetsBinding widgetsBinding =
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.manual,
    overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top],
  );
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await di.init();
  BindingInjection().dependencies();
  // FlutterNativeSplash.remove();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: lightTheme,
      routerConfig: AppRouter.goRouter,
    );
  }
}
