import 'package:data_abstraction/entity/stock_in_entity.dart';
import 'package:data_abstraction/entity/supplier_entity.dart';
import 'package:feature_transaction/presentation/journey/stock_in/bloc/stock_in_bloc.dart';
import 'package:feature_transaction/presentation/journey/stock_in/stock_in_constants.dart';
import 'package:flutter/material.dart';
import 'package:module_common/i18n/i18n_extension.dart';
import 'package:module_common/presentation/bloc/base_bloc.dart';
import 'package:ui_kit/common/constants/layout_dimen.dart';
import 'package:ui_kit/theme/colors.dart';
import 'package:ui_kit/ui/app_bar/app_bar_with_title_only.dart';
import 'package:ui_kit/ui/button/flat_button.dart';
import 'package:ui_kit/ui/input_field/input_basic.dart';
import 'package:ui_kit/ui/loading_indicator/loading_circular.dart';
import 'package:ui_kit/ui/snackbar/snackbar_dialog.dart';
import 'package:ui_kit/utils/screen_utils.dart';

class StockInSupplierArgument {
  StockInSupplierArgument({
    required this.stockInEntity,
    required this.stockInBloc,
  });

  final StockInEntity stockInEntity;
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
  TextEditingController supplierEditingController = TextEditingController();
  SupplierEntity? supplier;
  List<SupplierEntity> allSuppliers = [];
  List<SupplierEntity> suppliers = [];
  bool addNewSuppier = false;
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
                          controller: supplierEditingController,
                          labelText: 'Supplier(opsional)',
                          suffixIcon:
                              const Icon(Icons.keyboard_arrow_down_rounded),
                          margin: EdgeInsets.zero,
                          onChanged: (p0) {
                            setState(() {
                              displaySuppliers = true;
                              suppliers = allSuppliers
                                  .where(
                                    (element) => element.name
                                        .toLowerCase()
                                        .contains(p0.toLowerCase()),
                                  )
                                  .toList();
                            });
                          },
                        ),
                        if (displaySuppliers &&
                            supplierEditingController.text.isNotEmpty)
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
                                            addNewSuppier = true;
                                            supplier = null;
                                          });
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
                                    suppliers
                                        .map(
                                          (e) => InkWell(
                                            onTap: () {
                                              setState(() {
                                                displaySuppliers = false;
                                                addNewSuppier = false;
                                                supplier = e;
                                                supplierEditingController.text =
                                                    e.name;
                                              });
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
                      if (addNewSuppier && supplier == null)
                        InputBasic(
                          labelText: 'Nomor HP Supplier',
                          keyboardType: TextInputType.number,
                          margin: EdgeInsets.zero,
                          onChanged: (p0) {},
                        ),
                      InputBasic(
                        labelText: 'PIC Supplier (Opsional)',
                        margin: EdgeInsets.zero,
                        onChanged: (p0) {},
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
                          'Lewati dan ${StockInConstants.input.i18n(context)}',
                      onPressed: () {
                        stockInBloc.add(
                          SubmitStockInEvent(
                            widget.stockInSupplierArgument.stockInEntity,
                          ),
                        );
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
