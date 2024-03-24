import 'package:module_common/package/intl.dart';

extension NumberExtension on num {
  String toRupiahCurrency() {
    return NumberFormat.currency(
      locale: 'id',
      symbol: 'Rp.',
      decimalDigits: 2,
    ).format(this);
  }
}
