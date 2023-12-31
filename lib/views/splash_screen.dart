import 'dart:async';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:idify/theme/app_theme.dart';
import 'package:idify/utils/globals.dart';
import 'package:idify/utils/sizeconfig.dart';
import 'package:idify/views/sign_in.dart';

class SplashScreen extends StatefulWidget {
  static const TAG = "/splashScreen";

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  static double hw = 150;
  static double dashBorderRadius = 30;
  static double curveHW = 0;
  static Color dashColor = COLORS.WHITE;

  bool isAnimationComplete = false;
  bool isDark = false;

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

    if (!isAnimationComplete) {
      setState(() => isAnimationComplete = true);
      Timer(
        Duration(seconds: 2),
        () {
          setState(() {
            hw = 100;
            dashColor = COLORS.GREEN;
            curveHW = 75;
            // curveOpacity = 0.5;
          });
          Timer(
            const Duration(milliseconds: 1500),
            () => context.router.pushNamed("/SignIn"),
          );
        },
      );
    }
    return Scaffold(
      body: Stack(
        children: [
          /* main green circle */
          Align(
            alignment: Alignment.center,
            child: Container(
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                color: COLORS.GREEN,
                shape: BoxShape.circle,
              ),
            ),
          ),
          /* white canvas */
          Align(
            alignment: Alignment.center,
            child: AnimatedContainer(
              duration: new Duration(seconds: 1),
              curve: Curves.fastOutSlowIn,
              height: hw,
              width: hw,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: isDark ? COLORS.DARKER_GREY : COLORS.WHITE,
                shape: BoxShape.circle,
              ),
            ),
          ),
          /* dash (inside circle from left) */
          Align(
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedContainer(
                  duration: new Duration(seconds: 1),
                  curve: Curves.fastOutSlowIn,
                  height: 30,
                  width: 75,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(dashBorderRadius),
                      bottomLeft: Radius.circular(dashBorderRadius),
                    ),
                    color: dashColor,
                  ),
                ),
                SizedBox(height: 30, width: 75),
              ],
            ),
          ),
          /* top right opaque curve */
          Align(
            alignment: Alignment.center,
            child: Container(
              height: 150,
              width: 150,
              alignment: Alignment.topRight,
              child: AnimatedContainer(
                duration: new Duration(milliseconds: 300),
                curve: Curves.fastOutSlowIn,
                height: curveHW,
                width: curveHW,
                color: isDark
                    ? COLORS.DARKER_GREY.withOpacity(0.5)
                    : COLORS.WHITE.withOpacity(0.5),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
