
import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
import 'package:mini_inventory/mini_inventory/db/CounterDbHelper.dart';
import 'package:mini_inventory/mini_inventory/model/CounterCatModel.dart';
import 'package:mini_inventory/mini_inventory/model/CounterChangeLog.dart';
import 'package:mini_inventory/mini_inventory/model/CounterModel.dart';

import 'ICounterRepository.dart';

class SqfliteCounterRepository extends ICounterRepository {

  static SqfliteCounterRepository sqfliteCounterRepository = null;
  static SqfliteCounterRepository getInstance() {
    if (sqfliteCounterRepository == null) {
      sqfliteCounterRepository = new SqfliteCounterRepository();
    }

    return sqfliteCounterRepository;
  }



  Future<ICounterRepository> initDB() async {

    print('DEBUG initDB...0...');

    //await CounterDbHelper.instance.insertSomeSampleRowsIfNeeded();
    print('DEBUG initDB...10...');

    return this;
  }


  ////////////////////////////////////////////////////////////////////////

  Future<CounterCatModel> getNewCounterCatModel() async {
    return CounterCatModel.getNewCounterCatModel(-1);
  }


  Future<CounterCatModel> findCatModelById(int counterCatId) async {
    return (await CounterDbHelper.instance.CounterCat_queryRowById(counterCatId))
        .map( (_catMap)=>CounterCatModel.fromMap(_catMap)
    ).toList().first;
  }

  Future<CounterCatModel> addCounterCatModel(CounterCatModel counterCatModel) async {

    int id = await CounterDbHelper.instance.CounterCat_insert(counterCatModel.toMap());
    return counterCatModel.copyWith(counterCatId: id);
  }

  Future<void> setCounterCatModel(CounterCatModel counterCatModel) async {

    return await CounterDbHelper.instance.CounterCat_update(counterCatModel.toMap());
  }


  Future<List<CounterCatModel>> getAllCounterCats({ @required bool inclOnlyActive }) async {
    return (await CounterDbHelper.instance.CounterCat_queryRows(inclOnlyActive: inclOnlyActive))
        .map( (_catMap)=>CounterCatModel.fromMap(_catMap))
        .toList();
  }


  ////////////////////////////////////////////////////////////////////////

  Future<CounterModel> getNewCounterModel(int counterCatId) async {
    return CounterModel.getNewCounterModel(counterCatId, null);
  }

  Future<CounterModel> findModelById(int counterId) async {
    return (await CounterDbHelper.instance.Counter_queryRowById(counterId))
        .map( (_counterMap)=>CounterModel.fromMap(_counterMap)
    ).toList().first;
  }

  Future<List<CounterModel>> getActiveCounters({int counterCatId = -1}) async {
    return (await CounterDbHelper.instance.Counter_queryRows(
      counterCatId: counterCatId, inclOnlyActive: true))
        .map( (_counterMap)=>CounterModel.fromMap(_counterMap))
        .toList();
  }

  Future<List<CounterModel>> getAllCounters({ @required bool inclOnlyActive , @required int counterCatId}) async {
    var instance = await CounterDbHelper.instance;
    print('instance==${instance}');
    return (await instance.Counter_queryRows(inclOnlyActive: inclOnlyActive, counterCatId:counterCatId))
        .map( (_counterMap)=>CounterModel.fromMap(_counterMap)
    ).toList();
  }

  Future<void> addCounterModel(CounterModel newCounterModel) async {

    int id = await CounterDbHelper.instance.Counter_insert(newCounterModel.toMap());
    return newCounterModel.copyWith(counterId: id);
  }

  @override
  Future<void> saveCounterInfoWithoutValueChanged(CounterModel counterModel) async {

    return await CounterDbHelper.instance.Counter_update(counterModel.toMap());
  }

  @override
  Future<void> onDeltaChangeCounterValue(CounterModel counterModel, int delta) async {

    counterModel.counterValue += delta;
    counterModel.updateDate = DateTime.now();

    CounterChangeLog counterChangeLog = new CounterChangeLog(
        counterId: counterModel.counterId,
        counterChangeType: CounterChangeLog.TYPE_change,
        counterDelta: delta,
        counterValue: counterModel.counterValue,
        updateDate: DateTime.now()
    );

    return CounterDbHelper.instance.onUpdateCounterValue(
        counterModel.toMap(),
        counterChangeLog.toMap());
  }

  Future<void> adjustCounterValue(CounterModel uiCounterModel) async {

    CounterModel dbCounterModel = (
        await getAllCounters(counterCatId:uiCounterModel.counterCatId, inclOnlyActive: false))
        .where((counter)=>counter.counterId==uiCounterModel.counterId ).first;

    if (dbCounterModel == null) {
      throw Exception("COUNTER_NOT_EXIST");
    }

    CounterChangeLog counterChangeLog = new CounterChangeLog(
        counterId: uiCounterModel.counterId,
        counterChangeType: CounterChangeLog.TYPE_change,
        counterDelta: (uiCounterModel.counterValue - dbCounterModel.counterValue),
        counterValue: uiCounterModel.counterValue,
        updateDate: DateTime.now()
    );

    return CounterDbHelper.instance.onUpdateCounterValue(
        uiCounterModel.toMap(),
        counterChangeLog.toMap());
  }




}

