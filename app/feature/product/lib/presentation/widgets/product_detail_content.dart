import 'package:data_abstraction/entity/product_entity.dart';
import 'package:feature_product/presentation/bloc/product_bloc.dart';
import 'package:feature_product/presentation/product_constants.dart';
import 'package:flutter/material.dart';
import 'package:module_common/i18n/i18n_extension.dart';
import 'package:ui_kit/common/constants/layout_dimen.dart';
import 'package:ui_kit/theme/colors.dart';
import 'package:ui_kit/ui/button/flat_button.dart';
import 'package:ui_kit/ui/dialog/confirmation_dialog.dart';
import 'package:ui_kit/ui/input_field/input_basic.dart';
import 'package:ui_kit/utils/screen_utils.dart';

class ProductDetailContent extends StatelessWidget {
  const ProductDetailContent({
    super.key,
    required this.product,
    required this.bloc,
  });
  final ProductEntity product;
  final ProductBloc bloc;

  @override
  Widget build(BuildContext context) {
    String name = product.name;
    String price = product.saleNet?.toString() ?? '';

    final nameTextEditController = TextEditingController(text: name);
    final priceTextEditController = TextEditingController(text: price);

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
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: LayoutDimen.dimen_18.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        product.code,
                        style: TextStyle(
                          fontSize: LayoutDimen.dimen_18.minSp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          // TODO(Melly): move to strings class
                          ConfirmationDialog(
                            descriptionText: 'Hapus produk ini?',
                            cancelText: 'No',
                            confirmText: 'Yes',
                            onConfirmed: () {
                              Navigator.pop(context);
                              bloc.add(DeleteProductEvent(product));
                            },
                          ).show(context);
                        },
                        child: Icon(
                          Icons.delete,
                          size: LayoutDimen.dimen_30.w,
                          color: CustomColors.neutral.c30,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: LayoutDimen.dimen_18.h,
                  ),
                  InputBasic(
                    controller: nameTextEditController,
                    labelText: ProductStrings.nameLabelText.i18n(context),
                    margin: EdgeInsets.zero,
                    onChanged: (value) {
                      name = value;
                    },
                  ),
                  SizedBox(
                    height: LayoutDimen.dimen_18.h,
                  ),
                  InputBasic(
                    controller: priceTextEditController,
                    keyboardType: TextInputType.number,
                    labelText: ProductStrings.priceLabelText.i18n(context),
                    margin: EdgeInsets.zero,
                    onChanged: (value) {
                      price = value;
                    },
                  ),
                  SizedBox(
                    height: LayoutDimen.dimen_18.h,
                  ),
                  FlatButton(
                    title: ProductStrings.editButtonTitle.i18n(context),
                    onPressed: () {
                      // TODO(Melly): move to strings class
                      ConfirmationDialog(
                        descriptionText: 'Ubah produk ini?',
                        cancelText: 'No',
                        confirmText: 'Yes',
                        onConfirmed: () {
                          Navigator.pop(context);
                          bloc.add(
                            UpdateProductEvent(
                              ProductEntity(
                                id: product.id,
                                code: product.code,
                                storeId: product.storeId,
                                name: name,
                                saleNet:
                                    price.isEmpty ? null : double.parse(price),
                              ),
                            ),
                          );
                        },
                      ).show(context);
                    },
                    margin: EdgeInsets.zero,
                  ),
                  SizedBox(
                    height: LayoutDimen.dimen_18.h,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
