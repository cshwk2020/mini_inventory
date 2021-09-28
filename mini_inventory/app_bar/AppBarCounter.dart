import 'package:flutter/material.dart';
import 'package:mini_inventory/mini_inventory/model/CounterCatModel.dart';
import 'package:mini_inventory/mini_inventory/model/CounterModel.dart';
import 'package:mini_inventory/mini_inventory/provider/MiniInventoryCounterProvider.dart';
import 'package:mini_inventory/mini_inventory/provider/MiniInventoryNavProvider.dart';
import 'package:mini_inventory/mini_inventory/provider/MiniInventorySettingProvider.dart';
import 'package:provider/provider.dart';

import '../menu_counter/CounterAddNewView.dart';



class AppBarCounter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer3<SettingProvider, AppNavProvider, CounterProvider>(
        builder: (context, settingProvider, appNavProvider, counterProvider, child) {
          return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [

                if (settingProvider.getEditCounterMode())
                  IconButton(
                      icon: Icon(Icons.arrow_back_ios),
                      iconSize: 30,
                      color: settingProvider.getAppThemeData().accentColor,
                      onPressed: () {
                        settingProvider.toggleEditCounterMode();
                      })
                else
                  IconButton(
                      icon: Icon(Icons.edit),
                      iconSize: 30,
                      color: settingProvider.getAppThemeData().accentColor,
                      onPressed: () {
                        settingProvider.toggleEditCounterMode();
                      })
                ,


                if (settingProvider.getEditCounterMode())
                  Text('StockTake', style: Theme.of(context).textTheme.headline6)
                else
                  Text('Counters', style: Theme.of(context).textTheme.headline6)

                ,

                IconButton(
                    icon: Icon(Icons.add),
                    iconSize: 30,
                    color: settingProvider.getAppThemeData().accentColor,
                    onPressed: () async {

                      List<CounterCatModel> all_counterCat_list = await counterProvider.counterRepository.getAllCounterCats();
                      CounterModel new_counter_model = await counterProvider.getNewCounterModel(all_counterCat_list.first.counterCatId);

                      Navigator.push(context, _createAddCounterPageRoute(all_counterCat_list, new_counter_model));
                    }),

          ]);
        });
  }



  Route _createAddCounterPageRoute(List<CounterCatModel> counterCatList, CounterModel newCounterModel) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          CounterAddNewView(counterCatList: counterCatList, newCounterModel: newCounterModel),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
        Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}
