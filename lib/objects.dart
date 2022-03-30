import 'dart:math';
import 'package:flutter/material.dart';
import 'main.dart';

//TODO: the objects move too quickly after pressing, maybe just have them move when you open the page
// Possibility to count number of times used and order the list based on frequency of use
// This needs to be divisible by 7 or it goes poorly
//TODO: make background color a random primamry colr in the actual Thing class, so it doesn't change colors evry time you call setstate(otherwise it goes crazy)
List<Thing> objects = [
  Thing(name: "Pizza", icon: const Icon(Icons.local_pizza, color: Colors.white)),
  Thing(name: "Ball", icon: const Icon(Icons.sports_soccer, color: Colors.white)),
  Thing(
      name: "Sandwich",
      icon: const Icon(Icons.lunch_dining, color: Colors.white),
      plural: "Sandwiches"),
  Thing(name: "Football", icon: const Icon(Icons.sports_football, color: Colors.white)),
  Thing(name: "Field"),
  Thing(name: "Computer", icon: const Icon(Icons.computer, color: Colors.white)),
  Thing(name: "Pencil", icon: const Icon(Icons.edit, color: Colors.white)),
  Thing(name: "Paper", icon: const Icon(Icons.description, color: Colors.white)),
  Thing(
    name: "Pen",
  ),
  Thing(name: "School", icon: const Icon(Icons.school, color: Colors.white)),
  Thing(name: "Airpod", plural: "Airpods"),
  Thing(name: "Phone", icon: const Icon(Icons.phone_iphone, color: Colors.white)),
  Thing(name: "TV", icon: const Icon(Icons.tv, color: Colors.white)),
  Thing(name: "Water", icon: const Icon(Icons.water, color: Colors.white)),
];
String _currentVoiceText = "";

class ObjectsPage extends StatefulWidget {
  const ObjectsPage({Key? key, required this.voiceText, required this.setTextValue})
      : super(key: key);
  final String voiceText;
  final ValueChanged<String> setTextValue;
  @override
  _ObjectsPageState createState() => _ObjectsPageState();
}

class _ObjectsPageState extends State<ObjectsPage> {
  void _handleTextUpdate(String value) {
    setState(() {
      _currentVoiceText = value;
      widget.setTextValue(value);
    });
  }

  @override
  void initState() {
    super.initState();
    _currentVoiceText = widget.voiceText;
  }

