import 'package:data_abstraction/entity/receipt_entity.dart';
import 'package:feature_transaction/presentation/journey/transaction_list/bloc/transaction_list_bloc.dart';
import 'package:feature_transaction/presentation/journey/transaction_list/transaction_list_constants.dart';
import 'package:feature_transaction/presentation/journey/transaction_list/transaction_list_routes.dart';
import 'package:flutter/material.dart';
import 'package:module_common/common/constant/translation_constants.dart';
import 'package:module_common/i18n/i18n_extension.dart';
import 'package:module_common/package/intl.dart';
import 'package:module_common/presentation/bloc/base_bloc.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:ui_kit/common/constants/layout_dimen.dart';
import 'package:ui_kit/extensions/number_extension.dart';
import 'package:ui_kit/theme/colors.dart';
import 'package:ui_kit/ui/loading_indicator/loading_circular.dart';
import 'package:ui_kit/ui/widgets/dummy_circle_image.dart';
import 'package:ui_kit/utils/screen_utils.dart';

class TransactionListPage extends StatefulWidget {
  const TransactionListPage({
    Key? key,
    required this.transactionListBloc,
  }) : super(key: key);

  final TransactionListBloc transactionListBloc;

  @override
  State<TransactionListPage> createState() => _TransactionListPageState();
}

class _TransactionListPageState extends State<TransactionListPage> {
  bool showSales = true;
  final circleWidth = LayoutDimen.dimen_28.w;
  DateTime filterDateTime = DateTime.now();

