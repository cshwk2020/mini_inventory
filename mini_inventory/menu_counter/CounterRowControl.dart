
import 'package:flutter/material.dart';
import 'package:mini_inventory/mini_inventory/model/CounterCatModel.dart';
import 'package:mini_inventory/mini_inventory/model/CounterModel.dart';
import 'package:mini_inventory/mini_inventory/provider/LocalCounterInputProvider.dart';
import 'package:mini_inventory/mini_inventory/provider/MiniInventoryCounterProvider.dart';
import 'package:mini_inventory/mini_inventory/provider/MiniInventorySettingProvider.dart';
import 'package:provider/provider.dart';

import 'CounterRow.dart';
import 'CounterRowInput.dart';

class CounterRowControl extends StatefulWidget {

  CounterRowControl({this.counterModel, this.counterCatModel});

  CounterModel counterModel;
  CounterCatModel counterCatModel;

  //bool isInputDigitMode = false;

  @override
  State<StatefulWidget> createState() => CounterRowControlState();

}

class CounterRowControlState extends State<CounterRowControl> {
  @override
  Widget build(BuildContext context) {

    return Consumer3<SettingProvider, CounterProvider, LocalCounterInputProvider>(

      builder: (context, setting_provider, counterProvider, localCounterInputProvider,  child) {

        return Column(

          children: [

            CounterRow(
                counterModel: widget.counterModel, counterCatModel: widget.counterCatModel,
                onInputDigitModeClicked: (CounterModel counterModel){
                  setState(() {
                    localCounterInputProvider.setInputDigitMode(true);
                  });

                }
            )
            ,

            if (localCounterInputProvider.getInputDigitMode() == true)

                CounterRowInput(

                  counterModel: widget.counterModel,

                  onExitInputEvent: () {

                    setState(() {

                      localCounterInputProvider.setInputDigitMode(false);
                    });
                  },

                  onFinishInputEvent: (int delta) {
                    setState(() {

                      localCounterInputProvider.setInputDigitMode(false);
                      counterProvider.onDeltaCounterValue(counterModel: widget.counterModel, delta: delta);
                    });
                  }
              )

          ]

        );


      });


  }


}