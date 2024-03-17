import 'package:data_abstraction/entity/product_entity.dart';
import 'package:feature_transaction/presentation/journey/sale/bloc/sale_bloc.dart';
import 'package:feature_transaction/presentation/journey/sale/sale_constants.dart';
import 'package:flutter/material.dart';
import 'package:module_common/i18n/i18n_extension.dart';
import 'package:ui_kit/common/constants/layout_dimen.dart';
import 'package:ui_kit/extensions/string_extension.dart';
import 'package:ui_kit/theme/colors.dart';
import 'package:ui_kit/ui/button/flat_button.dart';
import 'package:ui_kit/ui/input_field/input_basic.dart';
import 'package:ui_kit/utils/screen_utils.dart';

class SaleProductModalContent extends StatefulWidget {
  const SaleProductModalContent({
    super.key,
    required this.product,
    required this.bloc,
  });
  final ProductEntity product;
  final SaleBloc bloc;

  @override
  State<SaleProductModalContent> createState() =>
      _SaleProductModalContentState();
}

class _SaleProductModalContentState extends State<SaleProductModalContent> {
  late String price;
  late final TextEditingController priceTextEditController;
  late final TextEditingController totalTextEditController;

  final totalFocusNode = FocusNode()..requestFocus();
  int? total;
  bool isEditPrice = false;

  @override
  void initState() {
    super.initState();
    price = widget.product.saleNet.toString();
    priceTextEditController = TextEditingController(text: price);
    totalTextEditController = TextEditingController(
      text: total?.toString(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      // handle visibility of text field once keyboard shown
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        height: LayoutDimen.dimen_352.h,
        width: ScreenUtil.screenWidth,
        padding: EdgeInsets.symmetric(
          horizontal: LayoutDimen.dimen_16.w,
        ),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(
                vertical: LayoutDimen.dimen_12.h,
              ),
              width: LayoutDimen.dimen_77.w,
              height: LayoutDimen.dimen_7.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  LayoutDimen.dimen_30.w,
                ),
                color: CustomColors.neutral.c90,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: LayoutDimen.dimen_18.h,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.product.name,
                      style: TextStyle(
                        fontSize: LayoutDimen.dimen_18.minSp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      widget.product.code,
                      style: TextStyle(
                        fontSize: LayoutDimen.dimen_18.minSp,
                        fontWeight: FontWeight.w200,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: LayoutDimen.dimen_18.h,
                ),
                if (isEditPrice)
                  InputBasic(
                    controller: priceTextEditController,
                    keyboardType: TextInputType.number,
                    labelText: SaleStrings.price.i18n(context),
                    margin: EdgeInsets.zero,
                    onChanged: (value) {
                      price = value;
                    },
                  )
                else
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        price.toRupiahCurrency(),
                        style: TextStyle(
                          fontSize: LayoutDimen.dimen_20.minSp,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            isEditPrice = !isEditPrice;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: LayoutDimen.dimen_12.w,
                          ),
                          child: Image.asset(
                            SaleAssets.pencilEditIcon,
                            height: LayoutDimen.dimen_30.w,
                          ),
                        ),
                      ),
                    ],
                  ),
                SizedBox(
                  height: LayoutDimen.dimen_18.h,
                ),
                InputBasic(
                  controller: totalTextEditController,
                  keyboardType: TextInputType.number,
                  labelText: SaleStrings.totalPcs.i18n(context),
                  margin: EdgeInsets.zero,
                  focusNode: totalFocusNode,
                  onChanged: (value) {
                    if (value.isEmpty) {
                      total = 1;
                    } else {
                      total = int.parse(value);
                    }
                  },
                ),
                SizedBox(
                  height: LayoutDimen.dimen_18.h,
                ),
                FlatButton(
                  title: SaleStrings.input.i18n(context),
                  onPressed: () {
                    widget.bloc.add(
                      CalculatePriceProductEvent(
                        product: ProductEntity(
                          id: widget.product.id,
                          code: widget.product.code,
                          name: widget.product.name,
                          storeId: widget.product.storeId,
                          saleNet: double.parse(price),
                        ),
                        total: total ?? 1,
                      ),
                    );
                    FocusManager.instance.primaryFocus?.unfocus();
                    Navigator.pop(context);
                  },
                  margin: EdgeInsets.zero,
                ),
                SizedBox(
                  height: LayoutDimen.dimen_18.h,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
