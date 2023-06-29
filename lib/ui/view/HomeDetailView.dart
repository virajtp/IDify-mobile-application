import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class HomeDetailView extends StatefulWidget {
  final int id;

  const HomeDetailView({Key key, this.id}) : super(key: key);
  // const HomeDetailView({ required this.id});

  @override
  State<HomeDetailView> createState() => _HomeDetailViewState();
}

class _HomeDetailViewState extends State<HomeDetailView> {
  @override
  Widget build(BuildContext context) {
    print(context.routeData.pathParams.get("id"));
    return Scaffold(
      appBar: AppBar(title: const Text("Detail")),
      body: Column(children: const [Text("sssssss")]),
    );
  }
}
