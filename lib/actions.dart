import 'dart:math';
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
          Container(height: _height * .045),
          buttons(_width * .9, _height * .805,
              ["a", "b", "c", "d", "e", "f", "g"], context),
        ],
      ),
    );
  }
}

Color randomColor() {
  Random random = Random();
  // Pick a random number in the range [0.0, 1.0)
  double randomDouble = random.nextDouble();

  return Color((randomDouble * 0xFFFFFF).toInt()).withOpacity(1.0);
}

Widget buttons(double width, double height, List lables, BuildContext context) {
  double _defaultHeight = height / 6.7;
  double _defaultWidth = width / 2.05;
  Random random = Random();
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
                color: randomColor(),
                child: TextButton(
                  onPressed: () {},
                  child: Text(lables[0]),
                ),
              ),
              Container(height: height * .05),
              Container(
                width: _defaultWidth,
                height: _defaultHeight * 2,
                color: randomColor(),
                child: TextButton(
                  onPressed: () {},
                  child: Text(lables[1]),
                ),
              ),
              Container(height: height * .05),
              Container(
                width: _defaultWidth,
                height: _defaultHeight,
                color: randomColor(),
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
                color: randomColor(),
                child: TextButton(
                  onPressed: () {},
                  child: Text(lables[3]),
                ),
              ),
              Container(height: height * .05),
              Container(
                width: _defaultWidth,
                height: _defaultHeight,
                color: randomColor(),
                child: TextButton(
                  onPressed: () {},
                  child: Text(lables[4]),
                ),
              ),
              Container(height: height * .05),
              Container(
                width: _defaultWidth,
                height: _defaultHeight * 2,
                color: randomColor(),
                child: TextButton(
                  onPressed: () {},
                  child: Text(lables[5]),
                ),
              ),
            ],
          ),
        ],
      ),
      Container(height: height * .05),
      Container(
        width: _defaultWidth * 2.1,
        height: _defaultHeight,
        color: randomColor(),
        child: TextButton(
          onPressed: () {},
          child: Text(lables[6]),
        ),
      )
    ],
  );
}
