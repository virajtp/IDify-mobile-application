import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../utils/globals.dart';
import '../utils/sizeconfig.dart';
import '../widgets/appBar.dart';
import '../widgets/bottom_curved_shadow.dart';

class RegLocations extends StatefulWidget {
  const RegLocations({Key key}) : super(key: key);

  @override
  State<RegLocations> createState() => _RegLocationsState();
}

class _RegLocationsState extends State<RegLocations> {
  bool isDark = false;
  String currentDarkModePref = "";

  List<RegisterLocation> RegLocations =
      []; // List to store fetched RegLocations

  @override
  void initState() {
    super.initState();
    fetchRegLocationsFromDatabase(); // Fetch RegLocations from the database
  }

  void fetchRegLocationsFromDatabase() {
    // Perform the necessary database queries or API calls to fetch RegLocations
    // Update the 'RegLocations' list with the retrieved data
    // For example:
    RegLocations = [
      RegisterLocation(
          description: "IDIFY - Registration Center",
          town: "Colombo 2",
          details: "Colombo 2"),
      RegisterLocation(
          description: "IDIFY - Registration Center",
          town: "Anuradhapura",
          details: "Anuradhapura"),
      RegisterLocation(
          description: "Department for Registrations of Persons",
          town: "Battaramulla",
          details: "Battaramulla"),
    ];
    // RegLocations = await DatabaseProvider.fetchRegLocations();
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

    void showTransactionDetails(RegisterLocation transaction) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(transaction.description),
            content: Text(transaction.details),
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
    }

    return Scaffold(
      body: Column(
        children: [
          Container(
            decoration: CurvedShadowDecoration.getDecoration(isDark: isDark),
            child: ThemeAppBar.appBar(context, title: "Register Locations"),
          ),
          Expanded(
            child: Container(
              // color: Color.fromARGB(255, 75, 72, 72),
              child: ListView.builder(
                itemCount: RegLocations.length,
                itemBuilder: (context, index) {
                  RegisterLocation transaction = RegLocations[index];
                  return Column(
                    children: [
                      const SizedBox(
                        height: 15,
                      ),
                      ListTile(
                        title: Text(
                          transaction.description,
                          style: TextStyle(
                              fontSize: 26, color: COLORS.LIGHTER_GREY),
                        ),
                        subtitle: Text(transaction.town.toString(),
                            style: TextStyle(
                                fontSize: 26, color: COLORS.LIGHT_GREY)),
                        onTap: () {
                          showTransactionDetails(transaction);
                        },
                        // Add more details or customize the list item as needed
                      ),
                    ],
                  );
                },
              ),
            ),
          ),

          SizedBox(height: SizeConfig.screenWidth * 0.05),
          // Expanded(child: settingsOptions()),
          // logOut(),
          SizedBox(height: SizeConfig.screenWidth * 0.025),
        ],
      ),
    );
  }
}

class RegisterLocation {
  final String description;
  final String town;
  final String details;

  RegisterLocation({this.description, this.town, this.details});
}
