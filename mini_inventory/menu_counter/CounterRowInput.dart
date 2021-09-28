import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:mini_inventory/mini_inventory/common/DialogHelper.dart';
import 'package:mini_inventory/mini_inventory/model/CounterCatModel.dart';
import 'package:mini_inventory/mini_inventory/model/CounterModel.dart';
import 'package:mini_inventory/mini_inventory/provider/LocalCounterInputProvider.dart';
import 'package:mini_inventory/mini_inventory/provider/MiniInventoryCounterProvider.dart';
import 'package:mini_inventory/mini_inventory/provider/MiniInventorySettingProvider.dart';
import 'package:mini_inventory/mini_inventory/widget/CustomActionButton.dart';
import 'package:mini_inventory/mini_inventory/widget/RectButton.dart';

import 'CounterRowDetail.dart';

class CounterRowInput extends StatefulWidget {
  CounterRowInput({ @required this.counterModel,
    @required this.onExitInputEvent, @required this.onFinishInputEvent });

  CounterModel counterModel;
  Function() onExitInputEvent;
  Function(int delta) onFinishInputEvent;

  TextEditingController changeValueController = new TextEditingController();

  void onMinusButtonConfirmed(BuildContext context, SettingProvider settingProvider) {
    int delta = int.tryParse(changeValueController.text);
    if (delta != null) {

      if ((counterModel.counterValue - delta) >= settingProvider.get_MIN_COUNTER_VALUE()) {
        onFinishInputEvent(-1 * delta);
      }
      else {

        Scaffold.of(context).showSnackBar(
          SnackBar(
              content:  Text('Stock Value Cannot Be Less Than Zero')
          )

        );



      }

    }
  }

  void onPlusButtonConfirmed(BuildContext context, SettingProvider settingProvider) {

    int delta = int.tryParse(changeValueController.text);
    if (delta != null) {
      if ((counterModel.counterValue + delta) <= settingProvider.get_MAX_COUNTER_VALUE()) {
        onFinishInputEvent(delta);
      }
      else {

        Scaffold.of(context).showSnackBar(
            SnackBar(
                content:  Text('Stock Value Too Large')
            )

        );



      }

    }
  }

  void onDigitClicked(String digit) {

    ////////////////////////////////////////////////
    // PreProcessing

    if (digit != '<') {
      if (changeValueController.text.length > 5) {
        return;
      }
    }


    if (changeValueController.text == '0') {
      changeValueController.text = '';
    }

    ////////////////////////////////////////////////
    // Processing

    if (digit == '<') {
      if (changeValueController.text.length > 0) {
        changeValueController.text = changeValueController.text.substring(0, changeValueController.text.length-1);
      }
    }
    else {
      changeValueController.text = '${changeValueController.text}${digit}';
    }

    ////////////////////////////////////////////////
    // Post Processing

    if (changeValueController.text.isEmpty || changeValueController.text.length == 0) {
      changeValueController.text = '0';
    }
    
  }

  @override
  State<StatefulWidget> createState() {

    changeValueController.text = "0";

    return CounterRowInputState();
  }

}

class CounterRowInputState extends State<CounterRowInput> {


  @override
  Widget build(BuildContext context) {


    widget.changeValueController.addListener(() {
      print("changeValueController...Listener...");
      setState(() {

      });
    });


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

                        Divider(
                          height: 1,
                          color: settingProvider.getAppThemeData().accentColor,
                        ),

                        SizedBox(height: 20),

                      _buildCounterChangeValueView(settingProvider, localCounterInputProvider),


                        /*
                        Divider(
                          height: 1,
                          color: settingProvider.getAppThemeData().accentColor,
                        ),
                        SizedBox(height: 10),
                         */

                        Container(
                          child: _buildCounterRowInputDetail(settingProvider ),
                        )


                      ]));
            }));
      },
    );
  }

  Table _buildCounterRowInputDetail(SettingProvider settingProvider) {

    return Table(
        //border: TableBorder.all(color: settingProvider.getAppThemeData().accentColor),

        children: [

          TableRow(children: [

            _buildDigitButton(settingProvider, '1', (){ widget.onDigitClicked('1'); }),
            _buildDigitButton(settingProvider, '2', (){ widget.onDigitClicked('2'); }),
            _buildDigitButton(settingProvider, '3', (){ widget.onDigitClicked('3'); }),
            _buildDigitButton(settingProvider, '4', (){ widget.onDigitClicked('4'); }),
            _buildDigitButton(settingProvider, '5', (){ widget.onDigitClicked('5'); }),

          ]),

          TableRow(children: [

            _buildDigitButton(settingProvider, '6', (){ widget.onDigitClicked('6'); }),
            _buildDigitButton(settingProvider, '7', (){ widget.onDigitClicked('7'); }),
            _buildDigitButton(settingProvider, '8', (){ widget.onDigitClicked('8'); }),
            _buildDigitButton(settingProvider, '9', (){ widget.onDigitClicked('9'); }),
            _buildDigitButton(settingProvider, '0', (){ widget.onDigitClicked('0'); }),

          ]),

          TableRow(children: [

            _buildDigitButton(settingProvider, ' del ', (){
              widget.onDigitClicked('<');
            }),

            Container(),

            Container(),

            /*
            _buildNonDigitButton(
                settingProvider,
                ' << ',
                settingProvider.getAppThemeData().accentColor,
                settingProvider.getAppThemeData().primaryColor,
                () {

                  widget.onExitInputEvent();
                }),

             */

            _buildNonDigitButton(
                settingProvider,
                ' - ',
                Colors.white,
                Colors.red,
                    () {
                       widget.onMinusButtonConfirmed(context, settingProvider);

                    }),

            _buildNonDigitButton(
                settingProvider,
                ' + ',
                Colors.white,
                Colors.green,
                    () {

                      widget.onPlusButtonConfirmed(context, settingProvider);

                    })


          ]),


    ]);

  }

  Widget _buildDigitButton(SettingProvider settingProvider, String text, Function() onClicked) {

    return Container(
      padding: EdgeInsets.all(3),
      child: RectButton(
          buttonText: text,
          buttonWidth: 30,
          textStyle: GoogleFonts.openSans(
              fontSize: 16.0, fontWeight: FontWeight.w600, color: settingProvider.getAppThemeData().accentColor),
          backgroundColor: Colors.transparent,
          onClicked: () {

            onClicked();
          }),

    );
  }

  Widget _buildNonDigitButton(
      SettingProvider settingProvider,
      String text,
      Color color,
      Color backgroundColor,
      Function() onClicked) {

    return Container(
      padding: EdgeInsets.all(3),
      child: RectButton(
          buttonText: text,
          buttonWidth: 30,
          textStyle: GoogleFonts.openSans(
              fontSize: 20.0, fontWeight: FontWeight.w600, color: color),
          backgroundColor: backgroundColor,
          onClicked: () {

            onClicked();
          }),

    );
  }

  Widget _buildCounterChangeValueView(settingProvider, localCounterInputProvider) {

      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          SizedBox(width: 10)
          ,
        Text('Change By: ',
          style: settingProvider.getAppThemeData().textTheme.headline6)
          ,
          SizedBox(width: 10)
          ,
          Expanded(
            child: Container(

                width: double.infinity,
                height: 50,

                decoration: BoxDecoration(
                    border: Border.all(color: settingProvider.getAppThemeData().accentColor)
                ),

                child: TextField(
                  enabled: false,
                  controller: widget.changeValueController,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ], // Only numbers can be entered

                  textAlign: TextAlign.right,


                  style: settingProvider.getAppThemeData().textTheme.headline1,
                )
            )
          )


    ]);

  }

}
