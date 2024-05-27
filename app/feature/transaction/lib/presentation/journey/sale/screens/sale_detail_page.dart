import 'package:data_abstraction/entity/receipt_entity.dart';
import 'package:feature_transaction/presentation/blocs/print_bloc/print_bloc.dart';
import 'package:feature_transaction/presentation/journey/sale/sale_constants.dart';
import 'package:flutter/material.dart';
import 'package:module_common/i18n/i18n_extension.dart';
import 'package:module_common/presentation/bloc/base_bloc.dart';
import 'package:ui_kit/common/constants/layout_dimen.dart';
import 'package:ui_kit/theme/colors.dart';
import 'package:ui_kit/ui/button/flat_button.dart';
import 'package:ui_kit/ui/line/dotted_line.dart';
import 'package:ui_kit/ui/snackbar/snackbar_dialog.dart';
import 'package:ui_kit/utils/screen_utils.dart';

class SaleDetailPage extends StatelessWidget {
  final ReceiptEntity receiptEntity;
  const SaleDetailPage({
    super.key,
    required this.receiptEntity,
  });

  @override
  Widget build(BuildContext context) {
    final printBloc = context.read<PrintBloc>();

    return Scaffold(
      backgroundColor: CustomColors.neutral.c98,
      appBar: AppBar(
        title: Text(
          'Detail Penjualan',
          style: TextStyle(
            fontSize: LayoutDimen.dimen_19.minSp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: LayoutDimen.dimen_16.w,
          vertical: LayoutDimen.dimen_32.h,
        ),
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Material(
                borderRadius: BorderRadius.circular(1),
                color: CustomColors.white,
                elevation: 2,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: LayoutDimen.dimen_32.h,
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: LayoutDimen.dimen_32.w,
                        ),
                        child: Column(
                          children: [
                            Text(
                              'Toko Adi Jaya Sembako',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: LayoutDimen.dimen_18.minSp,
                              ),
                            ),
                            Text(
                              'Jembatan 14, RT.001/RW.005, Bojong Rawalumbu, Kec. Rawalumbu, Kota Bks, Jawa Barat',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.w200,
                                fontSize: LayoutDimen.dimen_12.minSp,
                              ),
                            ),
                            Text(
                              '081234567890',
                              style: TextStyle(
                                fontWeight: FontWeight.w200,
                                fontSize: LayoutDimen.dimen_14.minSp,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: LayoutDimen.dimen_16.h,
                        ),
                        child: const DottedLine(),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: LayoutDimen.dimen_32.w,
                        ),
                        child: Column(
                          children: List.generate(
                            1,
                            (index) => Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  flex: 3,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Kopi Kapal Api 50g',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w200,
                                          fontSize: LayoutDimen.dimen_12.minSp,
                                        ),
                                      ),
                                      Text(
                                        '     5 X          Rp.2.000',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w100,
                                          fontSize: LayoutDimen.dimen_10.minSp,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Flexible(
                                  flex: 2,
                                  child: Text(
                                    'Rp. 10.000',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w200,
                                      fontSize: LayoutDimen.dimen_12.minSp,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: LayoutDimen.dimen_16.h,
                        ),
                        child: const DottedLine(),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: LayoutDimen.dimen_32.w,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              flex: 3,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Total',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: LayoutDimen.dimen_16.minSp,
                                    ),
                                  ),
                                  Text(
                                    'Bayar',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w200,
                                      fontSize: LayoutDimen.dimen_12.minSp,
                                    ),
                                  ),
                                  Text(
                                    'Kembali',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w200,
                                      fontSize: LayoutDimen.dimen_12.minSp,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Flexible(
                              flex: 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    'Rp. 10.000',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: LayoutDimen.dimen_16.minSp,
                                    ),
                                  ),
                                  Text(
                                    'Rp. 10.000',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w200,
                                      fontSize: LayoutDimen.dimen_12.minSp,
                                    ),
                                  ),
                                  Text(
                                    'Rp. 0',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w200,
                                      fontSize: LayoutDimen.dimen_12.minSp,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: LayoutDimen.dimen_16.h,
                        ),
                        child: const DottedLine(),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: LayoutDimen.dimen_32.w,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Tanggal Transaksi',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w200,
                                    fontSize: LayoutDimen.dimen_12.minSp,
                                  ),
                                ),
                                Text(
                                  'Senin, 6 November 2023',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: LayoutDimen.dimen_12.minSp,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: LayoutDimen.dimen_8.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  flex: 3,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Waktu',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w200,
                                          fontSize: LayoutDimen.dimen_12.minSp,
                                        ),
                                      ),
                                      Text(
                                        '21:22',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: LayoutDimen.dimen_12.minSp,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Flexible(
                                  flex: 2,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        'Kasir',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w200,
                                          fontSize: LayoutDimen.dimen_12.minSp,
                                        ),
                                      ),
                                      Text(
                                        'Melly Sujakto',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: LayoutDimen.dimen_12.minSp,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                BlocConsumer<PrintBloc, PrintState>(
                  listener: (context, printState) {
                    if (printState is PrintFailed) {
                      SnackbarDialog().show(
                        context: context,
                        message: 'Gagal mencetak struk,'
                            ' silakan cek kembali',
                        type: SnackbarDialogType.failed,
                      );
                    }
                  },
                  builder: (context, printState) {
                    if (printState is PrintLoading) {
                      return FlatButton(
                        title: 'Sedang mencetak...',
                        color: CustomColors.neutral.c90,
                        onPressed: null,
                      );
                    }
                    return FlatButton(
                      title: SaleStrings.printReceipt.i18n(context),
                      onPressed: () async {
                        // printBloc.add(
                        //   PrintExecuteEvent(
                        //     saleEntityList: state.saleEntityList,
                        //     receiptEntity: saleBloc.receipt,
                        //     dateText: state.dateText,
                        //     timeText: state.timeText,
                        //     userName: saleBloc.userName,
                        //   ),
                        // );
                      },
                      margin: EdgeInsets.zero,
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
