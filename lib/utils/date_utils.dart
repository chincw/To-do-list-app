import 'package:intl/intl.dart';

class DateUtil {
  static final DateFormat _dFMonthShortDate = DateFormat('dd MMM yyyy');
  static final DateFormat _dFDefaultDate = DateFormat('dd MMMM yyyy');

  static String formatMonthShortDate(DateTime d) => _dFMonthShortDate.format(d);
  static String formatDefaultDate(DateTime d) => _dFDefaultDate.format(d);
}
