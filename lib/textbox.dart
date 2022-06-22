import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:thoughtspeech/main.dart';

class TextBox extends StatefulWidget {
  const TextBox(
      {Key? key,
      required this.width,
      required this.height,
      required this.voiceText,
      required this.handleVoiceTextChanged})
      : super(key: key);
  final double width;
  final double height;
  final String voiceText;
  final Function(String text) handleVoiceTextChanged;

  @override
  State<TextBox> createState() => _TextBoxState();
}

class _TextBoxState extends State<TextBox> {
  @override
  Widget build(BuildContext context) {
    final expandController = ExpandableController();
    //Text box that has the text to read aloud
    return ExpandablePanel(
      controller: expandController,
      collapsed: Center(
        child: Stack(
          children: [
            TextWidget(widget: widget, expandController: expandController),
            //Button to clear the text box, only appears when there is text in the box
            Visibility(
              visible: widget.voiceText != "",
              child: Positioned(
                right: 0,
                child: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    setState(() {
                      widget.handleVoiceTextChanged("");
                    });
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      expanded: Center(
        child: Stack(
          children: [
            //Text box that has the text to read aloud
            Column(
              children: [
                TextWidget(widget: widget, expandController: expandController),
                PastWidget(widget: widget),
              ],
            ),
            //Button to clear the text box, only appears when there is text in the box
            Visibility(
              visible: widget.voiceText != "",
              child: Positioned(
                right: 0,
                child: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    setState(() {
                      widget.handleVoiceTextChanged("");
                    });
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TextWidget extends StatelessWidget {
  const TextWidget({
    Key? key,
    required this.widget,
    required this.expandController,
  }) : super(key: key);

  final TextBox widget;

  final ExpandableController expandController;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: widget.width * .9,
        height: widget.height * .15,
        child: Center(child: Text(widget.voiceText)),
        decoration: BoxDecoration(
          border: Border.all(
            color: (widget.voiceText == "") ? Colors.grey : Colors.blue,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      onTap: () {
        //do stuff to display past sentences
        expandController.value = !expandController.value;
      },
    );
  }
}

class PastWidget extends StatefulWidget {
  const PastWidget({
    Key? key,
    required this.widget,
  }) : super(key: key);

  final TextBox widget;

  @override
  State<PastWidget> createState() => _PastWidgetState();
}

class _PastWidgetState extends State<PastWidget> {
  @override
  Widget build(BuildContext context) {
    double height = globalVars.past.length * 40;
    if (height > widget.widget.height * .45) height = widget.widget.height * .45;
    return SizedBox(
      height: height,
      width: widget.widget.width * .8,
      child: ListView.builder(
        controller: ScrollController(),
        itemCount: globalVars.past.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            child: Card(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Text(
                    globalVars.past.reversed.elementAt(index),
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ),
              ),
            ),
            onTap: () {
              //make phrase the previous one
              widget.widget.handleVoiceTextChanged(
                globalVars.past.reversed.elementAt(index),
              );
              //bring it back to top
              String phrase = globalVars.past.removeAt(
                (globalVars.past.length - index) - 1,
              );
              globalVars.past.add(phrase);
              //Save to firebase
              globalVars.doc!.update(
                {"past": globalVars.past},
              );
            },
            onLongPress: () {
              //removes from history on long press
              globalVars.past.removeAt(
                (globalVars.past.length - index) - 1,
              );
              globalVars.doc!.update(
                {"past": globalVars.past},
              );
              setState(() {});
            },
          );
        },
      ),
    );
  }
}
