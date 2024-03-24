import 'package:feature_transaction/common/injector/injector.dart';
import 'package:feature_transaction/domain/navigation/interaction_navigation.dart';
import 'package:feature_transaction/presentation/blocs/print_bloc/print_bloc.dart';
import 'package:feature_transaction/presentation/journey/sale/bloc/sale_bloc.dart';
import 'package:feature_transaction/presentation/journey/sale/sale_constants.dart';
import 'package:feature_transaction/presentation/journey/sale/sale_routes.dart';
import 'package:flutter/material.dart';
import 'package:module_common/i18n/i18n_extension.dart';
import 'package:module_common/presentation/bloc/base_bloc.dart';
import 'package:ui_kit/common/constants/layout_dimen.dart';
import 'package:ui_kit/extensions/number_extension.dart';
import 'package:ui_kit/theme/colors.dart';
import 'package:ui_kit/ui/button/flat_button.dart';
import 'package:ui_kit/ui/snackbar/snackbar_dialog.dart';
import 'package:ui_kit/utils/screen_utils.dart';

class SaleResultArgument {
  final SaleBloc saleBloc;

  SaleResultArgument(this.saleBloc);
}

class SaleResultPage extends StatefulWidget {
  const SaleResultPage({
    Key? key,
    required this.saleResultArgument,
  }) : super(key: key);

  final SaleResultArgument saleResultArgument;

  @override
  State<SaleResultPage> createState() => _SaleResultPageState();
}

class _SaleResultPageState extends State<SaleResultPage> {
  late final SaleBloc saleBloc;
  late final PrintBloc printBloc;

  @override
  void initState() {
    super.initState();
    saleBloc = widget.saleResultArgument.saleBloc;
    printBloc = context.read<PrintBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.neutral.c95,
      body: BlocBuilder<SaleBloc, SaleState>(
        builder: (context, state) {
          if (state is SubmitSuccess) {
            return Stack(
              children: [
                SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(
                      LayoutDimen.dimen_16.w,
                      LayoutDimen.dimen_94.w,
                      LayoutDimen.dimen_16.w,
                      LayoutDimen.dimen_100.h,
                    ),
                    child: Column(
                      children: [
                        Image.asset(
                          SaleAssets.successResultImage,
                          width: LayoutDimen.dimen_94.w,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: LayoutDimen.dimen_32.h,
                          ),
                          child: Text(
                            SaleStrings.successResultText.i18n(context),
                            style: TextStyle(
                              fontSize: LayoutDimen.dimen_20.minSp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Material(
                          elevation: 2,
                          borderRadius:
                              BorderRadius.circular(LayoutDimen.dimen_10.w),
                          color: CustomColors.white,
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.fromLTRB(
                                  LayoutDimen.dimen_12.w,
                                  LayoutDimen.dimen_12.w,
                                  LayoutDimen.dimen_40.w,
                                  LayoutDimen.dimen_24.w,
                                ),
                                height: LayoutDimen.dimen_115.h,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      children: [
                                        Image.asset(
                                          SaleAssets.priceTagIcon,
                                          width: LayoutDimen.dimen_45.w,
                                        ),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          SaleStrings.cashier.i18n(context),
                                          style: TextStyle(
                                            fontSize:
                                                LayoutDimen.dimen_18.minSp,
                                            fontWeight: FontWeight.w200,
                                          ),
                                        ),
                                        Text(
                                          saleBloc.userName,
                                          style: TextStyle(
                                            fontSize:
                                                LayoutDimen.dimen_18.minSp,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              dashedLine(),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  vertical: LayoutDimen.dimen_24.h,
                                  horizontal: LayoutDimen.dimen_32.w,
                                ),
                                height: LayoutDimen.dimen_230.h,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      saleBloc.receipt.totalNet
                                          .toRupiahCurrency(),
                                      style: TextStyle(
                                        fontSize: LayoutDimen.dimen_24.minSp,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.all(LayoutDimen.dimen_8.w),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                SaleStrings.transactionDate
                                                    .i18n(context),
                                              ),
                                              Text(state.dateText),
                                            ],
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Text(
                                                SaleStrings.transactionTime
                                                    .i18n(context),
                                              ),
                                              Text(state.timeText),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
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
                                          title: SaleStrings.printReceipt
                                              .i18n(context),
                                          onPressed: () async {
                                            printBloc.add(
                                              PrintExecuteEvent(
                                                saleEntityList:
                                                    state.saleEntityList,
                                                receiptEntity: saleBloc.receipt,
                                                dateText: state.dateText,
                                                timeText: state.timeText,
                                                userName: saleBloc.userName,
                                              ),
                                            );
                                          },
                                          margin: EdgeInsets.zero,
                                        );
                                      },
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
                      ],
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
                        padding: EdgeInsets.fromLTRB(
                          LayoutDimen.dimen_16.w,
                          0,
                          LayoutDimen.dimen_16.w,
                          LayoutDimen.dimen_32.h,
                        ),
                        child: FlatButton(
                          title: SaleStrings.done.i18n(context),
                          onPressed: () {
                            Injector.resolve<TransactionInteractionNavigation>()
                                .navigateToDashboardFromTransaction(context);
                            Navigator.pushNamed(context, SaleRoutes.salesInput);
                          },
                          margin: EdgeInsets.zero,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
          return Container();
        },
      ),
    );
  }

  Widget dashedLine() {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth();
        const dashWidth = 10.0;
        const dashHeight = 1.0;
        final dashCount = (boxWidth / (2 * dashWidth)).floor();
        return Flex(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: dashHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: CustomColors.neutral.c80,
                ),
              ),
            );
          }),
        );
      },
    );
  }
}
