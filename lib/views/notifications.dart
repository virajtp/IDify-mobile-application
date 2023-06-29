import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../theme/app_theme.dart';
import '../utils/globals.dart';
import '../utils/sizeconfig.dart';
import '../widgets/appBar.dart';
import '../widgets/bottom_curved_shadow.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key key}) : super(key: key);

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  bool isDark = false;
  String currentDarkModePref = "";

  List<Transaction> transactions = []; // List to store fetched transactions

  @override
  void initState() {
    super.initState();
    fetchNotificationsFromDatabase(); // Fetch transactions from the database
  }

  void fetchNotificationsFromDatabase() {
    // Perform the necessary database queries or API calls to fetch transactions
    // Update the 'transactions' list with the retrieved data
    // For example:
    transactions = [
      Transaction(
          description: "New Survey added.",
          amount: "A survey about children's health is added",
          details: "Payment details 1"),
      Transaction(
          description: "Bank transaction is Successfull.",
          amount: "ABC Bank - AC 2536987",
          details: "ABC Bank - AC 2536987"),
      // Transaction(
      //     description: "Payment 3",
      //     amount: 300.0,
      //     details: "Payment details 3"),
    ];
    // transactions = await DatabaseProvider.fetchNotifications();
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
            child: ThemeAppBar.appBar(context, title: "Notifications"),
          ),
          Expanded(
            child: Container(
              // color: Color.fromARGB(255, 75, 72, 72),
              child: ListView.builder(
                itemCount: transactions.length,
                itemBuilder: (context, index) {
                  Transaction transaction = transactions[index];
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
                        subtitle: Text(transaction.amount.toString(),
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
            // child: ListView(
            //   padding: const EdgeInsets.all(8),
            //   children: <Widget>[
            //     Container(
            //       height: 50,
            //       color: Colors.amber[600],
            //       child: const Center(child: Text('Entry A')),
            //     ),
            //     Container(
            //       height: 50,
            //       color: Colors.amber[500],
            //       child: const Center(child: Text('Entry B')),
            //     ),
            //     Container(
            //       height: 50,
            //       color: Colors.amber[100],
            //       child: const Center(child: Text('Entry C')),
            //     ),
            //   ],
            // ),
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
  final String amount;
  final String details;

  Transaction({this.description, this.amount, this.details});
}
