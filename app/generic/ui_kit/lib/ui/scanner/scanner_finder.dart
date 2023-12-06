import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:ui_kit/common/constants/layout_dimen.dart';
import 'package:ui_kit/theme/colors.dart';
import 'package:ui_kit/ui/input_field/input_basic.dart';
import 'package:ui_kit/utils/screen_utils.dart';

abstract class ScannerFinderConstants {
  static const closeScannerAsset = 'assets/icons/close_scanner_icon.png';
  static const openScannerAsset = 'assets/icons/open_scanner_icon.png';
  static const scannerOverlayAsset = 'assets/icons/scanner_overlay.png';
  static const beepSoundAsset = 'audio/scanner_beep.mp3';
}

class ScannerFinder extends StatefulWidget {
  const ScannerFinder({
    super.key,
    required this.labelText,
    required this.onChanged,
    required this.onScan,
  });

  final String labelText;
  final void Function(String) onChanged;
  final void Function(String) onScan;

  @override
  State<ScannerFinder> createState() => _ScannerFinderState();
}

class _ScannerFinderState extends State<ScannerFinder> {
  final cameraController = MobileScannerController(
    facing: CameraFacing.front,
    // returnImage: true,
  );
  final player = AudioPlayer();
  bool scannerActive = false;
  final textEditController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (scannerActive)
          Container(
            margin: EdgeInsets.symmetric(
              vertical: LayoutDimen.dimen_16.w,
            ),
            height: LayoutDimen.dimen_105.h,
            width: MediaQuery.sizeOf(context).width,
            decoration: BoxDecoration(
              border: Border.all(color: CustomColors.neutral.c80),
            ),
            child: MobileScanner(
              overlay: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: LayoutDimen.dimen_32.w,
                  vertical: LayoutDimen.dimen_12.h,
                ),
                child: Image.asset(ScannerFinderConstants.scannerOverlayAsset),
              ),
              fit: BoxFit.fitWidth,
              controller: cameraController,
              onDetect: (capture) {
                final List<Barcode> barcodes = capture.barcodes;
                for (final barcode in barcodes) {
                  player
                    ..setVolume(1)
                    ..play(
                      AssetSource(ScannerFinderConstants.beepSoundAsset),
                    );

                  if (barcode.rawValue != null) {
                    if (kDebugMode) {
                      print('Scanned barcode: ${barcode.rawValue}');
                    }

                    setState(() {
                      textEditController.text = barcode.rawValue!;
                    });

                    widget.onScan(barcode.rawValue!);
                  }
                }
              },
            ),
          ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              flex: 6,
              child: InputBasic(
                controller: textEditController,
                labelText: widget.labelText,
                onChanged: widget.onChanged,
                margin: EdgeInsets.zero,
              ),
            ),
            SizedBox(
              width: LayoutDimen.dimen_8.w,
            ),
            Flexible(
              child: InkWell(
                onTap: () {
                  setState(() {
                    scannerActive = !scannerActive;
                  });
                },
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: LayoutDimen.dimen_8.w),
                  child: Image.asset(
                    scannerActive
                        ? ScannerFinderConstants.closeScannerAsset
                        : ScannerFinderConstants.openScannerAsset,
                    width: LayoutDimen.dimen_30.w,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
