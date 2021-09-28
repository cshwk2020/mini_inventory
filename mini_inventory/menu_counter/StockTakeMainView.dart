import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mini_inventory/mini_inventory/app_bar/AppBarCounter.dart';
import 'package:mini_inventory/mini_inventory/provider/LocalCounterInputProvider.dart';
import 'package:mini_inventory/mini_inventory/provider/MiniInventoryCounterProvider.dart';
import 'package:mini_inventory/mini_inventory/provider/MiniInventorySettingProvider.dart';
import 'package:mini_inventory/mini_inventory/widget/CounterCatDropdown.dart';
import 'package:mini_inventory/mini_inventory/menu_counter/CounterRow.dart';

import '../MiniInventoryAppBar.dart';
import 'CounterEditRow.dart';
import '../model/CounterCatModel.dart';
import '../model/CounterModel.dart';
import 'CounterEditRowControl.dart';
import 'CounterRowControl.dart';

class StockTakeMainView extends StatefulWidget {
  CounterCatModel selectedCounterCat;

  int getSelectedCounterCat() {
    if (selectedCounterCat == null) {
      return -1;
    } else {
      return selectedCounterCat.counterCatId;
    }
  }

  @override
  State<StatefulWidget> createState() => StockTakeMainViewState();
}

class StockTakeMainViewState extends State<StockTakeMainView>
    with AutomaticKeepAliveClientMixin<StockTakeMainView> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    print("CounterMainState...Widget build...");

    return Consumer2<SettingProvider, CounterProvider>(
        builder: (context, settingProvider, counterProvider, child) {
          print("here...10...???");

          return Scaffold(
              appBar: AppBar(
                title: AppBarCounter(),
              ),
              body: FutureBuilder(
                  future: Future.wait([
                    counterProvider.counterRepository.getAllCounters(
                        counterCatId: widget.getSelectedCounterCat()),
                    counterProvider.counterRepository.getAllCounterCats(),
                  ]),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Container(child: CircularProgressIndicator());
                    } else if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasError) {
                        return Container(
                            child: Text("${snapshot.error.toString()}"));
                      }
                    } else {
                      return Text("UNKNOWN ConnectionState");
                    }

                    List<CounterModel> all_counters_list = snapshot.data[0];
                    List<CounterCatModel> all_counterCat_list = snapshot.data[1];

                    return Column(

                        children: [

                          Container(
                              height: 65,
                              padding: EdgeInsets.all(3),
                              child: Card(
                                child: _buildEditCatDropDownView(
                                    context,
                                    settingProvider,
                                    counterProvider,
                                    all_counterCat_list),
                              ))
                          ,

                          Expanded(
                              child: ListView(key: PageStorageKey(0),

                                  children: [

                                    for (var counterModel in all_counters_list)

                                      if (counterModel.counterIsActive)
                                        Container(
                                            key: PageStorageKey(counterModel.counterId),
                                            padding: EdgeInsets.all(3),
                                            child: Card(
                                                child: CounterEditRowControl(
                                                    counterModel: counterModel,
                                                    counterCatList: all_counterCat_list)))

                                      else
                                        Container()


                                  ])

                          )

                        ]

                    );


                  }));
        });
  }

  Widget _buildEditCatDropDownView(
      BuildContext context,
      SettingProvider settingProvider,
      CounterProvider counterProvider,
      List<CounterCatModel> counterCatList) {
    return CounterCatDropdownWidget(
        selectedCounterCat: widget.selectedCounterCat,
        counterCatList: counterCatList,
        onSelectCounterCatModel: (cat) {
          setState(() {
            widget.selectedCounterCat = cat;
          });
        });
  }
}
