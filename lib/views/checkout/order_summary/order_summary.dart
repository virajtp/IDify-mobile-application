// import 'package:adaptive_theme/adaptive_theme.dart';
// import 'package:flutter/material.dart';
// import 'package:idify/models/cart_item.dart';
// import 'package:idify/models/paragraph.dart';
// import 'package:idify/theme/app_theme.dart';
// import 'package:idify/theme/images.dart';
// import 'package:idify/utils/globals.dart';
// import 'package:idify/utils/sizeconfig.dart';
// import 'package:idify/widgets/cart_item_tile.dart';
// import 'package:idify/widgets/input_field.dart';

// class OrderSummary extends StatefulWidget {
//   const OrderSummary({Key key}) : super(key: key);

//   @override
//   _OrderSummaryState createState() => _OrderSummaryState();
// }

// class _OrderSummaryState extends State<OrderSummary> {
//   bool isDark = false;

//   List<CartItem> cartItems = [
//     CartItem(
//       imagePath: StoreImages.broccoli,
//       text: "Broccoli",
//       quantity: "2 heads",
//       price: "£0.80",
//     ),
//     CartItem(
//       imagePath: StoreImages.kale,
//       text: "Kale",
//       quantity: "300g",
//       price: "£3.00",
//     ),
//     CartItem(
//       imagePath: StoreImages.pepper,
//       text: "Red Peppers",
//       quantity: "5",
//       price: "£1.50",
//     ),
//     CartItem(
//       imagePath: StoreImages.strawberry,
//       text: "Strawberries",
//       quantity: "2 punnets",
//       price: "£4.00",
//     ),
//   ];
//   List<Para> summary = [
//     Para(title: "Sub-total", desc: "£9.30"),
//     Para(title: "Delivery", desc: "Standard(free)"),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     SizeConfig().init(context);
//     if (AdaptiveTheme.of(context).mode == AdaptiveThemeMode.system) {
//       setState(() => isDark = Globals.systemDarkMode.getValue());
//     } else if (AdaptiveTheme.of(context).mode == AdaptiveThemeMode.dark) {
//       setState(() => isDark = true);
//     } else {
//       setState(() => isDark = false);
//     }

//     Widget cartItems() {
//       List<Widget> cartList = [];

//       this.cartItems.forEach((item) {
//         Widget card = ItemTile(
//           isDark: isDark,
//           itemDetails: item,
//         );
//         cartList.add(card);
//       });

//       return Container(
//         margin: EdgeInsets.only(top: SizeConfig.screenWidth * 0.03),
//         width: SizeConfig.screenWidth * 0.85,
//         alignment: Alignment.center,
//         child: Column(
//           children: cartList,
//         ),
//       );
//     }

//     Widget summary() {
//       List<Widget> summaryList = [];

//       TextStyle txtStyle = TextStyle(
//         color: COLORS.MEDIUM_DARK_GREY,
//         fontSize: Theme.of(context).textTheme.subtitle1.fontSize,
//       );

//       TextStyle totalTxtStyle = txtStyle.copyWith(
//         fontSize: Theme.of(context).textTheme.headline6.fontSize,
//       );

//       this.summary.forEach((element) {
//         Widget row = Container(
//           child: Row(
//             children: [
//               Text(element.title, style: txtStyle),
//               Expanded(
//                 child: Text(
//                   element.desc,
//                   textAlign: TextAlign.right,
//                   style: txtStyle,
//                 ),
//               ),
//             ],
//           ),
//         );

//         summaryList.add(row);
//         summaryList.add(SizedBox(height: SizeConfig.screenWidth * 0.025));
//       });

//       return Container(
//         width: SizeConfig.screenWidth * 0.85,
//         alignment: Alignment.center,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.end,
//           children: [
//             ...summaryList,
//             Row(
//               children: [
//                 Text("Total", style: totalTxtStyle),
//                 Expanded(
//                   child: Text(
//                     "£9.30",
//                     textAlign: TextAlign.right,
//                     style: totalTxtStyle,
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       );
//     }

//     return Container(
//       alignment: Alignment.center,
//       margin: EdgeInsets.all(SizeConfig.screenWidth * 0.05),
//       child: SingleChildScrollView(
//         child: Column(
//           children: [
//             SizedBox(height: SizeConfig.screenWidth * 0.025),
//             AbsorbPointer(child: cartItems()),
//             SizedBox(height: SizeConfig.screenWidth * 0.05),
//             Container(
//               width: SizeConfig.screenWidth * 0.85,
//               child: InputField(hintText: "Coupon Code"),
//             ),
//             SizedBox(height: SizeConfig.screenWidth * 0.05),
//             summary(),
//             SizedBox(height: SizeConfig.screenWidth * 0.025),
//           ],
//         ),
//       ),
//     );
//   }
// }
