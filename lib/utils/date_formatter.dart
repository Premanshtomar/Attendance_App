import 'package:intl/intl.dart';

String getDateFromDateTime(DateTime dateTime, {String? format}) {
  final DateFormat formatter = DateFormat(format ?? 'dd-MM-yyyy');
  final String formatted = formatter.format(dateTime);
  return formatted;
}

String getDayFromDateTime(DateTime dateTime, {String? format}) {
  final DateFormat formatter = DateFormat('EEEE');
  final String formatted = formatter.format(dateTime);
  return formatted;
}