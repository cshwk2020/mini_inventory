
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mini_inventory/mini_inventory/app_bar/AppBarCounter.dart';
import 'package:mini_inventory/mini_inventory/app_bar/AppBarCounterCat.dart';
import 'package:mini_inventory/mini_inventory/model/CounterCatModel.dart';
import 'package:mini_inventory/mini_inventory/provider/MiniInventoryCounterProvider.dart';
import 'package:mini_inventory/mini_inventory/provider/MiniInventorySettingProvider.dart';

import 'CounterCatEditRow.dart';
import 'CounterCatRow.dart';

class CounterCatMainView extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => CounterCatMainState();

}


class CounterCatMainState extends State<CounterCatMainView> with AutomaticKeepAliveClientMixin<CounterCatMainView> {

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {

    return Consumer2<SettingProvider, CounterProvider>(
        builder: (context, settingProvider, counterProvider, child) {


          return Scaffold(
              appBar: AppBar(
              title: AppBarCounterCat()
          ),
          body: FutureBuilder(
              future: Future.wait([
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

                List<CounterCatModel> all_counterCat_list = snapshot.data[0];

                return ListView(key: PageStorageKey(0), children: [


                  for (var counterCatModel in all_counterCat_list)

                    if (settingProvider.getEditCounterCatMode())

                      Container(
                          key: PageStorageKey(counterCatModel.counterCatId),
                          padding: EdgeInsets.all(3),
                          child: Card(
                              child: CounterCatEditRow(
                                  counterCatModel: counterCatModel,
                              )))

                    else

                      if (counterCatModel.counterCatIsActive)

                        Container(
                            key: PageStorageKey(counterCatModel.counterCatId),
                            padding: EdgeInsets.all(3),
                            child: Card(
                                child: CounterCatRow(
                                    counterCatModel: counterCatModel,
                                   ))
                        )
                      else
                        Container(child: Text(''))

                ]);
              })
          );

        });
  }


}
