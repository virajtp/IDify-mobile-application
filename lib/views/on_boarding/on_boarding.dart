import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:idify/theme/app_theme.dart';
import 'package:idify/theme/images.dart';
import 'package:idify/utils/globals.dart';
import 'package:idify/utils/sizeconfig.dart';
import 'package:idify/views/home_view.dart';
import 'package:idify/widgets/bottom_curved_shadow.dart';
import 'package:idify/widgets/button.dart';
import 'package:idify/widgets/switch.dart';
import '../../router/app_router.gr.dart';

class OnBoarding extends StatefulWidget {
  @override
  _OnBoardingState createState() =>
      _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  List<Slide> slides = [
    Slide(
      imagePath: Images.onBoarding_1,
      caption: "Quickly search and add healthy foods to your cart",
    ),
    Slide(
      imagePath: Images.onBoarding_2,
      caption:
          "With one click you can add every ingredient for a recipe to your cart",
    ),
  ];
  List<RecipePreferences> recipePreferences = [
    RecipePreferences(preference: "All", value: false),
    RecipePreferences(preference: "Vegan", value: true),
    RecipePreferences(preference: "Vegetarian", value: true),
    RecipePreferences(preference: "Paleo", value: false),
    RecipePreferences(preference: "Keto", value: true),
    RecipePreferences(preference: "Low Carb", value: false),
  ];
  final SwiperController _slideController = SwiperController();

  bool isDark = false;
  double bottomBoxH = AppBar().preferredSize.height * 2;

  @override
  void initState() {
    setState(() => _slideController.index = 0);
    super.initState();
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

    slides = [
      Slide(
        imagePath: isDark ? Images.onBoarding_Dark_1 : Images.onBoarding_1,
        caption: "Quickly search and add healthy foods to your cart",
      ),
      Slide(
        imagePath: isDark ? Images.onBoarding_Dark_2 : Images.onBoarding_2,
        caption:
            "With one click you can add every ingredient for a recipe to your cart",
      ),
    ];
    Widget customPagination = Container(
      margin: EdgeInsets.only(top: 25, bottom: 25),
      height: 20,
      width: 100,
      alignment: Alignment.center,
      child: ListView.builder(
        padding: EdgeInsets.zero,
        scrollDirection: Axis.horizontal,
        itemCount: 3,
        shrinkWrap: true,
        itemBuilder: (context, index) => Align(
          alignment: Alignment.center,
          child: AnimatedContainer(
            duration: new Duration(milliseconds: 500),
            curve: Curves.easeInCubic,
            height: 10,
            width: 10,
            margin: EdgeInsets.all(3),
            decoration: BoxDecoration(
              color: (_slideController.index) == index
                  ? COLORS.MEDIUM_GREY
                  : Color(0xFFA6B8C9).withOpacity(0.3),
              shape: BoxShape.circle,
            ),
          ),
        ),
      ),
    );
    Widget onBoardingSwiper = Swiper(
      controller: _slideController,
      onIndexChanged: (value) {
        setState(() {
          _slideController.index = value;
        });
      },
      itemCount: 3,
      itemBuilder: (context, index) {
        TextStyle captionTextStyle = TextStyle(
          fontSize: Theme.of(context).textTheme.subtitle1.fontSize,
          color: COLORS.MEDIUM_GREY,
        );
        /* image with caption */
        if (index != 2) {
          return Container(
            color: Colors.transparent,
            padding: EdgeInsets.only(
              left: SizeConfig.screenWidth * 0.1,
              right: SizeConfig.screenWidth * 0.1,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(height: 25),
                Container(
                  alignment: Alignment.center,
                  width: SizeConfig.screenWidth,
                  child: SvgPicture.asset(
                    slides[index].imagePath,
                    fit: BoxFit.fitWidth,
                  ),
                ),
                Text(
                  slides[index].caption,
                  textAlign: TextAlign.center,
                  style: captionTextStyle,
                ),
              ],
            ),
          );
        }
        /* recipe preferences */
        else {
          TextStyle titleTextStyle = TextStyle(
            fontSize: Theme.of(context).textTheme.headline6.fontSize,
            color: COLORS.MEDIUM_GREY,
          );
          TextStyle descTextStyle = TextStyle(
            fontSize: Theme.of(context).textTheme.subtitle1.fontSize,
            color: COLORS.MEDIUM_GREY,
          );
          List<Widget> elements = [
            Container(
              padding: EdgeInsets.only(top: 50),
              child: Text(
                "Recipe Preferences",
                style: titleTextStyle,
              ),
            ),
          ];

          List<Widget> scrollItems = [];
          recipePreferences.forEach((element) {
            scrollItems.add(
              Container(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(element.preference, style: descTextStyle),
                    ThemeSwitch(
                      value: element.value,
                      onPress: () {
                        /* change all */
                        if (recipePreferences.indexOf(element) == 0) {
                          bool v = !element.value;
                          recipePreferences.forEach((e) {
                            setState(() {
                              e.value = v;
                            });
                          });
                        }
                        /* change individual */
                        else {
                          setState(() {
                            element.value = !element.value;
                          });
                        }
                      },
                    ),
                  ],
                ),
              ),
            );
          });

          elements.add(SingleChildScrollView(
            child: Column(children: scrollItems),
          ));

          elements.add(Text(
            "Tailor your Recipes feed exactly how you like it",
            textAlign: TextAlign.center,
            style: descTextStyle,
          ));
          return Container(
            color: Colors.transparent,
            padding: EdgeInsets.only(
              left: SizeConfig.screenWidth * 0.1,
              right: SizeConfig.screenWidth * 0.1,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: elements,
            ),
          );
        }
      },
      loop: false,
      curve: Curves.fastOutSlowIn,
      autoplay: false,
    );
    return Scaffold(
      body: Stack(
        children: [
          /* skip button at bottom */
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: bottomBoxH,
              width: SizeConfig.screenWidth * 0.8,
              padding: EdgeInsets.only(top: bottomBoxH * 0.15),
              child: Center(
                child: _slideController.index != 2
                    ? CleanButton(
                        title: "SKIP",
                        onPressed: () {
                          setState(() {
                            _slideController.move(2, animation: true);
                          });
                        },
                      )
                    : Button(
                        title: "GET STARTED",
                        onPressed: () => context.router.pushNamed("/HomeView")),
              ),
            ),
          ),
          /* main content */
          Column(
            children: [
              Expanded(
                child: Container(
                  decoration: CurvedShadowDecoration.getDecoration(
                    isDark: isDark,
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(
                          width: SizeConfig.screenWidth,
                          child: onBoardingSwiper,
                        ),
                      ),
                      customPagination,
                    ],
                  ),
                ),
              ),
              SizedBox(height: bottomBoxH),
            ],
          ),
        ],
      ),
    );
  }
}

class Slide {
  final String imagePath;
  final String caption;

  Slide({@required this.imagePath, @required this.caption});
}

class RecipePreferences {
  String preference;
  bool value;

  RecipePreferences({@required this.preference, @required this.value});
}
