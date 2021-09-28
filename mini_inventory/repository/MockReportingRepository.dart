
import 'package:mini_inventory/mini_inventory/model/CounterChangeLog.dart';

import 'IReportingRepository.dart';

class MockReportingRepository extends IReportingRepository {

  static MockReportingRepository mockReportingRepository = null;
  static MockReportingRepository getInstance() {
    if (mockReportingRepository == null) {
      mockReportingRepository = new MockReportingRepository();
    }

    return mockReportingRepository;
  }


  Future<List<CounterChangeLog>> getCounterHistory(int counterId) async {

    List<CounterChangeLog> result = await MockReportingRepository.getInstance().getCounterHistory(counterId);


    _sortCounterLogList(result);

    return result.toList();

  }

  Future<void> _sortCounterLogList(List<CounterChangeLog> counterChangeLog) async {

    counterChangeLog.sort((counter1, counter2) {
      return counter1.updateDate.compareTo(counter2.updateDate);
    });

  }
}
