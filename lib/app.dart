import 'package:app_layout/collapseSimple.dart';
import 'package:app_layout/collapseWeekCalendar.dart';
import 'package:flutter/material.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  ScrollController _scrollController;
  double delta = 0;
  bool _close = false;

  @override
    void initState() {
      super.initState();
      _scrollController = new ScrollController();
    }
  @override
  Widget build(BuildContext context) {
    var mediaQuey = MediaQuery.of(context);
    return new Scaffold(
        body: new Column(
      children: <Widget>[
        new Container(padding: new EdgeInsets.only(top: mediaQuey.padding.top)),
        new CollapseSimple(mediaQuey, 100, _scrollController),
        new CollapseWeekCalendar(mediaQuey, 40, _scrollController, Colors.white, Colors.black),
        new Flexible(
          child: new ListView(
            controller: _scrollController,
            children: <Widget>[
              new Text(
                "1",
                style: new TextStyle(fontSize: 40),
              ),
              new Text(
                "1",
                style: new TextStyle(fontSize: 40),
              ),
              new Text(
                "1",
                style: new TextStyle(fontSize: 40),
              ),
              new Text(
                "1",
                style: new TextStyle(fontSize: 40),
              ),
              new Text(
                "1",
                style: new TextStyle(fontSize: 40),
              ),
              new Text(
                "1",
                style: new TextStyle(fontSize: 40),
              ),
              new Text(
                "1",
                style: new TextStyle(fontSize: 40),
              ),
              new Text(
                "1",
                style: new TextStyle(fontSize: 40),
              ),
              new Text(
                "1",
                style: new TextStyle(fontSize: 40),
              ),
              new Text(
                "1",
                style: new TextStyle(fontSize: 40),
              ),
              new Text(
                "1",
                style: new TextStyle(fontSize: 40),
              ),
              new Text(
                "1",
                style: new TextStyle(fontSize: 40),
              ),
              new Text(
                "1",
                style: new TextStyle(fontSize: 40),
              ),
              new Text(
                "1",
                style: new TextStyle(fontSize: 40),
              ),
              new Text(
                "1",
                style: new TextStyle(fontSize: 40),
              ),
              new Text(
                "1",
                style: new TextStyle(fontSize: 40),
              ),
              new Text(
                "1",
                style: new TextStyle(fontSize: 40),
              ),
              new Text(
                "1",
                style: new TextStyle(fontSize: 40),
              ),
              new Text(
                "1",
                style: new TextStyle(fontSize: 40),
              ),
              new Text(
                "1",
                style: new TextStyle(fontSize: 40),
              ),
              new Text(
                "1",
                style: new TextStyle(fontSize: 40),
              ),
              new Text(
                "1",
                style: new TextStyle(fontSize: 40),
              ),
              new Text(
                "1",
                style: new TextStyle(fontSize: 40),
              ),
              new Text(
                "1",
                style: new TextStyle(fontSize: 40),
              ),new Text(
                "1",
                style: new TextStyle(fontSize: 40),
              ),
              new Text(
                "1",
                style: new TextStyle(fontSize: 40),
              ),
              new Text(
                "1",
                style: new TextStyle(fontSize: 40),
              ),
              new Text(
                "1",
                style: new TextStyle(fontSize: 40),
              )
            ],
          ),
        )
      ],
    ));
  }
}

class FlexibleHeaderInfinityScroll extends StatefulWidget {
  FlexibleHeaderInfinityScroll(this.mediaQuey, this.heightHeader);
  final MediaQueryData mediaQuey;
  double heightHeader;
  @override
  _FlexibleHeaderInfinityScrollState createState() =>
      _FlexibleHeaderInfinityScrollState();
}

class _FlexibleHeaderInfinityScrollState
    extends State<FlexibleHeaderInfinityScroll> {
  ScrollController controller;
  var items = <int>[];
  var newHeight = 0.0;
  var currentScroll = 0.0;
  @override
  initState() {
    super.initState();
    newHeight = widget.heightHeader;
    controller = new ScrollController();
    controller.addListener(() {
      double maxScroll = controller.position.maxScrollExtent;
      currentScroll = controller.position.pixels;
      setState(() {
        newHeight = widget.heightHeader - currentScroll;
      });
      double delta = 200.0;
      if (maxScroll - currentScroll <= delta) {
        var last = items[items.length - 1];
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
    var headerPadding = widget.mediaQuey.padding.top;
    return new Center(
      child: new Column(children: <Widget>[
        new Container(
          decoration: new BoxDecoration(color: Colors.red),
          height: newHeight >= headerPadding ? newHeight : headerPadding,
        ),
        new Flexible(
          child: new ListView.builder(
              controller: controller,
              itemCount: items.length,
              itemBuilder: (BuildContext ctxt, int index) {
                return new Text(items[index].toString(),
                    style: new TextStyle(fontSize: 24));
              }),
        )
      ]),
    );
  }
}
