import 'package:data_abstraction/entity/supplier_entity.dart';
import 'package:flutter/material.dart';
import 'package:module_common/common/constant/translation_constants.dart';
import 'package:module_common/i18n/i18n_extension.dart';
import 'package:ui_kit/common/constants/layout_dimen.dart';
import 'package:ui_kit/theme/colors.dart';
import 'package:ui_kit/ui/button/flat_button.dart';
import 'package:ui_kit/ui/dialog/confirmation_dialog.dart';
import 'package:ui_kit/ui/input_field/input_basic.dart';
import 'package:ui_kit/utils/screen_utils.dart';

class SupplierDetail {
  void showBottomSheet(
    BuildContext context, {
    required void Function(SupplierEntity supplier) mainCallback,
    required SupplierEntity supplier,
    void Function()? deleteCallback,
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
      builder: (context) => SupplierDetailContent(
        supplier: supplier,
        deleteCallback: deleteCallback,
        mainCallback: mainCallback,
      ),
    );
  }
}

class SupplierDetailContent extends StatefulWidget {
  const SupplierDetailContent({
    super.key,
    required this.supplier,
    required this.mainCallback,
    this.deleteCallback,
  });
  final SupplierEntity supplier;
  final void Function(SupplierEntity supplier) mainCallback;
  final void Function()? deleteCallback;

  @override
  State<SupplierDetailContent> createState() => _SupplierDetailContentState();
}

class _SupplierDetailContentState extends State<SupplierDetailContent> {
  late String phone;
  late String name;

  late final TextEditingController phoneTextEditController;
  late final TextEditingController nameTextEditController;
  @override
  void initState() {
    super.initState();
    phone = widget.supplier.phone;
    name = widget.supplier.name;

    phoneTextEditController = TextEditingController(text: phone);
    nameTextEditController = TextEditingController(text: name);
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
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: LayoutDimen.dimen_18.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      if (widget.deleteCallback != null)
                        InkWell(
                          onTap: () {
                            ConfirmationDialog(
                              descriptionText: 'Hapus supplier ini?',
                              cancelText: TranslationConstants.no.i18n(context),
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
                    controller: phoneTextEditController,
                    keyboardType: TextInputType.number,
                    labelText: 'No HP',
                    margin: EdgeInsets.zero,
                    onChanged: (value) {
                      setState(() {
                        setState(() {
                          phone = value;
                        });
                      });
                    },
                  ),
                  SizedBox(
                    height: LayoutDimen.dimen_18.h,
                  ),
                  FlatButton(
                    title: TranslationConstants.editText.i18n(context),
                    onPressed: phone.isNotEmpty && name.isNotEmpty
                        ? () {
                            ConfirmationDialog(
                              descriptionText: 'Ubah detail supplier ini?',
                              cancelText: TranslationConstants.no.i18n(context),
                              confirmText:
                                  TranslationConstants.yes.i18n(context),
                              onConfirmed: () {
                                Navigator.pop(context);
                                widget.mainCallback(
                                  _generateSupplierDetail(),
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

  SupplierEntity _generateSupplierDetail() {
    return SupplierEntity(
      id: widget.supplier.id,
      phone: phone,
      name: name,
      createdAt: widget.supplier.createdAt,
      createdBy: widget.supplier.createdBy,
      updatedAt: widget.supplier.updatedAt,
      updatedBy: widget.supplier.updatedBy,
    );
  }
}
