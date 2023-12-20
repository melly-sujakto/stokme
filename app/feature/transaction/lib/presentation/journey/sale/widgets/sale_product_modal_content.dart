import 'package:data_abstraction/entity/product_entity.dart';
import 'package:feature_transaction/presentation/journey/sale/bloc/sale_bloc.dart';
import 'package:flutter/material.dart';
import 'package:ui_kit/common/constants/layout_dimen.dart';
import 'package:ui_kit/theme/colors.dart';
import 'package:ui_kit/ui/button/flat_button.dart';
import 'package:ui_kit/ui/input_field/input_basic.dart';
import 'package:ui_kit/utils/screen_utils.dart';

class SaleProductModalContent extends StatelessWidget {
  const SaleProductModalContent({
    super.key,
    required this.product,
    required this.bloc,
  });
  final ProductEntity product;
  final SaleBloc bloc;

  @override
  Widget build(BuildContext context) {
    String price = product.saleNet?.toString() ?? '';
    int total = 1;

    final priceTextEditController = TextEditingController(text: price);
    final totalTextEditController = TextEditingController(
      text: total.toString(),
    );
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
                      product.name,
                      style: TextStyle(
                        fontSize: LayoutDimen.dimen_18.minSp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      product.code,
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
                InputBasic(
                  controller: priceTextEditController,
                  keyboardType: TextInputType.number,
                  labelText: 'Harga',
                  margin: EdgeInsets.zero,
                  onChanged: (value) {
                    price = value;
                  },
                ),
                SizedBox(
                  height: LayoutDimen.dimen_18.h,
                ),
                InputBasic(
                  controller: totalTextEditController,
                  keyboardType: TextInputType.number,
                  labelText: 'Jumlah',
                  margin: EdgeInsets.zero,
                  onChanged: (value) {
                    if (value.isEmpty) {
                      total = 0;
                    } else {
                      total = int.parse(value);
                    }
                  },
                ),
                SizedBox(
                  height: LayoutDimen.dimen_18.h,
                ),
                FlatButton(
                  title: 'Masukan',
                  onPressed: () {
                    // ignore: avoid_print
                    print('harga: $price, total: $total');
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
