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
        new Collapse(mediaQuey, 100, _scrollController),
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

class Collapse extends StatefulWidget {
  Collapse(this.mediaQuey, this.heightBody, this._scrollController);
  final MediaQueryData mediaQuey;
  final double heightBody;
  ScrollController _scrollController;
  @override
  _CollapseState createState() => _CollapseState();
}

class _CollapseState extends State<Collapse> with TickerProviderStateMixin {
  AnimationController _collapseController;
  Animation<double> _animationHeight;
  Animation<double> _animationOpacity;
  double _heightCollapse;
  double _opacity = 1;
  bool _close;
  double _scrollValue = 0;

  double _prevScroll = 0;

  @override
  void initState() {
    super.initState();
    _close = false;
    _heightCollapse = widget.heightBody;
    _collapseController = new AnimationController(vsync: this, duration: new Duration(milliseconds: 300));
    _animationHeight = new Tween<double>(begin: 100, end: 0).animate(_collapseController);
    _animationOpacity = new Tween<double>(begin: 1, end: 0).animate(_collapseController);

    _collapseController.addListener((){
      setState(() {
        _heightCollapse = _animationHeight.value;
        _opacity = _animationOpacity.value;
      });
      if(_collapseController.status == AnimationStatus.completed && !_close){
        _collapseController.reset();
        _close = false;
      }
    });

    widget._scrollController.addListener((){
        if(!_close)
        {
            _prevScroll = _scrollValue;
          _scrollValue = widget._scrollController.position.pixels;
        }
        if(_scrollValue - _prevScroll > 5 && _prevScroll > 0 && !_close)
        {
          _close = true;
          _scrollValue = 0;
          _prevScroll = 0;
          _collapseController.forward();
        }
      });
  }

  @override
    void dispose() {
      super.dispose();
      _collapseController.dispose();
    }

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new Column(
        children: <Widget>[
          //header
          new InkWell(
            onTap: (){
              if(_collapseController.status == AnimationStatus.completed && _close){
                _collapseController.reverse();
                _close = false;
              }
              else if(_collapseController.status == AnimationStatus.dismissed){
                _collapseController.forward();
                _close = true;
              }

            },
            child: new Container(
              height: 30,
              width: widget.mediaQuey.size.width,
              decoration: new BoxDecoration(color: Colors.red),
              child: new Text("titulo"),
            )
          ),
          new Container(
            height: _heightCollapse,
            width: widget.mediaQuey.size.width,
            decoration: new BoxDecoration(color: Colors.blue),
            child: new Opacity(
              opacity: _opacity,
              child: new Container(
                child: new Text("conteudo"),
              ),
            )
          ),
        ],
      ),
    );
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
