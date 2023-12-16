import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:ui_kit/common/constants/layout_dimen.dart';
import 'package:ui_kit/theme/colors.dart';
import 'package:ui_kit/utils/screen_utils.dart';

class TransactionListPage extends StatefulWidget {
  const TransactionListPage({super.key});

  @override
  State<TransactionListPage> createState() => _TransactionListPageState();
}

class _TransactionListPageState extends State<TransactionListPage> {
  bool showSales = true;
  final circleWidth = LayoutDimen.dimen_28.w;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.neutral.c98,
      appBar: AppBar(
        title: Text(
          'Transaksi',
          style: TextStyle(
            fontSize: LayoutDimen.dimen_19.minSp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.all(LayoutDimen.dimen_16.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(LayoutDimen.dimen_10.w),
                color: CustomColors.neutral.c90,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        if (!showSales) {
                          setState(() {
                            showSales = true;
                          });
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: LayoutDimen.dimen_12.h,
                        ),
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(LayoutDimen.dimen_10.w),
                          color: showSales ? CustomColors.secondary.c60 : null,
                        ),
                        child: Center(
                          child: Text(
                            'Penjualan',
                            style: TextStyle(
                              fontSize: LayoutDimen.dimen_16.minSp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        if (showSales) {
                          setState(() {
                            showSales = false;
                          });
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: LayoutDimen.dimen_12.h,
                        ),
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(LayoutDimen.dimen_10.w),
                          color: !showSales ? CustomColors.secondary.c60 : null,
                        ),
                        child: Center(
                          child: Text(
                            'Stok Masuk',
                            style: TextStyle(
                              fontSize: LayoutDimen.dimen_16.minSp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            showSales
                ? percentIndicator([
                    'Rp.247.650.000',
                    '1100 pcs',
                    '297 penjualan',
                  ])
                : percentIndicator([
                    'Rp.197.650.000',
                    '1411 pcs',
                    '155 stok masuuk',
                  ])
          ],
        ),
      ),
    );
  }

  Widget percentIndicator(List<String> texts) {
    return Center(
      child: CircularPercentIndicator(
        radius: LayoutDimen.dimen_150.w,
        animationDuration: 1000,
        lineWidth: circleWidth,
        animation: true,
        percent: 1,
        center: Padding(
          padding: EdgeInsets.all(
            circleWidth + LayoutDimen.dimen_16.w,
          ),
          child: Stack(
            children: [
              Center(
                child: Text(
                  texts.first,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: LayoutDimen.dimen_24.minSp,
                  ),
                ),
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      texts[1],
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: LayoutDimen.dimen_16.minSp,
                      ),
                    ),
                    Text(
                      texts.last,
                      style: TextStyle(
                        fontWeight: FontWeight.w200,
                        fontSize: LayoutDimen.dimen_14.minSp,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        progressColor: CustomColors.errorAccent.c70,
      ),
    );
  }
}
