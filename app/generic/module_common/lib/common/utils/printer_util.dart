import 'dart:async';

import 'package:flutter/material.dart';
import 'package:module_common/package/bluetooth_print.dart';
import 'package:ui_kit/common/constants/layout_dimen.dart';
import 'package:ui_kit/theme/colors.dart';
import 'package:ui_kit/ui/dialog/plain_dialog.dart';
import 'package:ui_kit/ui/snackbar/snackbar_dialog.dart';
import 'package:ui_kit/utils/screen_utils.dart';

class PrinterUtil {
  static const printerIcon = 'assets/icons/printer_icon.png';

  late final BluetoothPrint _bluetoothPrint;
  PrinterUtil() : _bluetoothPrint = BluetoothPrint.instance;

  Future<void> executePrinter(
    BuildContext context, {
    BluetoothDevice? printer,
    String? additionalInfo,
    required List<LineText> lineTexts,
  }) async {
    if (printer == null) {
      await _getAvailablePrinters(
        context,
        lineTexts: lineTexts,
        additionalInfo: additionalInfo,
      );
    } else {
      await _showPrintingProcess(
        context,
        printer: printer,
        lineTexts: lineTexts,
      );
    }
  }

  Future<List<BluetoothDevice>> scan() async {
    List<BluetoothDevice>? devices;

    // begin scan
    await _bluetoothPrint.startScan(timeout: const Duration(seconds: 1));

    // get devices
    _bluetoothPrint.scanResults.listen((bluetoothDevices) {
      devices = bluetoothDevices;
    });

    while (devices == null) {
      await Future.delayed(const Duration(milliseconds: 100));
    }

// TODO(Melly): filter just printer devices
    return devices!;
  }

  Future<bool> _startPrint({
    required BluetoothDevice printer,
    required List<LineText> lineTexts,
  }) async {
    await _bluetoothPrint.connect(printer);

    bool isConnected = false;
    int maxCount = 0;

    while (!isConnected && maxCount <= 100) {
      isConnected = await _bluetoothPrint.isConnected ?? false;
      maxCount++;
    }
    final isAvailable = await _bluetoothPrint.isAvailable;
    final isOn = await _bluetoothPrint.isOn;
    return Future.delayed(const Duration(seconds: 5), () async {
      if (isConnected && isAvailable && isOn) {
        try {
          // bug on sdk: did not waiting for
          // _channel.invokeMethod('printReceipt', args);
          final result =
              // await _bluetoothPrint.printReceipt({}, [lineTexts.first]);
              await _bluetoothPrint.printReceipt({}, lineTexts);
          if (result != true) {
            return false;
          }
          return result;
        } catch (e) {
          throw Exception(e);
        }
      } else {
        throw Exception('[PrinterUtil.startPrint] printer cannot be connected');
      }
    });
  }

  Future<void> _getAvailablePrinters(
    BuildContext context, {
    String? additionalInfo,
    required List<LineText> lineTexts,
  }) async {
    PlainDialog(
      content: Container(
        width: LayoutDimen.dimen_400.w,
        padding: EdgeInsets.all(
          LayoutDimen.dimen_16.w,
        ),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            SizedBox(
              height: LayoutDimen.dimen_30.h,
              child: Image.asset(
                PrinterUtil.printerIcon,
              ),
            ),
            SizedBox(
              height: LayoutDimen.dimen_8.h,
            ),
            Text(
              //
              '${additionalInfo != null ? '$additionalInfo\n' : ''}'
              'Mencari printer...',
              style: TextStyle(
                fontSize: LayoutDimen.dimen_20.minSp,
                fontWeight: FontWeight.w300,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: LayoutDimen.dimen_16.h,
            ),
          ],
        ),
      ),
    ).show(context);

    final printers = await scan();

    if (printers.isNotEmpty) {
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      // ignore: use_build_context_synchronously
      await _showAllPrinters(context, printers: printers, lineTexts: lineTexts);
    } else {
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      // ignore: use_build_context_synchronously
      PlainDialog(
        content: Container(
          width: LayoutDimen.dimen_400.w,
          padding: EdgeInsets.all(
            LayoutDimen.dimen_16.w,
          ),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
          child: Column(
            children: [
              SizedBox(
                height: LayoutDimen.dimen_30.h,
                child: Image.asset(
                  PrinterUtil.printerIcon,
                ),
              ),
              SizedBox(
                height: LayoutDimen.dimen_8.h,
              ),
              Text(
                //
                'Printer tidak ditemukan!',
                style: TextStyle(
                  fontSize: LayoutDimen.dimen_20.minSp,
                  fontWeight: FontWeight.w300,
                ),
              ),
              SizedBox(
                height: LayoutDimen.dimen_16.h,
              ),
            ],
          ),
        ),
      ).show(context);
    }
  }

  Future<void> _showAllPrinters(
    BuildContext context, {
    required List<BluetoothDevice> printers,
    required List<LineText> lineTexts,
  }) async {
    PlainDialog(
      content: Container(
        width: LayoutDimen.dimen_400.w,
        padding: EdgeInsets.all(
          LayoutDimen.dimen_16.w,
        ),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            SizedBox(
              height: LayoutDimen.dimen_30.h,
              child: Image.asset(
                PrinterUtil.printerIcon,
              ),
            ),
            SizedBox(
              height: LayoutDimen.dimen_8.h,
            ),
            ...List.generate(
              printers.length,
              (index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context, printers[index]);
                      },
                      child: Container(
                        padding: EdgeInsets.all(
                          LayoutDimen.dimen_16.w,
                        ),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: CustomColors.neutral.c90,
                              width: 1,
                            ),
                          ),
                        ),
                        child: Text(
                          printers[index].name ?? '',
                          style: TextStyle(
                            fontSize: LayoutDimen.dimen_16.minSp,
                            fontWeight: FontWeight.w100,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    ).show(
      context,
      thenCallback: (value) async {
        if (value is BluetoothDevice) {
          await _showPrintingProcess(
            context,
            printer: value,
            lineTexts: lineTexts,
          );
        }
      },
    );
  }

  Future<void> _showPrintingProcess(
    BuildContext context, {
    required BluetoothDevice printer,
    required List<LineText> lineTexts,
  }) async {
    PlainDialog(
      content: Container(
        width: LayoutDimen.dimen_400.w,
        padding: EdgeInsets.all(
          LayoutDimen.dimen_16.w,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: CustomColors.secondary.c90,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: LayoutDimen.dimen_45.h,
                  child: Image.asset(
                    PrinterUtil.printerIcon,
                  ),
                ),
                Text(
                  printer.name ?? '',
                  style: TextStyle(
                    fontSize: LayoutDimen.dimen_16.minSp,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: LayoutDimen.dimen_16.h,
            ),
            Text(
              //
              'Sedang mencetak...',
              style: TextStyle(
                fontSize: LayoutDimen.dimen_20.minSp,
                fontWeight: FontWeight.w300,
              ),
            ),
            SizedBox(
              height: LayoutDimen.dimen_32.h,
            )
          ],
        ),
      ),
    ).show(context);
    final result = await _startPrint(printer: printer, lineTexts: lineTexts);
    // ignore: use_build_context_synchronously
    Navigator.pop(context);
    // ignore: use_build_context_synchronously
    SnackbarDialog().show(
      context: context,
      message: result ? 'Selesai mencetak!' : 'Gagal mencetak!',
      type: result ? SnackbarDialogType.success : SnackbarDialogType.failed,
    );
  }
}
