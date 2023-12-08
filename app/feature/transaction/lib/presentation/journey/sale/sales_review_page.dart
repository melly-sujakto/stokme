import 'package:data_abstraction/entity/product_entity.dart';
import 'package:flutter/material.dart';
import 'package:ui_kit/common/constants/layout_dimen.dart';
import 'package:ui_kit/extensions/string_extension.dart';
import 'package:ui_kit/theme/colors.dart';
import 'package:ui_kit/ui/button/flat_button.dart';
import 'package:ui_kit/utils/screen_utils.dart';

class SalesReviewArgument {
  final List<ProductEntity> products;

  SalesReviewArgument(this.products);
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
      appBar: AppBar(
        title: Text(
          'Review Penjualan',
          style: TextStyle(
            fontSize: LayoutDimen.dimen_19.minSp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
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
                  widget.salesReviewArgument.products.length,
                  (index) => SaleProductCard(
                    product: widget.salesReviewArgument.products[index],
                    orderNumber: index + 1,
                    totalPcs: 5,
                    useTotalNet: true,
                  ),
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
}

class SaleProductCard extends StatelessWidget {
  const SaleProductCard({
    Key? key,
    required this.product,
    required this.orderNumber,
    required this.totalPcs,
    this.onDelete,
    this.useTotalNet = false,
  }) : super(key: key);

  final ProductEntity product;
  final int orderNumber;
  final int totalPcs;
  final void Function()? onDelete;
  final bool useTotalNet;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: LayoutDimen.dimen_8.w,
        horizontal: LayoutDimen.dimen_4.w,
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: CustomColors.neutral.c90,
          ),
        ),
        color: Colors.transparent,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$orderNumber. ${product.name}',
            style: TextStyle(
              fontSize: LayoutDimen.dimen_13.minSp,
              overflow: TextOverflow.ellipsis,
              fontWeight: FontWeight.w500,
            ),
          ),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '$totalPcs pcs',
                    style: TextStyle(
                      fontSize: LayoutDimen.dimen_13.minSp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: LayoutDimen.dimen_2.h,
                  ),
                  Text(
                    (product.saleNet ?? '').toString().toRupiahCurrency(),
                    style: TextStyle(
                      fontSize: LayoutDimen.dimen_13.minSp,
                    ),
                  ),
                  SizedBox(
                    height: LayoutDimen.dimen_2.h,
                  ),
                  if (useTotalNet)
                    Text(
                      ((product.saleNet ?? 0) * totalPcs)
                          .toString()
                          .toRupiahCurrency(),
                      style: TextStyle(
                        fontSize: LayoutDimen.dimen_16.minSp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                ],
              ),
              if (onDelete != null) ...[
                SizedBox(
                  width: LayoutDimen.dimen_16.w,
                ),
                InkWell(
                  onTap: onDelete,
                  child: Icon(
                    Icons.close_rounded,
                    size: LayoutDimen.dimen_24.w,
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
