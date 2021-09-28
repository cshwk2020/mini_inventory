

import 'package:flutter/material.dart';

class CustomOverlayView extends StatelessWidget {

  CustomOverlayView({this.color, this.width, this.height});

  final Color color;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {

    return Container(

      width: width,
      height: height,

      //margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color,
      ),

    );
  }


}