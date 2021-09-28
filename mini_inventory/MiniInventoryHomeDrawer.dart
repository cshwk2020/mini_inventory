
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mini_inventory/mini_inventory/provider/MiniInventoryNavProvider.dart';
import 'package:mini_inventory/mini_inventory/provider/MiniInventorySettingProvider.dart';
import 'package:mini_inventory/mini_inventory/theme/AppNavMode.dart';
import 'package:mini_inventory/mini_inventory/widget/TopLevelNavigatorWrapper.dart';

import 'menu_counter_cat/CounterCatMainView.dart';
import 'menu_counter/CounterMainView.dart';
import 'menu_reporting/ReportLogCatView.dart';
import 'menu_setting/CounterSettingView.dart';
import 'MiniInventoryAppBar.dart';
import 'model/AppGlobal.dart';

class MiniInventoryHomeDrawer extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _MiniInventoryHomeDrawerState();

}

class _MiniInventoryHomeDrawerState extends State<MiniInventoryHomeDrawer> {

  List<Widget> pages = <Widget>[
    TopLevelNavigatorWrapper(child: CounterMainView()),
    TopLevelNavigatorWrapper(child: CounterCatMainView()),
    TopLevelNavigatorWrapper(child: ReportLogCatView()),
    TopLevelNavigatorWrapper(child: CounterSettingView()),
  ];

  @override
  void initState() {

    super.initState();
  }



  @override
  Widget build(BuildContext context) {

    return Consumer2<SettingProvider, AppNavProvider>( builder: (context, settingProvider, appNavProvider, child)
    {
      return GestureDetector(
          onTap: () => AppGlobal.hideKeyboard(context),
          child:  Scaffold(

          appBar: AppBar(
            title: Text("Mini Inventory"),

          ),

            drawer: getDrawer(settingProvider),


            body: Container()
          )
      );


    });


  }


  Drawer getDrawer(SettingProvider settingProvider) {

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
          children: [

            DrawerHeader(

              decoration: BoxDecoration(

              ),

              child: Text("Mini Inventory")
            ),


            ListTile(
              leading: Text("+/-"),
              title: Text("Items", style: settingProvider.getAppThemeData().textTheme.headline6),
              onTap: () {

                Navigator.pop(context);
                Navigator.push( context,  MaterialPageRoute(builder: (BuildContext context) {
                  return pages[0];
                }));

              },
            )

          ]

      )

    );
  }

}