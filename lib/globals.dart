import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:text_to_speech/text_to_speech.dart';

//this basically lets us use globals when we arent allowed to
class GlobalVars {
  TextToSpeech tts;
  String language; // should usually be 'en-US'
  double volume; //range 0-1, 1 is default
  double rate; //range 0-2, 1 is normal
  double pitch; //range is 0-2, 1 is default
  List<String> past = [];
  String? uid;
  DocumentReference? doc;
  //initialize freqs with 7 empty maps, one for each part of speech
  List<Map<String, List<DateTime>>> freqs = [
    {},
    {},
    {},
    {},
    {},
    {},
    {},
    {},
  ];
  List<String> pastVoiceTexts = [];
  GlobalVars({
    required this.tts,
    this.language = 'en-US',
    this.rate = 1,
    this.volume = 1,
    this.pitch = 1,
    this.uid,
    this.doc,
  });
}