  void objectButtonPressed(Thing input, {bool plural = false}) {
    //Rellly really hope that everything is passed by reference otherwise im screwed with frequencies
    input.freq++;
    if (!plural) {
      _handleTextUpdate(_currentVoiceText + " " + input.name);
    } else {
      if (input.plural == null) {
        _handleTextUpdate(_currentVoiceText + " " + input.name + "s");
      } else {
        _handleTextUpdate(_currentVoiceText + " " + input.plural!);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(title: const Text("Objects")),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          globalVars.tts.speak(_currentVoiceText);
        },
        heroTag: 'readaloudbtn',
        backgroundColor: Colors.grey,
        child: const Icon(Icons.record_voice_over),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * .9,
                  height: MediaQuery.of(context).size.height * .15,
                  child: Center(child: Text(_currentVoiceText)),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.blue,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                Visibility(
                  visible: _currentVoiceText != "",
                  child: Positioned(
                    right: 0,
                    child: IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        _handleTextUpdate("");
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(height: _height * .045),
          SizedBox(
            height: _height * .7,
            child: ListView.builder(
              itemCount: objects.length ~/ 7,
              itemBuilder: ((context, int index) {
                objects.sort();
                List<Thing> labels = objects.sublist(index * 7, (index + 1) * 7);
                double height = MediaQuery.of(context).size.height;
                double width = MediaQuery.of(context).size.width * .9;
                double _defaultHeight = height / 6.7;
                double _defaultWidth = width / 2.05;
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            GestureDetector(
                              onDoubleTap: () => objectButtonPressed(labels[0], plural: true),
                              child: Container(
                                width: _defaultWidth,
                                height: _defaultHeight,
                                decoration: BoxDecoration(
                                  color: randomColor(),
                                  borderRadius: BorderRadius.circular(10.0),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 5,
                                      blurRadius: 7,
                                      offset: const Offset(0, 3), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: TextButton(
                                  onPressed: () {
                                    objectButtonPressed(labels[0]);
                                  },
                                  child: (labels[0].hasIcon())
                                      ? Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            labels[0].icon!,
                                            Text(
                                              labels[0].toString(),
                                              style: TextStyle(
                                                  color: Theme.of(context).colorScheme.onBackground),
                                            ),
                                          ],
                                        )
                                      : Text(
                                          labels[0].toString(),
                                          style: TextStyle(
                                              color: Theme.of(context).colorScheme.onBackground),
                                        ),
                                ),
                              ),
                            ),
                            Container(height: height * .05),
                            Container(
                              width: _defaultWidth,
                              height: _defaultHeight * 2,
                              decoration: BoxDecoration(
                                color: randomColor(),
                                borderRadius: BorderRadius.circular(10.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: const Offset(0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: TextButton(
                                onPressed: () => objectButtonPressed(labels[1]),
                                child: (labels[1].hasIcon())
                                    ? Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          labels[1].icon!,
                                          Text(
                                            labels[1].toString(),
                                            style: TextStyle(
                                                color: Theme.of(context).colorScheme.onBackground),
                                          ),
                                        ],
                                      )
                                    : Text(
                                        labels[1].toString(),
                                        style: TextStyle(
                                            color: Theme.of(context).colorScheme.onBackground),
                                      ),
                              ),
                            ),
                            Container(height: height * .05),
                            Container(
                              width: _defaultWidth,
                              height: _defaultHeight,
                              decoration: BoxDecoration(
                                color: randomColor(),
                                borderRadius: BorderRadius.circular(10.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: const Offset(0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: TextButton(
                                onPressed: () => objectButtonPressed(labels[2]),
                                child: (labels[2].hasIcon())
                                    ? Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          labels[2].icon!,
                                          Text(
                                            labels[2].toString(),
                                            style: TextStyle(
                                                color: Theme.of(context).colorScheme.onBackground),
                                          ),
                                        ],
                                      )
                                    : Text(
                                        labels[2].toString(),
                                        style: TextStyle(
                                            color: Theme.of(context).colorScheme.onBackground),
                                      ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                color: randomColor(),
                                borderRadius: BorderRadius.circular(10.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: const Offset(0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              width: _defaultWidth,
                              height: _defaultHeight,
                              child: TextButton(
                                onPressed: () => objectButtonPressed(labels[3]),
                                child: (labels[3].hasIcon())
                                    ? Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          labels[3].icon!,
                                          Text(
                                            labels[3].toString(),
                                            style: TextStyle(
                                                color: Theme.of(context).colorScheme.onBackground),
                                          ),
                                        ],
                                      )
                                    : Text(
                                        labels[3].toString(),
                                        style: TextStyle(
                                            color: Theme.of(context).colorScheme.onBackground),
                                      ),
                              ),
                            ),
                            Container(height: height * .05),
                            Container(
                              width: _defaultWidth,
                              height: _defaultHeight,
                              decoration: BoxDecoration(
                                color: randomColor(),
                                borderRadius: BorderRadius.circular(10.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: const Offset(0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: TextButton(
                                onPressed: () => objectButtonPressed(labels[4]),
                                child: (labels[4].hasIcon())
                                    ? Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          labels[4].icon!,
                                          Text(
                                            labels[4].toString(),
                                            style: TextStyle(
                                                color: Theme.of(context).colorScheme.onBackground),
                                          ),
                                        ],
                                      )
                                    : Text(
                                        labels[4].toString(),
                                        style: TextStyle(
                                            color: Theme.of(context).colorScheme.onBackground),
                                      ),
                              ),
                            ),
                            Container(height: height * .05),
                            Container(
                              width: _defaultWidth,
                              height: _defaultHeight * 2,
                              decoration: BoxDecoration(
                                color: randomColor(),
                                borderRadius: BorderRadius.circular(10.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: const Offset(0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: TextButton(
                                onPressed: () => objectButtonPressed(labels[5]),
                                child: (labels[5].hasIcon())
                                    ? Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          labels[5].icon!,
                                          Text(
                                            labels[5].toString(),
                                            style: TextStyle(
                                                color: Theme.of(context).colorScheme.onBackground),
                                          ),
                                        ],
                                      )
                                    : Text(
                                        labels[5].toString(),
                                        style: TextStyle(
                                            color: Theme.of(context).colorScheme.onBackground),
                                      ),
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
                      decoration: BoxDecoration(
                        color: randomColor(),
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: TextButton(
                        onPressed: () => objectButtonPressed(labels[6]),
                        child: (labels[6].hasIcon())
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  labels[6].icon!,
                                  Text(
                                    labels[6].toString(),
                                    style:
                                        TextStyle(color: Theme.of(context).colorScheme.onBackground),
                                  ),
                                ],
                              )
                            : Text(
                                labels[6].toString(),
                                style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
                              ),
                      ),
                    ),
                    Container(height: height * .05),
                  ],
                );
              }),
            ),
          )
        ],
      ),
    );
  }
}

Color randomColor() => Colors.primaries[Random().nextInt(Colors.primaries.length)];

class Thing extends Comparable {
  final String name;
  String? plural;

  Icon? icon;
  int freq = 0;

  Thing({required this.name, this.icon, this.plural});

  @override
  String toString() {
    return name;
  }

  bool hasIcon() {
    return (icon != null);
  }

  @override
  int compareTo(other) {
    if (freq > other.freq) {
      return -1;
    } else if (freq < other.freq) {
      return 1;
    }
    return 0;
  }
}
