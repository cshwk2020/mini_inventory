import '../db/CounterDbHelper.dart';

class CounterChangeLog {
  CounterChangeLog(
      {this.counterChangeLogId, this.counterId, this.counterChangeType, this.counterDelta, this.counterValue, this.updateDate});

  static final String TYPE_initialValue = 'INITIAL';
  static final String TYPE_change = 'CHANGE';
  static final String TYPE_reset = 'RESET';

  final int counterChangeLogId;
  final String counterChangeType;
  final int counterId;
  final int counterDelta;
  final int counterValue;
  final DateTime updateDate;


  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = new Map();
    map[CounterDbHelper.Column_counterChangeLogId] = this.counterChangeLogId;
    map[CounterDbHelper.Column_counterId] = this.counterId;
    map[CounterDbHelper.Column_counterValue] = this.counterValue;
    map[CounterDbHelper.Column_counterDelta] = this.counterDelta;
    map[CounterDbHelper.Column_counterChangeType] = this.counterChangeType;
    map[CounterDbHelper.Column_updateDate] =
        this.updateDate.microsecondsSinceEpoch;

    return map;
  }

  static CounterChangeLog fromMap(Map<String, dynamic> map) {
    CounterChangeLog counterChangeLog = new CounterChangeLog(
      counterId: map[CounterDbHelper.Column_counterId],
      counterDelta: map[CounterDbHelper.Column_counterDelta],
      counterValue: map[CounterDbHelper.Column_counterValue],
      counterChangeType: map[CounterDbHelper.Column_counterChangeType],
      updateDate: DateTime.fromMicrosecondsSinceEpoch(
          map[CounterDbHelper.Column_updateDate].round()),
    );

    return counterChangeLog;
  }
}
