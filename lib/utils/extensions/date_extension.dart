import 'package:get/get.dart';
import 'package:intl/intl.dart';

extension DateExtension on DateTime {
  String get formatDateToYearMonthDay {
    return DateFormat('yyyy-MM-dd').format(this);
  }

  String get formatDateToYearMonthDayWithTime {
    String timeFormat = DateFormat('HH:mm').format(this);
    return '${DateFormat('yyyy-MM-dd').format(this)}  $timeFormat';
  }

  String get formatTime {
    return DateFormat('HH:mm').format(this);
  }

  String get formatTimeTo12Hour {
    int hour = this.hour;
    int minute = this.minute;

    String period = (hour < 12) ? 'am'.tr : 'pm'.tr;

    if (hour > 12) {
      hour -= 12;
    } else if (hour == 0) {
      hour = 12;
    }

    String time =
        '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')} $period';

    return time;
  }
}
