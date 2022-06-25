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
          //speaks
          globalVars.tts.speak(_currentVoiceText);
          if (!globalVars.past.contains(_currentVoiceText)) {
            //checks to make sure that the sentence isnt already in there
            //adds the sentence to globalVars.past
            globalVars.past.add(_currentVoiceText);
            //checks to make sure that past isnt too long, will only save the last 20 sentences(random arbitrary number, might change)
            if (globalVars.past.length > 20) {
              globalVars.past.removeAt(0); //removes the last index
            }
            globalVars.doc!.update(
              {"past": globalVars.past},
            );
          }
        }
      },
      heroTag: 'readaloudbtn',
      backgroundColor: Colors.grey,
      child: const Icon(Icons.record_voice_over),
    );
  }
}
