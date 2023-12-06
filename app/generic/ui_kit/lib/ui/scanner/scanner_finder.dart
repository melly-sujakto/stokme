import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:ui_kit/common/constants/layout_dimen.dart';
import 'package:ui_kit/theme/colors.dart';
import 'package:ui_kit/ui/input_field/input_basic.dart';
import 'package:ui_kit/utils/screen_utils.dart';

class ScannerFinder extends StatefulWidget {
  const ScannerFinder({super.key});

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
                child: Image.asset('assets/icons/scanner_overlay.png'),
              ),
              fit: BoxFit.fitWidth,
              controller: cameraController,
              onDetect: (capture) {
                final List<Barcode> barcodes = capture.barcodes;
                for (final barcode in barcodes) {
                  player
                    ..setVolume(1)
                    ..play(
                      AssetSource('audio/scanner_beep.mp3'),
                    );
                  setState(() {
                    if (barcode.rawValue != null) {
                      if (kDebugMode) {
                        print(barcode.rawValue);
                      }
                    }
                  });
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
                labelText: 'Cari nama/kode',
                onChanged: (value) {},
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
                        ? 'assets/icons/close_scanner_icon.png'
                        : 'assets/icons/open_scanner_icon.png',
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
