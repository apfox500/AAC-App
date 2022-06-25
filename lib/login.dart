import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'profile.dart' show ProfilePage;
import 'package:thoughtspeech/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; //allows us to store data to the cloud

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  @override
  _LoginPageState createState() => _LoginPageState();
}

//Tried to do some switching but it yelled at me :/, so now its basically useless
enum Options { login, password, signup, signup2 }

var login = Options.login;

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final pass2Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
        leading: IconButton(
          icon: const Icon(Icons.home),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const MyHomePage(
                title: "Home Page",
              ),
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          Center(
            child: (login == Options.login)
                //Normal Login
                ? Container(
                    padding: const EdgeInsets.all(8),
                    width: MediaQuery.of(context).size.width * .4,
                    height: MediaQuery.of(context).size.height * .45,
                    decoration: BoxDecoration(
                      border: Border.all(color: Theme.of(context).colorScheme.onBackground),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        //Enter Email
                        TextField(
                          controller: emailController,
                          decoration: const InputDecoration(labelText: "Email"),
                          autocorrect: false,
                          onSubmitted: (email) {
                            _submitLogin(email, passController.text, context);
                          },
                        ),
                        //Enter Password
                        TextField(
                          controller: passController,
                          obscureText: true,
                          decoration: const InputDecoration(labelText: "Password"),
                          onSubmitted: (pass) => _submitLogin(emailController.text, pass, context),
                        ),
                        //Login button
                        ElevatedButton(
                          onPressed: () =>
                              _submitLogin(emailController.text, passController.text, context),
                          child: const Text("Login"),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            //Forgot Password
                            TextButton(
                                child: const Text("Forgot Password?"),
                                onPressed: () {
                                  //Forgot password function goes here
                                  login = Options.password;
                                  setState(() {});
                                }),
                            //Sign up
                            TextButton(
                                child: const Text("Sign Up"),
                                onPressed: () {
                                  //Forgot password function goes here
                                  login = Options.signup;
                                  setState(() {});
                                }),
                          ],
                        )
                      ],
                    ),
                  )
                : (login == Options.password)
                    //Forgot Password
                    ? Container(
                        padding: const EdgeInsets.all(8),
                        width: MediaQuery.of(context).size.width * .4,
                        height: 190,
                        decoration: BoxDecoration(
                          border: Border.all(color: Theme.of(context).colorScheme.onBackground),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Column(
                              children: [
                                //Back Button
                                TextButton(
                                  onPressed: () {
                                    login = Options.login;
                                    pass2Controller.clear();
                                    passController.clear();
                                    emailController.clear();
                                    setState(() {});
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: const [
                                      Icon(
                                        Icons.west,
                                        size: 10,
                                      ),
                                      Text(
                                        "Back",
                                        style: TextStyle(fontSize: 10),
                                      )
                                    ],
                                  ),
                                ),
                                //Header text
                                const Text(
                                  "Forgot Password",
                                  style: TextStyle(
                                    fontSize: 24,
                                  ),
                                ),
                              ],
                            ),
                            //Email
                            TextField(
                              controller: emailController,
                              decoration: const InputDecoration(labelText: "Email"),
                              autocorrect: false,
                              onSubmitted: (email) {
                                _forgotPassword(email, context);
                              },
                            ),
                            //Submit
                            ElevatedButton(
                              onPressed: () => _forgotPassword(emailController.text, context),
                              child: const Text("Submit"),
                            ),
                          ],
                        ),
                      )
                    //Sign up for an account
                    : (login == Options.signup)
                        ? Container(
                            padding: const EdgeInsets.all(8),
                            width: MediaQuery.of(context).size.width * .4,
                            height: 290,
                            decoration: BoxDecoration(
                              border: Border.all(color: Theme.of(context).colorScheme.onBackground),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Column(
                                  children: [
                                    //Back Button
                                    TextButton(
                                      onPressed: () {
                                        login = Options.login;
                                        pass2Controller.clear();
                                        passController.clear();
                                        emailController.clear();
                                        setState(() {});
                                      },
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: const [
                                          Icon(
                                            Icons.west,
                                            size: 10,
                                          ),
                                          Text(
                                            "Back",
                                            style: TextStyle(fontSize: 10),
                                          )
                                        ],
                                      ),
                                    ),
                                    //Header text
                                    const Text(
                                      "Sign Up",
                                      style: TextStyle(
                                        fontSize: 24,
                                      ),
                                    ),
                                  ],
                                ),
                                //Email
                                TextField(
                                  controller: emailController,
                                  decoration: const InputDecoration(labelText: "Email"),
                                  autocorrect: false,
                                  onSubmitted: (email) {
                                    _createAccount(
                                        email, passController.text, pass2Controller.text, context);
                                  },
                                ),
                                //Password 1
                                TextField(
                                    controller: passController,
                                    obscureText: true,
                                    decoration: const InputDecoration(labelText: "Password"),
                                    onSubmitted: (pass) => _createAccount(
                                        emailController.text, pass, pass2Controller.text, context)),
                                //Password2
                                TextField(
                                  controller: pass2Controller,
                                  obscureText: true,
                                  decoration: const InputDecoration(labelText: "Confirm Password"),
                                  onSubmitted: (pass2) => _createAccount(
                                      emailController.text, passController.text, pass2, context),
                                ),
                                //Create Account button
                                ElevatedButton(
                                  onPressed: () => _createAccount(emailController.text,
                                      passController.text, pass2Controller.text, context),
                                  child: const Text("Create Account"),
                                ),
                              ],
                            ),
                          )
                        : //Populate with name, photo, phone # and email validation etc.
                        Container(
                            padding: const EdgeInsets.all(8),
                            width: MediaQuery.of(context).size.width * .4,
                            height: 290,
                            decoration: BoxDecoration(
                              border: Border.all(color: Theme.of(context).colorScheme.onBackground),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                //Header text
                                const Text(
                                  "Enter Information",
                                  style: TextStyle(
                                    fontSize: 24,
                                  ),
                                ),
                                //Name
                                TextField(
                                  controller: emailController,
                                  decoration: const InputDecoration(labelText: "Name"),
                                  autocorrect: false,
                                  onSubmitted: (email) {
                                    _submitInfo(email, context);
                                  },
                                ),

                                //Save Info button
                                ElevatedButton(
                                  onPressed: () {
                                    _submitInfo(emailController.text, context);
                                    setState(() {
                                      login = Options.signup2;
                                    });
                                  },
                                  child: const Text("Save Info"),
                                ),
                              ],
                            ),
                          ),
          ),
        ],
      ),
    );
  }
}

