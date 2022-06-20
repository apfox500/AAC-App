import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'main.dart';

class SpeakButton extends StatelessWidget {
  const SpeakButton({
    Key? key,
    required String currentVoiceText,
  })  : _currentVoiceText = currentVoiceText,
        super(key: key);

  final String _currentVoiceText;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        if (_currentVoiceText != "") {
          if (!globalVars.past!.contains(_currentVoiceText)) {
            globalVars.past!.add(_currentVoiceText);
            FirebaseFirestore.instance.collection("Users").doc(globalVars.uid).update(
              {"past": globalVars.past},
            );
          }
          globalVars.tts.speak(_currentVoiceText);
        }
      },
      heroTag: 'readaloudbtn',
      backgroundColor: Colors.grey,
      child: const Icon(Icons.record_voice_over),
    );
  }
}
