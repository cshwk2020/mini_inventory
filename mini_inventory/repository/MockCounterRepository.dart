
import 'package:flutter/cupertino.dart';
import 'package:mini_inventory/mini_inventory/model/CounterChangeLog.dart';

import '../model/CounterCatModel.dart';
import '../model/CounterModel.dart';
import 'ICounterRepository.dart';



class MockCounterRepository extends ICounterRepository {


  Future<CounterCatModel> getNewCounterCatModel() async {
    return CounterCatModel.getNewCounterCatModel(await getNewCounterCatId());
  }



  List<CounterCatModel> memoryCounterCats = List<CounterCatModel>();
  List<CounterModel> memoryCounters = List<CounterModel>();
  List<CounterChangeLog> memoryCounterChangeLogs = List<CounterChangeLog>();


  //

  Future<int> getNewCounterCatId() async {
    if (memoryCounterCats.isEmpty || memoryCounterCats.length == 0) {
      return 1;
    }
    else {
      return 1 + memoryCounterCats.fold(0, (result, model) => (model.counterCatId > result) ? model.counterCatId : result);
    }
  }

  Future<CounterCatModel> findCatModelById(int counterCatId) async {
    CounterCatModel model = (await getAllCounterCats()).where((counterCat)=>counterCat.counterCatId==counterCatId ).first;
    return model;
  }

  Future<void> addCounterCatModel(CounterCatModel newCounterCatModel) async {

    bool isIdExist = ((await getAllCounterCats()).where((counterCat)=>counterCat.counterCatId==newCounterCatModel.counterCatId )
        .length > 0);
    if (isIdExist) {
      throw Exception("COUNTER_CATEGORY_DUPLICATED");
    }

    bool isNameExists = ((await getAllCounterCats()).where((counterCat)=>counterCat.counterCatTitle==newCounterCatModel.counterCatTitle )
        .length > 0);
    if (isNameExists) {
      throw Exception("COUNTER_CATEGORY_NAME_DUPLICATED");
    }

    memoryCounterCats.add(newCounterCatModel);
  }

  Future<void> setCounterCatModel(CounterCatModel _counterCatModel) async {

    CounterCatModel counterCatModel = (await getAllCounterCats(inclOnlyActive: false)).where((counterCat)=>counterCat.counterCatId==_counterCatModel.counterCatId ).first;

    if (counterCatModel == null) {
      throw Exception("COUNTER_CATEGORY_NOT_EXIST");
    }

    counterCatModel.counterCatTitle = _counterCatModel.counterCatTitle;
    counterCatModel.counterCatIsActive = _counterCatModel.counterCatIsActive;

  }


  Future<List<CounterCatModel>> getAllCounterCats({ @required bool inclOnlyActive }) async {

    List<CounterCatModel> result = memoryCounterCats;
    if (inclOnlyActive == true) {
      result = result.where((cat) => cat.counterCatIsActive == true);
    }
    result.sort((counterCat1, counterCat2) => counterCat1.counterCatTitle.compareTo(counterCat2.counterCatTitle));

    return result;
  }


  //
  Future<int> getNewCounterId() async {
    return COUNTER_ID_SEQ++;
  }

  Future<CounterModel> getNewCounterModel(int counterCatId) async {
    return CounterModel.getNewCounterModel(counterCatId, await getNewCounterId());
  }


  Future<CounterModel> findModelById(int counterId)  async {
    CounterModel model = (await getAllCounters()).where((counter)=>counter.counterId==counterId ).first;
    return model;
  }

  static int COUNTER_ID_SEQ = 1;

  Future<ICounterRepository> initDB() async {

    COUNTER_ID_SEQ = 1;

    //
    for (var i=1; i < 10; i++) {

      String catTitle = "";
      for (var str_i = 0; str_i < i; str_i++) {
        catTitle = "CAT";
      }
      catTitle = "${catTitle} ${i} zzzzzzzzzz zzzzzzzzzz zzzzzzzzzz zzzzzzzzzz zzzzzzzzzz zzzzzzzzzz zzzzzzzzzz zzzzzzzzzz zzzzzzzzzz zzzzzzzzzz zzzzzzzzzz zzzzzzzzzz zzzzzzzzzz ";

      int newCounterCatId = i;

      memoryCounterCats.add(
          CounterCatModel(
              counterCatId: newCounterCatId,
              counterCatTitle: catTitle,
              counterCatIsActive: true,
          )
      );

      _initMockCounterList(newCounterCatId, 1+i);
    }

    return this;
  }


  Future<void> _initMockCounterList(int counterCatId, int maxItemCount) async {

    //
    for (var i=1; i < maxItemCount; i++) {

      String title = "";
      for (var str_i = 0; str_i < i; str_i++) {
        //title = title + "Counter ";
      }
      title = '''${i} zzzzzzzzzz zzzzzzzzzz zzzzzzzzzz zzzzzzzzzz zzzzzzzzzz zzzzzzzzzz''';

      memoryCounters.add(
          CounterModel(
              counterCatId: counterCatId,
              counterId: await getNewCounterId(),
              counterTitle: title
          )
      );
    }

  }

