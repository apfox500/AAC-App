import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:thoughtspeech/profile.dart';
import 'dictionary.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login.dart' show LoginPage;
import 'actions.dart' show ActionsPage;
import 'package:thoughtspeech/common_sentences.dart' show CommonSentencesPage;
import 'pronouns.dart' show PronounsPage;
import 'objects.dart' show ObjectsPage;
import 'package:text_to_speech/text_to_speech.dart';
import 'globals.dart' show GlobalVars;
import 'speak_button.dart';
import 'transitions.dart'; //file with all the transitions
import 'adjectives.dart' show AdjectivePage;
import 'adverbs.dart' show AdverbPage;
import 'prepositions.dart' show PrepositionPage;
import 'interjections.dart' show InterjectionPage;
import 'conjuctions.dart' show ConjunctionPage;
import 'textbox.dart';

//posisible title of thought speak

//TO-DO: add an undo button that undoes the last thing added
//TO-DO: it would be really cool to have an opening animation(for inspiration try changing the height and width to 1 and have those scale up?)
//TO-DO: when you double click the text box, have a keyboard popup? honestly dont know if this is a good idea(Andrew)
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
      home: const MyHomePage(
        title: 'Home Page',
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

///Home page of the app that has buttons to navigate to different parts of speech and various other screens
///Is a stateful widget because the text in the box at the top changes when the user chhoses words to add or clears etc.
class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
    required this.title,
    this.voiceText,
  }) : super(key: key);
  final String? voiceText;
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _currentVoiceText = "";

  void _handleVoiceTextChanged(String newValue) {
    setState(() {
      _currentVoiceText = newValue;
    });
  }

  @override
  void initState() {
    super.initState();
    if (widget.voiceText != null) {
      _currentVoiceText = widget.voiceText!;
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    //This line is screwing up deleting the text on the home page with the external text box

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
      floatingActionButton: SpeakButton(currentVoiceText: _currentVoiceText),
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(8),
          children: <Widget>[
            Column(
              children: [
                //padding
                const SizedBox(
                  height: 25,
                ),
                //Read aloud textbox
                TextBox(
                    width: width,
                    height: height,
                    voiceText: _currentVoiceText,
                    handleVoiceTextChanged: _handleVoiceTextChanged),
                //padding
                const SizedBox(height: 25),
                //Objects
                Container(
                  width: width * .9,
                  height: height * .15,
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        ScaleRoute(
                          page: ObjectsPage(
                            voiceText: _currentVoiceText,
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
                          width: width * .44,
                          height: height * .15,
                          child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  ScaleRoute(
                                    page: PronounsPage(
                                      voiceText: _currentVoiceText,
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
                          width: width * .44,
                          height: height * .15,
                          child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  ScaleRoute(
                                    page: CommonSentencesPage(
                                      voiceText: _currentVoiceText,
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
                      width: width * .43,
                      height: height * .34,
                      child: TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              ScaleRoute(
                                page: ActionsPage(
                                  voiceText: _currentVoiceText,
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
                ),
                //padding
                const SizedBox(height: 25),
                //Adjectives
                Container(
                  width: width * .9,
                  height: height * .15,
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        ScaleRoute(
                          page: AdjectivePage(
                            voiceText: _currentVoiceText,
                            setTextValue: _handleVoiceTextChanged,
                          ),
                        ),
                      );
                    },
                    child: Text(
                      "Adjectives",
                      style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 57, 0, 150),
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
                  children: [
                    //Adverbs
                    Container(
                      width: width * .43,
                      height: height * .34,
                      child: TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              ScaleRoute(
                                page: AdverbPage(
                                  voiceText: _currentVoiceText,
                                  setTextValue: _handleVoiceTextChanged,
                                ),
                              ),
                            );
                          },
                          child: Text(
                            "Adverbs",
                            style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
                          )),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(202, 0, 255, 242),
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
                    const SizedBox(width: 25),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        //Prepositions
                        Container(
                          width: width * .44,
                          height: height * .15,
                          child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  ScaleRoute(
                                    page: PrepositionPage(
                                      voiceText: _currentVoiceText,
                                      setTextValue: _handleVoiceTextChanged,
                                    ),
                                  ),
                                );
                              },
                              child: Text(
                                "Prepositions",
                                style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
                              )),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: const Color.fromARGB(255, 0, 128, 38),
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
                        //Interjections
                        Container(
                          width: width * .44,
                          height: height * .15,
                          child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  ScaleRoute(
                                    page: InterjectionPage(
                                      voiceText: _currentVoiceText,
                                      setTextValue: _handleVoiceTextChanged,
                                    ),
                                  ),
                                );
                              },
                              child: Text(
                                "Interjections",
                                style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
                              )),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 255, 197, 8),
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
                  ],
                ),
                //padding
                const SizedBox(height: 25),
                //Conjunctions
                Container(
                  width: width * .9,
                  height: height * .15,
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        ScaleRoute(
                          page: ConjunctionPage(
                            voiceText: _currentVoiceText,
                            setTextValue: _handleVoiceTextChanged,
                          ),
                        ),
                      );
                    },
                    child: Text(
                      "Conjunctions",
                      style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(199, 255, 43, 220),
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
              ],
            )
          ],
        ),
      ),
    );
  }
}

