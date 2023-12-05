import 'package:data_abstraction/entity/product_entity.dart';
import 'package:feature_product/presentation/bloc/product_bloc.dart';
import 'package:flutter/material.dart';
import 'package:module_common/presentation/bloc/base_bloc.dart';
import 'package:ui_kit/common/constants/layout_dimen.dart';
import 'package:ui_kit/theme/colors.dart';
import 'package:ui_kit/ui/loading_indicator/circular_progres.dart';
import 'package:ui_kit/utils/screen_utils.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.neutral.c98,
      appBar: AppBar(
        title: Text(
          'Produk dan Harga',
          style: TextStyle(
            fontSize: LayoutDimen.dimen_19.minSp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductLoading) {
            return const CircularProgress();
          }
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(LayoutDimen.dimen_16.w),
              child: Column(
                children: [
                  if (state is ProductListLoaded)
                    ...state.productList.map(productCard).toList()
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget productCard(ProductEntity product) {
    return Material(
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
                Container(
                  width: LayoutDimen.dimen_41.w,
                  height: LayoutDimen.dimen_41.w,
                  decoration: BoxDecoration(
                    color: CustomColors.neutral.c80,
                    borderRadius: BorderRadius.circular(LayoutDimen.dimen_50.w),
                  ),
                ),
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
              'Rp.${product.saleNet}',
              style: TextStyle(
                fontSize: LayoutDimen.dimen_13.minSp,
                fontWeight: FontWeight.w300,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
