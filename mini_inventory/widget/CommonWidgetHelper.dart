

import 'package:flutter/material.dart';
import 'package:mini_inventory/mini_inventory/theme/CommonStyle.dart';
 
import 'CircularButton.dart';

class CommonWidgetHelper {

  static DropdownMenuItem<String> getMinusPlusDropdownMenuItem({
      String val,
      double buttonWidth,
      Function() plusOnClicked,
      Function() minusOnClicked } ) {

    return DropdownMenuItem(



      child: Column(

        children: [

          SizedBox(height: 5,),

          Row(
              children: [
                getMinusCircularButton(onClicked: minusOnClicked, buttonWidth: buttonWidth),
                SizedBox(width: 20,),
                Text(
                  val,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(width: 20,),
                getPlusCircularButton(onClicked: plusOnClicked, buttonWidth: buttonWidth),
              ]
          ),

          SizedBox(height: 5,),

        ]),

      value: val,
    );

  }

  static DropdownMenuItem<String> getPlusMinusDropdownMenuItem({
    String val,
    double buttonWidth,
    Function() plusOnClicked,
    Function() minusOnClicked } ) {

    return DropdownMenuItem(



      child: Column(

        children: [

          SizedBox(height: 5,),

          Row(
              children: [
                getPlusCircularButton(onClicked: plusOnClicked, buttonWidth: buttonWidth),

                SizedBox(width: 20,),

                Text(
                  val,
                  overflow: TextOverflow.ellipsis,
                ),

                SizedBox(width: 20,),

                getMinusCircularButton(onClicked: minusOnClicked, buttonWidth: buttonWidth),
              ]
          ),

          SizedBox(height: 5,),

        ]
      )

       ,

      value: val,
    );

  }

  static CircularButton getPlusCircularButton( { double buttonWidth, Function() onClicked }) {

    return CircularButton(
        buttonText: '+',
        buttonWidth: buttonWidth,
        textStyle: CommonStyle.plusButtonTextStyle,
        backgroundColor: Colors.green,
        onClicked: onClicked
    );
  }

  static CircularButton getMinusCircularButton({ double buttonWidth, Function() onClicked }) {

    return CircularButton(
        buttonText: '-',
        buttonWidth: buttonWidth,
        textStyle: CommonStyle.minusButtonTextStyle,
        backgroundColor: Colors.red,
        onClicked: onClicked
    );
  }
}