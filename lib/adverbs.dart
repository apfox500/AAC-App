import 'package:flutter/material.dart';
import 'main.dart';
import 'speak_button.dart';
import 'transitions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'textbox.dart';
import 'actions.dart';
import 'dictionary.dart';

class AdverbPage extends StatefulWidget {
  const AdverbPage({Key? key, required this.voiceText, required this.setTextValue}) : super(key: key);
  final String voiceText;
  final ValueChanged<String> setTextValue;

  @override
  State<AdverbPage> createState() => _AdverbPageState();
}

class _AdverbPageState extends State<AdverbPage> {
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
                        "Go to Actions?",
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
                      builder: (context) => ActionsPage(
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

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Adverbs"),
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
      body: Padding(
        padding: const EdgeInsets.only(top: 8),
        child: SizedBox(
          height: height * .95,
          child: ListView(
            children: <Widget>[
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
                              "Time",
                              style: TextStyle(
                                  color: Color.fromARGB(
                                    255,
                                    195,
                                    195,
                                    195,
                                  ),
                                  fontSize: 18),
                            ),
                          ),
                          SizedBox(
                            width: width * .425,
                            height: height * .4,
                            child: ListView.builder(
                                itemCount: time.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: Container(
                                      width: width * .422,
                                      height: 60,
                                      decoration: BoxDecoration(
                                        color: time[index].color,
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      child: TextButton(
                                        onPressed: () => _handleTextUpdate(
                                            _currentVoiceText + " " + time[index].name),
                                        child: Text(
                                          time[index].name,
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
                              "Place",
                              style:
                                  TextStyle(color: Color.fromARGB(255, 195, 195, 195), fontSize: 18),
                            ),
                          ),
                          SizedBox(
                            width: width * .425,
                            height: height * .4,
                            child: ListView.builder(
                                itemCount: place.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: Container(
                                      width: width * .422,
                                      height: 60,
                                      decoration: BoxDecoration(
                                        color: place[index].color,
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      child: TextButton(
                                        onPressed: () => _handleTextUpdate(
                                            _currentVoiceText + " " + place[index].name),
                                        child: Text(
                                          place[index].name,
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
                              "Manner",
                              style:
                                  TextStyle(color: Color.fromARGB(255, 195, 195, 195), fontSize: 18),
                            ),
                          ),
                          SizedBox(
                            width: width * .425,
                            height: height * .4,
                            child: ListView.builder(
                                itemCount: manner.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: Container(
                                      width: width * .422,
                                      height: 60,
                                      decoration: BoxDecoration(
                                        color: manner[index].color,
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      child: TextButton(
                                        onPressed: () => _handleTextUpdate(
                                            _currentVoiceText + " " + manner[index].name),
                                        child: Text(
                                          manner[index].name,
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
                              "Degree",
                              style:
                                  TextStyle(color: Color.fromARGB(255, 195, 195, 195), fontSize: 18),
                            ),
                          ),
                          SizedBox(
                            width: width * .425,
                            height: height * .4,
                            child: ListView.builder(
                                itemCount: degree.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: Container(
                                      width: width * .422,
                                      height: 60,
                                      decoration: BoxDecoration(
                                        color: degree[index].color,
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      child: TextButton(
                                        onPressed: () => _handleTextUpdate(
                                            _currentVoiceText + " " + degree[index].name),
                                        child: Text(
                                          degree[index].name,
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
                              "Frequency",
                              style:
                                  TextStyle(color: Color.fromARGB(255, 195, 195, 195), fontSize: 18),
                            ),
                          ),
                          SizedBox(
                            width: width * .425,
                            height: height * .4,
                            child: ListView.builder(
                                itemCount: frequency.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: Container(
                                      width: width * .422,
                                      height: 60,
                                      decoration: BoxDecoration(
                                        color: frequency[index].color,
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      child: TextButton(
                                        onPressed: () => _handleTextUpdate(
                                            _currentVoiceText + " " + frequency[index].name),
                                        child: Text(
                                          frequency[index].name,
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
                              "Conjunctive",
                              style:
                                  TextStyle(color: Color.fromARGB(255, 195, 195, 195), fontSize: 18),
                            ),
                          ),
                          SizedBox(
                            width: width * .425,
                            height: height * .4,
                            child: ListView.builder(
                                itemCount: conjunctive.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: Container(
                                      width: width * .422,
                                      height: 60,
                                      decoration: BoxDecoration(
                                        color: conjunctive[index].color,
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      child: TextButton(
                                        onPressed: () => _handleTextUpdate(
                                            _currentVoiceText + " " + conjunctive[index].name),
                                        child: Text(
                                          conjunctive[index].name,
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

class Adverb {
  String name;
  Color color;
  Adverb(this.name, this.color);
}
