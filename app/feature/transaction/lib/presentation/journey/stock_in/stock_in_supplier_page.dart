import 'package:data_abstraction/entity/supplier_entity.dart';
import 'package:feature_transaction/presentation/journey/stock_in/bloc/stock_in_bloc.dart';
import 'package:feature_transaction/presentation/journey/stock_in/stock_in_constants.dart';
import 'package:flutter/material.dart';
import 'package:module_common/common/constant/translation_constants.dart';
import 'package:module_common/i18n/i18n_extension.dart';
import 'package:module_common/presentation/bloc/base_bloc.dart';
import 'package:ui_kit/common/constants/layout_dimen.dart';
import 'package:ui_kit/theme/colors.dart';
import 'package:ui_kit/ui/app_bar/app_bar_with_title_only.dart';
import 'package:ui_kit/ui/button/flat_button.dart';
import 'package:ui_kit/ui/dialog/confirmation_dialog.dart';
import 'package:ui_kit/ui/input_field/input_basic.dart';
import 'package:ui_kit/ui/loading_indicator/loading_circular.dart';
import 'package:ui_kit/ui/snackbar/snackbar_dialog.dart';
import 'package:ui_kit/utils/screen_utils.dart';

class StockInSupplierArgument {
  StockInSupplierArgument({required this.stockInBloc});

  final StockInBloc stockInBloc;
}

class StockInSupplierPage extends StatefulWidget {
  final StockInSupplierArgument stockInSupplierArgument;
  const StockInSupplierPage({
    super.key,
    required this.stockInSupplierArgument,
  });

  @override
  State<StockInSupplierPage> createState() => _StockInSupplierPageState();
}

class _StockInSupplierPageState extends State<StockInSupplierPage> {
  late final StockInBloc stockInBloc;
  TextEditingController supplierNameController = TextEditingController();
  TextEditingController supplierPhoneController = TextEditingController();
  TextEditingController supplierPICController = TextEditingController();
  SupplierEntity? selectedSupplier;
  List<SupplierEntity> allSuppliers = [];
  List<SupplierEntity> filteredSuppliers = [];
  bool addNewSupplier = false;
  bool displaySuppliers = false;

