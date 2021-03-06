import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; //allows logins
import 'package:thoughtspeech/login.dart'; //login page
import 'package:thoughtspeech/main.dart'; //main page
import 'package:cloud_firestore/cloud_firestore.dart'; //allows us to store data to the cloud
import 'transitions.dart'; //file with all the transitions

//TODO: make tags for users, and then implement them

//The page tht displays the users profile and various details associated with it
class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key, required this.user}) : super(key: key);
  final User user;

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final String defaultLanguage = 'en-US';
  TextEditingController textEditingController = TextEditingController();
  double volume = globalVars.volume; // Range: 0-1
  double rate = globalVars.rate; // Range: 0-2
  double pitch = globalVars.pitch; // Range: 0-2

  String? language;
  String? languageCode;
  List<String> languages = <String>[];
  List<String> languageCodes = <String>[];

  String? voice;

  final sentenceController = TextEditingController();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      initLanguages();
    });
  }

  Future<void> initLanguages() async {
    /// populate lang code (i.e. en-US)
    languageCodes = await globalVars.tts.getLanguages();

    /// populate displayed language (i.e. English)
    final List<String>? displayLanguages = await globalVars.tts.getDisplayLanguages();
    if (displayLanguages == null) {
      return;
    }

    languages.clear();
    for (final dynamic lang in displayLanguages) {
      languages.add(lang as String);
    }

    final String? defaultLangCode = await globalVars.tts.getDefaultLanguage();
    if (defaultLangCode != null && languageCodes.contains(defaultLangCode)) {
      languageCode = defaultLangCode;
    } else {
      languageCode = defaultLanguage;
    }
    language = await globalVars.tts.getDisplayLanguageByCode(languageCode!);

    /// get voice
    voice = await getVoiceByLang(languageCode!);

    if (mounted) {
      setState(() {});
    }
  }

  void updateSettings() {
    globalVars.language = language ?? defaultLanguage;
    globalVars.pitch = pitch;
    globalVars.rate = rate;
    globalVars.volume = volume;
    globalVars.tts.setLanguage(language ?? defaultLanguage);
    globalVars.tts.setPitch(pitch);
    globalVars.tts.setRate(rate);
    globalVars.tts.setVolume(volume);

    String uid = widget.user.uid;
    DocumentReference doc = FirebaseFirestore.instance.collection("Users").doc(uid);
    doc.set(
      {"language": language ?? defaultLanguage, "pitch": pitch, "rate": rate, "volume": volume},
    );
  }

  Future<String?> getVoiceByLang(String lang) async {
    final List<String>? voices = await globalVars.tts.getVoiceByLang(languageCode!);
    if (voices != null && voices.isNotEmpty) {
      return voices.first;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    double sentenceHeight = globalVars.sentences.length * 20;
    if (sentenceHeight > 250) sentenceHeight = 250;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        leading: IconButton(
          icon: const Icon(Icons.home),
          onPressed: () => Navigator.push(
            context,
            SlideRightRoute(
              page: MyHomePage(
                title: ((widget.user.displayName ?? "New User") + "'s Home Page"),
              ),
            ),
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListView(
            children: [
              Text(
                "Personal Info",
                style: Theme.of(context).textTheme.headline5,
              ),
              //Name
              TextField(
                decoration: InputDecoration(
                  labelText: widget.user.displayName,
                ),
                onSubmitted: (value) {
                  widget.user.updateDisplayName(value);
                },
                showCursor: true,
                textCapitalization: TextCapitalization.words,
              ),
              //Email
              TextField(
                decoration: InputDecoration(
                  labelText: widget.user.email,
                ),
                onSubmitted: (value) {
                  try {
                    widget.user.updateEmail(value);
                  } on FirebaseAuthException catch (e) {
                    if (e.code == "requires-recent-login") {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (BuildContext context) => const LoginPage()));
                    }
                  } catch (e) {
                    if (e.toString().contains("requires-recent-login")) {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (BuildContext context) => const LoginPage()));
                    }
                  }
                },
                showCursor: true,
              ),
              //section padding
              const SizedBox(height: 30),
              Text(
                "Custom Sentences",
                style: Theme.of(context).textTheme.headline5,
              ),
              //add sentences
              TextField(
                controller: sentenceController,
                decoration: const InputDecoration(
                    label: Text("Add sentences here"), hintText: "e.g. Can you pass me the salt."),
                onSubmitted: (sentence) async {
                  //this adds the sentence on to the list
                  bool dismissable = false;
                  showDialog(
                      barrierDismissible: dismissable,
                      context: context,
                      builder: (context) {
                        return const Center(child: CircularProgressIndicator());
                      });
                  globalVars.sentences.add(sentence);
                  await globalVars.doc!.update({"sentences": globalVars.sentences});
                  dismissable = true;
                  Navigator.pop(context);
                  sentenceController.text = "";
                  setState(() {});
                },
              ),
              //list of sentences
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: sentenceHeight,
                child: ListView.builder(
                  controller: ScrollController(),
                  itemCount: globalVars.sentences.length,
                  itemBuilder: ((context, index) {
                    return GestureDetector(
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Center(
                          child: Text(
                            globalVars.sentences[index],
                          ),
                        ),
                      ),
                      onLongPress: () async {
                        bool dismissable = false;
                        showDialog(
                            barrierDismissible: dismissable,
                            context: context,
                            builder: (context) {
                              return const Center(child: CircularProgressIndicator());
                            });
                        globalVars.sentences.removeAt(index);
                        await globalVars.doc!.update({"sentences": globalVars.sentences});
                        dismissable = true;
                        Navigator.pop(context);
                        setState(() {});
                      },
                    );
                  }),
                ),
              ),
              //section padding
              const SizedBox(height: 30),
              Text(
                "Voice Settings",
                style: Theme.of(context).textTheme.headline5,
              ),
              //Voice of the speaker
              Row(
                children: <Widget>[
                  const Text('Volume'),
                  Expanded(
                    child: Slider(
                      value: volume,
                      min: 0,
                      max: 1,
                      label: volume.round().toString(),
                      onChanged: (double value) {
                        initLanguages();
                        setState(() {
                          volume = value;
                        });
                        updateSettings();
                      },
                    ),
                  ),
                  Text('(${volume.toStringAsFixed(2)})'),
                ],
              ),
              //ratw
              Row(
                children: <Widget>[
                  const Text('Rate'),
                  Expanded(
                    child: Slider(
                      value: rate,
                      min: 0,
                      max: 2,
                      label: rate.round().toString(),
                      onChanged: (double value) {
                        setState(() {
                          rate = value;
                        });
                        updateSettings();
                      },
                    ),
                  ),
                  Text('(${rate.toStringAsFixed(2)})'),
                ],
              ),
              //pitch
              Row(
                children: <Widget>[
                  const Text('Pitch'),
                  Expanded(
                    child: Slider(
                      value: pitch,
                      min: 0,
                      max: 2,
                      label: pitch.round().toString(),
                      onChanged: (double value) {
                        setState(() {
                          pitch = value;
                        });
                        updateSettings();
                      },
                    ),
                  ),
                  Text('(${pitch.toStringAsFixed(2)})'),
                ],
              ),
              //langauge
              Row(
                children: <Widget>[
                  const Text('Language'),
                  const SizedBox(
                    width: 20,
                  ),
                  DropdownButton<String>(
                    value: language,
                    icon: const Icon(Icons.arrow_downward),
                    iconSize: 24,
                    elevation: 16,
                    onChanged: (String? newValue) async {
                      languageCode = await globalVars.tts.getLanguageCodeByName(newValue!);
                      voice = await getVoiceByLang(languageCode!);
                      setState(() {
                        language = newValue;
                      });
                      updateSettings();
                    },
                    items: languages.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ],
              ),
              //padding
              const SizedBox(height: 20),
              //voice
              Row(
                children: <Widget>[
                  const Text('Voice'),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(voice ?? '-'),
                ],
              ),
              //Test button
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    globalVars.tts.speak("This is what I sound like");
                  },
                  child: const Text("Test"),
                ),
              ),
              //section padding
              const SizedBox(height: 30),

              //Sign out button
              TextButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                },
                child: const Text("Sign out"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
