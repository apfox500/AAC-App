class AppDataState {
  static final AppDataState _instance = AppDataState._internal("Placeholder");

  late String voiceText;

  factory AppDataState() {
    return _instance;
  }

  AppDataState._internal(String text) {
    voiceText = text;
  }


  // static final AppDataState _instance = AppDataState._internal();

  // factory AppDataState() {
  //   return _instance;
  // }

  // late String voiceText;
  // String get getVoiceText => voiceText;

  // // ignore: use_setters_to_change_properties
  // set setVoiceText(String text) {
  //   voiceText = text;
  // }

  // AppDataState._internal() {
  //   voiceText = "Placeholder";
  // }
}