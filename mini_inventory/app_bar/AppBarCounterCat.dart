import 'package:flutter/material.dart';
import 'package:mini_inventory/mini_inventory/menu_counter_cat/CounterCatAddNewView.dart';
import 'package:mini_inventory/mini_inventory/model/CounterCatModel.dart';
import 'package:mini_inventory/mini_inventory/provider/MiniInventoryCounterProvider.dart';
import 'package:mini_inventory/mini_inventory/provider/MiniInventoryNavProvider.dart';
import 'package:mini_inventory/mini_inventory/provider/MiniInventorySettingProvider.dart';
import 'package:provider/provider.dart';

class AppBarCounterCat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer3<SettingProvider, AppNavProvider, CounterProvider>(
        builder: (context, settingProvider, appNavProvider, counterProvider, child) {
          return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [




              if (settingProvider.getEditCounterCatMode())
                IconButton(
                    icon: Icon(Icons.arrow_back_ios),
                    iconSize: 30,
                    color: settingProvider.getAppThemeData().accentColor,
                    onPressed: () {
                      settingProvider.toggleEditCounterCatMode();
                    })
              else
                IconButton(
                    icon: Icon(Icons.edit),
                    iconSize: 30,
                    color: settingProvider.getAppThemeData().accentColor,
                    onPressed: () {
                      settingProvider.toggleEditCounterCatMode();
                    })
              ,

              Text('Category Setup', style: Theme.of(context).textTheme.headline6)

              ,


              IconButton(
                  icon: Icon(Icons.add),
                  iconSize: 30,
                  color: settingProvider.getAppThemeData().accentColor,
                  onPressed: () async {

                    CounterCatModel new_counterCat_model = await counterProvider.getNewCounterCatModel();

                    Navigator.push(context, _createAddCounterCatPageRoute(new_counterCat_model));
                  }),

          ]);
        });
  }

  Route _createAddCounterCatPageRoute(CounterCatModel newCounterCatModel) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          CounterCatAddNewView(newCounterCatModel: newCounterCatModel),
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
