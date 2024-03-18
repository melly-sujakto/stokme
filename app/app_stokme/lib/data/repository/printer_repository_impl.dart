import 'package:data_abstraction/repository/printer_repository.dart';
import 'package:module_common/common/utils/printer_util.dart';
import 'package:module_common/package/bluetooth_print.dart';

class PrinterRepositoryImpl implements PrinterRepository {
  final PrinterUtil printerUtil;
  PrinterRepositoryImpl({
    required this.printerUtil,
  });

  @override
  Future<List<BluetoothDevice>> scan() async {
    return printerUtil.scan();
  }

  @override
  Future<void> startPrint({
    required BluetoothDevice device,
    required List<LineText> lineTexts,
  }) async {
    await printerUtil.startPrint(device: device, lineTexts: lineTexts);
  }
}
