import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:idify/theme/app_theme.dart';
import 'package:idify/theme/images.dart';
import 'package:idify/utils/globals.dart';
import 'package:idify/utils/sizeconfig.dart';
import 'package:idify/widgets/appBar.dart';
import 'package:idify/widgets/bottom_curved_shadow.dart';
import 'package:idify/widgets/input_field.dart';
import 'package:idify/widgets/switch.dart';

class UserAccountAll extends StatefulWidget {
  const UserAccountAll({Key key}) : super(key: key);

  @override
  _UserAccountAllState createState() => _UserAccountAllState();
}

class _UserAccountAllState extends State<UserAccountAll> {
  bool isDark = false;
  final FocusNode myFocusNode = FocusNode();
  bool _status = true;
  bool prefNotification = true;
  bool prefNewsletter = false;

  TextEditingController txtFName = TextEditingController();
  TextEditingController txtAddress = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPass = TextEditingController();

  @override
  void initState() {
    super.initState();
    initValues();
  }

  void initValues() {
    setState(() {
      txtFName.text = "Orlando Smith";
      txtAddress.text = "42 Wallabe Way, London, United Kingdom";
      txtEmail.text = "orlando.smith@gmail.com";
      txtPass.text = "is it really required";
    });
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

    Widget appBar = Container(
      alignment: Alignment.center,
      decoration: CurvedShadowDecoration.getDecoration(isDark: isDark),
      child: ThemeAppBar.appBar(
        context,
        title: "Your Account",
        leading: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(55)),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              splashColor: COLORS.GREEN,
              onTap: () => Navigator.of(context).pop(),
              child: Container(
                padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                height: 35,
                width: 55,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: SvgPicture.asset(
                  ThemeIcon.ARROW,
                  color: COLORS.MEDIUM_DARK_GREY,
                ),
              ),
            ),
          ),
        ),
        trailing: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(55)),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              splashColor: COLORS.GREEN,
              onTap: () => Navigator.of(context).pop(),
              child: Container(
                padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                height: 35,
                width: 55,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: SvgPicture.asset(
                  ThemeIcon.SELECT,
                  color: COLORS.GREEN,
                ),
              ),
            ),
          ),
        ),
      ),
    );

    Widget title({@required String text}) {
      return Container(
        margin: EdgeInsets.symmetric(
          horizontal: SizeConfig.screenWidth * 0.05,
          vertical: SizeConfig.screenWidth * 0.025,
        ),
        alignment: Alignment.centerLeft,
        child: Text(
          text,
          style: Theme.of(context).textTheme.headline6.copyWith(
                fontWeight: FontWeight.w400,
                color: COLORS.MEDIUM_DARK_GREY,
              ),
        ),
      );
    }

    Widget userInformation() {
      return Container(
        margin: EdgeInsets.symmetric(
          horizontal: SizeConfig.screenWidth * 0.05,
          vertical: SizeConfig.screenWidth * 0.025,
        ),
        padding: EdgeInsets.all(SizeConfig.screenWidth * 0.025),
        decoration: BoxDecoration(
          color: isDark ? COLORS.DARK_GREY : COLORS.LIGHTER_GREY,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          children: [
            InputField(
              hintText: "Full Name",
              controller: txtFName,
              suffix: SvgPicture.asset(
                ThemeIcon.EDIT,
                color: COLORS.MEDIUM_DARK_GREY,
              ),
            ),
            SizedBox(height: SizeConfig.screenWidth * 0.015),
            InputField(
              hintText: "Address",
              controller: txtAddress,
              suffix: SvgPicture.asset(
                ThemeIcon.EDIT,
                color: COLORS.MEDIUM_DARK_GREY,
              ),
            ),
            SizedBox(height: SizeConfig.screenWidth * 0.015),
            InputField(
              hintText: "Email",
              controller: txtEmail,
              suffix: SvgPicture.asset(
                ThemeIcon.EDIT,
                color: COLORS.MEDIUM_DARK_GREY,
              ),
            ),
            SizedBox(height: SizeConfig.screenWidth * 0.015),
            InputField(
              hintText: "Password",
              controller: txtPass,
              obscureText: true,
              suffix: SvgPicture.asset(
                ThemeIcon.EDIT,
                color: COLORS.MEDIUM_DARK_GREY,
              ),
            ),
          ],
        ),
      );
    }

    Widget preferences() {
      TextStyle prefTxtStyle = Theme.of(context).textTheme.subtitle1.copyWith(
            fontWeight: FontWeight.w400,
            color: COLORS.MEDIUM_DARK_GREY,
          );
      return Container(
        margin: EdgeInsets.symmetric(
          horizontal: SizeConfig.screenWidth * 0.05,
          vertical: SizeConfig.screenWidth * 0.025,
        ),
        decoration: BoxDecoration(
          color: isDark ? COLORS.DARK_GREY : COLORS.LIGHTER_GREY,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(
                SizeConfig.screenWidth * 0.05,
                SizeConfig.screenWidth * 0.05,
                SizeConfig.screenWidth * 0.05,
                SizeConfig.screenWidth * 0.025,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Notifications", style: prefTxtStyle),
                  ThemeSwitch(
                    value: prefNotification,
                    onPress: () {
                      setState(() => prefNotification = !prefNotification);
                    },
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(
                SizeConfig.screenWidth * 0.05,
                SizeConfig.screenWidth * 0.025,
                SizeConfig.screenWidth * 0.05,
                SizeConfig.screenWidth * 0.05,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Newsletter", style: prefTxtStyle),
                  ThemeSwitch(
                    value: prefNewsletter,
                    onPress: () {
                      setState(() => prefNewsletter = !prefNewsletter);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return WillPopScope(
      onWillPop: () async => true,
      child: Scaffold(
          body: ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                height: 250.0,
                // color: Colors.white,
                child: Column(
                  children: <Widget>[
                    Padding(
                        padding: const EdgeInsets.only(left: 20.0, top: 20.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const <Widget>[
                            Icon(
                              Icons.arrow_back_ios,
                              // color: Colors.black,
                              size: 22.0,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 25.0),
                              child: Text('PROFILE',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0,
                                    // fontFamily: 'sans-serif-light',
                                    // color: Colors.black
                                  )),
                            )
                          ],
                        )),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Stack(fit: StackFit.loose, children: <Widget>[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                                width: 140.0,
                                height: 140.0,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image:
                                        ExactAssetImage('assets/images/as.png'),
                                    fit: BoxFit.cover,
                                  ),
                                )),
                          ],
                        ),
                        // Padding(
                        //     padding:
                        //         const EdgeInsets.only(top: 90.0, right: 100.0),
                        //     child: Row(
                        //       mainAxisAlignment: MainAxisAlignment.center,
                        //       children: const <Widget>[
                        //         CircleAvatar(
                        //           backgroundColor: Colors.red,
                        //           radius: 25.0,
                        //           child: Icon(
                        //             Icons.camera_alt,
                        //             color: Colors.white,
                        //           ),
                        //         )
                        //       ],
                        //     )),
                      ]),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 25.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                        padding: const EdgeInsets.only(
                            left: 25.0, right: 25.0, top: 25.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: const <Widget>[
                                Text(
                                  'Parsonal Information',
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                _status ? _getEditIcon() : Container(),
                              ],
                            )
                          ],
                        )),
                    Padding(
                        padding: const EdgeInsets.only(
                            left: 25.0, right: 25.0, top: 25.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: const <Widget>[
                                Text(
                                  'Name',
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        )),
                    Padding(
                        padding: const EdgeInsets.only(
                            left: 25.0, right: 25.0, top: 2.0),
                        child: Text(
                          "ABC Perera",
                          style: TextStyle(color: Colors.white),

                          // decoration: const InputDecoration(
                          //   hintText: "Enter Your Name",
                          // ),
                          // enabled: !_status,
                          // autofocus: !_status,
                        )),
                    Padding(
                        padding:
                            EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: const <Widget>[
                                Text(
                                  'Email ID',
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        )),
                    Padding(
                        padding:
                            EdgeInsets.only(left: 25.0, right: 25.0, top: 2.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Flexible(
                              child: TextField(
                                decoration: const InputDecoration(
                                    hintText: "Enter Email ID"),
                                enabled: !_status,
                              ),
                            ),
                          ],
                        )),
                    Padding(
                        padding:
                            EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text(
                                  'Mobile',
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        )),
                    Padding(
                        padding:
                            EdgeInsets.only(left: 25.0, right: 25.0, top: 2.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Flexible(
                              child: TextField(
                                decoration: const InputDecoration(
                                    hintText: "Enter Mobile Number"),
                                enabled: !_status,
                              ),
                            ),
                          ],
                        )),
                    Padding(
                        padding:
                            EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                child: Text(
                                  'Pin Code',
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              flex: 2,
                            ),
                            Expanded(
                              child: Container(
                                child: Text(
                                  'State',
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              flex: 2,
                            ),
                          ],
                        )),
                    Padding(
                        padding: const EdgeInsets.only(
                            left: 25.0, right: 25.0, top: 2.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Flexible(
                              child: Padding(
                                padding: EdgeInsets.only(right: 10.0),
                                child: TextField(
                                  decoration: const InputDecoration(
                                      hintText: "Enter Pin Code"),
                                  enabled: !_status,
                                ),
                              ),
                              flex: 2,
                            ),
                            Flexible(
                              child: TextField(
                                decoration: const InputDecoration(
                                    hintText: "Enter State"),
                                enabled: !_status,
                              ),
                              flex: 2,
                            ),
                          ],
                        )),
                    !_status ? _getActionButtons() : Container(),
                  ],
                ),
              )
            ],
          ),
        ],
      )),
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    myFocusNode.dispose();
    super.dispose();
  }

  Widget _getActionButtons() {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0, right: 25.0, top: 45.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: Container(
                  child: MaterialButton(
                child: Text("Save"),
                textColor: Colors.white,
                color: Colors.green,
                onPressed: () {
                  setState(() {
                    _status = true;
                    FocusScope.of(context).requestFocus(FocusNode());
                  });
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
              )),
            ),
            flex: 2,
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Container(
                  child: MaterialButton(
                child: const Text("Cancel"),
                textColor: Colors.white,
                color: Colors.red,
                onPressed: () {
                  setState(() {
                    _status = true;
                    FocusScope.of(context).requestFocus(FocusNode());
                  });
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
              )),
            ),
          ),
        ],
      ),
    );
  }

  Widget _getEditIcon() {
    return GestureDetector(
      child: const CircleAvatar(
        backgroundColor: Colors.red,
        radius: 14.0,
        child: Icon(
          Icons.edit,
          color: Colors.white,
          size: 16.0,
        ),
      ),
      onTap: () {
        setState(() {
          _status = false;
        });
      },
    );
  }
}
