import 'package:data_abstraction/entity/product_entity.dart';
import 'package:feature_product/presentation/bloc/product_bloc.dart';
import 'package:feature_product/presentation/product_constants.dart';
import 'package:feature_product/presentation/widgets/product_detail_content.dart';
import 'package:flutter/material.dart';
import 'package:module_common/i18n/i18n_extension.dart';
import 'package:module_common/presentation/bloc/base_bloc.dart';
import 'package:ui_kit/common/constants/layout_dimen.dart';
import 'package:ui_kit/extensions/string_extension.dart';
import 'package:ui_kit/theme/colors.dart';
import 'package:ui_kit/ui/loading_indicator/circular_progres.dart';
import 'package:ui_kit/ui/scanner/scanner_finder.dart';
import 'package:ui_kit/ui/snackbar/snackbar_dialog.dart';
import 'package:ui_kit/ui/tab_bar/app_tab_bar.dart';
import 'package:ui_kit/ui/widgets/dummy_circle_image.dart';
import 'package:ui_kit/utils/screen_utils.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({
    super.key,
    required this.bloc,
  });
  final ProductBloc bloc;

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  int activeIndex = 0;
  String filterValue = '';

  @override
  void initState() {
    super.initState();
    widget.bloc.add(GetProductListEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.neutral.c98,
      appBar: AppBar(
        title: Text(
          ProductStrings.appTitle.i18n(context),
          style: TextStyle(
            fontSize: LayoutDimen.dimen_19.minSp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(LayoutDimen.dimen_16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ScannerFinder(
                labelText: ProductStrings.scannerLabelText.i18n(context),
                onChanged: (value) {
                  filterValue = value;
                  widget.bloc.add(
                    GetProductListEvent(
                      filterByUnsetPrice: activeIndex == 1,
                      filterValue: filterValue,
                    ),
                  );
                },
                onScan: (value) {
                  filterValue = value;
                  widget.bloc.add(
                    GetProductListEvent(
                      filterByUnsetPrice: activeIndex == 1,
                      filterValue: filterValue,
                    ),
                  );
                },
              ),
              AppTabBar(
                activeIndex: activeIndex,
                onIndexChanged: (index) {
                  activeIndex = index;
                },
                items: [
                  AppTabBarItem(
                    onTap: () {
                      widget.bloc.add(
                        GetProductListEvent(
                          filterValue: filterValue,
                        ),
                      );
                    },
                    title: ProductStrings.tabItemAll.i18n(context),
                  ),
                  AppTabBarItem(
                    onTap: () {
                      widget.bloc.add(
                        GetProductListEvent(
                          filterByUnsetPrice: true,
                          filterValue: filterValue,
                        ),
                      );
                    },
                    title: ProductStrings.tabItemUnsetPrice.i18n(context),
                  ),
                ],
              ),
              BlocConsumer<ProductBloc, ProductState>(
                listenWhen: (previous, current) {
                  if (previous is UpdateLoading) {
                    Navigator.pop(context);
                  }
                  return true;
                },
                listener: (context, state) {
                  if (state is UpdateSuccess) {
                    SnackbarDialog().show(
                      context: context,
                      message:
                          ProductStrings.updateSuccessSnackbar.i18n(context),
                      type: SnackbarDialogType.success,
                    );
                    widget.bloc.add(
                      GetProductListEvent(
                        filterByUnsetPrice: activeIndex == 1,
                        filterValue: filterValue,
                        forceRemote: true,
                      ),
                    );
                  }
                  if (state is UpdateFailed) {
                    SnackbarDialog().show(
                      context: context,
                      message:
                          ProductStrings.updateFailedSnackbar.i18n(context),
                      type: SnackbarDialogType.failed,
                    );
                  }
                  if (state is UpdateLoading) {
                    Navigator.pop(context);
                    showDialog(
                      context: context,
                      builder: (context) => const CircularProgress.fullPage(),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is ProductLoading) {
                    return const CircularProgress();
                  }
                  if (state is ProductListLoaded) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: state.productList.map(productCard).toList(),
                    );
                  }
                  return Container();
                },
              ),
            ],
          ),
        ),
      ),
    );
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
        child: InkWell(
          borderRadius: BorderRadius.circular(
            LayoutDimen.dimen_10.w,
          ),
          onTap: () {
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
                product: product,
                bloc: widget.bloc,
              ),
            );
          },
          child: Container(
            padding: EdgeInsets.all(LayoutDimen.dimen_10.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
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
                Text(
                  (product.saleNet?.toString() ?? '-').toRupiahCurrency(),
                  style: TextStyle(
                    fontSize: LayoutDimen.dimen_13.minSp,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
