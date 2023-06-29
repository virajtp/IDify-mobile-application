import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:idify/router/app_router.gr.dart';
import 'package:idify/theme/app_theme.dart';
import 'package:idify/utils/app_template.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('google_fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _router = AppRouter();
  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: AppTheme().getAppTheme(),
      dark: AppTheme().getDarkTheme(),
      initial: AdaptiveThemeMode.system,
      builder: (light, dark) => MaterialApp.router(
        title: 'IDify',
        routerDelegate: _router.delegate(),
        routeInformationParser: _router.defaultRouteParser(),
        debugShowCheckedModeBanner: false,
        // theme: AppTheme().getAppTheme(),
        // darkTheme: AppTheme().getDarkTheme(),
        theme: light,
        darkTheme: dark,
        // themeMode: themeMode,
        builder: (context, child) => AppTemplate(child: child),
      ),
    );
  }
}
