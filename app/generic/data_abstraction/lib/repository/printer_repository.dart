import 'package:module_common/package/bluetooth_print.dart';

abstract class PrinterRepository {
  Future<List<BluetoothDevice>> scan();
  Future<void> startPrint({
    required BluetoothDevice device,
    required List<LineText> lineTexts,
  });
}
