

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RectButton extends StatelessWidget{

  RectButton({this.buttonText, this.textStyle, this.buttonWidth, this.backgroundColor, this.onClicked, int buttonHeight });

  TextStyle textStyle;
  String buttonText;
  double buttonWidth;

  Color backgroundColor;
  void Function() onClicked;

  @override
  Widget build(BuildContext context) {

    return Container(
      width: buttonWidth,


      child: ElevatedButton(

        style: ButtonStyle(


            backgroundColor:MaterialStateProperty.all(  backgroundColor ?? Colors.transparent),

        ),

        child: Text(buttonText, style: textStyle),
        onPressed: onClicked,
      ),
    );
  }


}