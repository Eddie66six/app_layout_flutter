import 'package:flutter/material.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  var listX = <double>[];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var objSize = new Size(size.width -50, 100);
    var top = size.height/2 - objSize.height/2;
    var total = 2;
    var lstObjs = <Widget>[];
    if(lstObjs.length == 0){
      for (var i = 0; i < total; i++) {
        if(listX.length < total)
          listX.add(i == 0 ? 25 : objSize.width * i + 50); 
        lstObjs.add(
          new Card(objSize, i, listX[i], top)
        );
      }
    }

    _updatePositions(double qtd){
      //minimo
      if(qtd > 0 && listX[0] > 25){
        return;
      }
      //maximo
      if(qtd < 0 && listX[listX.length-1] <= 25){
        return;
      }
      for (var i = 0; i < listX.length; i++) {
        listX[i] += qtd;
      }
    }

    return Scaffold(
      body: new Center(
        child: new GestureDetector(
          child: new Stack(
            overflow: Overflow.clip,
            children: lstObjs,
          ),
          onPanUpdate: (DragUpdateDetails d){
            setState(() {
               _updatePositions(d.delta.dx);           
            });
          },
        )
      )
    );
  }
}

class Card extends StatefulWidget {
  Card(this.size,this.index, this.positionX, this.positionY);
  double positionX;
  double positionY;
  final Size size;
  final int index;
  @override
  _CardState createState() => _CardState();
}

class _CardState extends State<Card> {
  @override
  Widget build(BuildContext context) {
    return new Positioned(
          left: widget.positionX,
          top: widget.positionY,
          child: new Container(
            decoration: new BoxDecoration(
              color: Colors.red,
              border: new Border.all()
            ),
            height: widget.size.height,
            width: widget.size.width,
          ),
    );
  }
}