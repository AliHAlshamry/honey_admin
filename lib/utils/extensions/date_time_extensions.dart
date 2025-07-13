import 'package:intl/intl.dart';

extension StringDateTimeFormatter on String {
  DateTime toDateTime() => DateTime.parse(replaceFirst(' ', 'T'));

  String to12HourFormat() {
    final dt = toDateTime();
    return DateFormat('yyyy-MM-dd h:mm a').format(dt);
  }
}
