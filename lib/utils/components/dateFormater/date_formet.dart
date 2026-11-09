import 'package:intl/intl.dart';

String formatDate(String dateStr) {
  try {
    DateTime date = DateTime.parse(dateStr);
    return DateFormat('MMMM dd, yyyy').format(date);
  } catch (e) {
    // Return an error message or empty string in case of invalid format
    return 'Invalid date';
  }
}
