
import '../db/CounterDbHelper.dart';

class CounterCatModel {

  CounterCatModel({this.counterCatId, this.counterCatTitle, this.counterCatIsActive });

  final int counterCatId;
  String counterCatTitle = "";
  bool counterCatIsActive = true;

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = new Map();
    map[CounterDbHelper.Column_counterCatId] = this.counterCatId;
    map[CounterDbHelper.Column_counterCatTitle] = this.counterCatTitle;
    map[CounterDbHelper.Column_counterCatIsActive] = this.counterCatIsActive ? 1 : 0;
    return map;
  }

  Map<String, dynamic> toMapForInsert() {
    Map<String, dynamic> map = new Map();
    map[CounterDbHelper.Column_counterCatTitle] = this.counterCatTitle;
    map[CounterDbHelper.Column_counterCatIsActive] = this.counterCatIsActive ? 1 : 0;
    return map;
  }

  static CounterCatModel fromMap(Map<String, dynamic> map) {
    CounterCatModel counterCatModel = new CounterCatModel(
      counterCatId: map[CounterDbHelper.Column_counterCatId],
      counterCatTitle: map[CounterDbHelper.Column_counterCatTitle],
      counterCatIsActive: (map[CounterDbHelper.Column_counterCatIsActive]==1) ? true : false,
    );

    return counterCatModel;
  }


  static CounterCatModel getNewCounterCatModel(int counterCatId) {
    return CounterCatModel(

        counterCatTitle: '',
        counterCatIsActive: true
    );
  }

  static CounterCatModel getSelectPlaceholderForCounterCatModel() {
    return CounterCatModel(

        counterCatId: -1,
        counterCatTitle: '-- select --',
        counterCatIsActive: true
    );
  }

  CounterCatModel copyWith({
    int counterCatId,
    String counterCatTitle,
    bool counterCatIsActive }) {
    return CounterCatModel(
        counterCatId: counterCatId ?? this.counterCatId,
        counterCatTitle: counterCatTitle ?? this.counterCatTitle,
        counterCatIsActive: counterCatIsActive ?? this.counterCatIsActive
    );
  }



  String getCounterCatTitle() {
    return counterCatTitle;
  }
  void setCounterCatTitle(String _counterCatTitle) {
    counterCatTitle = _counterCatTitle;
  }

}