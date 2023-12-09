import 'package:flutter/material.dart';
import 'package:ui_kit/common/constants/layout_dimen.dart';
import 'package:ui_kit/extensions/string_extension.dart';
import 'package:ui_kit/theme/colors.dart';
import 'package:ui_kit/ui/button/flat_button.dart';
import 'package:ui_kit/utils/screen_utils.dart';

class SalesResultPage extends StatefulWidget {
  const SalesResultPage({
    Key? key,
  }) : super(key: key);

  @override
  State<SalesResultPage> createState() => _SalesResultPageState();
}

class _SalesResultPageState extends State<SalesResultPage> {
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
                                child: Row(
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
                                onPressed: () {},
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
                    onPressed: () {},
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
