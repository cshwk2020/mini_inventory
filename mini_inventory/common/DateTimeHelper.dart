
import 'package:intl/intl.dart';

class DateTimeHelper {

  static String formatDateTime(DateTime dt) {
    final f = new DateFormat('yyyy-MM-dd hh:mm');
    return f.format(dt);
  }

}