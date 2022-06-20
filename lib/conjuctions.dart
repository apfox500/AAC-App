import 'package:flutter/material.dart';
import 'package:thoughtspeech/speak_button.dart';
import 'main.dart';
import 'transitions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'textbox.dart';
import 'dictionary.dart';
import 'dart:math';

class ConjunctionPage extends StatefulWidget {
  const ConjunctionPage({Key? key, required this.voiceText, required this.setTextValue})
      : super(key: key);
  final String voiceText;
  final ValueChanged<String> setTextValue;

  @override
  State<ConjunctionPage> createState() => _ConjunctionPageState();
}

class _ConjunctionPageState extends State<ConjunctionPage> {
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

  List<Widget> createSubButtons(double width) {
    List<Widget> ret = [
      const Center(
        child: Padding(
          padding: EdgeInsets.all(1.0),
          child: Text(
            "Subordinating Conjunctions",
            style: TextStyle(color: Color.fromARGB(255, 195, 195, 195), fontSize: 23),
          ),
        ),
      ),
    ];
    for (int i = 0; i <= subordinating.length - 1; i += 2) {
      ret.add(
        Padding(
          padding: const EdgeInsets.all(3.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: width * .425,
                height: 60,
                decoration: BoxDecoration(
                  color: subordinating[i].color,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: TextButton(
                  onPressed: () => _handleTextUpdate(_currentVoiceText + " " + subordinating[i].name),
                  child: Text(
                    subordinating[i].name,
                    style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
                  ),
                ),
              ),
              SizedBox(width: width * .04),
              Container(
                width: width * .425,
                height: 60,
                decoration: BoxDecoration(
                  color: subordinating[i + 1].color,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: TextButton(
                  onPressed: () =>
                      _handleTextUpdate(_currentVoiceText + " " + subordinating[i + 1].name),
                  child: Text(
                    subordinating[i + 1].name,
                    style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
    return ret;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    List<Widget> subordinatingButtons = createSubButtons(width);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Conjunctions"),
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
      body: Center(
        child: SizedBox(
          width: width * .98,
          child: ListView(children: <Widget>[
            const SizedBox(height: 8),
            Center(
              child: TextBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  voiceText: _currentVoiceText,
                  handleVoiceTextChanged: _handleTextUpdate),
            ),
            SizedBox(height: height * .03),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: SizedBox(
                    width: width * .43,
                    height: height * .42 + 20,
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(1.0),
                          child: Text(
                            "Coordinating Conjunctions",
                            style: TextStyle(color: Color.fromARGB(255, 195, 195, 195), fontSize: 18),
                          ),
                        ),
                        SizedBox(
                          width: width * .425,
                          height: height * .4,
                          child: ListView.builder(
                              itemCount: coordinating.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: Container(
                                    width: width * .422,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      color: coordinating[index].color,
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: TextButton(
                                      onPressed: () => _handleTextUpdate(
                                          _currentVoiceText + " " + coordinating[index].name),
                                      child: Text(
                                        coordinating[index].name,
                                        style: TextStyle(
                                            color: Theme.of(context).colorScheme.onBackground),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: width * .03),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: SizedBox(
                    width: width * .43,
                    height: height * .42 + 20,
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(1.0),
                          child: Text(
                            "Correlative Conjunctions",
                            style: TextStyle(color: Color.fromARGB(255, 195, 195, 195), fontSize: 18),
                          ),
                        ),
                        SizedBox(
                          width: width * .425,
                          height: height * .4,
                          child: ListView.builder(
                              itemCount: correlative.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: width * .205,
                                        height: 60,
                                        decoration: BoxDecoration(
                                          color: correlative[index].color,
                                          borderRadius: BorderRadius.circular(10.0),
                                        ),
                                        child: TextButton(
                                          onPressed: () => _handleTextUpdate(
                                              _currentVoiceText + " " + correlative[index].name),
                                          child: Text(
                                            correlative[index].name,
                                            style: TextStyle(
                                                color: Theme.of(context).colorScheme.onBackground),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: width * .205,
                                        height: 60,
                                        decoration: BoxDecoration(
                                          color: correlative[index].color,
                                          borderRadius: BorderRadius.circular(10.0),
                                        ),
                                        child: TextButton(
                                          onPressed: () => _handleTextUpdate(
                                              _currentVoiceText + " " + correlative[index].partner!),
                                          child: Text(
                                            correlative[index].partner!,
                                            style: TextStyle(
                                                color: Theme.of(context).colorScheme.onBackground),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: height * .02,
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Column(
                children: subordinatingButtons,
              ),
            )
          ]),
        ),
      ),
    );
  }
}

Color randomColor() => Colors.primaries[Random().nextInt(Colors.primaries.length)];

class Conjunction {
  final String name;
  final String? partner;
  int freq = 0;
  Color color;
  Conjunction(this.name, {this.partner, required this.color});
}