  Future<void> _sortCounterList(List<CounterModel> counterList) async {

    List<CounterCatModel> counterCatList = await getAllCounterCats();
    Map counter_cat_map = Map();

    for (var counterCat in counterCatList) {
      counter_cat_map[counterCat.counterCatId] = counterCat;
    }

    counterList.sort((counter1, counter2) {

      CounterCatModel cat1 = counter_cat_map[counter1.counterCatId];
      CounterCatModel cat2 = counter_cat_map[counter2.counterCatId];
      int cat_compare = cat1.counterCatTitle.compareTo(cat2.counterCatTitle);
      if (cat_compare != 0) {
        return cat_compare;
      }
      else {

        return counter1.counterTitle.compareTo(counter2.counterTitle);
      }
    });

  }



  Future<List<CounterModel>> getAllCounters ({ @required inclOnlyActive, @required int counterCatId = -1}) async {

    //print('debug...getAllCounters...0...');


    List<CounterModel> result = memoryCounters.where((counter) {

      //print('debug...getAllCounters...10...');

      bool sub_result = true;
      bool cond_counterCatId = (counter.counterCatId == counterCatId);
      bool cond_inclOnlyActive = (counter.counterIsActive == true);

      //print('debug...getAllCounters...20...');

      if (counterCatId > 0) {
        sub_result = sub_result && cond_counterCatId;
      }

      //print('debug...getAllCounters...30...');

      if (inclOnlyActive == true) {
        sub_result = sub_result && cond_inclOnlyActive;
      }

      return sub_result;

    }).toList();

    //print('debug...getAllCounters...40...');

    await _sortCounterList(result);

    //print('debug...getAllCounters...50...');

    return result.toList();
  }

  Future<void> addCounterModel(CounterModel newCounterModel) async {

    bool isIdExist = ((await getAllCounters()).where((counter)=>counter.counterId==newCounterModel.counterId )
                    .length > 0);
    if (isIdExist) {
      throw Exception("COUNTER_DUPLICATED");
    }

    bool isNameExists = ((await getAllCounters()).where((counter)=>counter.counterTitle==newCounterModel.counterTitle )
        .length > 0);
    if (isNameExists) {
      throw Exception("COUNTER_NAME_DUPLICATED");
    }

    memoryCounters.add(newCounterModel);
  }

  Future<void> saveCounterInfoWithoutValueChanged(CounterModel _counterModel) async {

    print("debug saveCounterTextInfo...0...");

    CounterModel counterModel = (await getAllCounters()).where((counter)=>counter.counterId==_counterModel.counterId ).first;

    if (counterModel == null) {
      throw Exception("COUNTER_NOT_EXIST");
    }
    print("debug setCounterModel...20...");

    counterModel.counterTitle = _counterModel.counterTitle;
    counterModel.counterCatId = _counterModel.counterCatId;
    counterModel.updateDate = DateTime.now();
    print("debug setCounterModel...30...");
  }


  Future<void> _setCounterModel(CounterModel _counterModel) async {

    print("debug setCounterModel...0...");

    CounterModel counterModel = (await getAllCounters()).where((counter)=>counter.counterId==_counterModel.counterId ).first;

    print("debug setCounterModel...10...${_counterModel}...");

    if (counterModel == null) {
      throw Exception("COUNTER_NOT_EXIST");
    }

    print("debug setCounterModel...20...");

    counterModel.counterCatId = _counterModel.counterCatId;
    counterModel.counterTitle = _counterModel.counterTitle;
    counterModel.counterValue = _counterModel.counterValue;
    counterModel.counterIsActive = _counterModel.counterIsActive;

    counterModel.updateDate = DateTime.now();

    print("debug setCounterModel...30...");
  }

  Future<void> onDeltaChangeCounterValue(CounterModel counterModel, int delta) async {

    counterModel.counterValue += delta;

    _setCounterModel(counterModel);

    //
    CounterChangeLog counterChangeLog = new CounterChangeLog(
      counterId: counterModel.counterId,
      counterValue: counterModel.counterValue,
      counterDelta: delta,
      counterChangeType: CounterChangeLog.TYPE_change,
      updateDate: DateTime.now()
    );

    addCounterChangeLog(counterChangeLog);
  }






  Future<void> adjustCounterValue(CounterModel uiCounterModel) async {

    CounterModel dbCounterModel = (await getAllCounters()).where((counter)=>counter.counterId==uiCounterModel.counterId ).first;

    if (dbCounterModel == null) {
      throw Exception("COUNTER_NOT_EXIST");
    }

    CounterChangeLog counterChangeLog = CounterChangeLog(
      counterChangeType: CounterChangeLog.TYPE_reset,
        counterId: uiCounterModel.counterId,
        counterDelta : (uiCounterModel.counterValue - dbCounterModel.counterValue),
        counterValue: uiCounterModel.counterValue,
        updateDate: DateTime.now());

    await addCounterChangeLog(counterChangeLog);

    //
    dbCounterModel.counterTitle = uiCounterModel.counterTitle;
    dbCounterModel.counterValue = uiCounterModel.counterValue;
    dbCounterModel.counterIsActive = uiCounterModel.counterIsActive;
    dbCounterModel.counterCatId = uiCounterModel.counterCatId;
    dbCounterModel.updateDate = DateTime.now();
  }




  ////////////////////////////////////////////////////////////////////////

  Future<List<CounterChangeLog>> getCounterChangeLogs(counterId) async {
    return memoryCounterChangeLogs.where((log) => log.counterId==counterId).toList();
  }

  Future<void> addCounterChangeLog(CounterChangeLog counterChangeLog) async {

    memoryCounterChangeLogs.add(counterChangeLog);
  }
}
