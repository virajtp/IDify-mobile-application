import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../utils/globals.dart';
import '../../utils/sizeconfig.dart';
import '../../widgets/appBar.dart';
import '../../widgets/bottom_curved_shadow.dart';

class UserAccount extends StatefulWidget {
  const UserAccount({Key key, this.userdata}) : super(key: key);

  // final List<dynamic> userdata;
  // final Map<String, dynamic> userdata;
  final List<dynamic> userdata;

  @override
  State<UserAccount> createState() => _UserAccountState();
}

class _UserAccountState extends State<UserAccount> {
  bool isDark = false;
  String currentDarkModePref = "";

  final FocusNode myFocusNode = FocusNode();
  bool _status = true;

  Widget _buildSingleContainer({String startText, String endText}) {
    print(widget.userdata);
    return Column(
      children: [
        Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          child: Container(
            decoration: BoxDecoration(
                // color: _status == true ? color : Colors.white,
                // borderRadius: _status == false
                //     ? BorderRadius.circular(30)
                //     : BorderRadius.circular(0),
                ),
            width: double.infinity,
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(20.0, 15.0, 0.0, 15.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "$startText : ",
                      style: TextStyle(fontSize: 25, color: Colors.black45),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Container(
                    // width: MediaQuery.of(context).size.width * 0.8,
                    padding: EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 15.0),
                    child: Text(
                      endText,
                      style: const TextStyle(
                        fontSize: 25,
                      ),
                      softWrap: false,
                      maxLines: 2,
                      overflow: TextOverflow.fade,
                    ))
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 15,
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // SizeConfig().init(context);
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
            child: ThemeAppBar.appBar(context, title: "USER PROFILE"),
          ),
          SizedBox(height: SizeConfig.screenWidth * 0.05),
          Container(
            // height: 250.0,
            // color: Colors.white,

            child: Column(
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.only(left: 20.0, top: 20.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const <Widget>[
                        // Icon(
                        //   Icons.arrow_back_ios,
                        //   // color: Colors.black,
                        //   size: 22.0,
                        // ),
                        // Padding(
                        //   padding: EdgeInsets.only(left: 25.0),
                        //   child: Text('PROFILE',
                        //       style: TextStyle(
                        //         fontWeight: FontWeight.bold,
                        //         fontSize: 20.0,
                        //         // fontFamily: 'sans-serif-light',
                        //         // color: Colors.black
                        //       )),
                        // )
                      ],
                    )),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Stack(fit: StackFit.loose, children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        // Container(
                        //     width: 140.0,
                        //     height: 140.0,
                        //     decoration: const BoxDecoration(
                        //       shape: BoxShape.circle,
                        //       image: DecorationImage(
                        //         // image: NetworkImage(widget.userdata[0]["url"]),
                        //         image: ExactAssetImage('assets/images/as.png'),
                        //         fit: BoxFit.cover,
                        //       ),
                        //     )),
                        CircleAvatar(
                          radius: 70,
                          // backgroundImage: NetworkImage(widget.jsonData["imageUrl"]),
                          backgroundImage:
                              NetworkImage(widget.userdata[0]["url"]),

                          // backgroundImage: AssetImage('assets/images/as.png'),
                        ),
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
          const SizedBox(
            height: 25,
          ),
          FractionallySizedBox(
            widthFactor: 0.7,
            child: Column(
              children: [
                _buildSingleContainer(
                  endText: widget.userdata[0]["name"],
                  // endText: "ABC Perera",
                  startText: "Name",
                ),
                _buildSingleContainer(
                  endText: widget.userdata[0]["email"],
                  // endText: "abc@gmail.com",
                  startText: "Email",
                ),
                _buildSingleContainer(
                  endText: widget.userdata[0]['phone'],
                  // endText: "0701234567",
                  startText: "Phone",
                ),
                _buildSingleContainer(
                  // endText: widget.userdata[0]['address'],
                  // endText: "No64, Wewala, Horana",
                  endText: "Millewa, Horana",
                  startText: "Address",
                ),
                // dataField('Address', "No64, Wewala, Horana"),
                _buildSingleContainer(
                  endText: widget.userdata[0]['occupation'],
                  // endText: "Proffesor",
                  startText: "Occupation",
                ),
                _buildSingleContainer(
                  endText: widget.userdata[0]['dob'],
                  // endText: "01/01/1980",
                  startText: "Birthday",
                ),
              ],
            ),
          ),
          !_status ? _getActionButtons() : Container(),
        ],
      ),
    );
  }

// uid
// Name
// FullName
// Email
// Phone
// Gender
// Address
// Dob
// Occupation

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
