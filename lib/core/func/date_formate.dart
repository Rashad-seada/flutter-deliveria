import 'package:intl/intl.dart';

String formatDate(String? dateStr) {
  if (dateStr == null) return '2 June, 9:10 PM';
  try {
    final date = DateTime.parse(dateStr).toLocal();
    final day = date.day;
    final month = DateFormat.MMMM().format(date); // e.g. June
    final time = DateFormat('h:mm a').format(date); // e.g. 9:10 PM
    return '$day $month, $time';
  } catch (e) {
    return '2 June, 9:10 PM';
  }
}
