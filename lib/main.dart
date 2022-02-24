import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:thoughtspeech/profile.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login.dart' show LoginPage;
import 'actions.dart' show ActionsPage;
import 'package:thoughtspeech/common_sentences.dart' show CommonSentencesPage;

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
      title: 'AAC Application',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),

      home: const MyHomePage(title: 'Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

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
    tts.setSpeechRate(0.8);
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
                  FirebaseAuth.instance.userChanges().listen((User? user) {
                    if (user == null) {
                      //User is signed out
                      //Needs to open a login/signup page
                      Navigator.push(
                          context, MaterialPageRoute(builder: (context) => const LoginPage()));
                    } else {
                      //User is signed in
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProfilePage(
                                    user: user,
                                  )));
                    }
                  });
                },
              ),
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            tts.speak(_voiceText);
          },
          heroTag: 'readaloudbtn',
          backgroundColor: Colors.grey,
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
