import 'package:intl/intl.dart';

class AppDateUtils {
  static String formatTime(DateTime time) {
    return DateFormat('HH:mm').format(time);
  }

  static String formatRecordDate(String dateString) {
    final date = DateTime.tryParse(dateString);
    if (date == null) return dateString;
    return DateFormat('MM월 dd일').format(date);
  }
}