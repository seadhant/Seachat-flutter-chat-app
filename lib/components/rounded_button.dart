import 'package:flutter/material.dart';


class RoundedButton extends StatelessWidget {

  RoundedButton({this.colour,this.text,this.ontouch});
  final Color colour;
  final String text;
  final Function ontouch;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: colour,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: ontouch,
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            text,
          ),
        ),
      ),
    );
  }
}
