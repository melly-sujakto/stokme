import 'package:bluetooth_print/bluetooth_print.dart';
import 'package:bluetooth_print/bluetooth_print_model.dart';
import 'package:data_abstraction/entity/product_entity.dart';
import 'package:feature_transaction/common/injector/injector.dart';
import 'package:feature_transaction/domain/navigation/interaction_navigation.dart';
import 'package:feature_transaction/presentation/journey/sale/sale_routes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ui_kit/common/constants/layout_dimen.dart';
import 'package:ui_kit/extensions/string_extension.dart';
import 'package:ui_kit/theme/colors.dart';
import 'package:ui_kit/ui/button/flat_button.dart';
import 'package:ui_kit/utils/screen_utils.dart';

class SaleResultPage extends StatefulWidget {
  const SaleResultPage({
    Key? key,
  }) : super(key: key);

  @override
  State<SaleResultPage> createState() => _SaleResultPageState();
}

class _SaleResultPageState extends State<SaleResultPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.neutral.c95,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                LayoutDimen.dimen_16.w,
                LayoutDimen.dimen_94.w,
                LayoutDimen.dimen_16.w,
                LayoutDimen.dimen_100.h,
              ),
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/success_result.png',
                    width: LayoutDimen.dimen_94.w,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: LayoutDimen.dimen_32.h,
                    ),
                    child: Text(
                      'Penjualan berhasil dicatat',
                      style: TextStyle(
                        fontSize: LayoutDimen.dimen_20.minSp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Material(
                    elevation: 2,
                    borderRadius: BorderRadius.circular(LayoutDimen.dimen_10.w),
                    color: CustomColors.white,
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.fromLTRB(
                            LayoutDimen.dimen_12.w,
                            LayoutDimen.dimen_12.w,
                            LayoutDimen.dimen_40.w,
                            LayoutDimen.dimen_24.w,
                          ),
                          height: LayoutDimen.dimen_115.h,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Image.asset(
                                    'assets/icons/price_tag_icon.png',
                                    width: LayoutDimen.dimen_45.w,
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    'Kasir',
                                    style: TextStyle(
                                      fontSize: LayoutDimen.dimen_18.minSp,
                                      fontWeight: FontWeight.w200,
                                    ),
                                  ),
                                  Text(
                                    'Melly Sujakto',
                                    style: TextStyle(
                                      fontSize: LayoutDimen.dimen_18.minSp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        dashedLine(),
                        Container(
                          padding: EdgeInsets.symmetric(
                            vertical: LayoutDimen.dimen_24.h,
                            horizontal: LayoutDimen.dimen_32.w,
                          ),
                          height: LayoutDimen.dimen_230.h,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '20000'.toRupiahCurrency(),
                                style: TextStyle(
                                  fontSize: LayoutDimen.dimen_24.minSp,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(LayoutDimen.dimen_8.w),
                                child: const Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('Tanggal Transaksi'),
                                        Text('Senin, 6 November 2023'),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text('Waktu'),
                                        Text('21:22'),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              FlatButton(
                                title: 'Cetak Struk',
                                onPressed: () async {
                                  final printManager = PrintSomeText();
                                  await printManager.scan();
                                  await Future.delayed(
                                    const Duration(seconds: 1),
                                    printManager.startPrint,
                                  );
                                },
                                margin: EdgeInsets.zero,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: ScreenUtil.screenHeight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  color: CustomColors.neutral.c95,
                  padding: EdgeInsets.fromLTRB(
                    LayoutDimen.dimen_16.w,
                    0,
                    LayoutDimen.dimen_16.w,
                    LayoutDimen.dimen_32.h,
                  ),
                  child: FlatButton(
                    title: 'Selesai',
                    onPressed: () {
                      Injector.resolve<TransactionInteractionNavigation>()
                          .navigateToDashboardFromTransaction(context);
                      Navigator.pushNamed(context, SaleRoutes.salesInput);
                    },
                    margin: EdgeInsets.zero,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget dashedLine() {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth();
        const dashWidth = 10.0;
        const dashHeight = 1.0;
        final dashCount = (boxWidth / (2 * dashWidth)).floor();
        return Flex(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: dashHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: CustomColors.neutral.c80,
                ),
              ),
            );
          }),
        );
      },
    );
  }
}

class PrintSomeText {
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

  Future<void> startPrint() async {
    await bluetoothPrint.connect(_devices.first);
    const maxCharsPerLine = 32;
    const separator = '-';
    final products = [
      ProductEntity(
        id: 'id',
        code: 'code',
        name: 'name',
        storeId: 'storeId',
        saleNet: 10000,
      ),
      ProductEntity(
        id: 'id2',
        code: 'code2',
        name: 'test name more than 32 charrrrrrrrrrrrrrrrrrr',
        storeId: 'storeId2',
        saleNet: 20000,
      ),
    ];
    final textProductAndPrice = products
        .map(
          (e) => '${e.name}|${e.saleNet.toString().toRupiahCurrency()}',
        )
        .toList();

    final separatorLineText = LineText(
      type: LineText.TYPE_TEXT,
      content:
          List.generate(maxCharsPerLine, (index) => separator).toList().join(),
      weight: 0,
      align: LineText.ALIGN_CENTER,
      linefeed: 1,
    );

    String getSpaces(int textLength) {
      const space = ' ';
      final numberOfSpace = maxCharsPerLine - textLength;
      return List.generate(numberOfSpace, (index) => space).join();
    }

    String generateAlignBetween(String textContainsPipe) {
      const minSpace = 2;
      const maxLengthWithoutSpace = maxCharsPerLine - minSpace;
      const pipeChar = '|';
      final lengthWithoutPipe = textContainsPipe.length - 1;

      final splitted = textContainsPipe.split(pipeChar);
      if (splitted.length != 2) {
        throw Exception('splitted length should be 2. seems pipe char is '
            'there are more than one.');
      }

      if (lengthWithoutPipe > maxLengthWithoutSpace) {
        final leftText = splitted.first;
        final rightText = splitted.last;
        final availableSpace = maxLengthWithoutSpace - (rightText.length);
        final cuttedText = leftText.substring(0, availableSpace);
        splitted[0] = cuttedText;
      }

      final spaces = getSpaces(splitted.join().length);

      return splitted.join(spaces);
    }

    final listInList = textProductAndPrice
        .map(
          (e) => [
            LineText(
              type: LineText.TYPE_TEXT,
              content: generateAlignBetween(e),
              align: LineText.ALIGN_CENTER,
              linefeed: 1,
            ),
            LineText(
              type: LineText.TYPE_TEXT,
              content: '   5 X      Rp.2000',
              align: LineText.ALIGN_LEFT,
              linefeed: 1,
            ),
          ],
        )
        .toList();

    final listLineText =
        listInList.fold(<LineText>[], (previousValue, element) {
      previousValue.addAll(element);
      return previousValue;
    });

    final List<LineText> list = [
      LineText(
        type: LineText.TYPE_TEXT,
        content: 'Toko Adi Jaya Sembako',
        weight: 1,
        align: LineText.ALIGN_CENTER,
        linefeed: 1,
      ),
      LineText(
        type: LineText.TYPE_TEXT,
        content:
            'Jembatan 14, RT.001/RW.005, Bojong Rawalumbu, Kec. Rawalumbu, Kota Bks, Jawa Barat',
        align: LineText.ALIGN_CENTER,
        linefeed: 1,
      ),
      LineText(
        type: LineText.TYPE_TEXT,
        content: '081234567890',
        align: LineText.ALIGN_CENTER,
        linefeed: 1,
      ),
      separatorLineText,
      ...listLineText,
      separatorLineText,
      LineText(
        type: LineText.TYPE_TEXT,
        content: generateAlignBetween('Total|Rp.20.000'),
        align: LineText.ALIGN_CENTER,
        linefeed: 1,
        weight: 1,
      ),
      LineText(
        type: LineText.TYPE_TEXT,
        content: generateAlignBetween('Bayar|Rp.20.000'),
        align: LineText.ALIGN_CENTER,
        linefeed: 1,
      ),
      LineText(
        type: LineText.TYPE_TEXT,
        content: generateAlignBetween('Kembali|Rp.0'),
        align: LineText.ALIGN_CENTER,
        linefeed: 1,
      ),
      separatorLineText,
      LineText(
        type: LineText.TYPE_TEXT,
        content: 'Tanggal Transaksi',
        align: LineText.ALIGN_LEFT,
        linefeed: 1,
      ),
      LineText(
        type: LineText.TYPE_TEXT,
        content: 'Senin, 6 November 2023',
        align: LineText.ALIGN_LEFT,
        linefeed: 1,
        weight: 1,
      ),
      LineText(
        type: LineText.TYPE_TEXT,
        content: generateAlignBetween('Waktu|Kasir'),
        align: LineText.ALIGN_CENTER,
        linefeed: 1,
      ),
      LineText(
        type: LineText.TYPE_TEXT,
        content: generateAlignBetween('21:22|Melly Sujakto'),
        align: LineText.ALIGN_CENTER,
        linefeed: 1,
        weight: 1,
      ),
    ];
    await Future.delayed(
      const Duration(seconds: 2),
      () => bluetoothPrint.printReceipt({}, list),
    );
  }
}
