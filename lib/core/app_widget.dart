// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:idify/injection.dart';
// import 'package:idify/router/app_router.gr.dart';

// class AppWidget extends StatelessWidget {
//   final _appRouter = getIt<AppRouter>();

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp.router(
//       title: 'Routing Flutter',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData.light().copyWith(
//           inputDecorationTheme: InputDecorationTheme(border: InputBorder.none)),
//       routerDelegate: _appRouter.delegate(),
//       routeInformationParser: _appRouter.defaultRouteParser(),
//     );
//   }
// }
