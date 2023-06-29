import 'dart:convert';
// import 'package:idify/ui/view/HomeView.dart';

// import '../views/home_view.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:idify/router/app_router.gr.dart';
import 'package:idify/theme/app_theme.dart';
import 'package:idify/theme/images.dart';
import 'package:idify/utils/globals.dart';
import 'package:idify/utils/sizeconfig.dart';
import 'package:idify/widgets/bottom_curved_shadow.dart';
import 'package:idify/widgets/button.dart';
import 'package:idify/widgets/input_field.dart';
import 'package:http/http.dart' as http;

import '../shared/ipAddress.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  static List<Widget> signIn = [];
  static List<Widget> signUp = [];

  static bool isSignUp = false;

  bool isDark = false;

  double bottomBoxH = AppBar().preferredSize.height * 2;

  // Map<String, dynamic> jsonData;

  List<dynamic> jsonData;

  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  void toast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      textColor: Colors.black,
      fontSize: 16,
      backgroundColor: Colors.grey[200],
    );
  }

  Future<bool> fetchData(String email, String pw) async {
    // final response =
    //     await http.get(Uri.parse('http://${IP_ADDRESS}:8084/profile/${uid}'));

    // final response = await http.get(Uri.parse('http://10.34.18.249:5004/data/${email}'));

    // final Map<String, dynamic> requestBody = {
    //   "uid": "4317194c-09a6-11ee-9b18-0242ac110003"
    // };
    final response = await http.post(
      Uri.parse('http://10.34.18.249:5004/profile'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{"email": "${email}"}),
    );

    // final encodedParams = Uri.encodeQueryComponent(jsonEncode(requestBody));
    // // final url =
    // //     Uri.parse('http://${IP_ADDRESS}:8084/profile/$uid?$encodedParams');

    // final url = Uri.parse('http://10.34.18.249:5004/data?$encodedParams');

    // final response = await http.get(url);

    if (response.statusCode == 200) {
      print(response.body);
      jsonData = jsonDecode(response.body);

      if (jsonData[0]["password"] == pw) {
        print("TRUUUUUUUUUUUUUUUUU");
        return true;
      }
      // Process the received data as needed
    } else {
      print(response.body);
      // Handle the error case
      print('Request failed with status: ${response.statusCode}');
      return false;
    }
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

    signIn = [
      SizedBox(height: 100),
      Text(
        "WELCOME",
        style: TextStyle(
          fontSize: Theme.of(context).textTheme.headline2.fontSize,
          color: COLORS.GREEN,
        ),
      ),
      SizedBox(height: 25),
      isDark
          ? Image.asset('./assets/images/idify_logo_white.png')
          : Image.asset('./assets/images/idify_logo_black.png'),
      SizedBox(height: 25),
      Text("User Login",
          style: TextStyle(
            fontSize: Theme.of(context).textTheme.headline6.fontSize,
            color: COLORS.WHITE,
          )),
      SizedBox(height: 25),
      InputField(
        prefix: SvgPicture.asset(ThemeIcon.MAIL),
        hintText: "Email",
        controller: _email,
      ),
      SizedBox(height: 25),
      InputField(
        prefix: SvgPicture.asset(ThemeIcon.PADLOCK),
        hintText: "Password",
        obscureText: true,
        controller: _password,
      ),
      SizedBox(height: 25),
      CleanButton(
        title: "Forgot Password?",
        onPressed: () => context.router.pushNamed("/ForgetPassword"),
      ),
      SizedBox(height: 30),
      Button(
          title: "SIGN IN",
          onPressed: () async {
            final String email = _email.text.trim();
            final String password = _password.text.trim();
            // await fetchData("a1111", "12345");
            // await fetchData(email, password);
            // context.router
            //     .push(HomeView(jsonData: jsonData, isAuthority: false));

            await fetchData(email, password) == true
                // ? context.router.pushNamed("/HomeView")
                ? context.router
                    .push(HomeView(jsonData: jsonData, isAuthority: false))
                : toast("Invalid");
          }),
      SizedBox(height: 100),
    ];
    signUp = [
      SizedBox(height: 100),
      Text(
        "WELCOME",
        style: TextStyle(
          fontSize: Theme.of(context).textTheme.headline2.fontSize,
          color: COLORS.GREEN,
        ),
      ),
      SizedBox(height: 25),
      isDark
          ? Image.asset('./assets/images/idify_logo_white.png')
          : Image.asset('./assets/images/idify_logo_black.png'),
      SizedBox(height: 25),
      Text("Authority Login",
          style: TextStyle(
            fontSize: Theme.of(context).textTheme.headline6.fontSize,
            color: COLORS.WHITE,
          )),
      SizedBox(height: 25),
      InputField(
        prefix: SvgPicture.asset(ThemeIcon.MAIL),
        hintText: "Email",
        controller: _email,
      ),
      SizedBox(height: 25),
      InputField(
        prefix: SvgPicture.asset(ThemeIcon.PADLOCK),
        hintText: "Password",
        obscureText: true,
        controller: _password,
      ),
      SizedBox(height: 25),
      CleanButton(
        title: "Forgot Password?",
        onPressed: () => context.router.pushNamed("/ForgetPassword"),
      ),
      SizedBox(height: 30),
      Button(
          title: "SIGN IN",
          onPressed: () async {
            final String email = _email.text.trim();
            final String password = _password.text.trim();
            // await fetchData("a1111", "12345");
            // await fetchData(email, password);
            // context.router
            //     .push(HomeView(jsonData: jsonData, isAuthority: false));

            await fetchData(email, password) == true
                // ? context.router.pushNamed("/HomeView")
                ? context.router
                    .push(HomeView(jsonData: jsonData, isAuthority: true))
                : toast("Invalid");
          }),
      SizedBox(height: 100),
    ];

    return Scaffold(
      body: Stack(
        children: [
          /* bottom text button to switch from sign in <-> sign up */
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: bottomBoxH,
              padding: EdgeInsets.only(top: bottomBoxH * 0.15),
              child: Center(
                child: CleanButton(
                  // title: "SIGN IN",
                  title: isSignUp ? "USER LOGIN" : "AUTHORITY LOGIN",
                  onPressed: () {
                    setState(() => isSignUp = !isSignUp);
                  },
                ),
              ),
            ),
          ),
          /* scroll view */
          Column(
            children: [
              Expanded(
                child: Container(
                  width: SizeConfig.screenWidth,
                  padding: EdgeInsets.only(
                    left: SizeConfig.screenWidth * 0.1,
                    right: SizeConfig.screenWidth * 0.1,
                  ),
                  decoration: CurvedShadowDecoration.getDecoration(
                    isDark: isDark,
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 50),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: isSignUp ? signUp : signIn,
                          ),
                        ),
                      ),
                      SizedBox(height: 50),
                    ],
                  ),
                ),
              ),
              SizedBox(height: bottomBoxH),
            ],
          ),
          /* close button for create account case */
          AnimatedOpacity(
            duration: new Duration(milliseconds: 500),
            opacity: isSignUp ? 1 : 0,
            curve: Curves.fastOutSlowIn,
            child: Align(
              alignment: Alignment.topRight,
              child: Container(
                margin: EdgeInsets.only(
                  top: SizeConfig.screenWidth * 0.15,
                  right: SizeConfig.screenWidth * 0.1,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(35)),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      splashColor: COLORS.GREEN,
                      onTap: () {
                        setState(() => isSignUp = false);
                      },
                      child: Container(
                        height: 35,
                        width: 35,
                        padding: EdgeInsets.all(10),
                        child: SvgPicture.asset(ThemeIcon.CLOSE),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
