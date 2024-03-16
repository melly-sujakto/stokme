import 'package:data_abstraction/entity/product_entity.dart';
import 'package:flutter/material.dart';
import 'package:module_common/common/constant/translation_constants.dart';
import 'package:module_common/i18n/i18n_extension.dart';
import 'package:ui_kit/common/constants/layout_dimen.dart';
import 'package:ui_kit/theme/colors.dart';
import 'package:ui_kit/ui/button/flat_button.dart';
import 'package:ui_kit/ui/dialog/confirmation_dialog.dart';
import 'package:ui_kit/ui/input_field/input_basic.dart';
import 'package:ui_kit/ui/scanner/scanner_finder.dart';
import 'package:ui_kit/utils/screen_utils.dart';

class ProductDetail {
  void showBottomSheet(
    BuildContext context, {
    required void Function(ProductEntity product) mainCallback,
    ProductEntity? product,
    void Function()? deleteCallback,
    ProductDetailContentType type = ProductDetailContentType.add,
    bool useScannerForCode = false,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(
            LayoutDimen.dimen_30.w,
          ),
          topRight: Radius.circular(
            LayoutDimen.dimen_30.w,
          ),
        ),
      ),
      builder: (context) => ProductDetailContent(
        product: product ??
            ProductEntity(
              code: '',
              name: '',
              storeId: '',
            ),
        deleteCallback: deleteCallback,
        mainCallback: mainCallback,
        type: type,
        useScannerForCode: useScannerForCode,
      ),
    );
  }
}

enum ProductDetailContentType { add, edit }

class ProductDetailContent extends StatefulWidget {
  const ProductDetailContent({
    super.key,
    required this.product,
    required this.mainCallback,
    this.deleteCallback,
    required this.type,
    required this.useScannerForCode,
  });
  final ProductEntity product;
  final void Function(ProductEntity product) mainCallback;
  final void Function()? deleteCallback;
  final ProductDetailContentType type;
  final bool useScannerForCode;

  @override
  State<ProductDetailContent> createState() => _ProductDetailContentState();
}

class _ProductDetailContentState extends State<ProductDetailContent> {
  late String code;
  late String name;
  late String saleNet;

  late final TextEditingController codeTextEditController;
  late final TextEditingController nameTextEditController;
  late final TextEditingController purchaseNetTextEditController;
  @override
  void initState() {
    super.initState();
    code = widget.product.code;
    name = widget.product.name;
    saleNet = widget.product.saleNet?.toString() ?? '0';

    codeTextEditController = TextEditingController(text: code);
    nameTextEditController = TextEditingController(text: name);
    purchaseNetTextEditController = TextEditingController(text: saleNet);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      // handle visibility of text field once keyboard shown
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        height: widget.useScannerForCode
            ? ScreenUtil.screenHeightDp * 0.65
            : LayoutDimen.dimen_352.h,
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
                  if (widget.type == ProductDetailContentType.edit)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.product.code,
                          style: TextStyle(
                            fontSize: LayoutDimen.dimen_18.minSp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        if (widget.deleteCallback != null)
                          InkWell(
                            onTap: () {
                              ConfirmationDialog(
                                descriptionText: TranslationConstants
                                    .deleteConfirmation
                                    .i18n(context),
                                cancelText:
                                    TranslationConstants.no.i18n(context),
                                confirmText:
                                    TranslationConstants.yes.i18n(context),
                                onConfirmed: () {
                                  Navigator.pop(context);
                                  widget.deleteCallback!();
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
                    )
                  else if (widget.useScannerForCode)
                    ScannerFinder(
                      autoActiveScanner: true,
                      onChanged: (value) {
                        setState(() {
                          code = value;
                        });
                      },
                      onScan: (value) {
                        setState(() {
                          code = value;
                        });
                      },
                    )
                  else
                    InputBasic(
                      controller: codeTextEditController,
                      keyboardType: TextInputType.number,
                      labelText: TranslationConstants.code.i18n(context),
                      margin: EdgeInsets.zero,
                      onChanged: (value) {
                        setState(() {
                          code = value;
                        });
                      },
                    ),
                  SizedBox(
                    height: LayoutDimen.dimen_18.h,
                  ),
                  InputBasic(
                    controller: nameTextEditController,
                    labelText: TranslationConstants.nameLabelText.i18n(context),
                    margin: EdgeInsets.zero,
                    onChanged: (value) {
                      setState(() {
                        name = value;
                      });
                    },
                  ),
                  SizedBox(
                    height: LayoutDimen.dimen_18.h,
                  ),
                  InputBasic(
                    controller: purchaseNetTextEditController,
                    keyboardType: TextInputType.number,
                    labelText:
                        TranslationConstants.priceLabelText.i18n(context),
                    margin: EdgeInsets.zero,
                    onChanged: (value) {
                      setState(() {
                        if (value.isEmpty) {
                          saleNet = '0';
                        } else {
                          saleNet = value;
                        }
                      });
                    },
                  ),
                  SizedBox(
                    height: LayoutDimen.dimen_18.h,
                  ),
                  FlatButton(
                    title: widget.type == ProductDetailContentType.add
                        ? TranslationConstants.addProductText.i18n(context)
                        : TranslationConstants.editText.i18n(context),
                    onPressed: code.isNotEmpty &&
                            name.isNotEmpty &&
                            saleNet.isNotEmpty
                        ? widget.type == ProductDetailContentType.add
                            ? () => widget.mainCallback(
                                  ProductEntity(
                                    id: widget.product.id,
                                    code: code,
                                    storeId: widget.product.storeId,
                                    name: name,
                                    saleNet: saleNet.isEmpty
                                        ? 0
                                        : double.parse(saleNet),
                                  ),
                                )
                            : () {
                                ConfirmationDialog(
                                  descriptionText: TranslationConstants
                                      .editConfirmation
                                      .i18n(context),
                                  cancelText:
                                      TranslationConstants.no.i18n(context),
                                  confirmText:
                                      TranslationConstants.yes.i18n(context),
                                  onConfirmed: () {
                                    Navigator.pop(context);
                                    widget.mainCallback(
                                      ProductEntity(
                                        id: widget.product.id,
                                        code: code,
                                        storeId: widget.product.storeId,
                                        name: name,
                                        saleNet: saleNet.isEmpty
                                            ? null
                                            : double.parse(saleNet),
                                      ),
                                    );
                                  },
                                ).show(context);
                              }
                        : null,
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
