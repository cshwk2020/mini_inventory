
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mini_inventory/mini_inventory/provider/MiniInventorySettingProvider.dart';

class CornerFrameView extends StatelessWidget {

  final double CORNER_WIDTH = 20;
  final double CORNER_HEIGHT = 20;

  final double MARGIN_WIDTH = 30;
  final double MARGIN_HEIGHT = 10;

  const CornerFrameView({Key key, this.contentView}) : super(key: key);

  final Widget contentView;

  @override
  Widget build(BuildContext context) {

    return Consumer<SettingProvider>(builder: (context, setting_provider, child) {


      BorderSide corner_border_side = BorderSide(width: 1.0, color: setting_provider.getAppThemeData().accentColor);

      return Container(

          child: Stack (

              children:[

                Center(

                  child: Container(

                    margin: EdgeInsets.only(
                      left:MARGIN_WIDTH, right:MARGIN_WIDTH,
                      top: MARGIN_HEIGHT, bottom: MARGIN_HEIGHT
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity( 0.1 ),
                    ),

                  ),

                ),


                Container(
                  padding: EdgeInsets.only(
                      left:MARGIN_WIDTH, right:MARGIN_WIDTH,
                      top: MARGIN_HEIGHT, bottom: MARGIN_HEIGHT
                  ),

                  child: contentView,
                ),




                Positioned(
                    top: 0,
                    left: 0,

                    child: Container(
                        width: CORNER_WIDTH,
                        height: CORNER_HEIGHT,

                        decoration: BoxDecoration(

                          //
                          border: Border(

                            top: corner_border_side,
                            left: corner_border_side,

                          ),

                        )
                    )
                ),

                
                Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                        width: CORNER_WIDTH,
                        height: CORNER_HEIGHT,
                        decoration: BoxDecoration(
                          border: Border(
                            top: corner_border_side,
                            right: corner_border_side,
                          ),

                        )
                    )
                ),

                Positioned(
                    bottom: 0,
                    left: 0,
                    child: Container(
                        width: CORNER_WIDTH,
                        height: CORNER_HEIGHT,
                        decoration: BoxDecoration(

                          border: Border(
                            bottom: corner_border_side,
                            left: corner_border_side,
                          ),

                        )
                    )
                ),

                Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                        width: CORNER_WIDTH,
                        height: CORNER_HEIGHT,
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: corner_border_side,
                            right: corner_border_side,
                          ),

                        )
                    )
                ),
              ]
          )
      );
    });

  }

}