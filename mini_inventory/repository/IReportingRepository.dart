import 'package:flutter/cupertino.dart';
import 'package:mini_inventory/mini_inventory/model/CounterCatModel.dart';
import 'package:mini_inventory/mini_inventory/model/CounterChangeLog.dart';
import 'package:mini_inventory/mini_inventory/model/CounterModel.dart';

import 'ICounterRepository.dart';
import 'SqfliteReportingRepository.dart';

abstract class IReportingRepository {

  static IReportingRepository reportingRepository = null;
  static IReportingRepository getInstance() {
    if (reportingRepository == null) {
      reportingRepository = new SqfliteReportingRepository();
    }

    return reportingRepository;
  }


  Future<List<CounterChangeLog>> getCounterHistory(int counterId);


  //
  ICounterRepository counterRepository = ICounterRepository.getInstance();

  Future<List<CounterCatModel>> getAllCounterCats(@required bool inclOnlyActive) async {
    return await counterRepository.getAllCounterCats(inclOnlyActive: inclOnlyActive);
  }

  Future<List<CounterModel>> getAllCounters ({ @required inclOnlyActive, @required int counterCatId}) async {
    return await counterRepository.getAllCounters(inclOnlyActive: inclOnlyActive, counterCatId: counterCatId);
  }


}

