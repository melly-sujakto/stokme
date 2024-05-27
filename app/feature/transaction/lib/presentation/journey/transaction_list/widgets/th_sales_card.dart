import 'package:data_abstraction/entity/receipt_entity.dart';
import 'package:feature_transaction/presentation/journey/transaction_list/transaction_list_constants.dart';
import 'package:feature_transaction/presentation/journey/transaction_list/transaction_list_routes.dart';
import 'package:flutter/material.dart';
import 'package:module_common/i18n/i18n_extension.dart';
import 'package:ui_kit/common/constants/layout_dimen.dart';
import 'package:ui_kit/extensions/number_extension.dart';
import 'package:ui_kit/theme/colors.dart';
import 'package:ui_kit/ui/widgets/dummy_circle_image.dart';
import 'package:ui_kit/utils/screen_utils.dart';

class THSalesCard extends StatefulWidget {
  final ReceiptEntity receiptEntity;
  const THSalesCard({
    super.key,
    required this.receiptEntity,
  });

  @override
  State<THSalesCard> createState() => _THSalesCardState();
}

class _THSalesCardState extends State<THSalesCard> {
  @override
  Widget build(BuildContext context) {
    final receiptEntity = widget.receiptEntity;
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          TransactionListRoutes.saleDetail,
          arguments: receiptEntity,
        );
      },
      child: Material(
        color: CustomColors.white,
        borderRadius: BorderRadius.circular(LayoutDimen.dimen_10.w),
        elevation: 5,
        child: Container(
          padding: EdgeInsets.all(LayoutDimen.dimen_10.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Flexible(
                flex: 4,
                child: Row(
                  children: [
                    DummyCircleImage(title: receiptEntity.userName),
                    Padding(
                      padding: EdgeInsets.all(
                        LayoutDimen.dimen_10.w,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            receiptEntity.userName,
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
                            receiptEntity.createdAt.toString(),
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
              ),
              Flexible(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      TransactionListStrings.total.i18n(context),
                      style: TextStyle(
                        fontSize: LayoutDimen.dimen_12.minSp,
                        fontWeight: FontWeight.w200,
                      ),
                    ),
                    Text(
                      receiptEntity.totalNet.toRupiahCurrency(),
                      style: TextStyle(
                        fontSize: LayoutDimen.dimen_16.minSp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
