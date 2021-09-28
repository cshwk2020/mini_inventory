
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mini_inventory/mini_inventory/app_bar/AppBarReporting.dart';
import 'package:mini_inventory/mini_inventory/model/CounterCatModel.dart';
import 'package:mini_inventory/mini_inventory/model/CounterModel.dart';
import 'package:mini_inventory/mini_inventory/provider/MiniInventoryCounterProvider.dart';
import 'package:mini_inventory/mini_inventory/provider/MiniInventorySettingProvider.dart';
import 'package:mini_inventory/mini_inventory/widget/CustomActionButton.dart';

import 'ReportLogCounterView.dart';


class ReportLogCatView extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => ReportLogCatViewState();

}


class ReportLogCatViewState extends State<ReportLogCatView> with AutomaticKeepAliveClientMixin<ReportLogCatView> {

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {



    return Consumer2<SettingProvider, CounterProvider>(
        builder: (context, settingProvider, counterProvider, child) {


          return Scaffold(
              appBar: AppBar(
                title: Text('Select Category', style: Theme.of(context).textTheme.headline6),
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

                return ListView(key: PageStorageKey(0),

                    children: [


                  for (var counterCatModel in all_counterCat_list)

                      Container(
                        padding: EdgeInsets.all(3),

                           child: CustomActionButton(

                                text: counterCatModel.counterCatTitle,
                                textStyle: settingProvider.getAppThemeData().textTheme.headline6,
                                backgroundColor : settingProvider.getAppThemeData().backgroundColor,
                                onClicked: () async {

                                  await Navigator.push(context,
                                      MaterialPageRoute(builder: (context) => ReportLogCounterView(counterCatModel: counterCatModel)));

                                }
                            ),


                      ),

                ]);
              }));
        });
  }






}
