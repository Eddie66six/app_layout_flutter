import 'package:flutter/material.dart';

class CollapseSimple extends StatefulWidget {
  CollapseSimple(this.mediaQuey, this.heightBody, this.scrollController);
  final MediaQueryData mediaQuey;
  final double heightBody;
  final ScrollController scrollController;
  @override
  _CollapseSimpleState createState() => _CollapseSimpleState();
}

class _CollapseSimpleState extends State<CollapseSimple> with TickerProviderStateMixin {
  AnimationController _collapseController;
  Animation<double> _animationHeight;
  Animation<double> _animationOpacity;
  double _heightCollapse;
  double _opacity = 1;
  bool _close;
  double _scrollValue = 0;
  double _prevScroll = 0;

  var defaultTextStyle = new TextStyle(color: Colors.white);

  @override
  void initState() {
    super.initState();
    _close = false;
    _heightCollapse = widget.heightBody;
    _collapseController = new AnimationController(vsync: this, duration: new Duration(milliseconds: 300));
    _animationHeight = new Tween<double>(begin: widget.heightBody, end: 0).animate(_collapseController);
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

    widget.scrollController.addListener((){
        if(!_close)
        {
          _prevScroll = _scrollValue;
          _scrollValue = widget.scrollController.position.pixels;
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

  _onTapCollapse(){
    if(_collapseController.status == AnimationStatus.completed && _close){
      _collapseController.reverse();
      _close = false;
    }
    else if(_collapseController.status == AnimationStatus.dismissed){
      _collapseController.forward();
      _close = true;
    }
  }

  @override
  Widget build(BuildContext context) {

    var decorationBackground = new BoxDecoration(
      border: new Border(
        bottom: new BorderSide(color: Colors.white, width: 0.8),
        top: new BorderSide(color: Colors.white, width: 0.8)
      )
    );

    return new Container(
      decoration: decorationBackground,
      child: new Column(
        children: <Widget>[
          //header
          new InkWell(
            onTap: ()=> _onTapCollapse(),
            child: new Container(
              padding: new EdgeInsets.all(5),
              width: widget.mediaQuey.size.width,
              decoration: new BoxDecoration(
                color: Colors.black
              ),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  new Text("Sessoes disponiveis", style: defaultTextStyle),
                  new Row(
                    children: <Widget>[
                      new Text("10", style: new TextStyle(color: Colors.white)),
                      new Icon(!_close ? Icons.arrow_drop_down : Icons.arrow_drop_up, color: Colors.white)
                    ],
                  )
                ],
              ),
            )
          ),
          new Container(
            height: _heightCollapse,
            width: widget.mediaQuey.size.width,
            decoration: new BoxDecoration(
              color: Colors.black,
              border: new Border(top: new BorderSide(color: Colors.white, width: 0.8))
            ),
            child: new Opacity(
              opacity: _opacity,
              child: new Container(
                padding: new EdgeInsets.all(10),
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        new Text("Sessoes", style: defaultTextStyle),
                        new Text("10", style: defaultTextStyle),
                      ],
                    ),
                    new Container(height: 0.4 ,decoration: new BoxDecoration(color: Colors.white)),
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        new Text("Semanal", style: defaultTextStyle),
                        new Text("0", style: defaultTextStyle),
                      ],
                    )
                  ],
                ),
              ),
            )
          ),
        ],
      ),
    );
  }
}