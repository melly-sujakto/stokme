import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:module_common/common/constant/translation_constants.dart';
import 'package:module_common/i18n/i18n_extension.dart';
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
    this.labelText,
    required this.onChanged,
    required this.onScan,
    this.optionList = const [],
    this.onSelected,
    this.textEditController,
    this.keyboardType,
    this.holdScanner = false,
    this.addProductAction,
    // TODO(MELLY): activate feature by more value
    this.autoActiveScanner = false,
  });

  final String? labelText;
  final void Function(String) onChanged;
  final void Function(String) onScan;
  final List<Widget> optionList;
  final void Function(int)? onSelected;
  final TextEditingController? textEditController;
  final TextInputType? keyboardType;
  final void Function()? addProductAction;
  final bool autoActiveScanner;

  /// Set false to inactivate scanner sistem
  final bool holdScanner;

  @override
  State<ScannerFinder> createState() => _ScannerFinderState();
}

class _ScannerFinderState extends State<ScannerFinder> {
  final cameraController = MobileScannerController(
    facing: CameraFacing.back,
    // returnImage: true,
  );
  final player = AudioPlayer();
  late bool scannerActive;
  late final TextEditingController textEditController;

  @override
  void initState() {
    textEditController = widget.textEditController ?? TextEditingController();
    scannerActive = widget.autoActiveScanner;
    super.initState();
  }

  @override
  void dispose() {
    textEditController.dispose();
    super.dispose();
  }

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
            child: Stack(
              children: [
                MobileScanner(
                  overlay: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: LayoutDimen.dimen_32.w,
                      vertical: LayoutDimen.dimen_12.h,
                    ),
                    child:
                        Image.asset(ScannerFinderConstants.scannerOverlayAsset),
                  ),
                  fit: BoxFit.fitWidth,
                  controller: cameraController,
                  onDetect: (capture) {
                    if (!widget.holdScanner) {
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
                    }
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: cameraController.switchCamera,
                      child: Padding(
                        padding: EdgeInsets.all(LayoutDimen.dimen_8.w),
                        child: Icon(
                          Icons.cameraswitch_rounded,
                          size: LayoutDimen.dimen_20.h,
                          color: CustomColors.neutral.c60,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              flex: 6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InputBasic(
                    controller: textEditController,
                    labelText: widget.labelText ??
                        TranslationConstants.code.i18n(context),
                    onChanged: widget.onChanged,
                    margin: EdgeInsets.zero,
                    keyboardType: widget.keyboardType,
                    suffixIcon: widget.addProductAction != null
                        ? InkWell(
                            onTap: widget.addProductAction,
                            child: Icon(
                              Icons.add,
                              color: textEditController.text.isNotEmpty
                                  ? CustomColors.black
                                  : CustomColors.neutral.c70,
                              size: LayoutDimen.dimen_40.w,
                            ),
                          )
                        : null,
                  ),
                  if (widget.optionList.isNotEmpty)
                    Material(
                      elevation: 2,
                      borderRadius: BorderRadius.circular(
                        LayoutDimen.dimen_10.w,
                      ),
                      color: CustomColors.white,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: LayoutDimen.dimen_16.h,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: List.generate(
                            widget.optionList.length,
                            (index) => InkWell(
                              onTap: () {
                                if (widget.onSelected != null) {
                                  widget.onSelected!(index);
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: CustomColors.neutral.c80,
                                    ),
                                  ),
                                ),
                                child: widget.optionList[index],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
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
                  padding: EdgeInsets.symmetric(
                    horizontal: LayoutDimen.dimen_8.w,
                    vertical: LayoutDimen.dimen_10.h,
                  ),
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
