import 'package:flutter/material.dart';
import 'package:thoughtspeech/objects.dart';
import 'speak_button.dart';
import 'transitions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'main.dart';
import 'textbox.dart';

class CommonSentencesPage extends StatefulWidget {
  const CommonSentencesPage(
      {Key? key, required this.voiceText, required this.setTextValue})
      : super(key: key);

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
  void initState() {
    super.initState();
    _currentVoiceText = widget.voiceText;
  }

  //This function gets commone sentences from the users database(created via profile page)(if any)
  List<Widget> generateButtons() {
    List<Widget> output = [];
    for (String sentence in globalVars.sentences) {
      output.add(
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.5),
          child: Container(
            width: MediaQuery.of(context).size.width * .9,
            height: MediaQuery.of(context).size.height * .08,
            child: TextButton(
              onPressed: () {
                _handleTextUpdate(sentence);
              },
              child: Text(
                sentence,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
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
        ),
      );
    }
    return output;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Common Sentences"),
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
          children: <Widget>[
                //Read aloud text
                TextBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    voiceText: _currentVoiceText,
                    handleVoiceTextChanged: _handleTextUpdate), //padding
                const SizedBox(
                  height: 25,
                ),
                //My name is
                Container(
                  width: MediaQuery.of(context).size.width * .9,
                  height: MediaQuery.of(context).size.height * .08,
                  child: TextButton(
                    onPressed: () {
                      String? user = FirebaseAuth.instance.currentUser?.displayName;
                      if (user != null) {
                        _handleTextUpdate("Hello, My Name is " + user);
                      } else {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return Dialog(
                                child: TextField(
                                  decoration: const InputDecoration(labelText: "What's your name?"),
                                  onSubmitted: (user) {
                                    _handleTextUpdate("Hello, My Name is " + user);
                                    Navigator.pop(context, true);
                                  },
                                ),
                              );
                            });
                      }
                    },
                    child: Text(
                      "Hello, My Name is...",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 255, 230, 0),
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
                            child: Text(
                              "Goodbye",
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.onBackground,
                              ),
                            ),
                          ),
                          decoration: BoxDecoration(
                            color: Colors.deepPurple.shade200,
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
                        const SizedBox(height: 25),
                        //I like you
                        Container(
                          width: MediaQuery.of(context).size.width * .44,
                          height: MediaQuery.of(context).size.height * .3,
                          child: TextButton(
                            onPressed: () {
                              _handleTextUpdate("I like you");
                            },
                            child: Text(
                              "I like you",
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.onBackground,
                              ),
                            ),
                          ),
                          decoration: BoxDecoration(
                            color: Colors.redAccent.shade100,
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
                    //padding
                    const SizedBox(width: 25),
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
                            child: Text(
                              "Good Job",
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.onBackground,
                              ),
                            ),
                          ),
                          decoration: BoxDecoration(
                            color: Colors.redAccent.shade100,
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
                        const SizedBox(height: 25),
                        //I'm Hungry
                        Container(
                          width: MediaQuery.of(context).size.width * .44,
                          height: MediaQuery.of(context).size.height * .08,
                          child: TextButton(
                            onPressed: () {
                              _handleTextUpdate("I am Hungry");
                            },
                            child: Text(
                              "I am Hungry",
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.onBackground,
                              ),
                            ),
                          ),
                          decoration: BoxDecoration(
                            color: Colors.deepPurple.shade200,
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
                const SizedBox(height: 25),
                //I don't know
                Container(
                  width: MediaQuery.of(context).size.width * .9,
                  height: MediaQuery.of(context).size.height * .08,
                  child: TextButton(
                    onPressed: () {
                      _handleTextUpdate("I don't know");
                    },
                    child: Text(
                      "I don't know",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                    ),
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
              ] +
              generateButtons(),
        ),
      ),
    );
  }
}
