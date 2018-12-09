import 'package:app_layout/collapseSimple.dart';
import 'package:app_layout/collapseWeekCalendar.dart';
import 'package:flutter/material.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> with TickerProviderStateMixin {
  ScrollController _scrollController;
  double delta = 0;
  
  var items = <int>[];
  var newHeight = 0.0;
  var currentScroll = 0.0;

  @override
  initState() {
    super.initState();
    _scrollController = new ScrollController();
    _scrollController.addListener(() {
      double maxScroll = _scrollController.position.maxScrollExtent;
      currentScroll = _scrollController.position.pixels;
      double _delta = 200.0;
      if (maxScroll - currentScroll <= _delta) {
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
  Widget build(BuildContext context) {
    var mediaQuey = MediaQuery.of(context);
    return new Scaffold(
        body: new Column(
      children: <Widget>[
        new Container(padding: new EdgeInsets.only(top: mediaQuey.padding.top)),
        new CollapseSimple(mediaQuey, 100, _scrollController),
        new CollapseWeekCalendar(mediaQuey, 40, _scrollController, Colors.white, Colors.black),
        new Flexible(
          child: new ListView.builder(
              controller: _scrollController,
              itemCount: items.length,
              itemBuilder: (BuildContext ctxt, int index) {
                return new SimpleCard(mediaQuey, index.toString());
              }),
        )
      ],
    ));
  }
}

class SimpleCard extends StatefulWidget {
  SimpleCard(this.mediaQuery, this.title);
  final MediaQueryData mediaQuery;
  final String title;
  @override
  _SimpleCardState createState() => _SimpleCardState();
}

class _SimpleCardState extends State<SimpleCard> {
  @override
  Widget build(BuildContext context) {
    var decorationBackground = new BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomRight,
        tileMode: TileMode.clamp,
        colors: [
          Color.fromARGB(255, 42, 129, 141),
          Color.fromARGB(255, 52, 164, 168),
        ]
      ),
      border: new Border(top: new BorderSide(color: Colors.white))
    );
    return Container(
      height: 100,
      width: widget.mediaQuery.size.width - 15,
      padding: new EdgeInsets.all(10),
      margin: new EdgeInsets.only(left: 5, right: 5),
      decoration: decorationBackground,
      child: new Column(
        children: <Widget>[
          //title
          new Column(
            children: <Widget>[
              new Text(widget.title),
              new Divider(color: Colors.black38, height: 10,)
            ],
          ),
          new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              //body
              new Text("Conteudo"),
              //buttom
              new Text("Botao")
            ],
          )
        ],
      ),
    );
  }
}