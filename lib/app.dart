import 'package:flutter/material.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: new ListView(
      children: <Widget>[
        new Card(
            "Portuguesa", "palmito, presunto, mussarela, tomate seco oregano"),
        new Card("americana especial extra 222",
            "palmito, presunto, mussarela, tomate seco oregano ovo, banana, 123 123 oooooo123 dkkkkkkkkkkasasdASDasdASDasdsdfas"),
        new Card(
            "da casa", "palmito, presunto, mussarela, tomate seco oregano"),
        new Card(
            "da casa", "palmito, presunto, mussarela, tomate seco oregano"),
      ],
    ));
  }
}

class Card extends StatefulWidget {
  Card(this.title, this.description);
  final String title;
  final String description;
  @override
  _CardState createState() => _CardState();
}

class _CardState extends State<Card> with TickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _animationRotate;
  Animation<double> _animationOpacity;
  double rotate = 0;
  double opacity = 1;
  int qtde = 0;
  bool isFront = true;

  @override
  void initState() {
    super.initState();
    _animationController = new AnimationController(
        vsync: this, duration: new Duration(milliseconds: 700));
    _animationRotate =
        new Tween<double>(begin: 0, end: 180).animate(_animationController);
    _animationOpacity =
        new Tween<double>(begin: 1, end: 0).animate(_animationController);

    _animationController.addListener(() {
      setState(() {
        opacity = _animationOpacity.value;
        rotate = -_animationRotate.value * 3.14 / 180;
        if (_animationController.status == AnimationStatus.completed) {
          qtde = 0;
          isFront = !isFront;
          _animationController.reset();
        }
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return new InkWell(
      child: Transform(
          alignment: FractionalOffset.center,
          transform: new Matrix4(
            1.0, 0.0, 0.0, 0.0,
            0.0, 1.0, 0.0, 0.0,
            0.0, 0.0, 1.0, 0.001,
            0.0, 0.0, 0.0, 1.0,
          )
            ..scale(1.0, 1.0, 1.0)
            ..rotateX(rotate)
            ..rotateY(0)
            ..rotateZ(0),
          child: new CardBody(
              size,
              _animationController,
              _animationRotate,
              _animationOpacity,
              rotate,
              opacity,
              qtde,
              isFront,
              widget.title,
              widget.description)),
    );
  }
}

class CardBody extends StatefulWidget {
  CardBody(
      this.size,
      this._animationController,
      this._animationRotate,
      this._animationOpacity,
      this.rotate,
      this.opacity,
      this.qtde,
      this.isFront,
      this.title,
      this.description);
  final Size size;
  final AnimationController _animationController;
  final Animation<double> _animationRotate;
  final Animation<double> _animationOpacity;
  final double rotate;
  final double opacity;
  int qtde;
  final bool isFront;

  final String title;
  final String description;
  @override
  _CardBodyState createState() => _CardBodyState();
}

class _CardBodyState extends State<CardBody> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: new EdgeInsets.all(5),
        decoration: new BoxDecoration(
          color: Colors.grey[100],
          boxShadow: [
            new BoxShadow(
                color: Colors.grey[500],
                offset: new Offset(2.0, 2.0),
                blurRadius: 5)
          ],
        ),
        height: 100,
        child: new Opacity(
          opacity: widget.opacity,
          child: new Center(
              child: widget.isFront
                  ? new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        new Container(
                          width: widget.size.width / 1.5 - 10,
                          padding: new EdgeInsets.all(5),
                          child: new Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              new Row(
                                children: <Widget>[
                                  new Icon(Icons.local_pizza),
                                  new Container(
                                    width: widget.size.width / 1.5 - 50,
                                    child: new Text(widget.title,
                                        style: new TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                        maxLines: 1,
                                        softWrap: true,
                                        overflow: TextOverflow.ellipsis),
                                  )
                                ],
                              ),
                              new Text(widget.description,
                                  maxLines: 3,
                                  softWrap: true,
                                  overflow: TextOverflow.ellipsis)
                            ],
                          ),
                        ),
                        new InkWell(
                          onTap: () {
                            if (widget._animationController.status ==
                                AnimationStatus.dismissed)
                              widget._animationController.forward();
                          },
                          child: new Container(
                            decoration: new BoxDecoration(
                              color: Colors.green,
                              borderRadius: new BorderRadius.circular(50),
                              boxShadow: [
                                new BoxShadow(
                                    color: Colors.grey[700],
                                    offset: new Offset(1.0, 1.0),
                                    blurRadius: 2),
                                new BoxShadow(
                                    color: Colors.grey[400],
                                    offset: new Offset(2.0, 2.0),
                                    blurRadius: 2)
                              ],
                            ),
                            height: 50,
                            width: 50,
                            padding: new EdgeInsets.all(10),
                            child: new Icon(Icons.add),
                          ),
                        )
                      ],
                    )
                  : new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        new RaisedButton(
                          child: new Text("-"),
                          onPressed: () {
                            setState(() {
                              if (widget.qtde > 0) widget.qtde--;
                            });
                          },
                        ),
                        new Text(widget.qtde.toString()),
                        new RaisedButton(
                          child: new Text("+"),
                          onPressed: () {
                            setState(() {
                              widget.qtde++;
                            });
                          },
                        ),
                        new InkWell(
                          onTap: () {
                            if (widget._animationController.status ==
                                AnimationStatus.dismissed)
                              widget._animationController.forward();
                          },
                          child: new Container(
                            decoration: new BoxDecoration(
                              color: Colors.green,
                              borderRadius: new BorderRadius.circular(30),
                              boxShadow: [
                                new BoxShadow(
                                    color: Colors.grey[700],
                                    offset: new Offset(1.0, 1.0),
                                    blurRadius: 2),
                                new BoxShadow(
                                    color: Colors.grey[400],
                                    offset: new Offset(2.0, 2.0),
                                    blurRadius: 2)
                              ],
                            ),
                            padding: new EdgeInsets.all(20),
                            child: new Icon(Icons.add_shopping_cart),
                          ),
                        ),
                      ],
                    )),
        ));
  }
}
