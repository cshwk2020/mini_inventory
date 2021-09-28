import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mini_inventory/mini_inventory/app_bar/AppBarCounterCat.dart';
import 'package:mini_inventory/mini_inventory/app_bar/AppBarReporting.dart';
import 'package:mini_inventory/mini_inventory/provider/MiniInventoryCounterProvider.dart';
import 'package:mini_inventory/mini_inventory/provider/MiniInventoryNavProvider.dart';
import 'package:mini_inventory/mini_inventory/provider/MiniInventorySettingProvider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'menu_counter/CounterAddNewView.dart';
import 'app_bar/AppBarCounter.dart';
import 'app_bar/AppBarSetting.dart';
import 'model/CounterCatModel.dart';
import 'model/CounterModel.dart';

class MiniInventoryAppBarView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppNavProvider>(
        builder: (context, appNavProvider, child) {

        if (appNavProvider.isNavMode_counter()) {
          return AppBarCounter();
        }
        else if (appNavProvider.isNavMode_counterCat()) {
          return AppBarCounterCat();
        }
        else if (appNavProvider.isNavMode_reporting()) {
          return AppBarReporting();
        }
        else if (appNavProvider.isNavMode_setting()) {
          return AppBarSetting();
        }
        else {
          return Center(
            child:  Text(AppLocalizations.of(context).unknownMenuOption)
          );
        }


    });
  }

}
