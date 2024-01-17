import 'package:data_abstraction/entity/product_entity.dart';
import 'package:feature_transaction/presentation/blocs/transaction_bloc/transaction_bloc.dart';
import 'package:feature_transaction/presentation/routes.dart';
import 'package:flutter/material.dart';
import 'package:module_common/presentation/bloc/base_bloc.dart';
import 'package:ui_kit/common/constants/layout_dimen.dart';
import 'package:ui_kit/theme/colors.dart';
import 'package:ui_kit/ui/app_bar/app_bar_with_title_only.dart';
import 'package:ui_kit/ui/button/flat_button.dart';
import 'package:ui_kit/ui/input_field/input_basic.dart';
import 'package:ui_kit/ui/scanner/scanner_finder.dart';
import 'package:ui_kit/ui/snackbar/snackbar_dialog.dart';
import 'package:ui_kit/ui/widgets/dummy_circle_image.dart';
import 'package:ui_kit/utils/screen_utils.dart';

class StockInPage extends StatefulWidget {
  const StockInPage({
    super.key,
    required this.transactionBloc,
  });

  final TransactionBloc transactionBloc;

  @override
  State<StockInPage> createState() => _StockInPageState();
}

class _StockInPageState extends State<StockInPage> {
  List<ProductEntity> choiceProducts = [];
  bool isFromOnScan = false;
  bool holdScannerFlag = false;

  List<ProductEntity> filteredProducts = [];
  ProductEntity? selectedProduct;

  String totalProduct = '';
  String purchasePrice = '';

  final scannerTextEditController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.neutral.c95,
      appBar: const AppBarWithTitleOnly(
        appBarTitle: 'Stok Masuk',
      ),
      body: BlocConsumer<TransactionBloc, TransactionState>(
        listener: (context, state) {
          if (state is GetProductListLoaded) {
            choiceProducts = state.products;
            if (isFromOnScan && choiceProducts.length == 1) {
              onSelectedProduct(choiceProducts.first);
            }
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
                      // TODO(Melly): scanner finder will be wrapped as widget
                      // to be used on sale and stock_in
                      ScannerFinder(
                        labelText: 'Kode',
                        textEditController: scannerTextEditController,
                        holdScanner: holdScannerFlag,
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          addEventGetProducts(value);
                          setState(() {
                            isFromOnScan = false;
                          });
                        },
                        onScan: (value) {
                          addEventGetProducts(value);
                          setState(() {
                            isFromOnScan = true;
                          });
                        },
                        onSelected: (index) {
                          onSelectedProduct(choiceProducts[index]);
                        },
                        optionList: choiceProducts
                            .map(
                              (e) => Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: LayoutDimen.dimen_16.w,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      e.code,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: LayoutDimen.dimen_18.minSp,
                                        fontWeight: FontWeight.w200,
                                      ),
                                    ),
                                    Text(
                                      e.name,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: LayoutDimen.dimen_16.minSp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(
                                      height: LayoutDimen.dimen_8.h,
                                    )
                                  ],
                                ),
                              ),
                            )
                            .toList(),
                        addProductAction: () {},
                      ),
                      SizedBox(
                        height: LayoutDimen.dimen_12.h,
                      ),
                      if (selectedProduct != null) ...[
                        productCard(selectedProduct!),
                        SizedBox(
                          height: LayoutDimen.dimen_12.h,
                        ),
                        InputBasic(
                          labelText: 'Jumlah',
                          margin: EdgeInsets.zero,
                          keyboardType: TextInputType.number,
                          onChanged: (p0) {
                            setState(() {
                              totalProduct = p0;
                            });
                          },
                        ),
                        InputBasic(
                          labelText: 'Harga purchase (Rp)',
                          keyboardType: TextInputType.number,
                          margin: EdgeInsets.zero,
                          onChanged: (p0) {
                            setState(() {
                              purchasePrice = p0;
                            });
                          },
                        ),
                      ],
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
                      title: 'Masukan',
                      onPressed: selectedProduct != null &&
                              totalProduct.isNotEmpty &&
                              purchasePrice.isNotEmpty
                          ? () {
                              Navigator.pop(context);
                              Navigator.pushNamed(context, Routes.stockIn);
                              SnackbarDialog().show(
                                context: context,
                                message: 'Stok baru berhasil disimpan',
                                type: SnackbarDialogType.success,
                              );
                            }
                          : null,
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

  void addEventGetProducts(String value) {
    if (value.isEmpty) {
      setState(() {
        choiceProducts = [];
      });
    } else {
      widget.transactionBloc.add(
        GetProductListEvent(filterValue: value),
      );
    }
  }

  void onSelectedProduct(ProductEntity productEntity) {
    setState(() {
      holdScannerFlag = true;
      selectedProduct = productEntity;
      choiceProducts.clear();
      scannerTextEditController.clear();
    });
  }

  Widget productCard(ProductEntity product) {
    return Padding(
      padding: EdgeInsets.only(bottom: LayoutDimen.dimen_14.h),
      child: Material(
        elevation: 2,
        borderRadius: BorderRadius.circular(
          LayoutDimen.dimen_10.w,
        ),
        color: CustomColors.white,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: LayoutDimen.dimen_10.w,
            vertical: LayoutDimen.dimen_6.h,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  DummyCircleImage(title: product.name),
                  Padding(
                    padding: EdgeInsets.all(
                      LayoutDimen.dimen_10.w,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.name,
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
                          product.code,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: LayoutDimen.dimen_13.minSp,
                            fontWeight: FontWeight.w100,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    selectedProduct = null;
                    purchasePrice = '';
                    totalProduct = '';
                    holdScannerFlag = false;
                  });
                },
                child: Icon(
                  Icons.cancel_outlined,
                  size: LayoutDimen.dimen_38.w,
                  color: CustomColors.errorAccent.c60,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
