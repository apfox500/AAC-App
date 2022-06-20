import 'package:flutter/material.dart';
import 'main.dart';
import 'speak_button.dart';
import 'transitions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'textbox.dart';
import 'dictionary.dart';

//have it sort by the type(ie location, type, etc,) yknow, then a popup wher you select the individual one
class PrepositionPage extends StatefulWidget {
  const PrepositionPage({Key? key, required this.voiceText, required this.setTextValue})
      : super(key: key);
  final String voiceText;
  final ValueChanged<String> setTextValue;

  @override
  State<PrepositionPage> createState() => _PrepositionPageState();
}

class _PrepositionPageState extends State<PrepositionPage> {
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

  List<Widget> createSimpleButtons(double width) {
    List<Widget> ret = [
      const Center(
        child: Padding(
          padding: EdgeInsets.all(1.0),
          child: Text(
            "Simple",
            style: TextStyle(color: Color.fromARGB(255, 195, 195, 195), fontSize: 23),
          ),
        ),
      ),
    ];
    for (int i = 0; i <= simple.length - 1; i += 2) {
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
                  color: simple[i].color,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: TextButton(
                  onPressed: () => _handleTextUpdate(_currentVoiceText + " " + simple[i].name),
                  child: Text(
                    simple[i].name,
                    style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
                  ),
                ),
              ),
              SizedBox(width: width * .04),
              Container(
                width: width * .425,
                height: 60,
                decoration: BoxDecoration(
                  color: simple[i + 1].color,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: TextButton(
                  onPressed: () => _handleTextUpdate(_currentVoiceText + " " + simple[i + 1].name),
                  child: Text(
                    simple[i + 1].name,
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
    List<Widget> simpleButtons = createSimpleButtons(width);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Prepositions"),
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
          width: width * .95,
          height: height * .9,
          child: ListView(
            children: <Widget>[
              SizedBox(height: height * .03),
              Center(
                child: TextBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    voiceText: _currentVoiceText,
                    handleVoiceTextChanged: _handleTextUpdate),
              ),
              SizedBox(height: height * .03),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Column(
                  children: simpleButtons,
                ),
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
                              "Double",
                              style:
                                  TextStyle(color: Color.fromARGB(255, 195, 195, 195), fontSize: 18),
                            ),
                          ),
                          SizedBox(
                            width: width * .425,
                            height: height * .4,
                            child: ListView.builder(
                                itemCount: doublePrep.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: Container(
                                      width: width * .422,
                                      height: 60,
                                      decoration: BoxDecoration(
                                        color: doublePrep[index].color,
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      child: TextButton(
                                        onPressed: () => _handleTextUpdate(
                                            _currentVoiceText + " " + doublePrep[index].name),
                                        child: Text(
                                          doublePrep[index].name,
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
                              "Compound",
                              style:
                                  TextStyle(color: Color.fromARGB(255, 195, 195, 195), fontSize: 18),
                            ),
                          ),
                          SizedBox(
                            width: width * .425,
                            height: height * .4,
                            child: ListView.builder(
                                itemCount: compound.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: Container(
                                      width: width * .422,
                                      height: 60,
                                      decoration: BoxDecoration(
                                        color: compound[index].color,
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      child: TextButton(
                                        onPressed: () => _handleTextUpdate(
                                            _currentVoiceText + " " + compound[index].name),
                                        child: Text(
                                          compound[index].name,
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
                ],
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
                              "Pharasal",
                              style:
                                  TextStyle(color: Color.fromARGB(255, 195, 195, 195), fontSize: 18),
                            ),
                          ),
                          SizedBox(
                            width: width * .425,
                            height: height * .4,
                            child: ListView.builder(
                                itemCount: pharasal.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: Container(
                                      width: width * .422,
                                      height: 60,
                                      decoration: BoxDecoration(
                                        color: pharasal[index].color,
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      child: TextButton(
                                        onPressed: () => _handleTextUpdate(
                                            _currentVoiceText + " " + pharasal[index].name),
                                        child: Text(
                                          pharasal[index].name,
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
                              "Participle",
                              style:
                                  TextStyle(color: Color.fromARGB(255, 195, 195, 195), fontSize: 18),
                            ),
                          ),
                          SizedBox(
                            width: width * .425,
                            height: height * .4,
                            child: ListView.builder(
                                itemCount: participle.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: Container(
                                      width: width * .422,
                                      height: 60,
                                      decoration: BoxDecoration(
                                        color: participle[index].color,
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      child: TextButton(
                                        onPressed: () => _handleTextUpdate(
                                            _currentVoiceText + " " + participle[index].name),
                                        child: Text(
                                          participle[index].name,
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
                ],
              ),
              SizedBox(height: height * .03),
            ],
          ),
        ),
      ),
    );
  }
}

class Preposition {
  String name;
  Color color;
  Preposition(this.name, this.color);
}
