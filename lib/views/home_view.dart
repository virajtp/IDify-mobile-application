import 'package:flutter/material.dart';
import 'package:idify/utils/globals.dart';
import 'package:idify/utils/sizeconfig.dart';
import 'package:idify/views/grid_view/auth_home.dart';
import 'package:idify/views/grid_view/home.dart';
import 'package:idify/views/add_card.dart';
import 'package:idify/views/notifications.dart';
import 'package:idify/views/profile.dart';
import 'package:idify/views/settings/settings_view.dart';
import 'package:idify/views/survey_form.dart';
import 'package:idify/views/testing/test.dart';
import 'package:idify/views/transactions.dart';
import 'package:idify/views/user_account/user_account_mobile.dart';
import 'package:idify/widgets/bottom_navbar.dart';
import 'qr_scanner.dart';
import 'qr_view.dart';
import 'user_account/user_account.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class HomeView extends StatefulWidget {
  const HomeView({Key key, this.jsonData, this.isAuthority}) : super(key: key);
  // final Map<String, dynamic> jsonData;
  final List<dynamic> jsonData;
  final bool isAuthority;
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int index = 0;

  // List<Map<String, String>> jsonData;
  // List<dynamic> jsonData;

  int user_id = 1;

  // Future<void> fetchData() async {
  //   final response =
  //       await http.get(Uri.parse('http://192.168.8.155:8084/profile'));

  //   if (response.statusCode == 200) {
  //     print(response.body);
  //     jsonData = jsonDecode(response.body);
  //     print("hiiiiiiiiiiiiiiiiii");
  //     print(jsonData[0]["address"]);
  //     // Process the received data as needed
  //   } else {
  //     // Handle the error case
  //     print('Request failed with status: ${response.statusCode}');
  //   }
  // }

  @override
  void initState() {
    // fetchData();
    setState(() => index = Globals.homeNavStackIndex.getValue());
    Globals.homeNavStackIndex.listen(
      (value) {
        if (mounted) {
          setState(() {
            if (index != 4 && index != 7) {
              Globals.lastKnownHomeNavStackIndex.setValue(index);
            }
            index = value;
          });
        }
      },
    );
    super.initState();
  }

  Future<bool> _onBackPressed() async {
    if (index == 1) {
      Globals.homeNavStackIndex.setValue(0);
      return false;
    } else if (index == 3) {
      Globals.homeNavStackIndex.setValue(2);
      return false;
    } else if (index == 4) {
      int lastKnownIndex = Globals.lastKnownHomeNavStackIndex.getValue();
      Globals.homeNavStackIndex.setValue(lastKnownIndex);
      return false;
    } else if (index == 7) {
      Globals.homeNavStackIndex.setValue(0);
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    print(widget.jsonData[0]["uid"]);
    SizeConfig().init(context);
    List<Widget> content = [
      widget.isAuthority ? AuthHome() : Home(jsondata: widget.jsonData),
      TestScreen1(),
      // Transactions(),
      Notifications(),
      AddCard(),
      // SurveyForm(),
      // UserAccountAll(),

      widget.isAuthority ? QRScanner() : QRView(uid: widget.jsonData[0]["id"]),

      // DynamicForm(),
      // ABCForm(),
      // SurveyForm(),
      // SurveyPage(),
      UserAccount(userdata: widget.jsonData),
      Settings(),
    ];
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        body: widget.jsonData == ""
            ? const CircularProgressIndicator()
            : content[index],
        // Text("ssss"),
        bottomNavigationBar: BottomNavBar.bottomNavBar(context),
      ),
    );
  }
}
