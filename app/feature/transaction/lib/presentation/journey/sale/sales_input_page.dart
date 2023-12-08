import 'package:data_abstraction/entity/product_entity.dart';
import 'package:feature_transaction/presentation/journey/sale/sale_routes.dart';
import 'package:feature_transaction/presentation/journey/sale/sales_review_page.dart';
import 'package:flutter/material.dart';
import 'package:ui_kit/common/constants/layout_dimen.dart';
import 'package:ui_kit/theme/colors.dart';
import 'package:ui_kit/ui/button/flat_button.dart';
import 'package:ui_kit/ui/scanner/scanner_finder.dart';
import 'package:ui_kit/utils/screen_utils.dart';

class SalesInputPage extends StatefulWidget {
  const SalesInputPage({super.key});

  @override
  State<SalesInputPage> createState() => _SalesInputPageState();
}

class _SalesInputPageState extends State<SalesInputPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.neutral.c95,
      appBar: AppBar(
        title: Text(
          'Penjualan',
          style: TextStyle(
            fontSize: LayoutDimen.dimen_19.minSp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Stack(
        children: [
          Container(
            height: ScreenUtil.screenHeight,
            padding: EdgeInsets.all(LayoutDimen.dimen_16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ScannerFinder(
                  labelText: 'Kode',
                  onChanged: (value) {},
                  onScan: (value) {},
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
                      arguments: SalesReviewArgument(listproduct),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<ProductEntity> listproduct = List.generate(
    10,
    (index) => ProductEntity(
      id: 'id',
      code: 'code',
      name: 'name${index + 1}',
      storeId: 'storeId',
      saleNet: int.parse('2${index + 1}00'),
    ),
  );

  Widget productListCard() {
    return Container(
      padding: EdgeInsets.only(
        bottom: LayoutDimen.dimen_100.h,
      ),
      child: ListView(
        children: List.generate(
          listproduct.length,
          (index) => SaleProductCard(
            product: listproduct[index],
            orderNumber: index + 1,
            totalPcs: 5,
            onDelete: () {
              setState(() {
                listproduct.removeAt(index);
              });
            },
          ),
        ),
      ),
    );
  }
}

// class SaleProductCard extends StatelessWidget {
//   const SaleProductCard({
//     Key? key,
//     required this.product,
//     required this.orderNumber,
//     required this.totalPcs,
//     required this.onDelete,
//   }) : super(key: key);

//   final ProductEntity product;
//   final int orderNumber;
//   final int totalPcs;
//   final void Function() onDelete;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.symmetric(
//         vertical: LayoutDimen.dimen_8.w,
//         horizontal: LayoutDimen.dimen_4.w,
//       ),
//       decoration: BoxDecoration(
//         border: Border(
//           bottom: BorderSide(
//             color: CustomColors.neutral.c90,
//           ),
//         ),
//       ),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             '$orderNumber. ${product.name}',
//             style: TextStyle(
//               fontSize: LayoutDimen.dimen_13.minSp,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//           Row(
//             children: [
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 children: [
//                   Text(
//                     '$totalPcs pcs',
//                     style: TextStyle(
//                       fontSize: LayoutDimen.dimen_13.minSp,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                   Text(
//                     (product.saleNet ?? '').toString().toRupiahCurrency(),
//                     style: TextStyle(
//                       fontSize: LayoutDimen.dimen_13.minSp,
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(
//                 width: LayoutDimen.dimen_16.w,
//               ),
//               InkWell(
//                 onTap: onDelete,
//                 child: Icon(
//                   Icons.close_rounded,
//                   size: LayoutDimen.dimen_24.w,
//                 ),
//               )
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
