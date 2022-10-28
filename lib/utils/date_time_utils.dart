import 'package:intl/intl.dart';

class DateTimeUtils {
  static const String dateFormat1 = 'MMM dd, yyyy hh:mm a';

  static String convertDateToString(DateTime date) {
    return DateFormat(dateFormat1).format(date);
  }
}
