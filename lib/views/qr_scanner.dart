import 'dart:convert';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:idify/router/app_router.gr.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../shared/ipAddress.dart';
import '../theme/app_theme.dart';
import '../utils/globals.dart';
import '../utils/sizeconfig.dart';
import '../widgets/appBar.dart';
import '../widgets/bottom_curved_shadow.dart';
import 'package:http/http.dart' as http;

class QRScanner extends StatefulWidget {
  const QRScanner({Key key}) : super(key: key);

  @override
  State<QRScanner> createState() => _QRScannerState();
}

class _QRScannerState extends State<QRScanner> {
  bool isDark = false;
  String currentDarkModePref = "";
  String _scanBarcode = "";
  // Map<String, dynamic> jsonData;
  List<dynamic> jsonData;

  void toast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      textColor: Colors.black,
      fontSize: 16,
      backgroundColor: Colors.grey[200],
    );
  }

  Future<bool> fetchData(String id) async {
    final response = await http.post(
      Uri.parse('http://10.34.18.249:5004/data'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{"uid": "${id}"}),
    );

    if (response.statusCode == 200) {
      print(response.body);
      jsonData = jsonDecode(response.body);

      return true;
      // Process the received data as needed
    } else {
      print(response.body);
      // Handle the error case
      print('Request failed with status: ${response.statusCode}');
      return false;
    }
  }

  // Future<bool> fetchData(String uid) async {
  //   final response =
  //       await http.get(Uri.parse('http://${IP_ADDRESS}:8084/profile/${uid}'));

  //   if (response.statusCode == 200) {
  //     print(response.body);
  //     jsonData = jsonDecode(response.body);
  //     return true;

  //     // Process the received data as needed
  //   } else {
  //     // Handle the error case
  //     print('Request failed with status: ${response.statusCode}');
  //     return false;
  //   }
  // }

  Future scanBarcodeNormal() async {
    String barcodeScanRes;

    barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        "#ff6666", "Cancel", true, ScanMode.QR);
    print(barcodeScanRes);

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }

  @override
  void initState() {
    super.initState();
    scanBarcodeNormal;
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
      body: Column(
        children: [
          Container(
            decoration: CurvedShadowDecoration.getDecoration(isDark: isDark),
            child: ThemeAppBar.appBar(context, title: "Scan QR Code"),
          ),
          // const Text(
          //   "QR Code",
          //   style: TextStyle(fontSize: 20),
          // ),
          Center(
              child: Column(
            children: <Widget>[
              SizedBox(height: SizeConfig.screenWidth * 0.25),
              FloatingActionButton.extended(
                onPressed: scanBarcodeNormal,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15.0))),
                backgroundColor: const Color(0XFFFF7D54),
                label: const Text(
                  "Scan QR Code",
                  style: TextStyle(
                    fontFamily: 'Product Sans',
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 18.0,
                  ),
                ),
              ),
              SizedBox(height: SizeConfig.screenWidth * 0.25),
              // _scanBarcode != "" ? context.router.pushNamed("/Profile") : ""
              Text(
                _scanBarcode != "" ? "Successfully Scaned" : "",
                style: TextStyle(color: Colors.white, fontSize: 40),
              ),
              SizedBox(height: SizeConfig.screenWidth * 0.25),

              _scanBarcode != ""
                  ? MaterialButton(
                      child: Text(
                        "View Details",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      color: Colors.blue,
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      // onPressed: (() => context.router.pushNamed("/Profile"))
                      onPressed: () async {
                        // await fetchData(_scanBarcode);
                        // context.router.push(Profile(jsonData: jsonData));

                        await fetchData(_scanBarcode) == true
                            // ? context.router.pushNamed("/HomeView")
                            ? context.router.push(
                                Profile(jsonData: jsonData, isAuthority: true))
                            : {
                                toast("Invalid QR"),
                                setState(() {
                                  _scanBarcode = "";
                                })
                              };
                      },
                    )
                  : Text("")
              // QrImage(
              //     data: "QR Code",
              //     version: QrVersions.auto,
              //     size: 200.0,
              //     backgroundColor: Color.fromARGB(255, 200, 100, 100),
              //     foregroundColor: Color.fromARGB(255, 200, 25, 25),
              //     embeddedImage: AssetImage('assets/images/logo.png'),
              //     embeddedImageStyle: QrEmbeddedImageStyle(
              //         size: Size.square(30),
              //         color: Color.fromARGB(100, 10, 10, 10))),
            ],
          )),
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: scanBarcodeNormal,
      //   tooltip: 'Increment',
      //   child: Icon(Icons.add),
      // ),
    );
  }
}
