import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  Home(this.text);
  final String text;
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(),
      body: Container(
        child: new Center(
          child: new Text(widget.text),
        ),
      ),
    );
  }
}
