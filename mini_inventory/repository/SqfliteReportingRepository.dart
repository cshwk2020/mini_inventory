import 'package:flutter/cupertino.dart';
import 'package:mini_inventory/mini_inventory/db/CounterDbHelper.dart';
import 'package:mini_inventory/mini_inventory/model/CounterCatModel.dart';
import 'package:mini_inventory/mini_inventory/model/CounterChangeLog.dart';
import 'package:mini_inventory/mini_inventory/model/CounterModel.dart';

import 'ICounterRepository.dart';
import 'IReportingRepository.dart';


class SqfliteReportingRepository extends IReportingRepository {

  static SqfliteReportingRepository sqfliteReportingRepository = null;
  static SqfliteReportingRepository getInstance() {
    if (sqfliteReportingRepository == null) {
      sqfliteReportingRepository = new SqfliteReportingRepository();
  }

    return sqfliteReportingRepository;
  }


  Future<List<CounterChangeLog>> getCounterHistory(int counterId) async {

    var results = (await CounterDbHelper.instance.CounterChangeLog_queryAllRows(counterId));

    print("getCounterHistory...counterId==${counterId}...results==${results}");

    return results.map( (change_log_map) => CounterChangeLog.fromMap(change_log_map))
        .toList();
  }
}
