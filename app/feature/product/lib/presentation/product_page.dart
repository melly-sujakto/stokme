import 'package:data_abstraction/entity/product_entity.dart';
import 'package:feature_product/presentation/bloc/product_bloc.dart';
import 'package:feature_product/presentation/product_constants.dart';
import 'package:flutter/material.dart';
import 'package:module_common/i18n/i18n_extension.dart';
import 'package:module_common/presentation/bloc/base_bloc.dart';
import 'package:ui_kit/common/constants/layout_dimen.dart';
import 'package:ui_kit/theme/colors.dart';
import 'package:ui_kit/ui/button/flat_button.dart';
import 'package:ui_kit/ui/input_field/input_basic.dart';
import 'package:ui_kit/ui/loading_indicator/circular_progres.dart';
import 'package:ui_kit/ui/scanner/scanner_finder.dart';
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
                labelText: 'Cari nama/kode',
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
                    title: 'Semua',
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
                    title: 'Belum ada harga default',
                  ),
                ],
              ),
              BlocBuilder<ProductBloc, ProductState>(
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
              builder: (context) => detailContent(product),
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
                  'Rp.${product.saleNet ?? '-'}',
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

  Widget detailContent(ProductEntity product) {
    return Container(
      // height: LayoutDimen.dimen_352.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(LayoutDimen.dimen_30.w),
          topRight: Radius.circular(LayoutDimen.dimen_30.w),
        ),
        color: CustomColors.whiteSmoke,
      ),
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      product.code,
                      style: TextStyle(
                        fontSize: LayoutDimen.dimen_18.minSp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    InkWell(
                      onTap: () {},
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
                  controller: TextEditingController(text: product.name),
                  labelText: 'Nama',
                  margin: EdgeInsets.zero,
                ),
                SizedBox(
                  height: LayoutDimen.dimen_18.h,
                ),
                InputBasic(
                  controller: TextEditingController(
                    text: product.saleNet?.toString() ?? '',
                  ),
                  labelText: 'Harga Jual (opsional)',
                  margin: EdgeInsets.zero,
                ),
                SizedBox(
                  height: LayoutDimen.dimen_18.h,
                ),
                FlatButton(
                  title: 'Ubah',
                  onPressed: () {},
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
    );
  }
}