Future<void> getUserData() async {
  //using await because necesary to have settings loaded in
  //gets prefernces and creates variables
  await FirebaseFirestore.instance
      .collection("Users")
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .get()
      .then(
    (DocumentSnapshot documentSnapshot) {
      Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
      //once we have the map, then we assign to some variables and change our global variable
      double pitch = data["pitch"];
      double volume = data["volume"];
      double rate = data["rate"];
      String language = data["language"];
      List<dynamic> past = data["past"];
      globalVars.language = language;
      globalVars.pitch = pitch;
      globalVars.rate = rate;
      globalVars.volume = volume;
      globalVars.tts.setLanguage(language);
      globalVars.tts.setPitch(pitch);
      globalVars.tts.setRate(rate);
      globalVars.tts.setVolume(volume);
      globalVars.past = past.map((e) => e.toString()).toList();
      globalVars.uid = FirebaseAuth.instance.currentUser!.uid;
    },
  );
  globalVars.doc = FirebaseFirestore.instance.collection("Users").doc(globalVars.uid);
  //load in all the freqs for all words in dictionary(if they exist)

  globalVars.doc!.get().then((DocumentSnapshot documentSnapshot) {
    Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
    List<dynamic> freqs = data["freqs"] as List<dynamic>;
    for (var i = 0; i <= 7; i++) {
      Map<String, dynamic> actionsFreqs = freqs[i] as Map<String, dynamic>;
      actionsFreqs.forEach(
        (key, value) {
          List<DateTime> values =
              (value as List<dynamic>).map((e) => (e as Timestamp).toDate()).toList();
          //goes through for each part of speech(faster to do a loop with this than same code many times)
          //not all of them sort(yet), or have been completed which is why currently it looks a little useless, but like trust me bro this is smart
          if (i == 0) {
            //Actions(0)
            actions.firstWhere((element) => element.name == key).freqs = values;
          } else if (i == 1) {
            //Adjectives(1)
            adjectives.firstWhere((element) => element.name == key).freqs = values;
          } else if (i == 2) {
            //Adverbs(2)
            //doesnt sort
          } else if (i == 3) {
            //conjunctions(3)
            //doesnt sort
          } else if (i == 4) {
            //interjections(4)
            //not made yet
          } else if (i == 5) {
            //objects(5)
            objects.firstWhere((element) => element.name == key).freqs = values;
          } else if (i == 6) {
            //prepositions(6)
            //doesnt sort
          } else if (i == 7) {
            //pronouns(7)
            //doesnt sort
          }
          globalVars.freqs[i][key] = values;
        },
      );
    }
  });
}
