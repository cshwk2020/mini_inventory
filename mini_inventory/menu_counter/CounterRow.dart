import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mini_inventory/mini_inventory/model/CounterCatModel.dart';
import 'package:mini_inventory/mini_inventory/model/CounterModel.dart';
import 'package:mini_inventory/mini_inventory/provider/LocalCounterInputProvider.dart';
import 'package:mini_inventory/mini_inventory/provider/MiniInventoryCounterProvider.dart';
import 'package:mini_inventory/mini_inventory/provider/MiniInventorySettingProvider.dart';
import 'package:mini_inventory/mini_inventory/widget/RectButton.dart';
import 'package:provider/provider.dart';

import '../widget/CornerFrameView.dart';
import '../widget/CircularButton.dart';
import 'CounterRowDetail.dart';

class CounterRow extends StatelessWidget {
  CounterRow({this.counterModel, this.counterCatModel, this.onInputDigitModeClicked});

  CounterModel counterModel;
  CounterCatModel counterCatModel;

  Function(CounterModel counterModel) onInputDigitModeClicked;

  @override
  Widget build(BuildContext context) {
    return Consumer3<SettingProvider, CounterProvider, LocalCounterInputProvider>(
      builder: (context, settingProvider, counterProvider, localCounterInputProvider, child) {
        return Container(
            padding: const EdgeInsets.all(2),
            child: OrientationBuilder(builder: (context, orientation) {
              return Container(
                  padding: EdgeInsets.all(6),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row (

                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [

                            Expanded(
                              child: Text(
                                  '${counterCatModel.counterCatTitle} / ${counterModel.counterTitle}',
                                  style: settingProvider
                                      .getAppThemeData()
                                      .textTheme
                                      .headline6),
                            ),


                            _buildCounterInputView(settingProvider, localCounterInputProvider),

                          ]
                        ),

                        Divider(
                          height: 1,
                          color: settingProvider.getAppThemeData().accentColor,
                        ),
                        SizedBox(height: 10),
                        Container(
                          child: CounterRowDetail(counterModel: counterModel),
                        )
                      ]));
            }));
      },
    );
  }

  Widget _buildCounterInputView(SettingProvider settingProvider,
      LocalCounterInputProvider localCounterInputProvider) {

    var textStyle = GoogleFonts.openSans(
        fontSize: 20.0, fontWeight: FontWeight.w600, color: settingProvider.getAppThemeData().accentColor);

    var backgroundColor = Colors.transparent;

    if (localCounterInputProvider.getInputDigitMode() == false) {

      return RectButton(
          buttonText: '+/-',
          buttonWidth: 60,
          textStyle: textStyle,
          backgroundColor: backgroundColor,
          onClicked: () {

            print("_buildCounterInputView :: onInputDigitButtonClicked...${counterModel.counterTitle}");

            localCounterInputProvider.setInputDigitMode(true);

          });
    }
    else {

      return RectButton(
          buttonText: '<<',
          buttonWidth: 60,
          textStyle: textStyle,
          backgroundColor: backgroundColor,
          onClicked: () {

            print("_buildCounterInputView :: onInputDigitButtonClicked...${counterModel.counterTitle}");

            localCounterInputProvider.setInputDigitMode(false);

          });
    }



  }
}
