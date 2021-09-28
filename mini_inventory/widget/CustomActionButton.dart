

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mini_inventory/mini_inventory/model/CounterCatModel.dart';

class CustomActionButton extends StatelessWidget{

  CustomActionButton({this.text, this.textStyle, this.backgroundColor, this.onClicked });

  TextStyle textStyle;
  String text;
  Color backgroundColor;
  void Function() onClicked;

  @override
  Widget build(BuildContext context) {

    return Card(



      child: new InkWell(
        onTap: () {
          print("tapped");
          onClicked();
        },
        child: Column(

          children: [
            SizedBox(height: 20),
 
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  Expanded(
                    child:Container(
                      child: Text(text, style: textStyle ),
                      padding: EdgeInsets.only(left: 20),
                    ),
                  ),


                  Container(
                    child: Icon(Icons.arrow_forward_ios,  color: backgroundColor,),
                    padding: EdgeInsets.only(right: 20),

                  ),


                ]
              ),

            SizedBox(height: 20),

          ]
        ),
      ),
    );


  }


}