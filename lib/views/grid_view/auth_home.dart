import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:idify/utils/globals.dart';
import 'package:idify/utils/sizeconfig.dart';
import 'package:idify/views/qr_scanner.dart';

import '../../injection.dart';
import '../../router/app_router.gr.dart';

class AuthHome extends StatefulWidget {
  const AuthHome({Key key}) : super(key: key);

  @override
  _AuthHomeState createState() => _AuthHomeState();
}

class _AuthHomeState extends State<AuthHome> {
  bool isDark = false;

  String currentDarkModePref = "";

  Card makeDashboardItem(String title, String img, int index) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.all(8),
      child: Container(
        decoration: index == 0 || index == 3 || index == 4
            ? BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                gradient: const LinearGradient(
                  begin: FractionalOffset(0.0, 0.0),
                  end: FractionalOffset(3.0, -1.0),
                  colors: [
                    Color(0xFF004B8D),
                    Color(0xFFffffff),
                  ],
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.white,
                    blurRadius: 3,
                    offset: Offset(2, 2),
                  )
                ],
              )
            : BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                gradient: const LinearGradient(
                  begin: FractionalOffset(0.0, 0.0),
                  end: FractionalOffset(3.0, -1.0),
                  colors: [
                    Colors.cyan,
                    Colors.amber,
                  ],
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.white,
                    blurRadius: 3,
                    offset: Offset(2, 2),
                  )
                ],
              ),
        child: InkWell(
          onTap: () {
            if (index == 0) {
              context.router.pushNamed("/QRScanner");
            }
            if (index == 1) {
              context.router.pushNamed("/RegLocations");
            }
            if (index == 2) {
              context.router.pushNamed("/Survey");
            }
            if (index == 3) {
              context.router.pushNamed("/About");
            }
            if (index == 4) {
              //5.item
            }
            if (index == 5) {
              //6.item
            }
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            verticalDirection: VerticalDirection.down,
            children: [
              const SizedBox(height: 10),
              Center(
                child: Image.asset(
                  img,
                  height: 150,
                  width: 150,
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: Text(
                  title,
                  style: const TextStyle(
                      fontSize: 19,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 5),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    if (AdaptiveTheme.of(context).mode == AdaptiveThemeMode.system) {
      setState(() => isDark = Globals.systemDarkMode.getValue());
    } else if (AdaptiveTheme.of(context).mode == AdaptiveThemeMode.dark) {
      setState(() => isDark = true);
    } else {
      setState(() => isDark = false);
    }

    return Scaffold(
      // backgroundColor: Color.fromARGB(255, 170, 193, 232),
      body: Column(
        children: [
          SizedBox(height: SizeConfig.screenWidth * 0.15),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[],
            ),
          ),
          // SizedBox(height: 25),
          
          Image.asset(
            './assets/images/idify_logo_white.png',
            height: 100,
          ),
          SizedBox(height: SizeConfig.screenWidth * 0.15),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              padding: const EdgeInsets.all(2),
              children: [
                // Register Locations
                makeDashboardItem("Scan", 'assets/images/home_tiles/qr.png', 0),
                makeDashboardItem("Register Locations",
                    'assets/images/home_tiles/map.png', 1),
                makeDashboardItem(
                    "Survey", 'assets/images/home_tiles/news.png', 2),
                makeDashboardItem(
                    "About", 'assets/images/home_tiles/about.png', 3),
                // makeDashboardItem("Location", "assets/map.png", 3),
                // makeDashboardItem("Todo", "assets/todo.png", 4),
                // makeDashboardItem("Settings", "assets/setting.png", 5),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Setting {
  final String imagePath;
  final String title;
  final String routePath;

  Setting({
    @required this.imagePath,
    @required this.title,
    @required this.routePath,
  });
}
