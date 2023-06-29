import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../theme/app_theme.dart';
import '../utils/globals.dart';
import '../utils/sizeconfig.dart';
import '../widgets/appBar.dart';
import '../widgets/bottom_curved_shadow.dart';

class QRView extends StatefulWidget {
  const QRView({Key key, this.uid}) : super(key: key);
  final String uid;

  @override
  State<QRView> createState() => _QRViewState();
}

class _QRViewState extends State<QRView> {
  bool isDark = false;
  String currentDarkModePref = "";

  @override
  Widget build(BuildContext context) {
    print(widget.uid);
    SizeConfig().init(context);
    if (AdaptiveTheme.of(context).mode == AdaptiveThemeMode.system) {
      setState(() => isDark = Globals.systemDarkMode.getValue());
    } else if (AdaptiveTheme.of(context).mode == AdaptiveThemeMode.dark) {
      setState(() => isDark = true);
    } else {
      setState(() => isDark = false);
    }

    if (AdaptiveTheme.of(context).mode == AdaptiveThemeMode.system) {
      setState(() => currentDarkModePref = "System");
    } else {
      setState(() => currentDarkModePref = "Custom");
    }

    double cardH = AppBar().preferredSize.height;

    Widget settingsTile({
      @required Widget leading,
      @required String title,
      @required Widget trailing,
    }) {
      Color bgColor = isDark ? COLORS.DARK_GREY : COLORS.LIGHTER_GREY;
      Widget tiles = Container(
        margin: EdgeInsets.only(
          top: 2,
          bottom: 2,
          left: SizeConfig.screenWidth * 0.075,
          right: SizeConfig.screenWidth * 0.075,
        ),
        padding: EdgeInsets.only(
          left: SizeConfig.screenWidth * 0.025,
          right: SizeConfig.screenWidth * 0.025,
        ),
        height: cardH,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Row(
          children: [
            leading,
            Expanded(
              child: Text(
                title,
                style: const TextStyle(color: COLORS.MEDIUM_DARK_GREY),
              ),
            ),
            trailing,
          ],
        ),
      );
      return tiles;
    }

    return Scaffold(
      // print(widget.uid);
      body: Column(
        children: [
          Container(
            decoration: CurvedShadowDecoration.getDecoration(isDark: isDark),
            child: ThemeAppBar.appBar(context, title: "QR Code"),
          ),
          // const Text(
          //   "QR Code",
          //   style: TextStyle(fontSize: 20),
          // ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center, // Center vertically
            children: [
              const SizedBox(
                height: 250,
              ),
              Container(
                color: Colors.white,
                child: QrImage(
                  data: widget.uid,
                  size: 350,
                  // embeddedImage: AssetImage('images/logo.png'),
                  embeddedImageStyle: QrEmbeddedImageStyle(size: Size(80, 80)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
