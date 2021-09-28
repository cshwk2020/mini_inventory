import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mini_inventory/mini_inventory/model/CounterCatModel.dart';
import 'package:mini_inventory/mini_inventory/model/CounterModel.dart';
import 'package:mini_inventory/mini_inventory/provider/MiniInventoryCounterProvider.dart';
import 'package:mini_inventory/mini_inventory/provider/MiniInventorySettingProvider.dart';

import '../widget/CornerFrameView.dart';
import '../widget/CircularButton.dart';


class CounterCatRow extends StatelessWidget {
  CounterCatRow({this.counterCatModel });

  CounterCatModel counterCatModel;

  @override
  Widget build(BuildContext context) {
    return Consumer2<SettingProvider, CounterProvider>(
      builder: (context, settingProvider, counterProvider, child) {
        return Container(
                  padding: EdgeInsets.all(6),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        SizedBox(height: 16),

                        Text(
                            '${counterCatModel.counterCatTitle}',
                            style: settingProvider
                                .getAppThemeData()
                                .textTheme
                                .headline6),

                        SizedBox(height: 16),

                      ])
      );

    } );
  }
}
