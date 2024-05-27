import 'package:data_abstraction/entity/stock_in_entity.dart';
import 'package:flutter/material.dart';
import 'package:ui_kit/common/constants/layout_dimen.dart';
import 'package:ui_kit/extensions/number_extension.dart';
import 'package:ui_kit/theme/colors.dart';
import 'package:ui_kit/ui/widgets/dummy_circle_image.dart';
import 'package:ui_kit/utils/screen_utils.dart';

class THStockInCard extends StatefulWidget {
  final StockInEntity stockInEntity;
  const THStockInCard({
    super.key,
    required this.stockInEntity,
  });

  @override
  State<THStockInCard> createState() => _THStockInCardState();
}

class _THStockInCardState extends State<THStockInCard> {
  bool stockInCardExpanded = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          stockInCardExpanded = !stockInCardExpanded;
        });
      },
      child: Material(
        color: CustomColors.white,
        borderRadius: BorderRadius.circular(LayoutDimen.dimen_10.w),
        elevation: 5,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(LayoutDimen.dimen_10.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Flexible(
                    flex: 4,
                    child: Row(
                      children: [
                        DummyCircleImage(
                          title: widget.stockInEntity.productEntity.name,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: LayoutDimen.dimen_10.w,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                widget.stockInEntity.productEntity.name,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: LayoutDimen.dimen_13.minSp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(
                                height: LayoutDimen.dimen_7.h,
                              ),
                              Text(
                                widget.stockInEntity.productEntity.code,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: LayoutDimen.dimen_12.minSp,
                                  fontWeight: FontWeight.w200,
                                ),
                              ),
                              SizedBox(
                                height: LayoutDimen.dimen_7.h,
                              ),
                              Text(
                                widget.stockInEntity.createdAt.toString(),
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: LayoutDimen.dimen_12.minSp,
                                  fontWeight: FontWeight.w300,
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
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Harga Purchase',
                          style: TextStyle(
                            fontSize: LayoutDimen.dimen_12.minSp,
                            fontWeight: FontWeight.w200,
                          ),
                        ),
                        Text(
                          widget.stockInEntity.purchaseNet.toRupiahCurrency(
                            decimalDigits: 0,
                          ),
                          style: TextStyle(
                            fontSize: LayoutDimen.dimen_16.minSp,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.right,
                          maxLines: 2,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            if (stockInCardExpanded)
              Container(
                padding: EdgeInsets.fromLTRB(
                  LayoutDimen.dimen_10.w,
                  LayoutDimen.dimen_10.w,
                  LayoutDimen.dimen_10.w,
                  LayoutDimen.dimen_5.w,
                ),
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: CustomColors.neutral.c90,
                    ),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        SizedBox(width: LayoutDimen.dimen_41.w),
                        Expanded(
                          child: Padding(
                            padding:
                                EdgeInsets.only(left: LayoutDimen.dimen_10.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'CV. Wingsgood',
                                      style: TextStyle(
                                        fontSize: LayoutDimen.dimen_12.minSp,
                                      ),
                                    ),
                                    Text(
                                      'Aji Kusuma',
                                      style: TextStyle(
                                        fontSize: LayoutDimen.dimen_11.minSp,
                                        fontWeight: FontWeight.w200,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      'Masuk',
                                      style: TextStyle(
                                        fontSize: LayoutDimen.dimen_14.minSp,
                                        fontWeight: FontWeight.w200,
                                      ),
                                    ),
                                    Text(
                                      '${widget.stockInEntity.totalPcs} pcs',
                                      style: TextStyle(
                                        fontSize: LayoutDimen.dimen_14.minSp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: LayoutDimen.dimen_4.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Melly Sujakto',
                          style: TextStyle(
                            fontSize: LayoutDimen.dimen_13.minSp,
                          ),
                        ),
                        SizedBox(
                          width: LayoutDimen.dimen_2.w,
                        ),
                        Icon(
                          Icons.keyboard_arrow_up_rounded,
                          size: LayoutDimen.dimen_30.w,
                        )
                      ],
                    )
                  ],
                ),
              )
          ],
        ),
      ),
    );
  }
}
