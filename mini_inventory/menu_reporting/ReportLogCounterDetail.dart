
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mini_inventory/mini_inventory/common/DateTimeHelper.dart';
import 'package:mini_inventory/mini_inventory/model/CounterChangeLog.dart';
import 'package:mini_inventory/mini_inventory/model/CounterModel.dart';
import 'package:mini_inventory/mini_inventory/provider/MiniInventoryCounterProvider.dart';
import 'package:mini_inventory/mini_inventory/provider/MiniInventoryReportingProvider.dart';
import 'package:mini_inventory/mini_inventory/provider/MiniInventorySettingProvider.dart';
import 'package:mini_inventory/mini_inventory/repository/SqfliteReportingRepository.dart';

class ReportLogCounterDetail extends StatefulWidget {

  ReportLogCounterDetail({ this.counterModel });

  CounterModel counterModel;

  
  @override
  State<StatefulWidget> createState() => _ReportLogCounterDetailState();

}

class _ReportLogCounterDetailState extends State<ReportLogCounterDetail> {

  @override
  Widget build(BuildContext context) {

    print('ReportLogCounterDetail...build...');

    return Consumer3<SettingProvider, CounterProvider, ReportingProvider>(
        builder: (context, settingProvider, counterProvider, reportingProvider, child) {


          return Scaffold(
              appBar: AppBar(
                title: Text('${widget.counterModel.counterTitle} Logs', style: Theme.of(context).textTheme.headline6),
              ),
              body: FutureBuilder(
                  future: reportingProvider.reportingRepository.getCounterHistory(widget.counterModel.counterId),
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

                    List<CounterChangeLog> counter_changelogs_list = snapshot.data;

                    return ListView(



                      padding: EdgeInsets.all(6.0),
                      children: [  Table(
                        border: TableBorder.all(color: settingProvider.getAppThemeData().accentColor),
                        children: [

                          _buildCounterChangeLogHeader(settingProvider),

                          for (var counter_change_log in counter_changelogs_list)
                            _buildCounterChangeLogRow(settingProvider, counter_change_log),

                        ]

                      ),
                      ]
                    );

                    /*
                      ListView(key: PageStorageKey(0),

                        children: [


                          for (var counter_change_log in counter_changelogs_list)

                            Container(


                              child: _buildCounterChangeLogRow(settingProvider, counter_change_log),


                            ),

                        ]);

                     */
                  }));


        });
  }

  TableRow _buildCounterChangeLogHeader(SettingProvider settingProvider) {

    return TableRow(children: [
      Container(
        padding: EdgeInsets.all(6),
        child: Text('Update Date'),
      ),

        Container(
            padding: EdgeInsets.all(6),
            child: Text('Change')
        )

      ,

      Container(
        padding: EdgeInsets.all(6),
        child: Text('Running Total'),
      ),

    ]);

  }

    TableRow _buildCounterChangeLogRow(SettingProvider settingProvider, CounterChangeLog counter_change_log) {

    return TableRow(children: [
      Container(
        padding: EdgeInsets.all(6),
        child: Text('${DateTimeHelper.formatDateTime(counter_change_log.updateDate) }'),
      ),



      if (counter_change_log.counterChangeType == CounterChangeLog.TYPE_change)

        Container(
          padding: EdgeInsets.all(6),
            child: Text('${counter_change_log.counterDelta}')
          )

      else

        Container(
            padding: EdgeInsets.all(6),
            child: Text('RESET to ${counter_change_log.counterValue}')
        )

      ,

      Container(
        padding: EdgeInsets.all(6),
        child: Text('${ counter_change_log.counterValue }'),
      ),

      ]);


  }

}