import 'package:data_abstraction/entity/product_entity.dart';
import 'package:data_abstraction/entity/sale_entity.dart';
import 'package:feature_transaction/presentation/journey/sale/bloc/sale_bloc.dart';
import 'package:feature_transaction/presentation/journey/sale/sale_routes.dart';
import 'package:feature_transaction/presentation/journey/sale/screens/sale_review_page.dart';
import 'package:feature_transaction/presentation/journey/sale/widgets/sale_product_card.dart';
import 'package:feature_transaction/presentation/journey/sale/widgets/sale_product_modal_content.dart';
import 'package:flutter/material.dart';
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
  }) : super(key: key);

  final SaleBloc saleBloc;

  @override
  State<SaleInputPage> createState() => _SaleInputPageState();
}

class _SaleInputPageState extends State<SaleInputPage> {
  List<SaleEntity> recordedProducts = [];
  List<ProductEntity> choiceProducts = [];

  final scannerTextEditController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.neutral.c95,
      appBar: const AppBarWithTitleOnly(appBarTitle: 'Penjualan'),
      body: BlocConsumer<SaleBloc, SaleState>(
        listener: (context, state) {
          if (state is GetProductListLoaded) {
            choiceProducts = state.products;
          }
          if (state is CalculationSuccess) {
            choiceProducts = [];
            scannerTextEditController.clear();
            //close Keyboard
            // TODO(melly): will check, is it disturb end user or not?
            FocusManager.instance.primaryFocus?.unfocus();
            recordedProducts.add(state.saleEntity);
          }
        },
        builder: (context, state) => Stack(
          children: [
            Container(
              height: ScreenUtil.screenHeight,
              padding: EdgeInsets.all(LayoutDimen.dimen_16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ScannerFinder(
                    labelText: 'Kode',
                    textEditController: scannerTextEditController,
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
                    onSelected: (index) {
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
                          product: choiceProducts[index],
                          bloc: widget.saleBloc,
                        ),
                      );
                    },
                    onChanged: addEventGetProducts,
                    onScan: addEventGetProducts,
                  ),
                  SizedBox(
                    height: LayoutDimen.dimen_32.h,
                  ),
                  Expanded(child: productListCard()),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(bottom: LayoutDimen.dimen_32.h),
              height: ScreenUtil.screenHeight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FlatButton(
                    title: 'Lanjut',
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        SaleRoutes.salesReview,
                        arguments: SaleReviewArgument(recordedProducts),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
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
      widget.saleBloc.add(
        GetProductListEvent(filterValue: value),
      );
    }
  }

  Widget productListCard() {
    return Container(
      padding: EdgeInsets.only(
        bottom: LayoutDimen.dimen_100.h,
      ),
      child: ListView(
        children: List.generate(
          recordedProducts.length,
          (index) => SaleProductCard(
            product: recordedProducts[index].productEntity,
            orderNumber: index + 1,
            totalPcs: recordedProducts[index].total,
            onDelete: () {
              setState(() {
                recordedProducts.removeAt(index);
              });
            },
          ),
        ),
      ),
    );
  }
}
