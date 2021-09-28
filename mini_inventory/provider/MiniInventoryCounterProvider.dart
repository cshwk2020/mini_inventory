
import 'package:flutter/material.dart';
import 'package:mini_inventory/mini_inventory/model/CounterCatModel.dart';
import 'package:mini_inventory/mini_inventory/model/CounterChangeLog.dart';
import 'package:mini_inventory/mini_inventory/model/CounterModel.dart';
import 'package:mini_inventory/mini_inventory/repository/ICounterRepository.dart';

import 'MiniInventoryReportingProvider.dart';

class CounterProvider extends ChangeNotifier {


  ICounterRepository counterRepository = ICounterRepository.getInstance();



  Future<List<CounterCatModel>> getActiveCounterCats() async => await counterRepository.getAllCounterCats();

  Future<CounterCatModel> getNewCounterCatModel() async => await counterRepository.getNewCounterCatModel();

  Future<void> addCounterCatModel(CounterCatModel counterCatModel) async {
    counterRepository.addCounterCatModel(counterCatModel);
    notifyListeners();
    ReportingProvider.getInstance().notifyListeners();
  }
  Future<void> setCounterCatModel({ @required CounterCatModel counterCatModel, @required bool isForceRefresh}) async {
    counterRepository.setCounterCatModel(counterCatModel);

    ReportingProvider.getInstance().notifyListeners();

    if (isForceRefresh == true) {
      notifyListeners();
    }

  }




  //
  Future<List<CounterModel>> getActiveCounters(int counterCatId) async => await counterRepository.getAllCounters(inclOnlyActive: true, counterCatId:counterCatId);
  Future<List<CounterModel>> getAllCounters(int counterCatId) async =>  await counterRepository.getAllCounters(counterCatId:counterCatId);

  Future<CounterModel> getNewCounterModel(int counterCatId) async => await counterRepository.getNewCounterModel(counterCatId);


  Future<void> addCounterModel(CounterModel counterModel) async {
    counterRepository.addCounterModel(counterModel);
    notifyListeners();

    ReportingProvider.getInstance().notifyListeners();
  }

  Future<void> saveCounterInfoWithoutValueChanged(CounterModel counterModel) async {

    counterRepository.saveCounterInfoWithoutValueChanged(counterModel);

    ReportingProvider.getInstance().notifyListeners();
  }

  onDeltaCounterValue({ @required CounterModel counterModel, int delta}) async {

    counterRepository.onDeltaChangeCounterValue(counterModel, delta);

    ReportingProvider.getInstance().notifyListeners();

  }




  Future<void> adjustCounterValue({ @required CounterModel counterModel, @required bool isForceRefresh}) async {

    counterRepository.adjustCounterValue(counterModel);

    ReportingProvider.getInstance().notifyListeners();

    if (isForceRefresh == true) {
      notifyListeners();
    }

  }

 
}