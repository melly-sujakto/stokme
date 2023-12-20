import 'package:data_abstraction/entity/sale_entity.dart';
import 'package:feature_transaction/common/injector/injector.dart';
import 'package:feature_transaction/domain/navigation/interaction_navigation.dart';
import 'package:feature_transaction/presentation/journey/sale/sale_routes.dart';
import 'package:feature_transaction/presentation/journey/sale/widgets/sale_product_card.dart';
import 'package:flutter/material.dart';
import 'package:ui_kit/common/constants/layout_dimen.dart';
import 'package:ui_kit/extensions/string_extension.dart';
import 'package:ui_kit/theme/colors.dart';
import 'package:ui_kit/ui/app_bar/app_bar_with_title_only.dart';
import 'package:ui_kit/ui/button/flat_button.dart';
import 'package:ui_kit/utils/screen_utils.dart';

class SalesReviewArgument {
  final List<SaleEntity> saleEntityList;

  SalesReviewArgument(this.saleEntityList);
}

class SalesReviewPage extends StatefulWidget {
  const SalesReviewPage({
    Key? key,
    required this.salesReviewArgument,
  }) : super(key: key);

  final SalesReviewArgument salesReviewArgument;

  @override
  State<SalesReviewPage> createState() => _SalesReviewPageState();
}

class _SalesReviewPageState extends State<SalesReviewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.neutral.c95,
      appBar: const AppBarWithTitleOnly(appBarTitle: 'Review Penjualan'),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                LayoutDimen.dimen_16.w,
                LayoutDimen.dimen_16.w,
                LayoutDimen.dimen_16.w,
                LayoutDimen.dimen_200.h,
              ),
              child: Column(
                children: List.generate(
                  widget.salesReviewArgument.saleEntityList.length,
                  (index) {
                    final saleEntity =
                        widget.salesReviewArgument.saleEntityList[index];
                    return SaleProductCard(
                      product: saleEntity.productEntity,
                      orderNumber: index + 1,
                      totalPcs: saleEntity.total,
                      totalNet: saleEntity.totalNet,
                    );
                  },
                ),
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
                  padding: EdgeInsets.all(
                    LayoutDimen.dimen_16.w,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total',
                        style: TextStyle(
                          fontSize: LayoutDimen.dimen_18.minSp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '200000'.toRupiahCurrency(),
                        style: TextStyle(
                          fontSize: LayoutDimen.dimen_24.minSp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  color: CustomColors.neutral.c95,
                  padding: EdgeInsets.fromLTRB(
                    LayoutDimen.dimen_16.w,
                    0,
                    LayoutDimen.dimen_16.w,
                    LayoutDimen.dimen_32.h,
                  ),
                  child: FlatButton(
                    title: 'Proses',
                    onPressed: () {
                      Injector.resolve<TransactionInteractionNavigation>()
                          .navigateToDashboardFromTransaction(context);
                      Navigator.pushNamed(context, SaleRoutes.salesResult);
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
}
