import 'package:flutter/material.dart';

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
    return Stack(
      children: [
        //Text box that has the text to read aloud
        Container(
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
    );
  }
}
