import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; //allows logins
import 'package:thoughtspeech/login.dart'; //login page
import 'package:thoughtspeech/main.dart'; //main page
//import 'package:cloud_firestore/cloud_firestore.dart'; //allows us to store data to the cloud

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

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
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
    //TODO: upload the user's information to the cloud
    globalVars.language = language ?? defaultLanguage;
    globalVars.pitch = pitch;
    globalVars.rate = rate;
    globalVars.volume = volume;
    globalVars.tts.setLanguage(language ?? defaultLanguage);
    globalVars.tts.setPitch(pitch);
    globalVars.tts.setRate(rate);
    globalVars.tts.setVolume(volume);

    String uid = widget.user.uid;
    //DocumentReference doc = FirebaseFirestore.instance.collection("Users").doc(uid);
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
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        leading: IconButton(
          icon: const Icon(Icons.home),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MyHomePage(title: (widget.user.displayName! + "'s Home Page")),
            ),
          ),
        ),
      ),
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * .9,
          child: Column(
            children: [
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
              //TODO: Personalize the voice, langauge, speed, and tone of the voice
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
              const SizedBox(
                height: 20,
              ),
              Row(
                children: <Widget>[
                  const Text('Voice'),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(voice ?? '-'),
                ],
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    globalVars.tts.speak("This is what I sound like");
                  },
                  child: const Text("Test"),
                ),
              ),
              const SizedBox(
                height: 20,
              ),

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
