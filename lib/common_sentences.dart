import 'package:flutter/material.dart';

class CommonSentencesPage extends StatefulWidget {
  const CommonSentencesPage({Key? key, required this.voiceText, required this.setTextValue}) : super(key: key);

  final String voiceText;
  final ValueChanged<String> setTextValue;

  @override
  State<CommonSentencesPage> createState() => _CommonSentencesPageState();
}

class _CommonSentencesPageState extends State<CommonSentencesPage> {
  String _currentVoiceText = "";
  void _handleTextUpdate(String value) {
    setState(() {
      _currentVoiceText = value;
      widget.setTextValue(value);
    });
  }
@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text("Common Sentences"),
    ),
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          //Read aloud text
          Container(
            width: MediaQuery.of(context).size.width * .9,
            height: MediaQuery.of(context).size.height * .08,
            child: Center(child: Text(_currentVoiceText)),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.blue,
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          //padding
          const SizedBox(
            height: 25,
          ),
          //My name is
          Container(
            width: MediaQuery.of(context).size.width * .9,
            height: MediaQuery.of(context).size.height * .08,
            child: TextButton(
              onPressed: () {
                _handleTextUpdate("Hello, My Name is ...");
              },
              child: const Text("Hello, My Name is..."),
            ),
            decoration: BoxDecoration(
              color: Colors.yellow.shade200,
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
                        _handleTextUpdate("Goodbye");
                      },
                      child: const Text("Goodbye"),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.deepPurple.shade200,
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset:
                              const Offset(0, 3), // changes position of shadow
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
                        _handleTextUpdate("Lorem Ipsum");
                      },
                      child: const Text("Lorem Ipsum"),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.redAccent.shade100,
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset:
                              const Offset(0, 3), // changes position of shadow
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
                        _handleTextUpdate("Good Job");
                      },
                      child: const Text("Good Job"),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.redAccent.shade100,
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset:
                              const Offset(0, 3), // changes position of shadow
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
                        _handleTextUpdate("I am Hungry");
                      },
                      child: const Text("I am Hungry"),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.deepPurple.shade200,
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset:
                              const Offset(0, 3), // changes position of shadow
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
                _handleTextUpdate("I don't know");
              },
              child: const Text("I don't know"),
            ),
            decoration: BoxDecoration(
              color: Colors.lightBlue.shade100,
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