import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:idify/views/survey_form.dart';
import '../theme/app_theme.dart';
import '../utils/globals.dart';
import '../utils/sizeconfig.dart';
import '../widgets/appBar.dart';
import '../widgets/bottom_curved_shadow.dart';

class Survey extends StatefulWidget {
  const Survey({Key key}) : super(key: key);

  @override
  State<Survey> createState() => _SurveyState();
}

class _SurveyState extends State<Survey> {
  bool isDark = false;
  String currentDarkModePref = "";

  List<Transaction> transactions = [];
  final List<String> items = [
    'Survey About Agriculture',
    'Survey About Helth of Children',
    'Survey About Self Employers'
  ]; // List to store fetched transactions

  @override
  void initState() {
    super.initState();
    fetchSurveyFromDatabase(); // Fetch transactions from the database
  }

  void fetchSurveyFromDatabase() {
    // Perform the necessary database queries or API calls to fetch transactions
    // Update the 'transactions' list with the retrieved data
    // For example:
    transactions = [
      Transaction(
          description: "Payment 1",
          amount: 100.0,
          details: "Payment details 1"),
      Transaction(
          description: "Payment 2",
          amount: 200.0,
          details: "Payment details 2"),
      Transaction(
          description: "Payment 3",
          amount: 300.0,
          details: "Payment details 3"),
    ];
    // transactions = await DatabaseProvider.fetchSurvey();
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

    void showTransactionDetails(Transaction transaction) {
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
            child: ThemeAppBar.appBar(context, title: "Survey"),
          ),
          Expanded(
            child: Container(
              // color: Color.fromARGB(255, 75, 72, 72),
              child: ListView.builder(
                itemCount: transactions.length,
                itemBuilder: (context, index) {
                  Transaction transaction = transactions[index];
                  return Container(
                    padding: EdgeInsets.fromLTRB(20, 30, 20, 10),
                    child: ListTile(
                      title: Text(
                        items[index],
                        style:
                            TextStyle(fontSize: 26, color: COLORS.LIGHTER_GREY),
                      ),
                      onTap: () {
                        // Handle item click
                        // print('Clicked: ${items[index]}');
                        context.router.pushNamed("/SurveyForm");
                        // SurveyForm();
                      },
                    ),
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

class Transaction {
  final String description;
  final double amount;
  final String details;

  Transaction({this.description, this.amount, this.details});
}
