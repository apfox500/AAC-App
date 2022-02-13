import 'dart:js';

import 'package:flutter/material.dart';

String _textValue = "fillerlmao";

class ActionsPage extends StatefulWidget {
  const ActionsPage({Key? key}) : super(key: key);

  @override
  _ActionsPageState createState() => _ActionsPageState();
}

class _ActionsPageState extends State<ActionsPage> {
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(title: const Text("Actions")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Container(
              width: _width * .9,
              height: _height * .08,
              child: Center(child: Text(_textValue)),
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
          buttons(_width * .9, _height * .9,
              ["a", "b", "c", "d", "e", "f", "g"], context),
        ],
      ),
    );
  }
}

Widget buttons(double width, double height, List lables, BuildContext context) {
  double _defaultHeight = height / 5.54;
  double _defaultWidth = width / 2.01;
  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: <Widget>[
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                width: _defaultWidth,
                height: _defaultHeight,
                color: Theme.of(context).primaryColor,
                child: TextButton(
                  onPressed: () {},
                  child: Text(lables[0]),
                ),
              ),
              Container(
                width: _defaultWidth,
                height: _defaultHeight * 2,
                child: TextButton(
                  onPressed: () {},
                  child: Text(lables[1]),
                ),
              ),
              Container(
                width: _defaultWidth,
                height: _defaultHeight,
                child: TextButton(
                  onPressed: () {},
                  child: Text(lables[2]),
                ),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                width: _defaultWidth,
                height: _defaultHeight,
                child: TextButton(
                  onPressed: () {},
                  child: Text(lables[3]),
                ),
              ),
              Container(
                width: _defaultWidth,
                height: _defaultHeight,
                child: TextButton(
                  onPressed: () {},
                  child: Text(lables[4]),
                ),
              ),
              Container(
                width: _defaultWidth,
                height: _defaultHeight * 2,
                child: TextButton(
                  onPressed: () {},
                  child: Text(lables[5]),
                ),
              ),
            ],
          ),
        ],
      ),
      Container(
        width: width,
        height: _defaultHeight,
        child: TextButton(
          onPressed: () {},
          child: Text(lables[6]),
        ),
      )
    ],
  );
}
