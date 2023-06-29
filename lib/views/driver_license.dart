import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../theme/app_theme.dart';
import '../utils/globals.dart';
import '../utils/sizeconfig.dart';
import '../widgets/appBar.dart';
import '../widgets/bottom_curved_shadow.dart';

class DriverLicense extends StatefulWidget {
  const DriverLicense({
    Key key,
    this.jsonData,
  }) : super(key: key);
  // final Map<String, dynamic> jsonData;
  final List<dynamic> jsonData;

  @override
  State<DriverLicense> createState() => _DriverLicenseState();
}

class _DriverLicenseState extends State<DriverLicense> {
  bool isDark = false;
  String currentDarkModePref = "";

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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: CurvedShadowDecoration.getDecoration(isDark: isDark),
              child: ThemeAppBar.appBar(context, title: "Driver License"),
            ),
            // const Text(
            //   "QR Code",
            //   style: TextStyle(fontSize: 20),
            // ),
            Container(
              color: Color.fromARGB(255, 188, 180, 180),
              // margin: EdgeInsets.all(20),
              // padding: EdgeInsets.all(40),
              width: 150,
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center, // Center vertically
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  ListTile(
                    title: Text(
                      "License Num",
                      style: TextStyle(fontSize: 20),
                    ),
                    subtitle: Text(
                      widget.jsonData[0]["licencenum"],
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      "Issued Date",
                      style: TextStyle(fontSize: 20),
                    ),
                    subtitle: Text(
                      widget.jsonData[0]["issued_date"],
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      "Expiry Date",
                      style: TextStyle(fontSize: 20),
                    ),
                    subtitle: Text(
                      widget.jsonData[0]["expiry_date"],
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  // Container(
                  //   color: Colors.white,
                  //   child: QrImage(
                  //     data: widget.uid,
                  //     size: 350,
                  //     // embeddedImage: AssetImage('images/logo.png'),
                  //     embeddedImageStyle: QrEmbeddedImageStyle(size: Size(80, 80)),
                  //   ),
                  // ),
                  Container(
                    child: Column(
                      children: [
                        CheckboxListTile(
                          title: Text('A1'),
                          // value: widget.jsonData[0]["a1"],
                          value: true,
                          onChanged: null,
                        ),
                        CheckboxListTile(
                          title: Text('A'),
                          // value: widget.jsonData[0]["a"],
                          value: true,
                          onChanged: null,
                        ),
                        CheckboxListTile(
                          title: Text('B1'),
                          // value: widget.jsonData[0]["b1"],
                          value: true,
                          onChanged: null,
                        ),
                        CheckboxListTile(
                          title: Text('B'),
                          // value: widget.jsonData[0]["b"],
                          value: true,
                          onChanged: null,
                        ),
                        CheckboxListTile(
                          title: Text('C1'),
                          // value: widget.jsonData[0]["c1"],
                          value: false,
                          onChanged: null,
                        ),
                        CheckboxListTile(
                          title: Text('C'),
                          // value: widget.jsonData[0]["c"],
                          value: false,
                          onChanged: null,
                        ),
                        CheckboxListTile(
                          title: Text('CE'),
                          // value: widget.jsonData[0]["ce"],
                          value: false,
                          onChanged: null,
                        ),
                        CheckboxListTile(
                          title: Text('D1'),
                          // value: widget.jsonData[0]["d1"],
                          value: false,
                          onChanged: null,
                        ),
                        CheckboxListTile(
                          title: Text('D'),
                          // value: widget.jsonData[0]["d"],
                          value: false,
                          onChanged: null,
                        ),
                        CheckboxListTile(
                          title: Text('DE'),
                          // value: widget.jsonData[0]["de"],
                          value: true,
                          onChanged: null,
                        ),
                        CheckboxListTile(
                          title: Text('G1'),
                          // value: widget.jsonData[0]["g1"],
                          value: true,
                          onChanged: null,
                        ),
                        CheckboxListTile(
                          title: Text('G'),
                          // value: widget.jsonData[0]["g"],
                          value: false,
                          onChanged: null,
                        ),
                        CheckboxListTile(
                          title: Text('J'),
                          // value: widget.jsonData[0]["j"],
                          value: false,
                          onChanged: null,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
