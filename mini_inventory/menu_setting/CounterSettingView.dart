import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:mini_inventory/mini_inventory/app_bar/AppBarSetting.dart';
import 'package:mini_inventory/mini_inventory/model/CounterLayoutMode.dart';
import 'package:mini_inventory/mini_inventory/provider/MiniInventorySettingProvider.dart';
import 'package:mini_inventory/mini_inventory/theme/CommonStyle.dart';
import 'package:mini_inventory/mini_inventory/widget/CircularButton.dart';
import 'package:mini_inventory/mini_inventory/widget/CommonWidgetHelper.dart';
import 'package:mini_inventory/mini_inventory/widget/CustomSwitch.dart';

class CounterSettingView extends StatefulWidget {

  String selectedCounterLayout = CounterLayoutMode.Layout_Minus_Plus;

  List<DropdownMenuItem<String>> _getCounterLayoutDropdownMenuItemList() {
    List<DropdownMenuItem<String>> result = [

      CommonWidgetHelper.getMinusPlusDropdownMenuItem(
        val: CounterLayoutMode.Layout_Minus_Plus,
        buttonWidth: 50,
        plusOnClicked: (){},
        minusOnClicked: (){}
      ),

      CommonWidgetHelper.getPlusMinusDropdownMenuItem(
          val: CounterLayoutMode.Layout_Plus_Minus,
          buttonWidth: 50,
          plusOnClicked: (){},
          minusOnClicked: (){}
      ),

    ];

    return result;
  }


    @override
    State<StatefulWidget> createState() => CounterSettingState();

}

class CounterSettingState extends State<CounterSettingView> {


  @override
  Widget build(BuildContext context) {
    return Consumer<SettingProvider>(
        builder: (context, settingProvider, child) {
      return Scaffold(
          appBar: AppBar(
          title: AppBarSetting()
          ),
          body: SizedBox(
        width: MediaQuery.of(context).size.width, // hard coding child width

        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Card(child: _buildDarkModeSetting(context, settingProvider)),

          Card(child: _buildCounterLayoutSetting(context, settingProvider)),

        ]),
      ));
    });
  }

  Widget _buildDarkModeSetting(BuildContext context, SettingProvider settingProvider) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text("DarkMode", style: Theme.of(context).textTheme.headline6),
      Switch(
        value: settingProvider.isDarkThemeMode(),
        onChanged: (bool isDarkMode) {
          print("Switch onChanged");
          settingProvider.setAppThemeMode(isDarkMode);
        },
      )
    ]);
  }

  Widget _buildCounterLayoutSetting(BuildContext context, SettingProvider settingProvider) {

    return Column(

      crossAxisAlignment: CrossAxisAlignment.start,

      children: [

        Text("ItemLayout", style: Theme.of(context).textTheme.headline6),

        SizedBox(height: 10,),

        Container(

            child: DropdownButton<String>(
                itemHeight: 80,
                isExpanded: true,
              value: settingProvider.getCounterLayoutMode(), //widget.selectedCounterLayout,
              items: widget._getCounterLayoutDropdownMenuItemList(),
                hint: Text("-- Select --"),
            onChanged: (String value) {
              setState(() {
              //widget.selectedCounterLayout = value;
              settingProvider.setCounterLayoutMode(value);
            });

          })

        )
      ]
    );

  }




}
