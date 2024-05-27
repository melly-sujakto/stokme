import 'package:module_common/package/intl.dart';

extension DateTimeExtension on DateTime {
  String toYMMMMEEEEd() {
    return DateFormat.yMMMMEEEEd('id').format(this);
  }

  String toTimeWithColon() {
    return DateFormat('HH:mm').format(this);
  }
}
