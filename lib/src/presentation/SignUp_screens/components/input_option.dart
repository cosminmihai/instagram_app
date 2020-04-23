import 'package:flutter/material.dart';

class InputOption extends StatefulWidget {
  const InputOption({this.onPressed, this.text, this.color});

  final Function onPressed;
  final String text;

  final Color color;

  @override
  _InputOptionState createState() => _InputOptionState();
}

class _InputOptionState extends State<InputOption> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: Column(
        children: <Widget>[
          Container(
            child: Text(
              widget.text,
              style: TextStyle(color: widget.color, fontWeight: FontWeight.bold, fontSize: 20.0),
            ),
          ),
          Divider(
            height: 16.0,
            color: widget.color,
            thickness: 1.0,
          ),
        ],
      ),
    );
  }
}
