import 'package:intl/intl.dart';

class AppFormatters {
  static final NumberFormat _php = NumberFormat.currency(
    locale: 'en_PH',
    symbol: 'PHP ',
    decimalDigits: 2,
  );

  static final DateFormat _shortDate = DateFormat.yMMMd('en_US');

  static String currency(double value) => _php.format(value);

  static String shortDate(DateTime value) => _shortDate.format(value);
}
