

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CircularButton extends StatelessWidget{

  CircularButton({this.buttonText, this.textStyle, this.buttonWidth, this.backgroundColor, this.onClicked });

  TextStyle textStyle;
  String buttonText;
  double buttonWidth;
  Color backgroundColor;
  void Function() onClicked;

  @override
  Widget build(BuildContext context) {

    return Container(
      width: buttonWidth,
      height: buttonWidth,

      child: ElevatedButton(

        style: ButtonStyle(
         

            backgroundColor: MaterialStateProperty.all(backgroundColor),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(buttonWidth / 2),
                    side: BorderSide(color: Colors.teal, width: 2.0)))),

        child: Text(buttonText, style: textStyle),
        onPressed: onClicked,
      ),
    );
  }


}