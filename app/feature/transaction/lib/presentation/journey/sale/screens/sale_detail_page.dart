// ignore_for_file: lines_longer_than_80_chars

import 'package:data_abstraction/entity/receipt_entity.dart';
import 'package:data_abstraction/entity/sale_entity.dart';
import 'package:data_abstraction/entity/store_entity.dart';
import 'package:feature_transaction/presentation/blocs/print_bloc/print_bloc.dart';
import 'package:feature_transaction/presentation/journey/sale/bloc/sale_bloc.dart';
import 'package:feature_transaction/presentation/journey/sale/sale_constants.dart';
import 'package:flutter/material.dart';
import 'package:module_common/i18n/i18n_extension.dart';
import 'package:module_common/presentation/bloc/base_bloc.dart';
import 'package:ui_kit/common/constants/layout_dimen.dart';
import 'package:ui_kit/extensions/date_time_extension.dart';
import 'package:ui_kit/extensions/number_extension.dart';
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
    StoreEntity? storeDetail;
    List<SaleEntity> saleEntities = [];

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
      body: BlocConsumer<SaleBloc, SaleState>(
        listener: (context, state) {
          if (state is GetStoreLoaded) {
            storeDetail = state.storeEntity;
          }
          if (state is GetSalesByReceiptIdLoaded) {
            saleEntities = state.saleEntities;
          }
        },
        builder: (context, state) {
          return BlocBuilder<PrintBloc, PrintState>(
            builder: (context, state) {
              return Padding(
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
                                    if (storeDetail != null) ...[
                                      Text(
                                        storeDetail!.name,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: LayoutDimen.dimen_18.minSp,
                                        ),
                                      ),
                                      Text(
                                        storeDetail!.address.toString(),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w200,
                                          fontSize: LayoutDimen.dimen_12.minSp,
                                        ),
                                      ),
                                      Text(
                                        storeDetail!.phone,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w200,
                                          fontSize: LayoutDimen.dimen_14.minSp,
                                        ),
                                      ),
                                    ],
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
                                    saleEntities.length,
                                    (index) => Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Flexible(
                                          flex: 3,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                saleEntities[index]
                                                    .productEntity
                                                    .name,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w200,
                                                  fontSize: LayoutDimen
                                                      .dimen_12.minSp,
                                                ),
                                              ),
                                              Text(
                                                '     ${saleEntities[index].totalPcs} X          ${saleEntities[index].productEntity.saleNet.toRupiahCurrency()}',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w100,
                                                  fontSize: LayoutDimen
                                                      .dimen_10.minSp,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Flexible(
                                          flex: 2,
                                          child: Text(
                                            saleEntities[index]
                                                .totalNet
                                                .toRupiahCurrency(),
                                            style: TextStyle(
                                              fontWeight: FontWeight.w200,
                                              fontSize:
                                                  LayoutDimen.dimen_12.minSp,
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      flex: 3,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Total',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize:
                                                  LayoutDimen.dimen_16.minSp,
                                            ),
                                          ),
                                          Text(
                                            'Bayar',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w200,
                                              fontSize:
                                                  LayoutDimen.dimen_12.minSp,
                                            ),
                                          ),
                                          Text(
                                            'Kembali',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w200,
                                              fontSize:
                                                  LayoutDimen.dimen_12.minSp,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Flexible(
                                      flex: 2,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            receiptEntity.totalNet
                                                .toRupiahCurrency(),
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize:
                                                  LayoutDimen.dimen_16.minSp,
                                            ),
                                          ),
                                          Text(
                                            receiptEntity.cash
                                                .toRupiahCurrency(),
                                            style: TextStyle(
                                              fontWeight: FontWeight.w200,
                                              fontSize:
                                                  LayoutDimen.dimen_12.minSp,
                                            ),
                                          ),
                                          Text(
                                            receiptEntity.change
                                                .toRupiahCurrency(),
                                            style: TextStyle(
                                              fontWeight: FontWeight.w200,
                                              fontSize:
                                                  LayoutDimen.dimen_12.minSp,
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Tanggal Transaksi',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w200,
                                            fontSize:
                                                LayoutDimen.dimen_12.minSp,
                                          ),
                                        ),
                                        Text(
                                          receiptEntity.createdAt == null
                                              ? '-'
                                              : receiptEntity.createdAt!
                                                  .toYMMMMEEEEd(),
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize:
                                                LayoutDimen.dimen_12.minSp,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: LayoutDimen.dimen_8.h),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
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
                                                  fontSize: LayoutDimen
                                                      .dimen_12.minSp,
                                                ),
                                              ),
                                              Text(
                                                receiptEntity.createdAt == null
                                                    ? '-'
                                                    : '${receiptEntity.createdAt!.hour}:'
                                                        '${receiptEntity.createdAt!.minute}',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: LayoutDimen
                                                      .dimen_12.minSp,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Flexible(
                                          flex: 2,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Text(
                                                'Kasir',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w200,
                                                  fontSize: LayoutDimen
                                                      .dimen_12.minSp,
                                                ),
                                              ),
                                              Text(
                                                receiptEntity.userName,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: LayoutDimen
                                                      .dimen_12.minSp,
                                                ),
                                                textAlign: TextAlign.right,
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
                                printBloc.add(
                                  PrintExecuteEvent(
                                    saleEntityList: saleEntities,
                                    receiptEntity: receiptEntity,
                                    dateText: receiptEntity.createdAt == null
                                        ? '-'
                                        : receiptEntity.createdAt!
                                            .toYMMMMEEEEd(),
                                    timeText: receiptEntity.createdAt == null
                                        ? '-'
                                        : receiptEntity.createdAt!
                                            .toTimeWithColon(),
                                    userName: receiptEntity.userName,
                                    storeEntity: storeDetail,
                                  ),
                                );
                              },
                              margin: EdgeInsets.zero,
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