  @override
  void initState() {
    stockInBloc = widget.stockInSupplierArgument.stockInBloc
      ..add(GetSuppliersEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.neutral.c95,
      appBar: AppBarWithTitleOnly(
        appBarTitle: 'Supplier ${StockInConstants.appTitle.i18n(context)}',
      ),
      body: BlocConsumer<StockInBloc, StockInState>(
        listener: (context, stockInState) {
          if (stockInState is GetSuppliersLoaded) {
            allSuppliers = stockInState.suppliers;
          }
          if (stockInState is SubmitStockLoading) {
            showDialog(
              context: context,
              builder: (context) => const LoadingCircular(),
            );
          }
          if (stockInState is SubmitStockError) {
            Navigator.pop(context);
            SnackbarDialog().show(
              context: context,
              message: StockInConstants.failedInputStockMessage.i18n(context),
              type: SnackbarDialogType.failed,
            );
          }
          if (stockInState is SubmitStockSuccess) {
            Navigator.pop(context);
            Navigator.pop(context, true);
            SnackbarDialog().show(
              context: context,
              message: StockInConstants.successInputStockMessage.i18n(context),
              type: SnackbarDialogType.success,
            );
          }
        },
        builder: (context, state) {
          return Stack(
            children: [
              SingleChildScrollView(
                child: Container(
                  height: ScreenUtil.screenHeight,
                  padding: EdgeInsets.all(LayoutDimen.dimen_16.w),
                  child: Column(
                    children: [
                      ...[
                        InputBasic(
                          controller: supplierNameController,
                          labelText: 'Supplier(opsional)',
                          suffixIcon:
                              const Icon(Icons.keyboard_arrow_down_rounded),
                          margin: EdgeInsets.zero,
                          onChanged: (p0) {
                            setState(() {
                              displaySuppliers = true;
                              filteredSuppliers = allSuppliers
                                  .where(
                                    (element) => element.name
                                        .toLowerCase()
                                        .contains(p0.toLowerCase()),
                                  )
                                  .toList();
                            });
                            if (p0.isEmpty) {
                              setState(() {
                                selectedSupplier = null;
                                addNewSupplier = false;
                              });
                              stockInBloc.add(
                                UpdateStockInDataEvent(
                                  stockInBloc.stockInEntity.copyWith(
                                    supplierId: '',
                                    supplierName: '',
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                        if (displaySuppliers &&
                            supplierNameController.text.isNotEmpty)
                          Material(
                            elevation: 2,
                            borderRadius: BorderRadius.circular(
                              LayoutDimen.dimen_10.w,
                            ),
                            color: CustomColors.white,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                vertical: LayoutDimen.dimen_16.h,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            displaySuppliers = false;
                                            addNewSupplier = true;
                                            selectedSupplier = null;
                                          });
                                          stockInBloc.add(
                                            UpdateStockInDataEvent(
                                              stockInBloc.stockInEntity
                                                  .copyWith(
                                                supplierId: '',
                                                supplierName: '',
                                              ),
                                            ),
                                          );
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                            vertical: LayoutDimen.dimen_8.h,
                                            horizontal: LayoutDimen.dimen_16.w,
                                          ),
                                          decoration: BoxDecoration(
                                            border: Border(
                                              bottom: BorderSide(
                                                color: CustomColors.neutral.c80,
                                              ),
                                            ),
                                          ),
                                          child: Text(
                                            'Tambah Sebagai Supplier Baru',
                                            textAlign: TextAlign.center,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize:
                                                  LayoutDimen.dimen_18.minSp,
                                              fontWeight: FontWeight.w900,
                                              color: CustomColors.secondary.c30,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ] +
                                    filteredSuppliers
                                        .map(
                                          (e) => InkWell(
                                            onTap: () {
                                              setState(() {
                                                displaySuppliers = false;
                                                addNewSupplier = false;
                                                selectedSupplier = e;
                                                supplierNameController.text =
                                                    e.name;
                                              });
                                              stockInBloc.add(
                                                UpdateStockInDataEvent(
                                                  stockInBloc.stockInEntity
                                                      .copyWith(
                                                    supplierId: e.id,
                                                    supplierName: e.name,
                                                  ),
                                                ),
                                              );
                                            },
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                vertical: LayoutDimen.dimen_8.h,
                                                horizontal:
                                                    LayoutDimen.dimen_16.w,
                                              ),
                                              decoration: BoxDecoration(
                                                border: Border(
                                                  bottom: BorderSide(
                                                    color: CustomColors
                                                        .neutral.c80,
                                                  ),
                                                ),
                                              ),
                                              child: Text(
                                                e.name,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  fontSize: LayoutDimen
                                                      .dimen_18.minSp,
                                                  fontWeight: FontWeight.w200,
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                        .toList(),
                              ),
                            ),
                          ),
                      ],
                      if (addNewSupplier && selectedSupplier == null)
                        InputBasic(
                          controller: supplierPhoneController,
                          labelText: 'Nomor HP Supplier',
                          keyboardType: TextInputType.number,
                          margin: EdgeInsets.zero,
                          onChanged: (p0) {},
                        ),
                      if (selectedSupplier != null ||
                          (addNewSupplier && selectedSupplier == null))
                        InputBasic(
                          controller: supplierPICController,
                          labelText: 'PIC Supplier (Opsional)',
                          margin: EdgeInsets.zero,
                          onChanged: (p0) {
                            stockInBloc.add(
                              UpdateStockInDataEvent(
                                stockInBloc.stockInEntity
                                    .copyWith(supplierPIC: p0),
                              ),
                            );
                          },
                        ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(bottom: LayoutDimen.dimen_32.h),
                height: ScreenUtil.screenHeight,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    FlatButton(
                      title:
                          // ignore: lines_longer_than_80_chars
                          '${selectedSupplier == null && !addNewSupplier ? 'Lewati dan ' : ''}'
                          '${StockInConstants.input.i18n(context)}',
                      onPressed: displaySuppliers
                          ? null
                          : addNewSupplier &&
                                  supplierPhoneController.text.isEmpty
                              ? null
                              : () {
                                  ConfirmationDialog(
                                    descriptionText: 'Proses transaksi ini?',
                                    cancelText:
                                        TranslationConstants.no.i18n(context),
                                    confirmText:
                                        TranslationConstants.yes.i18n(context),
                                    onConfirmed: () {
                                      Navigator.pop(context);
                                      stockInBloc.add(
                                        SubmitStockInEvent(
                                          supplierEntity: addNewSupplier
                                              ? SupplierEntity(
                                                  name: supplierNameController
                                                      .text,
                                                  phone: supplierNameController
                                                      .text,
                                                )
                                              : selectedSupplier,
                                          isNewSupplier:
                                              selectedSupplier == null &&
                                                  addNewSupplier,
                                        ),
                                      );
                                    },
                                  ).show(context);
                                },
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
