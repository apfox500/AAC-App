import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:thoughtspeech/buttons.dart';
import 'package:thoughtspeech/speak_button.dart';
import 'main.dart';
import 'dictionary.dart';
import 'transitions.dart';
import 'objects.dart';
import 'textbox.dart';

String _currentVoiceText = "";

class ActionsPage extends StatefulWidget {
  const ActionsPage({Key? key, required this.voiceText, required this.setTextValue})
      : super(key: key);
  final String voiceText;
  final ValueChanged<String> setTextValue;
  @override
  _ActionsPageState createState() => _ActionsPageState();
}

class _ActionsPageState extends State<ActionsPage> {
  void _handleTextUpdate(String value) {
    setState(() {
      _currentVoiceText = value;
      widget.setTextValue(value);
    });

    if (value != "") {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Theme.of(context).backgroundColor,
          content: Row(
            children: <Widget>[
              TextButton(
                child: SizedBox(
                  height: 50,
                  width: MediaQuery.of(context).size.width * .9,
                  child: Card(
                    child: Center(
                      child: Text(
                        "Go to Objects?",
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ),
                  ),
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ObjectsPage(
                        voiceText: _currentVoiceText,
                        setTextValue: widget.setTextValue,
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _currentVoiceText = widget.voiceText;
  }

  void actionButtonPressed(Action input, BuildContext context) {
    //Rellly really hope that everything is passed by reference otherwise im screwed with frequencies

    List<String> forms = input.conjugate();
    showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(children: [
            Center(
              child: Text("Conjugations of '${input.name}':",
                  style: Theme.of(context).textTheme.headline4),
            ),
            SizedBox(
              height: forms.length * 50,
              width: MediaQuery.of(context).size.width * .6,
              child: ListView.builder(
                  itemCount: forms.length,
                  itemBuilder: ((context, index) {
                    return ListTile(
                        title: Text(
                          forms[index],
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                        onTap: () {
                          _handleTextUpdate(_currentVoiceText + " " + forms[index]);
                          Navigator.pop(context, true);
                          input.freq++;
                          //adds the date to the freqs list, checks to make sure it is null beofre adding, otherwise makes it a new list
                          if (input.freqs != null) {
                            input.freqs!.add(DateTime.now());
                          } else {
                            input.freqs = [DateTime.now()];
                          }
                          globalVars.freqs[0][input.name] = input.freqs!;
                          globalVars.doc!.update({"freqs": globalVars.freqs});
                        });
                  })),
            ),
          ]);
        });
  }

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Actions"),
        leading: IconButton(
          icon: const Icon(Icons.home),
          tooltip: "Home",
          onPressed: () => Navigator.of(context).push(
            SlideRightRoute(
              page: MyHomePage(
                title: (FirebaseAuth.instance.currentUser == null)
                    ? "Home Page"
                    : FirebaseAuth.instance.currentUser!.displayName! + "'s Home Page",
                voiceText: _currentVoiceText,
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: SpeakButton(currentVoiceText: _currentVoiceText),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          //text box with words to speak
          TextBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              voiceText: _currentVoiceText,
              handleVoiceTextChanged: _handleTextUpdate),
          SizedBox(height: _height * .045),
          SizedBox(
            height: _height * .68,
            child: ListView.builder(
              itemCount: actions.length ~/ 7,
              itemBuilder: ((context, int index) {
                actions.sort();
                List<Action> labels = actions.sublist(index * 7, (index + 1) * 7);
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
                              ActionListButton(
                                  defaultWidth: _defaultWidth,
                                  defaultHeight: _defaultHeight,
                                  label: labels[0],
                                  actionButtonPressed: actionButtonPressed),
                              //Use sized boxes for whitespace, not containers
                              SizedBox(height: height * .05),
                              //labels[1]
                              ActionListButton(
                                  defaultWidth: _defaultWidth,
                                  defaultHeight: _defaultHeight * 2,
                                  label: labels[1],
                                  actionButtonPressed: actionButtonPressed),
                              SizedBox(height: height * .05),
                              //labels[2]
                              ActionListButton(
                                  defaultWidth: _defaultWidth,
                                  defaultHeight: _defaultHeight,
                                  label: labels[2],
                                  actionButtonPressed: actionButtonPressed),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              //lables[3]
                              ActionListButton(
                                  defaultWidth: _defaultWidth,
                                  defaultHeight: _defaultHeight,
                                  label: labels[3],
                                  actionButtonPressed: actionButtonPressed),
                              SizedBox(height: height * .05),
                              //labels[4]
                              ActionListButton(
                                  defaultWidth: _defaultWidth,
                                  defaultHeight: _defaultHeight,
                                  label: labels[4],
                                  actionButtonPressed: actionButtonPressed),
                              SizedBox(height: height * .05),
                              //labels[5]
                              ActionListButton(
                                  defaultWidth: _defaultWidth,
                                  defaultHeight: _defaultHeight * 2,
                                  label: labels[5],
                                  actionButtonPressed: actionButtonPressed),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: height * .05),
                      //labels[6]
                      ActionListButton(
                          defaultWidth: _defaultWidth * 2.1,
                          defaultHeight: _defaultHeight,
                          label: labels[6],
                          actionButtonPressed: actionButtonPressed),
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

class Action extends Comparable {
  final String name;
  Icon? icon;
  int freq = 0;
  Color color;
  List<DateTime>? freqs;
  Action({required this.name, this.icon, required this.color});

  @override
  String toString() {
    return name;
  }

  List<String> conjugate() {
    return verbsToConjugations[name]!;
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
