import 'package:flutter/material.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({Key? key, this.title = ''}) : super(key: key);

  final String title;

  @override
  State<StatefulWidget> createState() => DrawerWidgetState();
}

class DrawerWidgetState extends State<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
    return const Drawer(
      child: Text("测试了一下"),
    );
  }
}
