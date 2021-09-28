
import 'package:flutter/material.dart';
import 'package:mini_inventory/mini_inventory/model/CounterCatModel.dart';
import 'package:mini_inventory/mini_inventory/model/CounterChangeLog.dart';
import 'package:mini_inventory/mini_inventory/model/CounterModel.dart';
import 'package:mini_inventory/mini_inventory/repository/ICounterRepository.dart';
import 'package:mini_inventory/mini_inventory/repository/IReportingRepository.dart';

class ReportingProvider extends ChangeNotifier {

  static ReportingProvider reportingProvider = null;
  static ReportingProvider getInstance() {
    if (reportingProvider == null) {
      reportingProvider = new ReportingProvider();
    }

    return reportingProvider;
  }


  IReportingRepository reportingRepository = IReportingRepository.getInstance();

  Future<List<CounterChangeLog>> getCounterHistory (int counterId) {
    return reportingRepository.getCounterHistory(counterId);
  }

}