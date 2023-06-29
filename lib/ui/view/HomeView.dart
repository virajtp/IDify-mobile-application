import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  // const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  // late final TextEditingController? emailController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("AppBar")),
      body: Column(children: [
        const Text("Abcd Efgh"),
        TextButton(
            onPressed: () {
              context.router.pushNamed("/detail/100");
            },
            child: Text("AAAA")),
        TextButton(
            onPressed: () {
              context.router.pushNamed("/login");
            },
            child: Text("AAAA")),
      ]),
    );
  }
}
