import 'package:flutter/material.dart';
import 'dart:math';
import 'main.dart';

//TODO:  remake pronouns page to include all of them
//TODO: fix color changing on pronouns page
//for refrence:https://en.wikipedia.org/wiki/English_pronouns#Full_list
//make it popup like the actions page when you choose a specific one
class PronounsPage extends StatefulWidget {
  const PronounsPage({Key? key, required this.voiceText, required this.setTextValue})
      : super(key: key);

  final String voiceText;
  final ValueChanged<String> setTextValue;

  @override
  State<PronounsPage> createState() => _PronounsPageState();
}

class _PronounsPageState extends State<PronounsPage> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pronouns"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          globalVars.tts.speak(_currentVoiceText);
        },
        heroTag: 'readaloudbtn',
        backgroundColor: Colors.grey,
        child: const Icon(Icons.record_voice_over),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //Read aloud text
            Stack(
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
            //padding
            const SizedBox(
              height: 25,
            ),
            //I
            Container(
              width: MediaQuery.of(context).size.width * .9,
              height: MediaQuery.of(context).size.height * .08,
              child: TextButton(
                onPressed: () {
                  _handleTextUpdate(_currentVoiceText + " I");
                },
                child: Text(
                  "I",
                  style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
                ),
              ),
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
            ),
            //padding
            const SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    //Goodbye
                    Container(
                      width: MediaQuery.of(context).size.width * .44,
                      height: MediaQuery.of(context).size.height * .08,
                      child: TextButton(
                        onPressed: () {
                          _handleTextUpdate(_currentVoiceText + " you");
                        },
                        child: Text(
                          "You",
                          style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
                        ),
                      ),
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
                    ),
                    //padding
                    const SizedBox(
                      height: 25,
                    ),
                    //Lorem Ipsum
                    Container(
                      width: MediaQuery.of(context).size.width * .44,
                      height: MediaQuery.of(context).size.height * .3,
                      child: TextButton(
                        onPressed: () {
                          _handleTextUpdate(_currentVoiceText + " they");
                        },
                        child: Text(
                          "They",
                          style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
                        ),
                      ),
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
                    ),
                  ],
                ),
                const SizedBox(
                  width: 25,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    //Good Job
                    Container(
                      width: MediaQuery.of(context).size.width * .43,
                      height: MediaQuery.of(context).size.height * .3,
                      child: TextButton(
                        onPressed: () {
                          _handleTextUpdate(_currentVoiceText + " he");
                        },
                        child: Text(
                          "He",
                          style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
                        ),
                      ),
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
                    ),
                    //padding
                    const SizedBox(
                      height: 25,
                    ),
                    //I'm Hungry
                    Container(
                      width: MediaQuery.of(context).size.width * .44,
                      height: MediaQuery.of(context).size.height * .08,
                      child: TextButton(
                        onPressed: () {
                          _handleTextUpdate(_currentVoiceText + " she");
                        },
                        child: Text(
                          "She",
                          style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
                        ),
                      ),
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
                    ),
                  ],
                )
              ],
            ),
            //padding
            const SizedBox(
              height: 25,
            ),
            //I don't know
            Container(
              width: MediaQuery.of(context).size.width * .9,
              height: MediaQuery.of(context).size.height * .08,
              child: TextButton(
                onPressed: () {
                  _handleTextUpdate(_currentVoiceText + " we");
                },
                child: Text(
                  "We",
                  style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
                ),
              ),
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
            ),
          ],
        ),
      ),
    );
  }
}

Color randomColor() {
  return Colors.primaries[Random().nextInt(Colors.primaries.length)];
}
