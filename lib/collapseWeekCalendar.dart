import 'package:flutter/material.dart';

class CollapseWeekCalendar extends StatefulWidget {
  CollapseWeekCalendar(this.mediaQuey, this.heightBody, this.scrollController, this.color,
    this.backgroundcolor,{this.week = const ["Dom","Seg","Ter", "Qua", "Qui", "Sex", "Sab"]});
  final Color color;
  final Color backgroundcolor;
  final List<String> week;

  final MediaQueryData mediaQuey;
  final double heightBody;
  final ScrollController scrollController;
  @override
  _CollapseWeekCalendarState createState() => _CollapseWeekCalendarState();
}

class _CollapseWeekCalendarState extends State<CollapseWeekCalendar> with TickerProviderStateMixin {
  //collapse
  AnimationController _collapseController;
  Animation<double> _animationHeight;
  Animation<double> _animationOpacity;
  double _heightCollapse;
  double _opacity = 1;
  bool _close;
  double _scrollValue = 0;
  double _prevScroll = 0;
  //calendar
  var weekDays = <int>[];
  var currentDate = DateTime.now();
  var selectedStyle = new TextStyle(color: Colors.red);
  var normalStyle = new TextStyle(color: Colors.white);

  _getFistDayOfWeek(DateTime date){
    return date.add(new Duration(days: -(date.weekday == 7 ? 0 : date.weekday)));
  }

  _getWeekDays(DateTime date){
    var firstDayOfWeek = _getFistDayOfWeek(date);
    var _weekDays = <int>[];
    for (var i = 0; i < 7; i++) {
      _weekDays.add(firstDayOfWeek.add(new Duration(days: i)).day);
    }
    return _weekDays;
  }

  _alterWeek(bool next){
    if(next)
      currentDate = currentDate.add(new Duration(days: 7));
    else
      currentDate = currentDate.add(new Duration(days: -7));
    
    setState(() {
       weekDays = _getWeekDays(currentDate);      
    });
  }

  _formatDate(DateTime date){
    return date.day.toString() + "/" + date.month.toString() + "/" + date.year.toString();
  }

  @override
  void initState() {
    super.initState();
    //calendar
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

  @override
  Widget build(BuildContext context) {
    weekDays = _getWeekDays(currentDate);

    return Container(
      decoration: new BoxDecoration(
        color: widget.backgroundcolor,
        border: new Border(
          bottom: new BorderSide(color: Colors.white, width: 0.8),
          top: new BorderSide(color: Colors.white, width: 0.8)
        )
      ),
      child: new Column(
        children: <Widget>[
          new Container(
            padding: new EdgeInsets.all(5),
              child: new Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new Row(
                  children: <Widget>[
                    new Container(width: widget.mediaQuey.size.width / 100 * 25),
                    new InkWell(
                      child: new Icon(Icons.arrow_left, color: Colors.white,),
                      onTap: ()=> _alterWeek(false)
                    ),
                    new Text(widget.week[currentDate.weekday == 7 ? 0 : currentDate.weekday]
                        + ", " + _formatDate(currentDate),
                        style: normalStyle),
                    new InkWell(
                      child: new Icon(Icons.arrow_right, color: Colors.white,),
                      onTap: ()=> _alterWeek(true)
                    ),
                  ],
                ),
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
                  child: new Icon(!_close ? Icons.arrow_drop_down : Icons.arrow_drop_up, color: Colors.white,)
                )
              ],
            )
          ),
          new Container(
            height: _heightCollapse,
            child: new Opacity(
              opacity: _opacity,
          child:new Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: weekDays.map((item) =>
            new InkWell(
              onTap: (){
                setState(() {
                  currentDate = _getFistDayOfWeek(currentDate).add(new Duration(days: weekDays.indexOf(item)));
                });
            },
          child: new Column(
            children: <Widget>[
                new Text(widget.week[weekDays.indexOf(item)], style:  currentDate.day == item ? selectedStyle : normalStyle),
                new Text(item.toString(), style:  currentDate.day == item ? selectedStyle : normalStyle),
            ],
          )
        )
        ).toList()
      )
          )
          )
        ],
      )
    );
  }
}
