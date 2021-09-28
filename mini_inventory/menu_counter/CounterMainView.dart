import 'package:flutter/material.dart';
import 'package:mini_inventory/mini_inventory/app_bar/AppBarCounter.dart';
import 'package:mini_inventory/mini_inventory/provider/LocalCounterInputProvider.dart';
import 'package:mini_inventory/mini_inventory/provider/MiniInventoryCounterProvider.dart';
import 'package:mini_inventory/mini_inventory/provider/MiniInventorySettingProvider.dart';
import 'package:mini_inventory/mini_inventory/repository/ICounterRepository.dart';
import 'package:mini_inventory/mini_inventory/widget/CounterCatDropdown.dart';
import 'package:provider/provider.dart';


import '../model/CounterCatModel.dart';
import '../model/CounterModel.dart';
import 'CounterEditRowControl.dart';
import 'CounterRowControl.dart';

class CounterMainView extends StatefulWidget {

  CounterCatModel selectedCounterCat;

  List<CounterCatModel> getCounterCatSelectListWithDefaultOption(List<CounterCatModel> counterCatList) {
    CounterCatModel defaultCounterCat = CounterCatModel.getSelectPlaceholderForCounterCatModel();

    var results = List.of(counterCatList);
    results.insert(0, defaultCounterCat);

    return results;
  }

  int getSelectedCounterCat() {
    if (selectedCounterCat == null) {
      return -1;
    } else {
      return selectedCounterCat.counterCatId;
    }
  }

  @override
  State<StatefulWidget> createState() => CounterMainState();
}

class CounterMainState extends State<CounterMainView>
    with AutomaticKeepAliveClientMixin<CounterMainView> {
  @override
  bool get wantKeepAlive => true;

  Future<List<CounterCatModel>> counterCatFuture;
  Future<List<CounterModel>> counterFuture;

  @override
  void initState() {

    print("initState...");


    counterFuture = ICounterRepository.getInstance().getAllCounters(
        counterCatId: widget.getSelectedCounterCat());

    counterCatFuture = ICounterRepository.getInstance().getAllCounterCats();
  }

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

              future: Future.value([
                counterProvider.counterRepository.getAllCounters(
                    counterCatId: widget.getSelectedCounterCat()) ,
                counterProvider.counterRepository.getAllCounterCats(),
              ]),

              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  print("DEBUG...ConnectionState.waiting...");
                  return Container(child: CircularProgressIndicator());
                } else if (snapshot.connectionState == ConnectionState.done) {
                  print("DEBUG...ConnectionState.DONE...");
                  if (snapshot.hasError) {
                    print("DEBUG...snapshot.hasError...");
                    return Container(
                        child: Text("${snapshot.error.toString()}"));
                  }
                  else {

                    print("DEBUG...db pass through...");


                    List<CounterModel> all_counters_list = snapshot.data[0];
                    List<CounterCatModel> all_counterCat_list = snapshot.data[1];

                    print("all_counters_list==${all_counters_list}");
                    print("all_counterCat_list==${all_counterCat_list}");


                    return Column(

                        children: [


                          if ((all_counterCat_list != null) && (all_counterCat_list.isNotEmpty))
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


                          if ((all_counters_list != null)  && (all_counters_list.isNotEmpty))
                          Expanded(
                              child: ListView(key: PageStorageKey(0),


                                  children: [


                                    for (var counterModel in all_counters_list)

                                      if (settingProvider.getEditCounterMode())

                                        Container(
                                            key: PageStorageKey(counterModel.counterId),
                                            padding: EdgeInsets.all(3),
                                            child: Card(
                                                child: CounterEditRowControl(
                                                    counterModel: counterModel,
                                                    counterCatList: all_counterCat_list)))

                                      else

                                        if (counterModel.counterIsActive)

                                          ChangeNotifierProvider<LocalCounterInputProvider>(
                                              create: (_) {
                                                return LocalCounterInputProvider();
                                              },
                                              child: Container(
                                                  key: PageStorageKey(counterModel.counterId),
                                                  padding: EdgeInsets.all(3),
                                                  child: Card(
                                                      child: CounterRowControl(
                                                          counterModel: counterModel,
                                                          counterCatModel: all_counterCat_list
                                                              .where((cat) => cat.counterCatId == counterModel.counterCatId)
                                                              .first))))

                                        else
                                          Container(child: Text(''))

                                  ])

                          )



                        ]

                    );

                  }

                } else {

                  return Text("UNKNOWN ConnectionState");

                }




              }));
    });
  }

  Widget _buildEditCatDropDownView(
      BuildContext context,
      SettingProvider settingProvider,
      CounterProvider counterProvider,
      List<CounterCatModel> counterCatList) {

    print("_buildEditCatDropDownView...counterCatList == ${counterCatList}");
    print("_buildEditCatDropDownView...selectedCounterCat == ${widget.selectedCounterCat}");

    return CounterCatDropdownWidget(
        selectedCounterCat: widget.selectedCounterCat,
        counterCatList: widget.getCounterCatSelectListWithDefaultOption(counterCatList),
        onSelectCounterCatModel: (cat) {
          widget.selectedCounterCat = cat;
          setState(() {
            print("selectedCounterCat==${cat.counterCatId}, ${cat.counterCatTitle}");

          });
        },

    );
  }
}
