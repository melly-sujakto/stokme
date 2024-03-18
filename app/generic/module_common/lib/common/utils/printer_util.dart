import 'package:module_common/package/bluetooth_print.dart';

class PrinterUtil {
  final bluetoothPrint = BluetoothPrint.instance;

  Future<List<BluetoothDevice>> scan() async {
    List<BluetoothDevice>? devices;

    // begin scan
    await bluetoothPrint.startScan(timeout: const Duration(seconds: 1));

    // get devices
    bluetoothPrint.scanResults.listen((bluetoothDevices) {
      devices = bluetoothDevices;
    });

    while (devices == null) {
      await Future.delayed(const Duration(milliseconds: 100));
    }

    return devices!;
  }

  Future<void> startPrint({
    required BluetoothDevice device,
    required List<LineText> lineTexts,
  }) async {
    await bluetoothPrint.connect(device);

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
