
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mini_inventory/mini_inventory/provider/MiniInventoryNavProvider.dart';
import 'package:mini_inventory/mini_inventory/provider/MiniInventorySettingProvider.dart';
import 'package:mini_inventory/mini_inventory/theme/AppNavMode.dart';
import 'package:mini_inventory/mini_inventory/widget/TopLevelNavigatorWrapper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'menu_counter_cat/CounterCatMainView.dart';
import 'menu_counter/CounterMainView.dart';
import 'menu_reporting/ReportLogCatView.dart';
import 'menu_setting/CounterSettingView.dart';
import 'MiniInventoryAppBar.dart';
import 'model/AppGlobal.dart';

class MiniInventoryHomeBottomBar extends StatefulWidget {



  @override
  State<StatefulWidget> createState() => _MiniInventoryHomeBottomBarState();

}

class _MiniInventoryHomeBottomBarState extends State<MiniInventoryHomeBottomBar> {

  static List<Widget> _pages = <Widget>[
    TopLevelNavigatorWrapper(child: CounterMainView()),
    TopLevelNavigatorWrapper(child: CounterCatMainView()),
    TopLevelNavigatorWrapper(child: ReportLogCatView()),
    TopLevelNavigatorWrapper(child: CounterSettingView()),
  ];

  static Widget getPages(int index) {

    switch(index) {

      case 0:
        if (_pages[0]==null) {
          _pages[0] = TopLevelNavigatorWrapper(child: CounterMainView());
        }
        break;

      case 1:
        if (_pages[1]==null) {
          _pages[1] = TopLevelNavigatorWrapper(child: CounterCatMainView());
        }
        break;

      case 2:
        if (_pages[2]==null) {
          _pages[2] = TopLevelNavigatorWrapper(child: ReportLogCatView());
        }
        break;

      case 3:
        if (_pages[3]==null) {
          _pages[3] = TopLevelNavigatorWrapper(child: CounterSettingView());
        }
        break;
    }


    return _pages[index];


  }


  @override
  void initState() {
    super.initState();
  }

  void _onItemTapped(int index, AppNavProvider appNavProvider) {

      print("_onItemTapped...${index}");

      setState( () {

        print("_selectedIndex == ${ getPages(appNavProvider.getSelectedIndex())}");
        appNavProvider.setSelectedIndex(index);
        print("_selectedIndex == ${ getPages(appNavProvider.getSelectedIndex())}");

      } );
  }

  @override
  Widget build(BuildContext context) {


    return Consumer2<SettingProvider, AppNavProvider>( builder: (context, settingProvider, appNavProvider, child)
    {
      return GestureDetector(
        onTap: () => AppGlobal.hideKeyboard(context),
        child:  Scaffold(
          /*
          appBar: AppBar(
            title: MiniInventoryAppBarView(),
          ),
           */
          body: Center(

            child: IndexedStack(
              index: appNavProvider.getSelectedIndex(),
              children: _pages,
            )

            //pages[appNavProvider.getSelectedIndex()],
          ),

          bottomNavigationBar: BottomNavigationBar(
              currentIndex: appNavProvider.getSelectedIndex(),
              onTap: (index)=> _onItemTapped(index, appNavProvider),

              selectedLabelStyle: settingProvider.getAppThemeData().textTheme.headline6,
              selectedItemColor: settingProvider.getAppThemeData().accentColor,
              unselectedItemColor: Colors.grey,
              showUnselectedLabels: true,

              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem (
                  icon: Icon(Icons.add_circle_outline),
                  label: AppLocalizations.of(context).items,

                ),

                BottomNavigationBarItem (
                  icon: Icon(Icons.category),
                  label: AppLocalizations.of(context).category,
                ),

                BottomNavigationBarItem (
                  icon: Icon(Icons.article_outlined),
                  label: AppLocalizations.of(context).reporting,
                ),

                BottomNavigationBarItem (
                  icon: Icon(Icons.settings),
                  label: AppLocalizations.of(context).setting,
                )

              ]
          ),

        )
      );

    });

  }

}