  @override
  void initState() {
    widget.transactionListBloc.add(
      GetSaleReceipts(
        dateTimeRange: DateTimeRange(
          start: filterDateTime.subtract(
            Duration(days: filterDateTime.day),
          ),
          end: filterDateTime,
        ),
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.neutral.c98,
      appBar: AppBar(
        title: Text(
          TransactionListStrings.transactionTitle.i18n(context),
          style: TextStyle(
            fontSize: LayoutDimen.dimen_19.minSp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: BlocBuilder<TransactionListBloc, TransactionListState>(
          builder: (context, state) {
            if (state is GetSaleReceiptsLoaded) {
              final totalAllPcs = state.saleReceipts
                  .map((e) => e.totalPcs)
                  .reduce((a, b) => a + b);
              final totalAllNet = state.saleReceipts
                  .map((e) => e.totalNet)
                  .reduce((a, b) => a + b);
              final receiptsCount = state.saleReceipts.length;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  buttonController(),
                  dateController(),
                  showSales
                      ? percentIndicator([
                          totalAllNet.toRupiahCurrency(),
                          // ignore: lines_longer_than_80_chars
                          '$totalAllPcs ${TranslationConstants.pcs.i18n(context)}',
                          // ignore: lines_longer_than_80_chars
                          '$receiptsCount ${TransactionListStrings.sales.i18n(context)}',
                        ])
                      : percentIndicator([
                          'Rp.197.650.000',
                          '1411 pcs',
                          '155 stok masuk',
                        ]),
                  thSales(state.saleReceipts),
                ],
              );
            }
            return const LoadingCircular();
          },
        ),
      ),
    );
  }

  Widget thSales(List<ReceiptEntity> receipts) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: LayoutDimen.dimen_16.h,
      ),
      margin: EdgeInsets.only(top: LayoutDimen.dimen_35.h),
      color: CustomColors.white.withOpacity(0.5),
      child: Column(
        children: List.generate(
          receipts.length,
          (index) => thSalesCard(receipts[index]),
        ),
      ),
    );
  }

  Widget thSalesCard(ReceiptEntity receiptEntity) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          TransactionListRoutes.transactionSaleDetail,
        );
      },
      child: Padding(
        padding: EdgeInsets.only(
          top: LayoutDimen.dimen_14.h,
          left: LayoutDimen.dimen_16.w,
          right: LayoutDimen.dimen_16.w,
        ),
        child: Container(
          padding: EdgeInsets.all(LayoutDimen.dimen_10.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  DummyCircleImage(title: receiptEntity.userName),
                  Padding(
                    padding: EdgeInsets.all(
                      LayoutDimen.dimen_10.w,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          receiptEntity.userName,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: LayoutDimen.dimen_13.minSp,
                            fontWeight: FontWeight.w100,
                          ),
                        ),
                        SizedBox(
                          height: LayoutDimen.dimen_7.h,
                        ),
                        Text(
                          receiptEntity.createdAt.toString(),
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: LayoutDimen.dimen_12.minSp,
                            fontWeight: FontWeight.w200,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    TransactionListStrings.total.i18n(context),
                    style: TextStyle(
                      fontSize: LayoutDimen.dimen_12.minSp,
                      fontWeight: FontWeight.w200,
                    ),
                  ),
                  Text(
                    receiptEntity.totalNet.toRupiahCurrency(),
                    style: TextStyle(
                      fontSize: LayoutDimen.dimen_16.minSp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget dateController() {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: LayoutDimen.dimen_35.h,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {},
            borderRadius: BorderRadius.circular(50),
            child: Material(
              elevation: 1,
              color: CustomColors.neutral.c80.withOpacity(0.5),
              borderRadius: BorderRadius.circular(50),
              child: Icon(
                Icons.arrow_left_rounded,
                size: LayoutDimen.dimen_35.h,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: LayoutDimen.dimen_11.w,
            ),
            child: InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(
                LayoutDimen.dimen_10.w,
              ),
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: LayoutDimen.dimen_11.w,
                  vertical: LayoutDimen.dimen_5.h,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    LayoutDimen.dimen_10.w,
                  ),
                  color: CustomColors.errorAccent.c50.withOpacity(0.3),
                ),
                child: Column(
                  children: [
                    Text(
                      // TODO(melly): move to a extension
                      DateFormat.MMMM('id').format(filterDateTime),
                      style: TextStyle(
                        fontSize: LayoutDimen.dimen_18.minSp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      filterDateTime.year.toString(),
                      style: TextStyle(
                        fontSize: LayoutDimen.dimen_14.minSp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {},
            borderRadius: BorderRadius.circular(50),
            child: Material(
              elevation: 1,
              color: CustomColors.neutral.c80.withOpacity(0.5),
              borderRadius: BorderRadius.circular(50),
              child: Icon(
                Icons.arrow_right_rounded,
                size: LayoutDimen.dimen_35.h,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buttonController() {
    return Container(
      margin: EdgeInsets.only(
        left: LayoutDimen.dimen_16.w,
        right: LayoutDimen.dimen_16.w,
        top: LayoutDimen.dimen_16.h,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(LayoutDimen.dimen_10.w),
        color: CustomColors.neutral.c90,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: InkWell(
              onTap: () {
                if (!showSales) {
                  setState(() {
                    showSales = true;
                  });
                }
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: LayoutDimen.dimen_12.h,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(LayoutDimen.dimen_10.w),
                  color: showSales ? CustomColors.secondary.c60 : null,
                ),
                child: Center(
                  child: Text(
                    TransactionListStrings.salesTitle.i18n(context),
                    style: TextStyle(
                      fontSize: LayoutDimen.dimen_16.minSp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () {
                if (showSales) {
                  setState(() {
                    showSales = false;
                  });
                }
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: LayoutDimen.dimen_12.h,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(LayoutDimen.dimen_10.w),
                  color: !showSales ? CustomColors.secondary.c60 : null,
                ),
                child: Center(
                  child: Text(
                    TransactionListStrings.stockInTitle.i18n(context),
                    style: TextStyle(
                      fontSize: LayoutDimen.dimen_16.minSp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget percentIndicator(List<String> texts) {
    return Center(
      child: CircularPercentIndicator(
        radius: LayoutDimen.dimen_150.w,
        animationDuration: 1000,
        lineWidth: circleWidth,
        animation: true,
        percent: 1,
        center: Padding(
          padding: EdgeInsets.all(
            circleWidth + LayoutDimen.dimen_16.w,
          ),
          child: Stack(
            children: [
              Center(
                child: Text(
                  texts.first,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: LayoutDimen.dimen_24.minSp,
                  ),
                ),
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      texts[1],
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: LayoutDimen.dimen_16.minSp,
                      ),
                    ),
                    Text(
                      texts.last,
                      style: TextStyle(
                        fontWeight: FontWeight.w200,
                        fontSize: LayoutDimen.dimen_14.minSp,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        progressColor: CustomColors.errorAccent.c70,
      ),
    );
  }
}
