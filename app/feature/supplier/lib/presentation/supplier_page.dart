import 'package:flutter/material.dart';
import 'package:ui_kit/common/constants/layout_dimen.dart';
import 'package:ui_kit/theme/colors.dart';
import 'package:ui_kit/ui/input_field/input_basic.dart';
import 'package:ui_kit/ui/widgets/dummy_circle_image.dart';
import 'package:ui_kit/utils/screen_utils.dart';

class SupplierPage extends StatefulWidget {
  const SupplierPage({
    super.key,
  });

  @override
  State<SupplierPage> createState() => _SupplierPageState();
}

class _SupplierPageState extends State<SupplierPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.neutral.c98,
      appBar: AppBar(
        title: Text(
          'Supplier',
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
            children: [
              InputBasic.search(labelText: 'Cari nama'),
              SizedBox(
                height: LayoutDimen.dimen_16.h,
              ),
              ...List.generate(
                5,
                (index) => supplierCard(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget supplierCard() {
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
            // SupplierDetail().showBottomSheet(
            //   context,
            //   type: ProductDetailContentType.edit,
            //   product: product,
            //   mainCallback: (product) {
            //     widget.bloc.add(UpdateProductEvent(product));
            //   },
            //   deleteCallback: () => widget.bloc.add(
            //     DeleteProductEvent(product),
            //   ),
            // );
          },
          child: Container(
            padding: EdgeInsets.all(LayoutDimen.dimen_8.w),
            child: Row(
              children: [
                const DummyCircleImage(title: 'CV. Indogood'),
                Padding(
                  padding: EdgeInsets.all(
                    LayoutDimen.dimen_10.w,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'CV. Indogood',
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
                        '081928273535',
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
          ),
        ),
      ),
    );
  }
}
