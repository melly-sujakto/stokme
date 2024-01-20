import 'package:data_abstraction/entity/product_entity.dart';
import 'package:data_abstraction/entity/stock_in_entity.dart';
import 'package:feature_transaction/presentation/blocs/transaction_bloc/transaction_bloc.dart';
import 'package:feature_transaction/presentation/journey/stock_in/bloc/stock_in_bloc.dart';
import 'package:feature_transaction/presentation/journey/stock_in/stock_in_constants.dart';
import 'package:flutter/material.dart';
import 'package:module_common/common/constant/translation_constants.dart';
import 'package:module_common/i18n/i18n_extension.dart';
import 'package:module_common/presentation/bloc/base_bloc.dart';
import 'package:module_common/presentation/widgets/product_detail_widget.dart';
import 'package:ui_kit/common/constants/layout_dimen.dart';
import 'package:ui_kit/theme/colors.dart';
import 'package:ui_kit/ui/app_bar/app_bar_with_title_only.dart';
import 'package:ui_kit/ui/button/flat_button.dart';
import 'package:ui_kit/ui/input_field/input_basic.dart';
import 'package:ui_kit/ui/loading_indicator/circular_progres.dart';
import 'package:ui_kit/ui/scanner/scanner_finder.dart';
import 'package:ui_kit/ui/snackbar/snackbar_dialog.dart';
import 'package:ui_kit/ui/widgets/dummy_circle_image.dart';
import 'package:ui_kit/utils/screen_utils.dart';

class StockInPage extends StatefulWidget {
  const StockInPage({
    super.key,
    required this.transactionBloc,
    required this.stockInBloc,
  });

  final TransactionBloc transactionBloc;
  final StockInBloc stockInBloc;

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
      appBar: AppBarWithTitleOnly(
        appBarTitle: StockInConstants.appTitle.i18n(context),
      ),
      body: BlocListener<StockInBloc, StockInState>(
        listener: (context, state) {
          if (state is SubmitStockLoading || state is AddProductLoading) {
            showDialog(
              context: context,
              builder: (context) => const CircularProgress(),
            );
          }
          if (state is SubmitStockError) {
            Navigator.pop(context);
            SnackbarDialog().show(
              context: context,
              message: StockInConstants.failedInputStockMessage.i18n(context),
              type: SnackbarDialogType.failed,
            );
          }
          if (state is SubmitStockSuccess) {
            Navigator.pop(context);
            SnackbarDialog().show(
              context: context,
              message: StockInConstants.successInputStockMessage.i18n(context),
              type: SnackbarDialogType.success,
            );
            resetSelectedProduct();
          }
          if (state is AddProductError) {
            Navigator.pop(context);
            SnackbarDialog().show(
              context: context,
              message:
                  TranslationConstants.failedAddProductMessage.i18n(context),
              type: SnackbarDialogType.failed,
            );
          }
          if (state is AddProductSuccess) {
            Navigator.pop(context);
            Navigator.pop(context);
            SnackbarDialog().show(
              context: context,
              message:
                  TranslationConstants.successAddProductMessage.i18n(context),
              type: SnackbarDialogType.success,
            );
            resetSelectedProduct();
          }
        },
        child: BlocConsumer<TransactionBloc, TransactionState>(
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
                          labelText: TranslationConstants.code.i18n(context),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                          addProductAction:
                              scannerTextEditController.text.isNotEmpty
                                  ? () {
                                      ProductDetail().showBottomSheet(
                                        context,
                                        // TODO(melly): handle initial product
                                        product: ProductEntity(
                                          code: scannerTextEditController.text,
                                          name: '',
                                          storeId: '',
                                        ),
                                        mainCallback: (product) {
                                          widget.stockInBloc
                                              .add(AddProductEvent(product));
                                        },
                                      );
                                    }
                                  : () {},
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
                            labelText: StockInConstants.totalPcs.i18n(context),
                            margin: EdgeInsets.zero,
                            keyboardType: TextInputType.number,
                            onChanged: (p0) {
                              setState(() {
                                totalProduct = p0;
                              });
                            },
                          ),
                          InputBasic(
                            labelText:
                                StockInConstants.purchaseNet.i18n(context),
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
                        title: StockInConstants.input.i18n(context),
                        onPressed: selectedProduct != null &&
                                totalProduct.isNotEmpty &&
                                purchasePrice.isNotEmpty
                            ? () {
                                widget.stockInBloc.add(
                                  SubmitStockInEvent(
                                    StockInEntity(
                                      productEntity: selectedProduct!,
                                      totalPcs: int.parse(totalProduct),
                                      purchaseNet: double.parse(purchasePrice),
                                    ),
                                  ),
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
                onTap: resetSelectedProduct,
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

  void resetSelectedProduct() {
    setState(() {
      choiceProducts.clear();
      selectedProduct = null;
      purchasePrice = '';
      totalProduct = '';
      holdScannerFlag = false;
      isFromOnScan = false;
      scannerTextEditController.clear();
      FocusManager.instance.primaryFocus?.unfocus();
    });
  }
}
