
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mini_inventory/mini_inventory/app_bar/AppBarReporting.dart';
import 'package:mini_inventory/mini_inventory/model/CounterCatModel.dart';
import 'package:mini_inventory/mini_inventory/model/CounterModel.dart';
import 'package:mini_inventory/mini_inventory/provider/MiniInventoryCounterProvider.dart';
import 'package:mini_inventory/mini_inventory/provider/MiniInventorySettingProvider.dart';
import 'package:mini_inventory/mini_inventory/widget/CustomActionButton.dart';

import 'ReportLogCounterDetail.dart';


class ReportLogCounterView extends StatefulWidget {

  ReportLogCounterView({ this.counterCatModel });

  CounterCatModel counterCatModel;

  @override
  State<StatefulWidget> createState() => ReportLogCounterViewState();

}


class ReportLogCounterViewState extends State<ReportLogCounterView> with AutomaticKeepAliveClientMixin<ReportLogCounterView> {

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {



    return Consumer2<SettingProvider, CounterProvider>(
        builder: (context, settingProvider, counterProvider, child) {


          return Scaffold(
              appBar: AppBar(
                title: Text('Select Counter', style: Theme.of(context).textTheme.headline6),
          ),
          body: FutureBuilder(
              future: Future.wait([
                counterProvider.counterRepository.getAllCounters(inclOnlyActive: false, counterCatId: widget.counterCatModel.counterCatId),
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

                List<CounterModel> all_counter_list = snapshot.data[0];

                return ListView(key: PageStorageKey(0),

                    children: [


                      for (var counterModel in all_counter_list)

                        Container(

                          padding: EdgeInsets.all(3),

                          child: CustomActionButton(

                              text: counterModel.counterTitle,
                              textStyle: settingProvider.getAppThemeData().textTheme.headline6,
                              backgroundColor : settingProvider.getAppThemeData().backgroundColor,
                              onClicked: () async {

                                await Navigator.push(context,
                                    MaterialPageRoute(builder: (context) => ReportLogCounterDetail(counterModel: counterModel)));

                              }
                          ),


                        ),

                    ]);
              }));
        });
  }


}
