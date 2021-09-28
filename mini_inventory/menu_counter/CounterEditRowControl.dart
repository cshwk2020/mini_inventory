import 'package:flutter/material.dart';
import 'package:mini_inventory/mini_inventory/model/CounterCatModel.dart';
import 'package:mini_inventory/mini_inventory/model/CounterModel.dart';
import 'package:mini_inventory/mini_inventory/provider/MiniInventoryCounterProvider.dart';
import 'package:mini_inventory/mini_inventory/provider/MiniInventorySettingProvider.dart';
import 'package:provider/provider.dart';

import 'CounterEditRow.dart';
import 'CounterEditRowInput.dart';
import 'CounterRow.dart';
import 'CounterRowInput.dart';

class CounterEditRowControl extends StatefulWidget {
  CounterEditRowControl({this.counterModel, this.counterCatList});

  List<CounterCatModel> counterCatList;
  CounterModel counterModel;

  bool isInputDigitMode = false;

  @override
  State<StatefulWidget> createState() => _CounterEditRowControlState();
}

class _CounterEditRowControlState extends State<CounterEditRowControl> {
  @override
  Widget build(BuildContext context) {
    return Consumer2<SettingProvider, CounterProvider>(
        builder: (context, setting_provider, counterProvider, child) {
      return Column(children: [
        CounterEditRow(
            counterModel: widget.counterModel,
            counterCatList: widget.counterCatList,
            onInputDigitModeEvent: (counterMode) => setState(() {
                widget.isInputDigitMode = true;
              })
            ,
        ),

        if (widget.isInputDigitMode == true)
          CounterEditRowInput(
              counterModel: widget.counterModel,
              onExitInputEvent: () {
                setState(() {
                  widget.isInputDigitMode = false;
                });
              },
              onFinishInputEvent: (int newValue) {
                setState(() {

                  widget.counterModel.counterValue = newValue;

                  counterProvider.adjustCounterValue(

                      counterModel: widget.counterModel, isForceRefresh: false);

                  widget.isInputDigitMode = false;
                });
              })


      ]);
    });
  }
}
