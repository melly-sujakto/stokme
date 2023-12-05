import 'package:data_abstraction/entity/product_entity.dart';
import 'package:feature_product/presentation/bloc/product_bloc.dart';
import 'package:feature_product/presentation/product_constants.dart';
import 'package:flutter/material.dart';
import 'package:module_common/i18n/i18n_extension.dart';
import 'package:module_common/presentation/bloc/base_bloc.dart';
import 'package:ui_kit/common/constants/layout_dimen.dart';
import 'package:ui_kit/theme/colors.dart';
import 'package:ui_kit/ui/loading_indicator/circular_progres.dart';
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
              tabBar(),
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

  Widget tabBar() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.symmetric(
        vertical: LayoutDimen.dimen_19.h,
      ),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              if (activeIndex != 0) {
                setState(() {
                  activeIndex = 0;
                });
                widget.bloc.add(GetProductListEvent());
              }
            },
            customBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: LayoutDimen.dimen_18.w,
                vertical: LayoutDimen.dimen_6.w,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: activeIndex == 0 ? CustomColors.neutral.c90 : null,
              ),
              child: Text(
                'Semua',
                style: TextStyle(
                  fontSize: LayoutDimen.dimen_13.minSp,
                  fontWeight: FontWeight.w600,
                  color: activeIndex == 0
                      ? CustomColors.black
                      : CustomColors.neutral.c50,
                ),
              ),
            ),
          ),
          SizedBox(
            width: LayoutDimen.dimen_16.w,
          ),
          InkWell(
            onTap: () {
              if (activeIndex != 1) {
                setState(() {
                  activeIndex = 1;
                });
                widget.bloc.add(
                  GetProductListEvent(
                    filterByUnsetPrice: true,
                  ),
                );
              }
            },
            customBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: LayoutDimen.dimen_18.w,
                vertical: LayoutDimen.dimen_6.w,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: activeIndex == 1 ? CustomColors.neutral.c90 : null,
              ),
              child: Text(
                'Belum ada harga default',
                style: TextStyle(
                  fontSize: LayoutDimen.dimen_13.minSp,
                  fontWeight: FontWeight.w600,
                  color: activeIndex == 0
                      ? CustomColors.neutral.c50
                      : CustomColors.black,
                ),
              ),
            ),
          ),
        ],
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
        child: Container(
          padding: EdgeInsets.all(LayoutDimen.dimen_10.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                children: [
                  dummyCircleImage(title: product.name),
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
    );
  }

  Widget dummyCircleImage({String title = ''}) {
    late String logo;
    logo = title;
    if (title.isNotEmpty) {
      final titleSplitted = title.split(' ');
      if (titleSplitted.length == 1) {
        logo = titleSplitted.first[0].toUpperCase();
      }
      if (titleSplitted.length > 1) {
        logo = (titleSplitted.first[0] + titleSplitted.last[0]).toUpperCase();
      }
    }

    return Container(
      width: LayoutDimen.dimen_41.w,
      height: LayoutDimen.dimen_41.w,
      decoration: BoxDecoration(
        color: CustomColors.neutral.c90,
        borderRadius: BorderRadius.circular(LayoutDimen.dimen_50.w),
      ),
      child: Center(
        child: Text(
          logo,
          style: TextStyle(
            fontSize: LayoutDimen.dimen_13.minSp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
