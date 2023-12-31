import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:idify/theme/app_theme.dart';
import 'package:idify/theme/images.dart';
import 'package:idify/utils/globals.dart';
import 'package:idify/utils/sizeconfig.dart';
import 'package:idify/views/checkout/delivery_options/delivery_options.dart';
import 'package:idify/views/checkout/order_summary/order_summary.dart';
import 'package:idify/views/checkout/payment_method/payment_method.dart';
import 'package:idify/widgets/appBar.dart';
import 'package:idify/widgets/bottom_curved_shadow.dart';
import 'package:idify/widgets/button.dart';
import 'package:idify/widgets/menu_bar.dart';

import 'delivery_address/delivery_address.dart';

class CheckoutMobilePortrait extends StatefulWidget {
  const CheckoutMobilePortrait({Key key}) : super(key: key);

  @override
  _CheckoutMobilePortraitState createState() => _CheckoutMobilePortraitState();
}

class _CheckoutMobilePortraitState extends State<CheckoutMobilePortrait> {
  bool isDark = false;
  String title = "Delivery Address";
  // KeyboardVisibilityController _keyboardVisibilityController;
  bool buttonVisibility = true;

  @override
  void initState() {
    super.initState();
    Globals.checkoutMenuController.listen((value) {
      String title;
      if (value == 0)
        title = "Delivery Address";
      else if (value == 1)
        title = "Delivery Options";
      else if (value == 2)
        title = "Payment Method";
      else if (value == 3) title = "Order Summary";
      setState(() => this.title = title);
    });
    // _keyboardVisibilityController = new KeyboardVisibilityController();
    // _keyboardVisibilityController.onChange.listen((event) {
    //   setState(() => buttonVisibility = !event);
    // });
  }

  Future<bool> _onBackPressed() async {
    if (Globals.checkoutMenuController.getValue() != 0) {
      int v = Globals.checkoutMenuController.getValue() - 1;
      Globals.checkoutMenuController.setValue(v);
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    if (AdaptiveTheme.of(context).mode == AdaptiveThemeMode.system) {
      setState(() => isDark = Globals.systemDarkMode.getValue());
    } else if (AdaptiveTheme.of(context).mode == AdaptiveThemeMode.dark) {
      setState(() => isDark = true);
    } else {
      setState(() => isDark = false);
    }
    Widget appBar = Container(
      decoration: CurvedShadowDecoration.getDecoration(
        isDark: isDark,
      ),
      child: Column(
        children: [
          ThemeAppBar.appBar(
            context,
            title: title,
            leading: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(55)),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  splashColor: COLORS.GREEN,
                  onTap: () async {
                    if (await _onBackPressed()) Navigator.of(context).pop();
                  },
                  child: Container(
                    padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                    height: 35,
                    width: 55,
                    decoration: BoxDecoration(shape: BoxShape.circle),
                    child: SvgPicture.asset(
                      ThemeIcon.ARROW,
                      color: COLORS.MEDIUM_DARK_GREY,
                    ),
                  ),
                ),
              ),
            ),
          ),
          MenuBar.menuBarIcons(
            context,
            icons: [
              ThemeIcon.LOCATION,
              ThemeIcon.DELIVERY,
              ThemeIcon.PAYMENT,
              ThemeIcon.SUMMARY,
            ],
            controller: Globals.checkoutMenuController,
          ),
        ],
      ),
    );
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        body: Column(
          children: [
            appBar,
            Expanded(
              child: IndexedStack(
                children: [
                  DeliveryAddress(),
                  DeliveryOptions(),
                  PaymentMethod(),
                  // OrderSummary(),
                ],
                index: Globals.checkoutMenuController.getValue(),
              ),
            ),
            AnimatedContainer(
              duration: Duration(milliseconds: 100),
              height: buttonVisibility ? 56 : 0,
              margin: EdgeInsets.all(SizeConfig.screenWidth * 0.05),
              child: Button(
                title: Globals.checkoutMenuController.getValue() == 3
                    ? "PLACE ORDER"
                    : "CONTINUE",
                onPressed: () {
                  if (Globals.checkoutMenuController.getValue() != 3) {
                    int val = Globals.checkoutMenuController.getValue();
                    Globals.checkoutMenuController.setValue(val + 1);
                  } else {
                    Globals.homeNavStackIndex.setValue(7);
                    Navigator.of(context).pop();
                    Globals.checkoutMenuController.setValue(0);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
