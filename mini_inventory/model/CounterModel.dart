
import '../db/CounterDbHelper.dart';

class CounterModel {



  CounterModel(
      { this.counterId, this.counterCatId, this.counterValue = 0, this.counterTitle, this.counterIsActive = true,
        this.createDate, this.updateDate}) {

    this.createDate = createDate ?? DateTime.now();
    this.updateDate = updateDate ?? DateTime.now();
  }

  final int counterId;
  int counterCatId;
  int counterValue = 0;
  String counterTitle = "";
  bool counterIsActive = true;
  DateTime createDate = DateTime.now();
  DateTime updateDate = DateTime.now();



  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = new Map();
    map[CounterDbHelper.Column_counterCatId] = this.counterCatId;
    map[CounterDbHelper.Column_counterId] = this.counterId;
    map[CounterDbHelper.Column_counterTitle] = this.counterTitle;
    map[CounterDbHelper.Column_counterValue] = this.counterValue;
    map[CounterDbHelper.Column_counterIsActive] = (this.counterIsActive) ? 1 : 0;
    map[CounterDbHelper.Column_createDate] = this.createDate.microsecondsSinceEpoch;
    map[CounterDbHelper.Column_updateDate] = this.updateDate.microsecondsSinceEpoch;

    return map;
  }

  Map<String, dynamic> toMapForInsert() {
    Map<String, dynamic> map = new Map();
    map[CounterDbHelper.Column_counterCatId] = this.counterCatId;
    map[CounterDbHelper.Column_counterTitle] = this.counterTitle;
    map[CounterDbHelper.Column_counterValue] = this.counterValue;
    map[CounterDbHelper.Column_counterIsActive] = (this.counterIsActive) ? 1 : 0;
    map[CounterDbHelper.Column_createDate] = this.createDate.microsecondsSinceEpoch;
    map[CounterDbHelper.Column_updateDate] = this.updateDate.microsecondsSinceEpoch;

    return map;
  }

  static CounterModel fromMap(Map<String, dynamic> map) {

    print('CounterModel::fromMap...0...counterCatId==${map[CounterDbHelper.Column_counterCatId]}');
    print('CounterModel::fromMap...1...Column_counterId==${map[CounterDbHelper.Column_counterId]}');
    print('CounterModel::fromMap...2...Column_counterTitle==${map[CounterDbHelper.Column_counterTitle]}');
    print('CounterModel::fromMap...3...counterValue==${map[CounterDbHelper.Column_counterValue]}');
    print('CounterModel::fromMap...4...counterIsActive==${map[CounterDbHelper.Column_counterIsActive]}');
    print('CounterModel::fromMap...5...createDate==${map[CounterDbHelper.Column_createDate].round()}');
    print('CounterModel::fromMap...6...updateDate==${map[CounterDbHelper.Column_updateDate].round()}');


    CounterModel counterModel = new CounterModel(

      counterCatId: map[CounterDbHelper.Column_counterCatId],
      counterId: map[CounterDbHelper.Column_counterId],
      counterTitle: map[CounterDbHelper.Column_counterTitle],
      counterValue: map[CounterDbHelper.Column_counterValue],
      counterIsActive: (map[CounterDbHelper.Column_counterIsActive] == 1) ? true : false,
      createDate: DateTime.fromMicrosecondsSinceEpoch(
          map[CounterDbHelper.Column_createDate].round()),
      updateDate: DateTime.fromMicrosecondsSinceEpoch(
          map[CounterDbHelper.Column_updateDate].round()),
    );

    print('CounterModel::fromMap...10...');

    return counterModel;
  }

  static CounterModel getNewCounterModel(int counterCatId, int counterId) {
    return CounterModel(

        counterCatId: counterCatId,
        counterValue: 0,
        counterTitle: '',
        counterIsActive: true,
        createDate: DateTime.now(),
        updateDate: DateTime.now(),
    );
  }



  CounterModel copyWith({
    int counterId,
    int counterCatId,
    int counterValue,
    String counterTitle,
    bool isActive,
    DateTime createDate,
    DateTime updateDate }) {

    return CounterModel(
        counterId: counterId ?? this.counterId,
        counterCatId: counterCatId ?? this.counterCatId,
        counterValue: counterValue ?? this.counterValue,
        counterTitle: counterTitle ?? this.counterTitle,
        counterIsActive: isActive ?? this.counterIsActive,
        createDate: createDate ?? this.createDate,
        updateDate: updateDate ?? this.updateDate,
    );
  }

  int getCounterValue() {
    return counterValue;
  }

  CounterModel incr() =>
      copyWith(
        counterValue: (this.counterValue + 1),
          updateDate: DateTime.now(),
      );

  CounterModel decr() {
    if (this.counterValue > 0) {
      return copyWith(
        counterValue: (this.counterValue - 1),
        updateDate: DateTime.now(),
      );
    } else {
      return this;
    }
  }





  void setCounterValue(int _counterValue) {
    counterValue = _counterValue;
  }

  String getCounterTitle() {
    return counterTitle;
  }
  void setCounterTitle(String _counterTitle) {
    counterTitle = _counterTitle;
  }


}