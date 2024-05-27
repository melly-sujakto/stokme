import 'package:module_common/package/intl.dart';

extension NumberExtension on num {
  String toRupiahCurrency({int decimalDigits = 2}) {
    return NumberFormat.currency(
      locale: 'id',
      symbol: 'Rp.',
      decimalDigits: decimalDigits,
    ).format(this);
  }
}
