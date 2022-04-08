import 'package:flutter/material.dart';
import 'dart:math';
import 'main.dart';
import 'transitions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'textbox.dart';
import 'actions.dart';

class PronounsPage extends StatefulWidget {
  const PronounsPage({Key? key, required this.voiceText, required this.setTextValue})
      : super(key: key);

  final String voiceText;
  final ValueChanged<String> setTextValue;

  @override
  State<PronounsPage> createState() => _PronounsPageState();
}

class _PronounsPageState extends State<PronounsPage> {
  String _currentVoiceText = "";
  void _handleTextUpdate(String value) {
    setState(() {
      _currentVoiceText = value;
      widget.setTextValue(value);
    });
    if (value != "") {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Theme.of(context).backgroundColor,
          content: Row(
            children: <Widget>[
              TextButton(
                child: SizedBox(
                  height: 50,
                  width: MediaQuery.of(context).size.width * .9,
                  child: Card(
                    child: Center(
                      child: Text(
                        "Go to Actions?",
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ),
                  ),
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ActionsPage(
                        voiceText: _currentVoiceText,
                        setTextValue: widget.setTextValue,
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      );
    }
  }

  late bool showAllSecond;

  @override
  void initState() {
    super.initState();
    _currentVoiceText = widget.voiceText;
    showAllSecond = false;
  }

  void firstPerson() {
    List<String> singular = ["I", "Me", "Myself", "Mine", "My"];
    List<String> plural = ["We", "Us", "Ourselves", "Ours", "Our"];
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: SizedBox(
              height: MediaQuery.of(context).size.height * .6,
              width: MediaQuery.of(context).size.width * .6,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Singular",
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        SizedBox(
                          height: singular.length * 60,
                          width: MediaQuery.of(context).size.width * .27,
                          child: ListView.builder(
                            itemCount: singular.length,
                            itemBuilder: ((context, index) {
                              return ListTile(
                                  title: Text(
                                    singular[index],
                                    style: Theme.of(context).textTheme.labelLarge,
                                  ),
                                  onTap: () {
                                    _handleTextUpdate(_currentVoiceText + " " + singular[index]);
                                    Navigator.pop(context, true);
                                  });
                            }),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Plural",
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        SizedBox(
                          height: plural.length * 60,
                          width: MediaQuery.of(context).size.width * .27,
                          child: ListView.builder(
                            itemCount: plural.length,
                            itemBuilder: ((context, index) {
                              return ListTile(
                                  title: Text(
                                    plural[index],
                                    style: Theme.of(context).textTheme.labelLarge,
                                  ),
                                  onTap: () {
                                    _handleTextUpdate(_currentVoiceText + " " + plural[index]);
                                    Navigator.pop(context, true);
                                  });
                            }),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  void secondPerson() {
    List<String> singular = ["you", "yourself", "yours", "your"];
    List<String> singularAll = singular + ["thou", "thee", "thyself", "thine"];
    List<String> plural = ["you", "you", "yourselves", "yours", "your"];
    List<String> pluralAll = plural +
        [
          "ye",
          "you all",
          "y'all",
          "youse",
          "yeerselves",
          "y'all's selves",
          "yeers",
          "y'all's yeer",
          "y'all's"
        ];
    int singularLength = ((showAllSecond) ? singularAll : singular).length;
    int pluralLength = (showAllSecond ? pluralAll : plural).length;
    showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: ((context, setState) {
              return Dialog(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * .6,
                  width: MediaQuery.of(context).size.width * .6,
                  child: Stack(
                    children: [
                      Positioned(
                        child: IconButton(
                            icon: Icon((!showAllSecond) ? Icons.unfold_more : Icons.unfold_less),
                            onPressed: () {
                              setState(() {
                                showAllSecond = !showAllSecond;
                              });
                            }),
                        right: 0,
                        bottom: 0,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              //Singular
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "Singular",
                                    style: Theme.of(context).textTheme.headline6,
                                  ),
                                  SizedBox(
                                    height: ((singularLength * 60) >
                                            (MediaQuery.of(context).size.height * .53))
                                        ? (MediaQuery.of(context).size.height * .53)
                                        : (singularLength * 60),
                                    width: MediaQuery.of(context).size.width * .27,
                                    child: ListView.builder(
                                      controller: ScrollController(),
                                      itemCount: ((showAllSecond) ? singularAll : singular).length,
                                      itemBuilder: ((context, index) {
                                        return ListTile(
                                            title: Text(
                                              ((showAllSecond) ? singularAll : singular)[index],
                                              style: Theme.of(context).textTheme.labelLarge,
                                            ),
                                            onTap: () {
                                              _handleTextUpdate(_currentVoiceText +
                                                  " " +
                                                  ((showAllSecond) ? singularAll : singular)[index]);
                                              Navigator.pop(context, true);
                                            });
                                      }),
                                    ),
                                  ),
                                ],
                              ),
                              //Plural
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "Plural",
                                    style: Theme.of(context).textTheme.headline6,
                                  ),
                                  SizedBox(
                                    height: ((pluralLength * 60) >
                                            (MediaQuery.of(context).size.height * .52))
                                        ? (MediaQuery.of(context).size.height * .52)
                                        : (pluralLength * 60),
                                    width: MediaQuery.of(context).size.width * .27,
                                    child: ListView.builder(
                                      controller: ScrollController(),
                                      itemCount: (showAllSecond ? pluralAll : plural).length,
                                      itemBuilder: ((context, index) {
                                        return ListTile(
                                            title: Text(
                                              (showAllSecond ? pluralAll : plural)[index],
                                              style: Theme.of(context).textTheme.labelLarge,
                                            ),
                                            onTap: () {
                                              _handleTextUpdate(_currentVoiceText +
                                                  " " +
                                                  (showAllSecond ? pluralAll : plural)[index]);
                                              Navigator.pop(context, true);
                                            });
                                      }),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            }),
          );
        });
  }

  void thirdPerson() {
    List<String> masculine = ["he", "him", "himself", "his"];
    List<String> feminine = ["she", "her", "herself", "hers"];
    List<String> neuter = ["it", "itself", "its"];
    List<String> genderNeutral = ["they", "them", "themselves", "themself", "theirs", "their"];
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * .82,
              height: MediaQuery.of(context).size.height * .6,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      //masculine
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Masculine",
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          SizedBox(
                            height:
                                ((masculine.length * 60) > (MediaQuery.of(context).size.height * .53))
                                    ? (MediaQuery.of(context).size.height * .53)
                                    : (masculine.length * 60),
                            width: MediaQuery.of(context).size.width * .15,
                            child: ListView.builder(
                              itemCount: masculine.length,
                              itemBuilder: ((context, index) {
                                return ListTile(
                                    title: Text(
                                      masculine[index],
                                      style: Theme.of(context).textTheme.labelLarge,
                                    ),
                                    onTap: () {
                                      _handleTextUpdate(_currentVoiceText + " " + masculine[index]);
                                      Navigator.pop(context, true);
                                    });
                              }),
                            ),
                          ),
                        ],
                      ),
                      //feminine
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Feminine",
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          SizedBox(
                            height:
                                ((feminine.length * 60) > (MediaQuery.of(context).size.height * .53))
                                    ? (MediaQuery.of(context).size.height * .53)
                                    : (feminine.length * 60),
                            width: MediaQuery.of(context).size.width * .15,
                            child: ListView.builder(
                              itemCount: feminine.length,
                              itemBuilder: ((context, index) {
                                return ListTile(
                                    title: Text(
                                      feminine[index],
                                      style: Theme.of(context).textTheme.labelLarge,
                                    ),
                                    onTap: () {
                                      _handleTextUpdate(_currentVoiceText + " " + masculine[index]);
                                      Navigator.pop(context, true);
                                    });
                              }),
                            ),
                          ),
                        ],
                      ),
                      //Neuter
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Neuter",
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          SizedBox(
                            height:
                                ((neuter.length * 60) > (MediaQuery.of(context).size.height * .53))
                                    ? (MediaQuery.of(context).size.height * .53)
                                    : (neuter.length * 60),
                            width: MediaQuery.of(context).size.width * .15,
                            child: ListView.builder(
                              itemCount: neuter.length,
                              itemBuilder: ((context, index) {
                                return ListTile(
                                    title: Text(
                                      neuter[index],
                                      style: Theme.of(context).textTheme.labelLarge,
                                    ),
                                    onTap: () {
                                      _handleTextUpdate(_currentVoiceText + " " + neuter[index]);
                                      Navigator.pop(context, true);
                                    });
                              }),
                            ),
                          ),
                        ],
                      ),
                      //Gender Neutral
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Gender Neutral",
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          SizedBox(
                            height: ((genderNeutral.length * 60) >
                                    (MediaQuery.of(context).size.height * .53))
                                ? (MediaQuery.of(context).size.height * .53)
                                : (genderNeutral.length * 60),
                            width: MediaQuery.of(context).size.width * .15,
                            child: ListView.builder(
                              itemCount: genderNeutral.length,
                              itemBuilder: ((context, index) {
                                return ListTile(
                                    title: Text(
                                      genderNeutral[index],
                                      style: Theme.of(context).textTheme.labelLarge,
                                    ),
                                    onTap: () {
                                      _handleTextUpdate(
                                          _currentVoiceText + " " + genderNeutral[index]);
                                      Navigator.pop(context, true);
                                    });
                              }),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  void generic() {
    //TODO implement generic
    List<String> formal = ["one", "oneself", "one's"];
    List<String> informal = ["you", "yourself", "your"];
  }

  void wh() {
    //TODO implement wh-
    List<String> personal = ["who", "whom", "whose"];
    List<String> nonPersonal = ["what"];
    List<String> relative = ["which"];
  }

  void reciprocalDummy() {
    //TODO implement reciprocal/dummy
    List<String> reciprocal = ["each other", "one another"];
    List<String> dummy = ["there", "it"];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pronouns"),
        leading: IconButton(
          icon: const Icon(Icons.home),
          tooltip: "Home",
          onPressed: () => Navigator.of(context).push(
            SlideRightRoute(
              page: MyHomePage(
                title: (FirebaseAuth.instance.currentUser == null)
                    ? "Home Page"
                    : FirebaseAuth.instance.currentUser!.displayName! + "'s Home Page",
                voiceText: _currentVoiceText,
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          globalVars.tts.speak(_currentVoiceText);
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
            TextBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                voiceText: _currentVoiceText,
                handleVoiceTextChanged: _handleTextUpdate),
            //padding
            const SizedBox(height: 25),
            //First Person
            Container(
              width: MediaQuery.of(context).size.width * .9,
              height: MediaQuery.of(context).size.height * .08,
              child: TextButton(
                onPressed: () {
                  firstPerson();
                },
                child: Text(
                  "First Person",
                  style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.primaries[0],
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
                    //Dummy/Reciprocal
                    Container(
                      width: MediaQuery.of(context).size.width * .44,
                      height: MediaQuery.of(context).size.height * .08,
                      child: TextButton(
                        onPressed: () {
                          reciprocalDummy();
                        },
                        child: Text(
                          "Dummy/Reciprocal",
                          style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.primaries[1],
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
                    //Third Person
                    Container(
                      width: MediaQuery.of(context).size.width * .44,
                      height: MediaQuery.of(context).size.height * .3,
                      child: TextButton(
                        onPressed: () {
                          thirdPerson();
                        },
                        child: Text(
                          "Third Person",
                          style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.primaries[2],
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
                const SizedBox(width: 25),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    //Second Person
                    Container(
                      width: MediaQuery.of(context).size.width * .43,
                      height: MediaQuery.of(context).size.height * .3,
                      child: TextButton(
                        onPressed: () {
                          secondPerson();
                        },
                        child: Text(
                          "Second Person",
                          style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.primaries[3],
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
                    //Wh-
                    Container(
                      width: MediaQuery.of(context).size.width * .44,
                      height: MediaQuery.of(context).size.height * .08,
                      child: TextButton(
                        onPressed: () {
                          wh();
                        },
                        child: Text(
                          "Wh-",
                          style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.primaries[4],
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
            //padding
            const SizedBox(height: 25),
            //Generic
            Container(
              width: MediaQuery.of(context).size.width * .9,
              height: MediaQuery.of(context).size.height * .08,
              child: TextButton(
                onPressed: () {
                  generic();
                },
                child: Text(
                  "Generic",
                  style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.primaries[5],
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
      ),
    );
  }
}

Color randomColor() {
  return Colors.primaries[Random().nextInt(Colors.primaries.length)];
}
