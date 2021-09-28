import 'package:flutter/material.dart';
import 'package:mini_inventory/mini_inventory/provider/MiniInventoryCounterProvider.dart';
import 'package:mini_inventory/mini_inventory/provider/MiniInventoryNavProvider.dart';
import 'package:mini_inventory/mini_inventory/provider/MiniInventorySettingProvider.dart';
import 'package:provider/provider.dart';

class AppBarSetting extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Consumer3<SettingProvider, AppNavProvider, CounterProvider>(
        builder: (context, settingProvider, appNavProvider, counterProvider, child) {
          return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [

            Container(),
            Text('Setting', style: Theme.of(context).textTheme.headline6),
            Container(),
            
          ]);
        });
  }

}
