import 'package:flutter/material.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  ScrollController controller;
  var items = <int>[];
  @override
  initState() {
    super.initState();
    controller = new ScrollController();
    controller.addListener((){
      double maxScroll = controller.position.maxScrollExtent;
      double currentScroll = controller.position.pixels;
      double delta = 200.0;
      if ( maxScroll - currentScroll <= delta) {
        var last = items[items.length-1];
        setState(() {
          for (var i = last; i <= last + 10; i++) {
            items.add(i);
          }
        });
      }
    });

    for (var i = 0; i <= 30; i++) {
      items.add(i);
    }
  }

  @override
  dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        child: new Container(
          child: new ListView.builder(
              controller: controller,
              itemCount: items.length,
                itemBuilder: (BuildContext ctxt, int index) {
                return new Text(items[index].toString(), style: new TextStyle(fontSize: 24));
            }
          ),
        ),
      )
    );
  }
}