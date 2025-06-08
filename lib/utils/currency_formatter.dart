import 'package:intl/intl.dart';

class CurrencyFormatter {
  static String formatUSD(double amount) {
    final format = NumberFormat.currency(locale: 'en_US', symbol: '\$');
    return format.format(amount);
  }

  static String formatBRL(double amount) {
    final format = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');
    return format.format(amount);
  }

  static String formatDate(DateTime date) {
    final format = DateFormat('dd/MM/yyyy HH:mm', 'pt_BR');
    return format.format(date);
  }
}
