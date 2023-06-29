import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../theme/app_theme.dart';
import '../utils/globals.dart';
import '../utils/sizeconfig.dart';
import '../widgets/appBar.dart';
import '../widgets/bottom_curved_shadow.dart';

class Profile extends StatefulWidget {
  const Profile({
    Key key,
    this.jsonData,
    this.isAuthority,
  }) : super(key: key);
  // final String uid;
  // final Map<String, dynamic> jsonData;
  final List<dynamic> jsonData;
  final bool isAuthority;

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool isDark = false;
  String currentDarkModePref = "";

  // String imageUrl;
  // String imageUrl1;
  // final storage = FirebaseStorage.instance;
  // @override
  // void initState() {
  //   super.initState();
  //   // Set the initial value of imageUrl to an empty string
  //   imageUrl = '';
  //   imageUrl1 = '';
  //   //Retrieve the imge grom Firebase Storage
  //   getImageUrl();
  // }

  // Future<void> getImageUrl() async {
  //   // Get the feference to the image file in Firebase Storage
  //   final ref = storage.ref().child('banner.jpg');
  //   final ref1 = storage.ref().child('java.jpg');
  //   // Get teh inageUrl to download URL
  //   final url = await ref.getDownloadURL();
  //   final url1 = await ref1.getDownloadURL();
  //   setState(() {
  //     imageUrl = url;
  //     imageUrl1 = url1;
  //   });
  // }

  dataField(String title, final String stitle) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(fontSize: 26),
      ),
      subtitle: Text(
        stitle,
        style: TextStyle(fontSize: 24),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    print(widget.jsonData[0]["email"]);
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
            child: ThemeAppBar.appBar(context, title: "ID Card Details"),
          ),
          // const Text(
          //   "QR Code",
          //   style: TextStyle(fontSize: 20),
          // ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center, // Center vertically
            children: [
              const SizedBox(
                height: 25,
              ),
              CircleAvatar(
                radius: 70,
                backgroundImage: NetworkImage(widget.jsonData[0]["url"]),
                // backgroundImage: AssetImage('assets/images/as.png'),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                // padding: const EdgeInsets.only(left: 20.0, top: 20.0),
                color: Color.fromARGB(255, 188, 180, 180),
                margin: EdgeInsets.all(20),
                padding: EdgeInsets.all(40),
                child: Column(
                  children: [
                    // QrImage(
                    //   data: "widget.uid",
                    //   size: 350,
                    //   // embeddedImage: AssetImage('images/logo.png'),
                    //   embeddedImageStyle: QrEmbeddedImageStyle(size: Size(80, 80)),
                    // ),
                    // Text(widget.jsonData[0]["fullname"]),
                    dataField('Full Name', widget.jsonData[0]["fullName"]),
                    dataField('NIC Number', widget.jsonData[0]["nic"]),
                    // dataField('Address', widget.jsonData[0]["address"]),
                    dataField('Address', "No64, Wewala, Horana"),
                    dataField('Date of Birth', widget.jsonData[0]["dob"]),
                    dataField('Occupation', widget.jsonData[0]["occupation"]),
                    const SizedBox(
                      height: 25,
                    ),
                    widget.isAuthority
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
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 10),
                            // onPressed: (() => context.router.pushNamed("/Profile"))
                            onPressed: () async {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    // title: Text(''),
                                    content: SingleChildScrollView(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
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
                                          CheckboxListTile(
                                            title: Text('A1'),
                                            // value: widget.jsonData[0]["a1"],
                                            value: false,
                                            onChanged: null,
                                          ),
                                          CheckboxListTile(
                                            title: Text('A'),
                                            // value: widget.jsonData[0]["a"],
                                            value: false,
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
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('Close'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          )
                        : Text("")
                    // dataField('Occupation', widget.jsonData[0]["fullname"]),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
