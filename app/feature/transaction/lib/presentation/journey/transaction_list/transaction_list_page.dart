import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:ui_kit/common/constants/layout_dimen.dart';
import 'package:ui_kit/theme/colors.dart';
import 'package:ui_kit/utils/screen_utils.dart';

class TransactionListPage extends StatelessWidget {
  const TransactionListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final circleWidth = LayoutDimen.dimen_28.w;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Circular Percent Indicators'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: CircularPercentIndicator(
                radius: LayoutDimen.dimen_150.w,
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
                          'Rp.247.650.000',
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
                              '1100 pcs',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: LayoutDimen.dimen_16.minSp,
                              ),
                            ),
                            Text(
                              '297 penjualan',
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
                // footer: const Text(
                //   'Sales this week',
                //   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
                // ),
                // circularStrokeCap: CircularStrokeCap.round,
                progressColor: CustomColors.errorAccent.c70,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
