import 'package:data_abstraction/entity/product_entity.dart';
import 'package:feature_transaction/presentation/journey/sale/sale_routes.dart';
import 'package:feature_transaction/presentation/journey/sale/sales_review_page.dart';
import 'package:feature_transaction/presentation/journey/sale/widgets/sales_product_card.dart';
import 'package:flutter/material.dart';
import 'package:ui_kit/common/constants/layout_dimen.dart';
import 'package:ui_kit/theme/colors.dart';
import 'package:ui_kit/ui/app_bar/app_bar_with_title_only.dart';
import 'package:ui_kit/ui/button/flat_button.dart';
import 'package:ui_kit/ui/scanner/scanner_finder.dart';
import 'package:ui_kit/utils/screen_utils.dart';

class SalesInputPage extends StatefulWidget {
  const SalesInputPage({super.key});

  @override
  State<SalesInputPage> createState() => _SalesInputPageState();
}

class _SalesInputPageState extends State<SalesInputPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.neutral.c95,
      appBar: const AppBarWithTitleOnly(appBarTitle: 'Penjualan'),
      body: Stack(
        children: [
          Container(
            height: ScreenUtil.screenHeight,
            padding: EdgeInsets.all(LayoutDimen.dimen_16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ScannerFinder(
                  labelText: 'Kode',
                  onChanged: (value) {},
                  onScan: (value) {},
                ),
                SizedBox(
                  height: LayoutDimen.dimen_32.h,
                ),
                Expanded(child: productListCard()),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(bottom: LayoutDimen.dimen_32.h),
            height: ScreenUtil.screenHeight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FlatButton(
                  title: 'Lanjut',
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      SaleRoutes.salesReview,
                      arguments: SalesReviewArgument(listproduct),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<ProductEntity> listproduct = List.generate(
    10,
    (index) => ProductEntity(
      id: 'id',
      code: 'code',
      name: 'name${index + 1}',
      storeId: 'storeId',
      saleNet: int.parse('2${index + 1}00'),
    ),
  );

  Widget productListCard() {
    return Container(
      padding: EdgeInsets.only(
        bottom: LayoutDimen.dimen_100.h,
      ),
      child: ListView(
        children: List.generate(
          listproduct.length,
          (index) => SalesProductCard(
            product: listproduct[index],
            orderNumber: index + 1,
            totalPcs: 5,
            onDelete: () {
              setState(() {
                listproduct.removeAt(index);
              });
            },
          ),
        ),
      ),
    );
  }
}
