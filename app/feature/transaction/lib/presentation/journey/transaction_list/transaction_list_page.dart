import 'package:feature_transaction/presentation/journey/transaction_list/transaction_list_routes.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:ui_kit/common/constants/layout_dimen.dart';
import 'package:ui_kit/theme/colors.dart';
import 'package:ui_kit/ui/scanner/scanner_finder.dart';
import 'package:ui_kit/ui/widgets/dummy_circle_image.dart';
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
      // body: SingleChildScrollView(
      //   child: Column(
      //     crossAxisAlignment: CrossAxisAlignment.center,
      //     children: [
      //       buttonController(),
      //       dateController(),
      //       showSales
      //           ? percentIndicator([
      //               'Rp.247.650.000',
      //               '1100 pcs',
      //               '297 penjualan',
      //             ])
      //           : percentIndicator([
      //               'Rp.197.650.000',
      //               '1411 pcs',
      //               '155 stok masuk',
      //             ]),
      //       thSales(),
      //     ],
      //   ),
      // ),
      body: const Center(
        child: Text('Sedang dalam pengerjaan, fitur ini akan segera ada.'),
      ),
    );
  }

  Widget thSales() {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: LayoutDimen.dimen_16.h,
      ),
      margin: EdgeInsets.only(top: LayoutDimen.dimen_35.h),
      color: CustomColors.white.withOpacity(0.5),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: LayoutDimen.dimen_16.w,
            ),
            child: ScannerFinder(
              labelText: 'Cari kasir/tanggal',
              onChanged: (_) {},
              onScan: (_) {},
            ),
          ),
          ...List.generate(
            5,
            (index) => thSalesCard(),
          ),
        ],
      ),
    );
  }

  Widget thSalesCard() {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          TransactionListRoutes.transactionSaleDetail,
        );
      },
      child: Padding(
        padding: EdgeInsets.only(
          top: LayoutDimen.dimen_14.h,
          left: LayoutDimen.dimen_16.w,
          right: LayoutDimen.dimen_16.w,
        ),
        child: Container(
          padding: EdgeInsets.all(LayoutDimen.dimen_10.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const DummyCircleImage(title: 'M S'),
                  Padding(
                    padding: EdgeInsets.all(
                      LayoutDimen.dimen_10.w,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Melly Sujakto',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: LayoutDimen.dimen_13.minSp,
                            fontWeight: FontWeight.w100,
                          ),
                        ),
                        SizedBox(
                          height: LayoutDimen.dimen_7.h,
                        ),
                        Text(
                          '9 November 2023 • 21:22',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: LayoutDimen.dimen_12.minSp,
                            fontWeight: FontWeight.w200,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total',
                    style: TextStyle(
                      fontSize: LayoutDimen.dimen_12.minSp,
                      fontWeight: FontWeight.w200,
                    ),
                  ),
                  Text(
                    'Rp.20.000',
                    style: TextStyle(
                      fontSize: LayoutDimen.dimen_16.minSp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget dateController() {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: LayoutDimen.dimen_35.h,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {},
            borderRadius: BorderRadius.circular(50),
            child: Material(
              elevation: 1,
              color: CustomColors.neutral.c80.withOpacity(0.5),
              borderRadius: BorderRadius.circular(50),
              child: Icon(
                Icons.arrow_left_rounded,
                size: LayoutDimen.dimen_35.h,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: LayoutDimen.dimen_11.w,
            ),
            child: InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(
                LayoutDimen.dimen_10.w,
              ),
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: LayoutDimen.dimen_11.w,
                  vertical: LayoutDimen.dimen_5.h,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    LayoutDimen.dimen_10.w,
                  ),
                  color: CustomColors.errorAccent.c50.withOpacity(0.3),
                ),
                child: Column(
                  children: [
                    Text(
                      'November',
                      style: TextStyle(
                        fontSize: LayoutDimen.dimen_18.minSp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '2023',
                      style: TextStyle(
                        fontSize: LayoutDimen.dimen_14.minSp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {},
            borderRadius: BorderRadius.circular(50),
            child: Material(
              elevation: 1,
              color: CustomColors.neutral.c80.withOpacity(0.5),
              borderRadius: BorderRadius.circular(50),
              child: Icon(
                Icons.arrow_right_rounded,
                size: LayoutDimen.dimen_35.h,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buttonController() {
    return Container(
      margin: EdgeInsets.only(
        left: LayoutDimen.dimen_16.w,
        right: LayoutDimen.dimen_16.w,
        top: LayoutDimen.dimen_16.h,
      ),
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
                  borderRadius: BorderRadius.circular(LayoutDimen.dimen_10.w),
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
                  borderRadius: BorderRadius.circular(LayoutDimen.dimen_10.w),
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
