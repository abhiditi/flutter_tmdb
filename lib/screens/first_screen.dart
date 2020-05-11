import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertmdb/style/theme.dart' as Style;
import 'package:fluttertmdb/widgets/popular.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScrenState createState() => _HomeScrenState();
}

class _HomeScrenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style.Colors.mainColor,
      body: Popular(),
    );
  }
}