void _submitLogin(email, pass, context) async {
  //If email is empty or is an invalid email
  if (email.isEmpty ||
      !(RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(email))) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Please enter a valid email"),
            actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text("Ok"))],
          );
        });
  } else
  //If password is empty
  if (pass.isEmpty) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Please enter a password"),
            actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text("Ok"))],
          );
        });
  } //Get to actually login
  else {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: pass);
      //import their data :)
      getUserData();
      //Naviagte to their profile page
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ProfilePage(
                    user: userCredential.user!,
                  )));
    } on FirebaseAuthException catch (e) {
      //user not found
      if (e.code == 'user-not-found') {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("No user found for that email"),
                actions: [
                  TextButton(onPressed: () => Navigator.pop(context), child: const Text("Ok"))
                ],
              );
            });
      } else
      //Wrong password
      if (e.code == 'wrong-password') {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Wrong password provided for that user.'),
                actions: [
                  TextButton(onPressed: () => Navigator.pop(context), child: const Text("Ok"))
                ],
              );
            });
      }
    }
  }
}

void _forgotPassword(String email, BuildContext context) {
  FirebaseAuth.instance.sendPasswordResetEmail(email: email);
}

void _createAccount(String email, String pass, String pass2, BuildContext context) async {
  if (pass == pass2) {
    try {
      //actually create the account
      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: pass);
      await createDoc();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Password is too weak'),
                content: const Text("Needs to be at least 6 characters long."),
                actions: [
                  TextButton(onPressed: () => Navigator.pop(context), child: const Text("Ok"))
                ],
              );
            });
      } else if (e.code == 'email-already-in-use') {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Email already has an account'),
                content: const Text("Double check your spelling, or try forgot password."),
                actions: [
                  TextButton(onPressed: () => Navigator.pop(context), child: const Text("Ok"))
                ],
              );
            });
      }
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  } else {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Passwords don't match"),
            content: const Text("Double check your spelling,"),
            actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text("Ok"))],
          );
        });
  }
}

void _submitInfo(String name, BuildContext context) {
  try {
    if (name.isEmpty) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Please enter a value for Name"),
              actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text("Ok"))],
            );
          });
    } else {
      FirebaseAuth.instance.currentUser!.updateDisplayName(name);
    }
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ProfilePage(
                  user: FirebaseAuth.instance.currentUser!,
                )));
  } catch (e) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage()));
  }
}

Future<void> createDoc() async {
  String uid = FirebaseAuth.instance.currentUser!.uid;
  DocumentReference doc = FirebaseFirestore.instance.collection("Users").doc(uid);
  doc.set(
    {
      "language": globalVars.language,
      "pitch": globalVars.pitch,
      "rate": globalVars.rate,
      "volume": globalVars.volume
    },
  );
}
