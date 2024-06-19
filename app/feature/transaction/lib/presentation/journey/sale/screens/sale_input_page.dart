import 'package:data_abstraction/entity/product_entity.dart';
import 'package:data_abstraction/entity/sale_entity.dart';
import 'package:feature_transaction/presentation/blocs/transaction_bloc/transaction_bloc.dart';
import 'package:feature_transaction/presentation/journey/sale/bloc/sale_bloc.dart';
import 'package:feature_transaction/presentation/journey/sale/sale_constants.dart';
import 'package:feature_transaction/presentation/journey/sale/sale_routes.dart';
import 'package:feature_transaction/presentation/journey/sale/screens/sale_review_page.dart';
import 'package:feature_transaction/presentation/journey/sale/widgets/sale_product_card.dart';
import 'package:feature_transaction/presentation/journey/sale/widgets/sale_product_modal_content.dart';
import 'package:flutter/material.dart';
import 'package:module_common/i18n/i18n_extension.dart';
import 'package:module_common/presentation/bloc/base_bloc.dart';
import 'package:ui_kit/common/constants/layout_dimen.dart';
import 'package:ui_kit/theme/colors.dart';
import 'package:ui_kit/ui/app_bar/app_bar_with_title_only.dart';
import 'package:ui_kit/ui/button/flat_button.dart';
import 'package:ui_kit/ui/scanner/scanner_finder.dart';
import 'package:ui_kit/utils/screen_utils.dart';

class SaleInputPage extends StatefulWidget {
  const SaleInputPage({
    Key? key,
    required this.saleBloc,
    required this.transactionBloc,
  }) : super(key: key);

  final SaleBloc saleBloc;
  final TransactionBloc transactionBloc;

  @override
  State<SaleInputPage> createState() => _SaleInputPageState();
}

class _SaleInputPageState extends State<SaleInputPage> {
  List<SaleEntity> recordedProducts = [];
  List<ProductEntity> choiceProducts = [];
  bool isFromOnScan = false;
  bool? isAutoActiveScanner;
  bool isAvailableEditPrice = false;

  final scannerTextEditController = TextEditingController();

  @override
  void initState() {
    widget.saleBloc.add(PrepareDataEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.neutral.c95,
      appBar: AppBarWithTitleOnly(
        appBarTitle: SaleStrings.inputPageTitle.i18n(context),
      ),
      body: BlocConsumer<SaleBloc, SaleState>(
        listener: (context, state) {
          if (state is SaleInitial) {
            isAutoActiveScanner = state.isAutoActiveScanner;
            isAvailableEditPrice = state.isAvailableEditPrice;
          }
          if (state is CalculationSuccess) {
            choiceProducts = [];
            scannerTextEditController.clear();
            //close Keyboard
            // TODO(melly): will check, is it disturb end user or not?
            FocusManager.instance.primaryFocus?.unfocus();
            recordedProducts.insert(0, state.saleEntity);
          }
        },
        builder: (context, state) =>
            BlocConsumer<TransactionBloc, TransactionState>(
          listener: (context, transactionState) {
            if (transactionState is GetProductListLoaded) {
              choiceProducts = transactionState.products;
            }
            if (transactionState is GetProductListLoadedOnLastPage) {
              if (isFromOnScan && transactionState.products.length == 1) {
                onSelectedProduct(transactionState.products.first);
              }
            }
          },
          builder: (context, transactionState) {
            return Stack(
              children: [
                SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.all(LayoutDimen.dimen_16.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (isAutoActiveScanner != null)
                          ScannerFinder(
                            labelText: SaleStrings.code.i18n(context),
                            autoActiveScanner: isAutoActiveScanner!,
                            textEditController: scannerTextEditController,
                            keyboardType: TextInputType.number,
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
                                            fontSize:
                                                LayoutDimen.dimen_18.minSp,
                                            fontWeight: FontWeight.w200,
                                          ),
                                        ),
                                        Text(
                                          e.name,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize:
                                                LayoutDimen.dimen_16.minSp,
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
                            onSelected: (index) {
                              onSelectedProduct(choiceProducts[index]);
                            },
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
                          ),
                        SizedBox(
                          height: LayoutDimen.dimen_32.h,
                        ),
                        ...List.generate(
                          recordedProducts.length,
                          (index) {
                            final orderNumber = recordedProducts.length - index;
                            final product =
                                recordedProducts[index].productEntity;
                            return SaleProductCard(
                              product: product,
                              orderNumber: orderNumber,
                              totalPcs: recordedProducts[index].totalPcs,
                              onEdit: () {
                                onEditProductDetail(
                                  productEntity: product,
                                  totalPcs: recordedProducts[index].totalPcs,
                                  recordedIndex: index,
                                  
                                );
                              },
                              onDelete: () {
                                setState(() {
                                  recordedProducts.removeAt(index);
                                });
                              },
                            );
                          },
                        ),
                        SizedBox(
                          height: LayoutDimen.dimen_100.h,
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
                        title: SaleStrings.continueBtnTitle.i18n(context),
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            SaleRoutes.salesReview,
                            arguments: SaleReviewArgument(
                              saleEntityList:
                                  recordedProducts.reversed.toList(),
                              saleBloc: widget.saleBloc,
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
      ),
    );
  }

  void onSelectedProduct(ProductEntity productEntity) {
    widget.saleBloc.add(
      CalculatePriceProductEvent(
        product: productEntity,
        totalPcs: 1,
      ),
    );
  }

  void onEditProductDetail({
    required ProductEntity productEntity,
    required int totalPcs,
    required int recordedIndex,
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
      builder: (context) => SaleProductModalContent(
        product: productEntity,
        totalPcs: totalPcs,
        bloc: widget.saleBloc,
        isAvailableEditPrice: isAvailableEditPrice,
        onEdit: () {
          setState(() {
            recordedProducts.removeAt(recordedIndex);
          });
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
        GetProductListEvent(filterByCode: value),
      );
    }
  }
}
