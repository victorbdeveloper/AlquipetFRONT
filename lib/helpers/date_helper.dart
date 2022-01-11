import 'package:intl/intl.dart';

class DateHelper {
  ///
  /// Example: 27/08/1999
  ///
  static String getDateShortFormatWithBars(DateTime? dateTime) {
    return dateTime != null ? DateFormat("dd/MM/yyyy").format(dateTime) : "-";
  }
}
