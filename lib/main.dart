import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:thoughtspeech/profile.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login.dart' show LoginPage;
import 'actions.dart' show ActionsPage;
import 'package:thoughtspeech/common_sentences.dart' show CommonSentencesPage;
import 'pronouns.dart' show PronounsPage;
import 'objects.dart' show ObjectsPage;
import 'package:text_to_speech/text_to_speech.dart';
import 'globals.dart' show GlobalVars;
import 'transitions.dart'; //file with all the transitions

//TODO: add in the other parts of speech(scroll view/listview)
//TODO: go and comment everything, make the whole file comments
//TODO: you lose the text in the speak text box thingy  when you go into/out of profile and login pages
//TODO: when you double click the text box, have a keyboard popup? honestly dont know if this is a good idea(Andrew)
//TODO: have the frequency of clicks also be date based, so it only does like the most used in the last month(What the guy said in our interview)
late GlobalVars globalVars;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  globalVars = GlobalVars(tts: TextToSpeech());
  if (FirebaseAuth.instance.currentUser != null) {
    //If the user is logged in, then you want to get their voice and other data
    await getUserData();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ThoughtSpeech',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: const MyHomePage(title: 'Home Page'),
      debugShowCheckedModeBanner: false,
    );
  }
}

///Home page of the app that has buttons to navigate to different parts of speech and various other screens
///Is a stateful widget because the text in the box at the top changes when the user chhoses words to add or clears etc.
class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _voiceText = "";
  void _handleVoiceTextChanged(String newValue) {
    setState(() {
      _voiceText = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        automaticallyImplyLeading: false,
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
                        ),
                      ),
                    );
                  }
                });
              },
            ),
          )
        ],
      ),
      //Button to make it read aloud text
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          globalVars.tts.speak(_voiceText);
        },
        heroTag: 'readaloudbtn',
        backgroundColor: Colors.grey,
        child: const Icon(Icons.record_voice_over),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //Read aloud textbox
            Stack(
              children: [
                //Text box that has the text to read aloud
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
                //Button to clear the text box, only appears when there is text in the box
                Visibility(
                  visible: _voiceText != "",
                  child: Positioned(
                    right: 0,
                    child: IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        _handleVoiceTextChanged("");
                      },
                    ),
                  ),
                ),
              ],
            ),
            //padding
            const SizedBox(
              height: 25,
            ),
            //Objects
            Container(
              width: MediaQuery.of(context).size.width * .89,
              height: MediaQuery.of(context).size.height * .15,
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    ScaleRoute(
                      page: ObjectsPage(
                        voiceText: _voiceText,
                        setTextValue: _handleVoiceTextChanged,
                      ),
                    ),
                  );
                },
                child: Text(
                  "Objects",
                  style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
                ),
              ),
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
            const SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    //Pronouns
                    Container(
                      width: MediaQuery.of(context).size.width * .44,
                      height: MediaQuery.of(context).size.height * .15,
                      child: TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              ScaleRoute(
                                page: PronounsPage(
                                  voiceText: _voiceText,
                                  setTextValue: _handleVoiceTextChanged,
                                ),
                              ),
                            );
                          },
                          child: Text(
                            "Pronouns",
                            style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
                          )),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.pink.shade300,
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
                    const SizedBox(height: 25),
                    //Common Sentences
                    Container(
                      width: MediaQuery.of(context).size.width * .44,
                      height: MediaQuery.of(context).size.height * .15,
                      child: TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              ScaleRoute(
                                page: CommonSentencesPage(
                                  voiceText: _voiceText,
                                  setTextValue: _handleVoiceTextChanged,
                                ),
                              ),
                            );
                          },
                          child: Text(
                            "Common Sentences",
                            style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
                          )),
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
                //Actions
                Container(
                  width: MediaQuery.of(context).size.width * .43,
                  height: 270,
                  child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          ScaleRoute(
                            page: ActionsPage(
                              voiceText: _voiceText,
                              setTextValue: _handleVoiceTextChanged,
                            ),
                          ),
                        );
                      },
                      child: Text(
                        "Actions",
                        style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
                      )),
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
      ),
    );
  }
}

Future<void> getUserData() async {
  await FirebaseFirestore.instance
      .collection("Users")
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .get()
      .then((DocumentSnapshot documentSnapshot) {
    Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
    //once we have the map, then we assign to some variables and change our global variable
    double pitch = data["pitch"];
    double volume = data["volume"];
    double rate = data["rate"];
    String language = data["language"];
    globalVars.language = language;
    globalVars.pitch = pitch;
    globalVars.rate = rate;
    globalVars.volume = volume;
    globalVars.tts.setLanguage(language);
    globalVars.tts.setPitch(pitch);
    globalVars.tts.setRate(rate);
    globalVars.tts.setVolume(volume);
  });
}
