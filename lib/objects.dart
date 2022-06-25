import 'dart:math';
import 'package:flutter/material.dart';
import 'buttons.dart';
import 'dictionary.dart';
import 'main.dart';
import 'speak_button.dart';
import 'textbox.dart';

//TODO swipe on the button to add "the" before the object
class ObjectsPage extends StatefulWidget {
  const ObjectsPage({Key? key, required this.voiceText, required this.setTextValue, this.leading})
      : super(key: key);
  final String voiceText;
  final ValueChanged<String> setTextValue;
  final Widget? leading;
  @override
  _ObjectsPageState createState() => _ObjectsPageState();
}

class _ObjectsPageState extends State<ObjectsPage> {
  String _currentVoiceText = "";
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
    //Really really hope that everything is passed by reference otherwise im screwed with frequencies
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
    //adds the date to the freqs list, checks to make sure it is null beofre adding, otherwise makes it a new list
    if (input.freqs != null) {
      input.freqs!.add(DateTime.now());
    } else {
      input.freqs = [DateTime.now()];
    }
    globalVars.freqs[5][input.name] = input.freqs!;
    globalVars.doc!.update({"freqs": globalVars.freqs});
  }

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
          title: const Text("Objects"),
          leading: widget.leading ?? HomeButton(currentVoiceText: _currentVoiceText)),
      floatingActionButton: SpeakButton(currentVoiceText: _currentVoiceText),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          TextBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              voiceText: _currentVoiceText,
              handleVoiceTextChanged: _handleTextUpdate),
          SizedBox(height: _height * .045),
          SizedBox(
            height: _height * .68,
            child: ListView.builder(
              itemCount: objects.length ~/ 7,
              itemBuilder: ((context, int index) {
                objects.sort();
                List<Thing> labels = objects.sublist(index * 7, (index + 1) * 7);
                double height = MediaQuery.of(context).size.height;
                double width = MediaQuery.of(context).size.width * .9;
                double _defaultHeight = height / 6.7;
                double _defaultWidth = width / 2.05;
                return Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              //labels[0]
                              ThingListButton(
                                  defaultWidth: _defaultWidth,
                                  defaultHeight: _defaultHeight,
                                  label: labels[0],
                                  objectButtonPressed: objectButtonPressed),
                              SizedBox(height: height * .05),
                              //labels[1]
                              ThingListButton(
                                  defaultWidth: _defaultWidth,
                                  defaultHeight: _defaultHeight * 2,
                                  label: labels[1],
                                  objectButtonPressed: objectButtonPressed),
                              SizedBox(height: height * .05),
                              //labels[2]
                              ThingListButton(
                                  defaultWidth: _defaultWidth,
                                  defaultHeight: _defaultHeight,
                                  label: labels[2],
                                  objectButtonPressed: objectButtonPressed),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              //labels[3]
                              ThingListButton(
                                  defaultWidth: _defaultWidth,
                                  defaultHeight: _defaultHeight,
                                  label: labels[3],
                                  objectButtonPressed: objectButtonPressed),
                              SizedBox(height: height * .05),
                              //labels[4]
                              ThingListButton(
                                  defaultWidth: _defaultWidth,
                                  defaultHeight: _defaultHeight,
                                  label: labels[4],
                                  objectButtonPressed: objectButtonPressed),
                              SizedBox(height: height * .05),
                              //labels[5]
                              ThingListButton(
                                  defaultWidth: _defaultWidth,
                                  defaultHeight: _defaultHeight * 2,
                                  label: labels[5],
                                  objectButtonPressed: objectButtonPressed),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: height * .05),
                      //labels[6]
                      ThingListButton(
                          defaultWidth: _defaultWidth * 2.1,
                          defaultHeight: _defaultHeight,
                          label: labels[6],
                          objectButtonPressed: objectButtonPressed),
                      SizedBox(height: height * .05),
                    ],
                  ),
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

//had to call thi sclas 'Thing' because we can't very well call it Object
class Thing extends Comparable {
  final String name;
  String? plural;
  Color color;
  Icon? icon;
  int freq = 0;
  List<DateTime>? freqs;
  Thing({required this.name, this.icon, this.plural, required this.color});

  @override
  String toString() {
    return name;
  }

  bool hasIcon() {
    return (icon != null);
  }

  @override
  int compareTo(other) {
    if (freqs == null) {
      //traditional compare, runs if there is not a list of datetimes(oldversion)
      if (freq > other.freq) {
        return -1;
      } else if (freq < other.freq) {
        return 1;
      }
      return 0;
    } else {
      //compares dates, so only those that are recently used or used so much they overide time go to front
      double otherFreqs = other.getFreqsTime();
      double freqsTime = getFreqsTime();
      if (freqsTime > otherFreqs) {
        return -1;
      } else if (freqsTime < otherFreqs) {
        return 1;
      }
      return 0;
    }
  }

  double getFreqsTime() {
    //for now it is only linear(freq/time), may convert to some other relationship later to change weighting
    if (freqs != null) {
      int total = 0; //total days to be added up
      for (DateTime date in freqs!) {
        //add one because otherwise there would be dividing by zero
        total += DateTime.now().difference(date).inDays + 1;
      }
      return freqs!.length / total;
    } else {
      return 0;
    }
  }
}
