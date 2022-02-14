import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:thoughtspeech/login.dart';
import 'package:thoughtspeech/main.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key, required this.user}) : super(key: key);
  final User user;

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        leading: IconButton(
          icon: Icon(Icons.home),
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
              //Text(widget.user.toString(),),
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
