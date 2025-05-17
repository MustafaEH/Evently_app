import 'package:intl/intl.dart';

extension FormatDate on DateTime{
  String get getMonthName{
    DateFormat format = DateFormat.MMMM();
    return format.format(this);
  }
}