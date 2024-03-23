import 'package:data_abstraction/entity/sale_entity.dart';
import 'package:feature_transaction/common/injector/injector.dart';
import 'package:feature_transaction/domain/navigation/interaction_navigation.dart';
import 'package:feature_transaction/presentation/journey/sale/bloc/sale_bloc.dart';
import 'package:feature_transaction/presentation/journey/sale/sale_constants.dart';
import 'package:feature_transaction/presentation/journey/sale/sale_routes.dart';
import 'package:feature_transaction/presentation/journey/sale/screens/sale_result_page.dart';
import 'package:feature_transaction/presentation/journey/sale/widgets/sale_product_card.dart';
import 'package:flutter/material.dart';
import 'package:module_common/i18n/i18n_extension.dart';
import 'package:module_common/presentation/bloc/base_bloc.dart';
import 'package:ui_kit/common/constants/layout_dimen.dart';
import 'package:ui_kit/extensions/string_extension.dart';
import 'package:ui_kit/theme/colors.dart';
import 'package:ui_kit/ui/app_bar/app_bar_with_title_only.dart';
import 'package:ui_kit/ui/button/flat_button.dart';
import 'package:ui_kit/ui/loading_indicator/loading_circular.dart';
import 'package:ui_kit/utils/screen_utils.dart';

class SaleReviewArgument {
  final List<SaleEntity> saleEntityList;
  final SaleBloc saleBloc;

  SaleReviewArgument({
    required this.saleEntityList,
    required this.saleBloc,
  });
}

class SaleReviewPage extends StatefulWidget {
  const SaleReviewPage({
    Key? key,
    required this.salesReviewArgument,
  }) : super(key: key);

  final SaleReviewArgument salesReviewArgument;

  @override
  State<SaleReviewPage> createState() => _SaleReviewPageState();
}

class _SaleReviewPageState extends State<SaleReviewPage> {
  double? total;

  @override
  void initState() {
    super.initState();
    widget.salesReviewArgument.saleBloc.add(
      CalculateTotalPriceEvent(
        widget.salesReviewArgument.saleEntityList,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.neutral.c95,
      appBar: AppBarWithTitleOnly(
        appBarTitle: SaleStrings.saleReviewTitle.i18n(context),
      ),
      body: BlocConsumer<SaleBloc, SaleState>(
        listener: (context, state) {
          if (state is CalculationTotalPriceSuccess) {
            total = state.receiptEntity.totalNet;
          }
          if (state is SubmitSuccess) {
            Injector.resolve<TransactionInteractionNavigation>()
                .navigateToDashboardFromTransaction(context);
            Navigator.pushNamed(
              context,
              SaleRoutes.salesResult,
              arguments: SaleResultArgument(
                widget.salesReviewArgument.saleBloc,
              ),
            );
          }
        },
        builder: (context, state) {
          return Stack(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                    LayoutDimen.dimen_16.w,
                    LayoutDimen.dimen_16.w,
                    LayoutDimen.dimen_16.w,
                    LayoutDimen.dimen_200.h,
                  ),
                  child: Column(
                    children: List.generate(
                      widget.salesReviewArgument.saleEntityList.length,
                      (index) {
                        final saleEntity =
                            widget.salesReviewArgument.saleEntityList[index];
                        return SaleProductCard(
                          product: saleEntity.productEntity,
                          orderNumber: index + 1,
                          totalPcs: saleEntity.totalPcs,
                          totalNet: saleEntity.totalNet,
                        );
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: ScreenUtil.screenHeight,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      color: CustomColors.neutral.c95,
                      padding: EdgeInsets.all(
                        LayoutDimen.dimen_16.w,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            SaleStrings.totalPrice.i18n(context),
                            style: TextStyle(
                              fontSize: LayoutDimen.dimen_18.minSp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            total != null
                                ? total.toString().toRupiahCurrency()
                                : '',
                            style: TextStyle(
                              fontSize: LayoutDimen.dimen_24.minSp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      color: CustomColors.neutral.c95,
                      padding: EdgeInsets.fromLTRB(
                        LayoutDimen.dimen_16.w,
                        0,
                        LayoutDimen.dimen_16.w,
                        LayoutDimen.dimen_32.h,
                      ),
                      child: state is SubmitLoading
                          ? const LoadingCircular()
                          : FlatButton(
                              title: SaleStrings.process.i18n(context),
                              onPressed: () {
                                widget.salesReviewArgument.saleBloc.add(
                                  SubmitReceiptAndSalesEvent(
                                    widget.salesReviewArgument.saleEntityList,
                                  ),
                                );
                              },
                              margin: EdgeInsets.zero,
                            ),
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
