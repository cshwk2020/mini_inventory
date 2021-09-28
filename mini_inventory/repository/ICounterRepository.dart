

import 'package:flutter/cupertino.dart';
import 'package:mini_inventory/mini_inventory/model/CounterCatModel.dart';
import 'package:mini_inventory/mini_inventory/model/CounterChangeLog.dart';
import 'package:mini_inventory/mini_inventory/model/CounterModel.dart';
import 'package:mini_inventory/mini_inventory/repository/SqfliteCounterRepository.dart';

import 'MockCounterRepository.dart';

abstract class ICounterRepository {

  static ICounterRepository counterRepository = null;
  static ICounterRepository getInstance() {
    if (counterRepository == null) {
      counterRepository = SqfliteCounterRepository.getInstance();
      //mockCounterRepository = MockCounterRepository.getInstance();
      //mockCounterRepository.initDB();
    }

    return counterRepository;
  }


  //

  Future<ICounterRepository> initDB();

  //

  Future<CounterCatModel> findCatModelById(int counterCatId);
  Future<void> addCounterCatModel(CounterCatModel counterCatModel);
  Future<void> setCounterCatModel(CounterCatModel counterCatModel);
  Future<List<CounterCatModel>> getAllCounterCats({ @required bool inclOnlyActive });

  Future<CounterCatModel> getNewCounterCatModel();


  //
  Future<List<CounterModel>> getAllCounters({@required bool inclOnlyActive, @required int counterCatId});

  Future<CounterModel> getNewCounterModel(int counterCatId);

  Future<CounterModel> findModelById(int counterId);
  Future<void> addCounterModel(CounterModel counterModel);
  Future<void> onDeltaChangeCounterValue(CounterModel counterModel, int delta);
  Future<void> adjustCounterValue(CounterModel counterModel);

  Future<void> saveCounterInfoWithoutValueChanged(CounterModel counterModel);


}
