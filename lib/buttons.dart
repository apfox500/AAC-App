import 'adjectives.dart';
import 'objects.dart';
import 'package:flutter/material.dart' hide Action;
import 'actions.dart';
import 'transitions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'main.dart';

class ThingListButton extends StatelessWidget {
  const ThingListButton({
    Key? key,
    required this.defaultWidth,
    required this.defaultHeight,
    required this.label,
    required this.objectButtonPressed,
  }) : super(key: key);

  final double defaultWidth;
  final double defaultHeight;
  final Thing label;
  final Function(Thing input, {bool plural}) objectButtonPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: () => objectButtonPressed(label, plural: true),
      child: Container(
        width: defaultWidth,
        height: defaultHeight,
        decoration: BoxDecoration(
          color: label.color,
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
        child: TextButton(
          onPressed: () {
            objectButtonPressed(label);
          },
          child: (label.hasIcon())
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    label.icon!,
                    Text(
                      label.toString(),
                      style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
                    ),
                  ],
                )
              : Text(
                  label.toString(),
                  style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
                ),
        ),
      ),
    );
  }
}

class ActionListButton extends StatelessWidget {
  const ActionListButton({
    Key? key,
    required this.defaultWidth,
    required this.defaultHeight,
    required this.label,
    required this.actionButtonPressed,
  }) : super(key: key);
  final double defaultWidth;
  final double defaultHeight;
  final Action label;
  final Function(Action input, BuildContext context) actionButtonPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: defaultWidth,
      height: defaultHeight,
      decoration: BoxDecoration(
        color: label.color,
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
      child: TextButton(
        onPressed: () {
          actionButtonPressed(label, context);
        },
        child: (label.hasIcon())
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  label.icon!,
                  Text(
                    label.toString(),
                    style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
                  ),
                ],
              )
            : Text(
                label.toString(),
                style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
              ),
      ),
    );
  }
}

class HomeButton extends StatelessWidget {
  const HomeButton({Key? key, required this.currentVoiceText}) : super(key: key);
  final String currentVoiceText;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.home),
      tooltip: "Home",
      onPressed: () => Navigator.of(context).push(
        SlideRightRoute(
          page: MyHomePage(
            title: (FirebaseAuth.instance.currentUser == null)
                ? "Home Page"
                : FirebaseAuth.instance.currentUser!.displayName! + "'s Home Page",
            voiceText: currentVoiceText,
          ),
        ),
      ),
    );
  }
}

class AdjectiveListButton extends StatelessWidget {
  const AdjectiveListButton({
    Key? key,
    required this.defaultWidth,
    required this.defaultHeight,
    required this.label,
    required this.objectButtonPressed,
  }) : super(key: key);

  final double defaultWidth;
  final double defaultHeight;
  final Adjective label;
  final Function(Adjective input, {bool plural}) objectButtonPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: () => objectButtonPressed(label, plural: true),
      child: Container(
        width: defaultWidth,
        height: defaultHeight,
        decoration: BoxDecoration(
          color: label.color,
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
        child: TextButton(
          onPressed: () {
            objectButtonPressed(label);
          },
          child: Text(
            label.toString(),
            style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
          ),
        ),
      ),
    );
  }
}
