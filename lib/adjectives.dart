import 'package:flutter/material.dart';
import 'package:thoughtspeech/dictionary.dart' show adjectives;
import 'buttons.dart';
import 'main.dart';
import 'objects.dart';
import 'speak_button.dart';
import 'transitions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'textbox.dart';

class AdjectivePage extends StatefulWidget {
  const AdjectivePage(
      {Key? key, required this.voiceText, required this.setTextValue})
      : super(key: key);
  final String voiceText;
  final ValueChanged<String> setTextValue;

  @override
  State<AdjectivePage> createState() => _AdjectivePageState();
}

class _AdjectivePageState extends State<AdjectivePage> {
  String _currentVoiceText = "";
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

  void objectButtonPressed(Adjective input, {bool plural = false}) {
    //Really really hope that every Adjective is passed by reference otherwise im screwed with frequencies
    input.freq++;
    //actually changes the voice text
    _handleTextUpdate(_currentVoiceText + " " + input.name);

    //adds the date to the freqs list, checks to make sure it is null beofre adding, otherwise makes it a new list
    if (input.freqs != null) {
      input.freqs!.add(DateTime.now());
    } else {
      input.freqs = [DateTime.now()];
    }
    globalVars.freqs[1][input.name] = input.freqs!;
    globalVars.doc!.update({"freqs": globalVars.freqs});
  }

  List<Widget> generateButtons() {
    List<Widget> output = [];
    adjectives.sort();
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width * .9;
    double _defaultHeight = height / 6.7;
    double _defaultWidth = width / 2.05;
    for (var i = 0; i < adjectives.length / 7; i += 7) {
      List<Adjective> labels = adjectives.sublist(i * 7, (i + 1) * 7);

      output.add(
        Padding(
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
                      AdjectiveListButton(
                          defaultWidth: _defaultWidth,
                          defaultHeight: _defaultHeight,
                          label: labels[0],
                          objectButtonPressed: objectButtonPressed),
                      SizedBox(height: height * .05),
                      //labels[1]
                      AdjectiveListButton(
                          defaultWidth: _defaultWidth,
                          defaultHeight: _defaultHeight * 2,
                          label: labels[1],
                          objectButtonPressed: objectButtonPressed),
                      SizedBox(height: height * .05),
                      //labels[2]
                      AdjectiveListButton(
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
                      AdjectiveListButton(
                          defaultWidth: _defaultWidth,
                          defaultHeight: _defaultHeight,
                          label: labels[3],
                          objectButtonPressed: objectButtonPressed),
                      SizedBox(height: height * .05),
                      //labels[4]
                      AdjectiveListButton(
                          defaultWidth: _defaultWidth,
                          defaultHeight: _defaultHeight,
                          label: labels[4],
                          objectButtonPressed: objectButtonPressed),
                      SizedBox(height: height * .05),
                      //labels[5]
                      AdjectiveListButton(
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
              AdjectiveListButton(
                  defaultWidth: _defaultWidth * 2.1,
                  defaultHeight: _defaultHeight,
                  label: labels[6],
                  objectButtonPressed: objectButtonPressed),
              SizedBox(height: height * .05),
            ],
          ),
        ),
      );
    }
    return output;
  }

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    adjectives.shuffle(); //makes the list less alphabetical
    return Scaffold(
      appBar: AppBar(
        title: const Text("Adjectives"),
        leading: IconButton(
          icon: const Icon(Icons.home),
          tooltip: "Home",
          onPressed: () => Navigator.of(context).push(
            SlideRightRoute(
              page: MyHomePage(
                title: (FirebaseAuth.instance.currentUser == null)
                    ? "Home Page"
                    : FirebaseAuth.instance.currentUser!.displayName! +
                        "'s Home Page",
                voiceText: _currentVoiceText,
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: SpeakButton(currentVoiceText: _currentVoiceText),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: ListView(
          children: [
                TextBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    voiceText: _currentVoiceText,
                    handleVoiceTextChanged: _handleTextUpdate),
                SizedBox(height: _height * .045),
              ] +
              generateButtons(),

        ),
      ),
    );
  }
}

class Adjective extends Comparable {
  Adjective({required this.name, required this.color});

  int freq = 0;
  Color color;
  final String name;
  List<DateTime>? freqs;

  @override
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

  @override
  String toString() {
    return name;
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
