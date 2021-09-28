import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mini_inventory/mini_inventory/model/CounterCatModel.dart';
import 'package:mini_inventory/mini_inventory/provider/MiniInventoryCounterProvider.dart';
import 'package:mini_inventory/mini_inventory/provider/MiniInventorySettingProvider.dart';

class CounterCatDropdownWidget extends StatefulWidget {

  CounterCatDropdownWidget({this.onSelectCounterCatModel, this.counterCatList, this.selectedCounterCat});

  final List<CounterCatModel> counterCatList;
  final Function(CounterCatModel model) onSelectCounterCatModel;
  CounterCatModel selectedCounterCat;

  CounterCatModel getCounterCat(int counterCarId) {
    return counterCatList.where((cat) => cat.counterCatId==counterCarId).first;
  }

  @override
  State<StatefulWidget> createState() {

    /*
    if (selectedCounterCat == null && counterCatList.isNotEmpty) {
      selectedCounterCat = counterCatList.first;
    }

     */

    return _CounterCatDropdownState();
  }
}

class _CounterCatDropdownState extends State<CounterCatDropdownWidget> {

  List<DropdownMenuItem<CounterCatModel>> _getDropdownMenuItemList() {

    List<DropdownMenuItem<CounterCatModel>> result = widget.counterCatList.map((cat) {

      print("DropdownMenuItem...cat == ${cat.counterCatId}...${cat.counterCatTitle}");

      return DropdownMenuItem(
        child: Text(
          cat.counterCatTitle,
          overflow: TextOverflow.ellipsis,
        ),
        value: cat,
      );

    }).toList();

    /*
    result.insert(0,
        DropdownMenuItem(
          child: Text( "-- Select --" ),
          value: "-1",
        )
    );

     */

    return result.toList();
  }

  @override
  Widget build(BuildContext context) {

    print("rebuilt...");

    return Consumer2<SettingProvider, CounterProvider>(
        builder: (context, settingProvider, counterProvider, child) {


          if (widget.counterCatList.isNotEmpty && widget.counterCatList.length > 0) {

            var dropdown_menu_list = _getDropdownMenuItemList().toList();


            return Column(
              children: [

                /*
                if (widget.selectedCounterCat==null)
                  Text("selectedCounterCat == null")
                else
                  Text("selectedCounterCat == ${widget.selectedCounterCat.counterCatTitle}")
                */



                DropdownButton<CounterCatModel>(
                    isExpanded: true,
                    value: (widget.selectedCounterCat != null) ? widget.getCounterCat(widget.selectedCounterCat.counterCatId) : null,
                    items: _getDropdownMenuItemList().toList(),

                    onChanged: (CounterCatModel value) {

                      setState(() {
                        widget.selectedCounterCat = value;
                        widget.onSelectCounterCatModel(value);

                      });
                    },
                    hint: Text("-- Select --")
                )

              ]
            );

          }
          else {
            return Container (
              child: Text("No Category")
            );

          }

    });
  }
}
