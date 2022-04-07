import 'package:flutter/material.dart';
import 'main.dart';
import 'transitions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'textbox.dart';

//TODO: make the Conjunctions page
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

  @override
  Widget build(BuildContext context) {
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
            TextBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                voiceText: _currentVoiceText,
                handleVoiceTextChanged: _handleTextUpdate),
          ],
        ),
      ),
    );
  }
}
