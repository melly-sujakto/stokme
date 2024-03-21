import 'package:data_abstraction/entity/product_entity.dart';
import 'package:flutter/material.dart';
import 'package:module_common/common/constant/translation_constants.dart';
import 'package:module_common/i18n/i18n_extension.dart';
import 'package:ui_kit/common/constants/layout_dimen.dart';
import 'package:ui_kit/extensions/string_extension.dart';
import 'package:ui_kit/theme/colors.dart';
import 'package:ui_kit/utils/screen_utils.dart';

class SaleProductCard extends StatelessWidget {
  const SaleProductCard({
    Key? key,
    required this.product,
    required this.orderNumber,
    required this.totalPcs,
    this.onDelete,
    this.totalNet,
  }) : super(key: key);

  final ProductEntity product;
  final int orderNumber;
  final int totalPcs;
  final void Function()? onDelete;
  final double? totalNet;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: LayoutDimen.dimen_2.h),
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
                    '$totalPcs ${TranslationConstants.pcs.i18n(context)}',
                    style: TextStyle(
                      fontSize: LayoutDimen.dimen_13.minSp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: LayoutDimen.dimen_2.h,
                  ),
                  Text(
                    product.saleNet.toString().toRupiahCurrency(),
                    style: TextStyle(
                      fontSize: LayoutDimen.dimen_13.minSp,
                    ),
                  ),
                  SizedBox(
                    height: LayoutDimen.dimen_2.h,
                  ),
                  if (totalNet != null)
                    Text(
                      totalNet.toString().toRupiahCurrency(),
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
