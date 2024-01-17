import 'package:bluetooth_print/bluetooth_print.dart';
import 'package:bluetooth_print/bluetooth_print_model.dart';
import 'package:flutter/foundation.dart';

class PrinterUtil {
  final bluetoothPrint = BluetoothPrint.instance;
  List<BluetoothDevice> _devices = [];

  Future<void> scan() async {
    // begin scan
    await bluetoothPrint.startScan(timeout: const Duration(seconds: 1));

    // get devices
    bluetoothPrint.scanResults.listen((val) {
      _devices = val;
      if (kDebugMode) {
        print(_devices);
      }
    });
  }

  Future<void> startPrint(List<LineText> lineTexts) async {
    await bluetoothPrint.connect(_devices.first);

    bool isConnected = false;
    int maxCount = 0;

    while (!isConnected && maxCount <= 100) {
      isConnected = await bluetoothPrint.isConnected ?? false;
      maxCount++;
    }

    if (isConnected) {
      await Future.delayed(
        const Duration(seconds: 2),
        () async {
          await bluetoothPrint.printReceipt({}, lineTexts);
        },
      );
    } else {
      throw Exception('[PrinterUtil.startPrint] printer cannot be connected');
    }
  }
}
