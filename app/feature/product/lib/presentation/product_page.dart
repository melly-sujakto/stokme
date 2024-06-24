import 'package:data_abstraction/entity/product_entity.dart';
import 'package:feature_product/presentation/bloc/product_bloc.dart';
import 'package:feature_product/presentation/product_constants.dart';
import 'package:flutter/material.dart';
import 'package:module_common/common/constant/translation_constants.dart';
import 'package:module_common/i18n/i18n_extension.dart';
import 'package:module_common/presentation/bloc/base_bloc.dart';
import 'package:module_common/presentation/widgets/product_detail_widget.dart';
import 'package:ui_kit/common/constants/layout_dimen.dart';
import 'package:ui_kit/extensions/number_extension.dart';
import 'package:ui_kit/theme/colors.dart';
import 'package:ui_kit/ui/infinite_pagination/infinite_paginantion_widget.dart';
import 'package:ui_kit/ui/loading_indicator/loading_circular.dart';
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

  final pagingController =
      PagingController<int, ProductEntity>(firstPageKey: 0);
  final limit = 10;
  int index = 0;
  ProductEntity? lastProduct;

  @override
  void initState() {
    super.initState();
    pagingController.addPageRequestListener(
      (pageKey) {
        addGetStockListEvent();
      },
    );
  }

  void addGetStockListEvent() {
    widget.bloc.add(
      GetProductListEvent(
        filterValue: filterValue,
        filterByUnsetPrice: activeIndex == 1,
        index: index,
        pageSize: limit,
        lastProduct: lastProduct,
      ),
    );
  }

  void resetFilter() {
    index = 0;
    lastProduct = null;
    pagingController.refresh();
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
        actions: [
          Padding(
            padding: EdgeInsets.only(right: LayoutDimen.dimen_16.w),
            child: InkWell(
              onTap: () {
                ProductDetail().showBottomSheet(
                  context,
                  mainCallback: (product) {
                    widget.bloc.add(AddProductEvent(product));
                  },
                  useScannerForCode: true,
                );
              },
              child: Icon(
                Icons.add,
                size: LayoutDimen.dimen_40.w,
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(LayoutDimen.dimen_16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ScannerFinder(
                labelText: TranslationConstants.scannerSearchNameCodeText
                    .i18n(context),
                onChanged: (value) {
                  filterValue = value;
                  resetFilter();
                },
                onScan: (value) {
                  filterValue = value;
                  resetFilter();
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
                      if (activeIndex == 0) {
                        resetFilter();
                      }
                    },
                    title: ProductStrings.tabItemAll.i18n(context),
                  ),
                  AppTabBarItem(
                    onTap: () {
                      if (activeIndex == 1) {
                        resetFilter();
                      }
                    },
                    title: ProductStrings.tabItemUnsetPrice.i18n(context),
                  ),
                ],
              ),
              BlocConsumer<ProductBloc, ProductState>(
                listenWhen: (previous, current) {
                  if (previous is UpdateLoading ||
                      previous is DeleteLoading ||
                      previous is AddProductLoading) {
                    Navigator.pop(context);
                  }
                  return true;
                },
                listener: (context, state) {
                  if (state is UpdateSuccess || state is DeleteSuccess) {
                    SnackbarDialog().show(
                      context: context,
                      message: state is UpdateSuccess
                          ? ProductStrings.updateSuccessSnackbar.i18n(context)
                          : ProductStrings.deleteSuccessSnackbar.i18n(context),
                      type: SnackbarDialogType.success,
                    );
                    resetFilter();
                  }
                  if (state is UpdateFailed || state is DeleteFailed) {
                    SnackbarDialog().show(
                      context: context,
                      message: state is UpdateSuccess
                          ? ProductStrings.updateFailedSnackbar.i18n(context)
                          : ProductStrings.deleteFailedSnackbar.i18n(context),
                      type: SnackbarDialogType.failed,
                    );
                  }
                  if (state is UpdateLoading ||
                      state is DeleteLoading ||
                      state is AddProductLoading) {
                    Navigator.pop(context);
                    showDialog(
                      context: context,
                      builder: (context) => const LoadingCircular.fullPage(),
                    );
                  }

                  if (state is AddProductError) {
                    SnackbarDialog().show(
                      context: context,
                      message: TranslationConstants.failedAddProductMessage
                          .i18n(context),
                      type: SnackbarDialogType.failed,
                    );
                  }
                  if (state is AddProductSuccess) {
                    SnackbarDialog().show(
                      context: context,
                      message: TranslationConstants.successAddProductMessage
                          .i18n(context),
                      type: SnackbarDialogType.success,
                    );
                    resetFilter();
                  }
                  if (state is ProductListLoaded) {
                    if (state.isLastPage) {
                      pagingController.appendLastPage(state.productList);
                    } else {
                      if (state.productList.isNotEmpty) {
                        lastProduct = state.productList.last;
                      }
                      index++;
                      pagingController.appendPage(state.productList, index);
                    }
                  }
                },
                builder: (context, state) {
                  return InfinitePaginationWidget(
                    itemBuilder: (context, item, key) => productCard(item),
                    pagingController: pagingController,
                  );
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
            ProductDetail().showBottomSheet(
              context,
              type: ProductDetailContentType.edit,
              product: product,
              mainCallback: (product) {
                widget.bloc.add(UpdateProductEvent(product));
              },
              deleteCallback: () => widget.bloc.add(
                DeleteProductEvent(product),
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
                  product.saleNet.toRupiahCurrency(),
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
