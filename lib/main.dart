import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
//import 'package:flutter/foundation.dart' show kIsWeb;
//import 'dart:io' show Platform;
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'login.dart' show LoginPage;
import 'actions.dart' show ActionsPage;
import 'package:thoughtspeech/common_sentences.dart' show CommonSentencesPage;

//TODO: Fix slight bug where this wont update across screens(some kind of varaible to pass maybe or a set state call?)
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //TODO: Add in a title here
      title: 'Flutter Demo',
      theme: ThemeData.light(),
      //darkTheme: ThemeData.dark(),

      //TODO: Add in a better title for the page
      home: const MyHomePage(title: 'Home Page'),
    );
  }
}

/* class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

enum TtsState { playing, stopped, paused, continued }

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  late FlutterTts flutterTts;
  String? language;
  String? engine;
  double volume = 0.5;
  double pitch = 1.0;
  double rate = 0.5;
  bool isCurrentLanguageInstalled = false;
  TtsState ttsState = TtsState.stopped;

  final AppDataState appData = AppDataState();


  get isPlaying => ttsState == TtsState.playing;
  get isStopped => ttsState == TtsState.stopped;
  get isPaused => ttsState == TtsState.paused;
  get isContinued => ttsState == TtsState.continued;

  bool get isIOS => !kIsWeb && Platform.isIOS;
  bool get isAndroid => !kIsWeb && Platform.isAndroid;
  bool get isWeb => kIsWeb;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initTts();
  }

  initTts() {
    flutterTts = FlutterTts();

    _setAwaitOptions();

    if (isAndroid) {
      _getDefaultEngine();
    }

    flutterTts.setStartHandler(() {
      setState(() {
        print("Playing");
        ttsState = TtsState.playing;
      });
    });

    flutterTts.setCompletionHandler(() {
      setState(() {
        print("Complete");
        ttsState = TtsState.stopped;
      });
    });

    flutterTts.setCancelHandler(() {
      setState(() {
        print("Cancel");
        ttsState = TtsState.stopped;
      });
    });

    if (isWeb || isIOS) {
      flutterTts.setPauseHandler(() {
        setState(() {
          print("Paused");
          ttsState = TtsState.paused;
        });
      });

      flutterTts.setContinueHandler(() {
        setState(() {
          print("Continued");
          ttsState = TtsState.continued;
        });
      });
    }

    flutterTts.setErrorHandler((msg) {
      setState(() {
        print("error: $msg");
        ttsState = TtsState.stopped;
      });
    });
  }

  Future<dynamic> _getLanguages() => flutterTts.getLanguages;

  Future<dynamic> _getEngines() => flutterTts.getEngines;

  Future _getDefaultEngine() async {
    var engine = await flutterTts.getDefaultEngine;
    if (engine != null) {
      print(engine);
    }
  }

  Future _speak() async {
    await flutterTts.setVolume(volume);
    await flutterTts.setSpeechRate(rate);
    await flutterTts.setPitch(pitch);

    if (_newVoiceText != null) {
      if (_newVoiceText!.isNotEmpty) {
        await flutterTts.speak(_newVoiceText!);
      }
    }
  }

  Future _setAwaitOptions() async {
    await flutterTts.awaitSpeakCompletion(true);
  }

  Future _stop() async {
    var result = await flutterTts.stop();
    if (result == 1) setState(() => ttsState = TtsState.stopped);
  }

  Future _pause() async {
    var result = await flutterTts.pause();
    if (result == 1) setState(() => ttsState = TtsState.paused);
  }

  @override
  void dispose() {
    super.dispose();
    flutterTts.stop();
  }

  List<DropdownMenuItem<String>> getEnginesDropDownMenuItems(dynamic engines) {
    var items = <DropdownMenuItem<String>>[];
    for (dynamic type in engines) {
      items.add(DropdownMenuItem(value: type as String?, child: Text(type as String)));
    }
    return items;
  }

  void changedEnginesDropDownItem(String? selectedEngine) {
    flutterTts.setEngine(selectedEngine!);
    language = null;
    setState(() {
      engine = selectedEngine;
    });
  }

  List<DropdownMenuItem<String>> getLanguageDropDownMenuItems(dynamic languages) {
    var items = <DropdownMenuItem<String>>[];
    for (dynamic type in languages) {
      items.add(DropdownMenuItem(value: type as String?, child: Text(type as String)));
    }
    return items;
  }

  void changedLanguageDropDownItem(String? selectedType) {
    setState(() {
      language = selectedType;
      flutterTts.setLanguage(language!);
      if (isAndroid) {
        flutterTts
            .isLanguageInstalled(language!)
            .then((value) => isCurrentLanguageInstalled = (value as bool));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    print(appData);
    return MaterialApp(
      //TODO: Add in a title here
      title: 'Flutter Demo',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      //TODO: Add in a better title for the page
      home: MyHomePage(title: 'Home Page', appState: appData),
    );
  }
}
 */
class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final FlutterTts tts = FlutterTts();
  String _voiceText = "";

  void _handleVoiceTextChanged(String newValue) {
    setState(() {
      _voiceText = newValue;
    });
  }

  _MyHomePageState() {
    tts.setLanguage('en');
    tts.setSpeechRate(0.4);
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: IconButton(
                icon: const Icon(Icons.person),
                onPressed: () {
                  //Find if they are logged in
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage()));
                },
              ),
            )
          ],
        ),
        //Button to make it read aloud? not sure just copying the figma
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            tts.speak(_voiceText);
          },
          heroTag: 'readaloudbtn',
          backgroundColor: Colors.grey,
          child: const Icon(Icons.record_voice_over),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              //Read aloud text
              Container(
                width: MediaQuery.of(context).size.width * .9,
                height: MediaQuery.of(context).size.height * .15,
                child: Center(child: Text(_voiceText)),
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
              //Objects
              Container(
                width: MediaQuery.of(context).size.width * .9,
                height: MediaQuery.of(context).size.height * .15,
                child: TextButton(onPressed: () {}, child: const Text("Objects")),
                decoration: BoxDecoration(
                  color: Colors.purple.shade200,
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
                      //Actions
                      Container(
                        width: MediaQuery.of(context).size.width * .44,
                        height: MediaQuery.of(context).size.height * .15,
                        child: TextButton(
                            onPressed: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) => const ActionsPage()));
                            },
                            child: const Text("Actions")),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          //TODO: Get the gradient to work, it refuses to work and go diagonal but oh well
                          gradient: LinearGradient(
                              colors: [Colors.pink.shade300, Colors.pink.shade200],
                              begin: const Alignment(0, 0),
                              end: Alignment.bottomLeft),
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
                      //Padding
                      const SizedBox(
                        height: 25,
                      ),
                      //Common Sentences
                      Container(
                        width: MediaQuery.of(context).size.width * .44,
                        height: MediaQuery.of(context).size.height * .15,
                        child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CommonSentencesPage(
                                          voiceText: _voiceText,
                                          setTextValue: _handleVoiceTextChanged,
                                        )),
                              );
                            },
                            child: const Text("Common Sentences")),
                        decoration: BoxDecoration(
                          color: Colors.lightGreen,
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
                  //Padding
                  const SizedBox(width: 25),
                  //Pronouns
                  Container(
                    width: MediaQuery.of(context).size.width * .43,
                    height: 225,
                    child: TextButton(onPressed: () {}, child: const Text("Pronouns")),
                    decoration: BoxDecoration(
                      color: Colors.orange,
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
        ));
  }
}
