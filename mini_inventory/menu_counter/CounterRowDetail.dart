
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mini_inventory/mini_inventory/model/CounterLayoutMode.dart';
import 'package:mini_inventory/mini_inventory/model/CounterModel.dart';
import 'package:mini_inventory/mini_inventory/provider/LocalCounterInputProvider.dart';
import 'package:mini_inventory/mini_inventory/provider/MiniInventoryCounterProvider.dart';
import 'package:mini_inventory/mini_inventory/provider/MiniInventorySettingProvider.dart';
import 'package:mini_inventory/mini_inventory/widget/CustomActionButton.dart';
import 'package:mini_inventory/mini_inventory/provider/MiniInventorySettingProvider.dart';

import '../widget/CornerFrameView.dart';
import '../widget/CircularButton.dart';
import '../widget/CustomOverlayView.dart';
import 'package:google_fonts/google_fonts.dart';

class CounterRowDetail extends StatefulWidget {

  CounterRowDetail({this.counterModel});

  CounterModel counterModel;

  @override
  State<StatefulWidget> createState() => CounterRowDetailState();

}

class CounterRowDetailState extends State<CounterRowDetail> {

  static double MINUS_BUTTON_WIDTH = 60;
  static double PLUS_BUTTON_WIDTH = 60;
  static double MARGIN_WIDTH = 0;
  static double WIDGET_HEIGHT = PLUS_BUTTON_WIDTH + MARGIN_WIDTH;
  static TextStyle minusButtonTextStyle = GoogleFonts.openSans(
      fontSize: 32.0, fontWeight: FontWeight.w600, color: Colors.white);
  static TextStyle plusButtonTextStyle = GoogleFonts.openSans(
      fontSize: 32.0, fontWeight: FontWeight.w600, color: Colors.white);


  @override
  Widget build(BuildContext context) {

    return Consumer3<SettingProvider, CounterProvider, LocalCounterInputProvider>(
        builder: (_context, settingProvider, counterProvider, localCounterInputProvider, child) {


          return Stack (

            children: [

              Container(

                child: Row(

                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [

                      if (localCounterInputProvider.getInputDigitMode()==true)

                          Container()

                      else

                          if (settingProvider.getCounterLayoutMode() == CounterLayoutMode.Layout_Minus_Plus)
                            _buildMinusButton(settingProvider, counterProvider)
                          else
                            _buildPlusButton(settingProvider, counterProvider)

                      ,

                      SizedBox(width: 20)

                      ,

                      _buildCounterValueView(settingProvider, counterProvider, localCounterInputProvider)
                      ,

                      SizedBox(width: 20)

                      ,

                      if (localCounterInputProvider.getInputDigitMode()==true)

                          Container()

                      else

                          if (settingProvider.getCounterLayoutMode() == CounterLayoutMode.Layout_Minus_Plus)
                            _buildPlusButton(settingProvider, counterProvider)
                          else
                            _buildMinusButton(settingProvider,  counterProvider)




                    ])

              ),


            ]
          );


        });
  }




    Widget _buildCounterValueView(SettingProvider settingProvider,
        CounterProvider counterProvider, LocalCounterInputProvider localCounterInputProvider) {

      if (localCounterInputProvider.getInputDigitMode() == true) {
        return Text('Running Total: ${widget.counterModel.counterValue}',
            style:
            settingProvider.getAppThemeData().textTheme.headline3);
      }
      else {
        return Text('${widget.counterModel.counterValue}',
            style:
            settingProvider.getAppThemeData().textTheme.headline1);
      }


  }

    Widget _buildMinusButton(SettingProvider settingProvider, CounterProvider counterProvider) {

    return CircularButton(
        buttonText: '-',
        buttonWidth: MINUS_BUTTON_WIDTH,
        textStyle: minusButtonTextStyle,
        backgroundColor: Colors.red,
        onClicked: () {
          setState((){
            if (widget.counterModel.counterValue > 0) {
              counterProvider.onDeltaCounterValue(counterModel: widget.counterModel, delta: -1);
            }

          });
        });
  }

  Widget _buildPlusButton(SettingProvider settingProvider, CounterProvider counterProvider) {

    return CircularButton(
        buttonText: '+',
        buttonWidth: PLUS_BUTTON_WIDTH,
        textStyle: plusButtonTextStyle,
        backgroundColor: Colors.green,
        onClicked: () {
          setState((){
            counterProvider.onDeltaCounterValue(counterModel: widget.counterModel, delta: 1);
          });

        }
    );
  }



}