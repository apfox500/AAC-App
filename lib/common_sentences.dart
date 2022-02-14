import 'package:flutter/material.dart';

class CommonSentencesPage extends StatefulWidget {
  const CommonSentencesPage({Key? key}) : super(key: key);

  @override
  _CommonSentencesPageState createState() => _CommonSentencesPageState();
}

class _CommonSentencesPageState extends State<CommonSentencesPage> {
  void setText(String text) {
    setState(() {
      
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Common Sentences"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //Read aloud text
            Container(
              width: MediaQuery.of(context).size.width * .9,
              height: MediaQuery.of(context).size.height * .08,
              child: Center(child: Text(_newVoiceText)),
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
            //My name is
            Container(
              width: MediaQuery.of(context).size.width * .9,
              height: MediaQuery.of(context).size.height * .08,
              child: TextButton(
                onPressed: () {
                  setState(() {
                    _newVoiceText = "Hello, My Name is...";
                  });
                },
                child: const Text("Hello, My Name is..."),
              ),
              decoration: BoxDecoration(
                color: Colors.yellow.shade200,
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
                    //Goodbye
                    Container(
                      width: MediaQuery.of(context).size.width * .44,
                      height: MediaQuery.of(context).size.height * .08,
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            _newVoiceText = "Goodbye";
                          });
                        },
                        child: const Text("Goodbye"),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.deepPurple.shade200,
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(
                                0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                    ),
                    //padding
                    const SizedBox(
                      height: 25,
                    ),
                    //Lorem Ipsum
                    Container(
                      width: MediaQuery.of(context).size.width * .44,
                      height: MediaQuery.of(context).size.height * .3,
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            _newVoiceText = "Lorem Ipsum";
                          });
                        },
                        child: const Text("Lorem Ipsum"),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.redAccent.shade100,
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(
                                0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 25,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    //Good Job
                    Container(
                      width: MediaQuery.of(context).size.width * .43,
                      height: MediaQuery.of(context).size.height * .3,
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            _newVoiceText = "Good Job";
                          });
                        },
                        child: const Text("Good Job"),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.redAccent.shade100,
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(
                                0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                    ),
                    //padding
                    const SizedBox(
                      height: 25,
                    ),
                    //I'm Hungry
                    Container(
                      width: MediaQuery.of(context).size.width * .44,
                      height: MediaQuery.of(context).size.height * .08,
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            _newVoiceText = "I am Hungry";
                          });
                        },
                        child: const Text("I am Hungry"),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.deepPurple.shade200,
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(
                                0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
            //padding
            const SizedBox(
              height: 25,
            ),
            //I don't know
            Container(
              width: MediaQuery.of(context).size.width * .9,
              height: MediaQuery.of(context).size.height * .08,
              child: TextButton(
                onPressed: () {
                  setState(() {
                    _newVoiceText = "I don't know";
                  });
                },
                child: const Text("I don't know"),
              ),
              decoration: BoxDecoration(
                color: Colors.lightBlue.shade100,
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