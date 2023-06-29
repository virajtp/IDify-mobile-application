import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:awesome_card/awesome_card.dart';
import 'package:awesome_card/credit_card.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../theme/app_theme.dart';
import '../utils/globals.dart';
import '../utils/sizeconfig.dart';
import '../widgets/appBar.dart';
import '../widgets/bottom_curved_shadow.dart';
import 'dart:math' as math;

import '../widgets/button.dart';

class AddCard extends StatefulWidget {
  const AddCard({Key key}) : super(key: key);

  @override
  State<AddCard> createState() => _AddCardState();
}

class _AddCardState extends State<AddCard> {
  bool isDark = false;
  String currentDarkModePref = "";
  String cardNumber = '';
  String cardHolderName = '';
  String expiryDate = '';
  String cvv = '';
  bool showBack = false;

  FocusNode _focusNode;
  TextEditingController cardNumberCtrl = TextEditingController();
  TextEditingController expiryFieldCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      setState(() {
        _focusNode.hasFocus ? showBack = true : showBack = false;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: CurvedShadowDecoration.getDecoration(isDark: isDark),
              child: ThemeAppBar.appBar(context, title: "Add Card"),
            ),
            // const Text(
            //   "QR Code",
            //   style: TextStyle(fontSize: 20),
            // ),
            SizedBox(
              height: 40,
            ),
            CreditCard(
              cardNumber: cardNumber,
              cardExpiry: expiryDate,
              cardHolderName: cardHolderName,
              cvv: cvv,
              bankName: 'Axis Bank',
              showBackSide: showBack,
              frontBackground: CardBackgrounds.black,
              backBackground: CardBackgrounds.white,
              showShadow: true,
              // mask: getCardTypeMask(cardType: CardType.americanExpress),
            ),
            SizedBox(
              height: 40,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center, // Center vertically
              children: [
                // const SizedBox(
                //   height: 250,
                // ),
                // QrImage(
                //   data: "984253698V",
                //   size: 350,
                //   // embeddedImage: AssetImage('images/logo.png'),
                //   embeddedImageStyle: QrEmbeddedImageStyle(size: Size(80, 80)),
                // ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      child: TextFormField(
                        controller: cardNumberCtrl,
                        decoration: InputDecoration(hintText: 'Card Number'),
                        maxLength: 16,
                        onChanged: (value) {
                          final newCardNumber = value.trim();
                          var newStr = '';
                          final step = 4;

                          for (var i = 0; i < newCardNumber.length; i += step) {
                            newStr += newCardNumber.substring(
                                i, math.min(i + step, newCardNumber.length));
                            if (i + step < newCardNumber.length) newStr += ' ';
                          }

                          setState(() {
                            cardNumber = newStr;
                          });
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      child: TextFormField(
                        controller: expiryFieldCtrl,
                        decoration: InputDecoration(hintText: 'Card Expiry'),
                        maxLength: 5,
                        onChanged: (value) {
                          var newDateValue = value.trim();
                          final isPressingBackspace =
                              expiryDate.length > newDateValue.length;
                          final containsSlash = newDateValue.contains('/');

                          if (newDateValue.length >= 2 &&
                              !containsSlash &&
                              !isPressingBackspace) {
                            newDateValue = newDateValue.substring(0, 2) +
                                '/' +
                                newDateValue.substring(2);
                          }
                          setState(() {
                            expiryFieldCtrl.text = newDateValue;
                            expiryFieldCtrl.selection =
                                TextSelection.fromPosition(
                                    TextPosition(offset: newDateValue.length));
                            expiryDate = newDateValue;
                          });
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      child: TextFormField(
                        decoration:
                            InputDecoration(hintText: 'Card Holder Name'),
                        onChanged: (value) {
                          setState(() {
                            cardHolderName = value;
                          });
                        },
                      ),
                    ),
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                      child: TextFormField(
                        decoration: InputDecoration(hintText: 'CVV'),
                        maxLength: 3,
                        onChanged: (value) {
                          setState(() {
                            cvv = value;
                          });
                        },
                        focusNode: _focusNode,
                      ),
                    ),
                    SizedBox(height: SizeConfig.screenWidth * 0.15),
                    Container(
                      padding: EdgeInsets.symmetric(
                        vertical: SizeConfig.screenWidth * 0.05,
                      ),
                      child: Button(
                        title: "CONTINUE",
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
