import 'package:flutter/material.dart';
import 'main.dart';
import 'transitions.dart';
import 'package:firebase_auth/firebase_auth.dart';

//TODO: make the Interjections page
class InterjectionPage extends StatefulWidget {
  const InterjectionPage({Key? key, required this.voiceText, required this.setTextValue})
      : super(key: key);
  final String voiceText;
  final ValueChanged<String> setTextValue;

  @override
  State<InterjectionPage> createState() => _InterjectionPageState();
}

class _InterjectionPageState extends State<InterjectionPage> {
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
        title: const Text("Interjections"),
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
            Center(
              child: Stack(
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
            ),
          ],
        ),
      ),
    );
  }
}
