import 'package:data_abstraction/entity/receipt_entity.dart';
import 'package:data_abstraction/entity/stock_in_entity.dart';
import 'package:feature_transaction/presentation/journey/transaction_list/bloc/transaction_list_bloc.dart';
import 'package:feature_transaction/presentation/journey/transaction_list/transaction_list_constants.dart';
import 'package:feature_transaction/presentation/journey/transaction_list/widgets/th_sales_card.dart';
import 'package:feature_transaction/presentation/journey/transaction_list/widgets/th_stock_in_card.dart';
import 'package:flutter/material.dart';
import 'package:module_common/common/constant/translation_constants.dart';
import 'package:module_common/i18n/i18n_extension.dart';
import 'package:module_common/package/intl.dart';
import 'package:module_common/presentation/bloc/base_bloc.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:ui_kit/common/constants/layout_dimen.dart';
import 'package:ui_kit/extensions/number_extension.dart';
import 'package:ui_kit/theme/colors.dart';
import 'package:ui_kit/ui/scanner/scanner_finder.dart';
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

  int receiptTotalAllPcs = 0;
  double receiptTotalAllNet = 0;
  int receiptsCount = 0;
  List<ReceiptEntity> saleReceipts = [];

  int stockInTotalAllPcs = 0;
  double stockInTotalPurchaseNet = 0;
  int stockInCount = 0;
  List<StockInEntity> stockInList = [];

  @override
  void initState() {
    widget.transactionListBloc.add(
      GetSaleReceipts(
        dateTimeRange: getFilterDateRange(),
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
        child: BlocConsumer<TransactionListBloc, TransactionListState>(
          listener: (context, state) {
            if (state is GetSaleReceiptsLoaded) {
              receiptTotalAllPcs = state.saleReceipts
                  .map((e) => e.totalPcs)
                  .reduce((a, b) => a + b);
              receiptTotalAllNet = state.saleReceipts
                  .map((e) => e.totalNet)
                  .reduce((a, b) => a + b);
              receiptsCount = state.saleReceipts.length;
              saleReceipts = state.saleReceipts;
            }
            if (state is GetStockInListLoaded) {
              stockInTotalAllPcs = state.stockInList
                  .map((e) => e.totalPcs)
                  .reduce((a, b) => a + b);
              stockInTotalPurchaseNet = state.stockInList
                  .map((e) => e.purchaseNet)
                  .reduce((a, b) => a + b);
              stockInCount = state.stockInList.length;
              stockInList = state.stockInList;
            }
          },
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                buttonController(),
                dateController(),
                ...showSales
                    ? [
                        percentIndicator([
                          receiptTotalAllNet.toRupiahCurrency(),
                          // ignore: lines_longer_than_80_chars
                          '$receiptTotalAllPcs ${TranslationConstants.pcs.i18n(context)}',
                          // ignore: lines_longer_than_80_chars
                          '$receiptsCount ${TransactionListStrings.sales.i18n(context)}',
                        ]),
                        thSales(saleReceipts)
                      ]
                    : [
                        percentIndicator([
                          stockInTotalPurchaseNet.toRupiahCurrency(),
                          // ignore: lines_longer_than_80_chars
                          '$stockInTotalAllPcs ${TranslationConstants.pcs.i18n(context)}',
                          // ignore: lines_longer_than_80_chars
                          '$stockInCount stok masuk',
                        ]),
                        thStockInList(stockInList),
                      ],
              ],
            );
          },
        ),
      ),
    );
  }

  Widget thStockInList(List<StockInEntity> stockInList) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: LayoutDimen.dimen_16.h,
        horizontal: LayoutDimen.dimen_16.w,
      ),
      margin: EdgeInsets.only(top: LayoutDimen.dimen_35.h),
      color: CustomColors.white,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: LayoutDimen.dimen_8.h),
            child: ScannerFinder(
              labelText: 'Cari nama/kode',
              onChanged: (value) {},
              onScan: (value) {},
            ),
          ),
          ...List.generate(
            stockInList.length,
            (index) => Padding(
              padding: EdgeInsets.symmetric(vertical: LayoutDimen.dimen_8.h),
              child: THStockInCard(stockInEntity: stockInList[index]),
            ),
          ),
        ],
      ),
    );
  }

  Widget thSales(List<ReceiptEntity> receipts) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: LayoutDimen.dimen_16.h,
        horizontal: LayoutDimen.dimen_16.w,
      ),
      margin: EdgeInsets.only(top: LayoutDimen.dimen_35.h),
      color: CustomColors.white,
      child: Column(
        children: List.generate(
          receipts.length,
          (index) => Padding(
            padding: EdgeInsets.symmetric(vertical: LayoutDimen.dimen_8.h),
            child: THSalesCard(receiptEntity: receipts[index]),
          ),
        ),
      ),
    );
  }

  int dateFilterIndex = 0;
  // TODO(Melly): implement lang
  Widget getDateFilterWidget() {
    final data = [
      Column(
        children: [
          Text(
            DateFormat.MMMM('id').format(DateTime.now()),
            style: TextStyle(
              fontSize: LayoutDimen.dimen_18.minSp,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            DateTime.now().year.toString(),
            style: TextStyle(
              fontSize: LayoutDimen.dimen_14.minSp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
      Text(
        'Hari Ini',
        style: TextStyle(
          fontSize: LayoutDimen.dimen_18.minSp,
          fontWeight: FontWeight.bold,
        ),
      ),
      Text(
        DateTime.now().year.toString(),
        style: TextStyle(
          fontSize: LayoutDimen.dimen_18.minSp,
          fontWeight: FontWeight.bold,
        ),
      ),
    ];
    final color = [
      CustomColors.errorAccent.c50.withOpacity(0.3),
      CustomColors.secondary.c40.withOpacity(0.3),
      CustomColors.yellowMedium.withOpacity(0.3),
    ];
    return Container(
      width: LayoutDimen.dimen_115.w,
      padding: EdgeInsets.symmetric(
        horizontal: LayoutDimen.dimen_11.w,
        vertical: LayoutDimen.dimen_5.h,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          LayoutDimen.dimen_10.w,
        ),
        color: color[dateFilterIndex],
      ),
      child: Center(child: data[dateFilterIndex]),
    );
  }

  DateTimeRange getFilterDateRange() {
    switch (dateFilterIndex) {
      case 1:
        // today
        return DateTimeRange(
          start: DateTime(
            DateTime.now().year,
            DateTime.now().month,
            DateTime.now().day,
          ),
          end: DateTime.now(),
        );
      case 2:
        // this year
        return DateTimeRange(
          start: DateTime(DateTime.now().year, 1, 1),
          end: DateTime.now(),
        );
      default:
        // this month
        return DateTimeRange(
          start: DateTime(
            DateTime.now().year,
            DateTime.now().month,
            1,
          ),
          end: DateTime.now(),
        );
    }
  }

  void addEventStockInList() {
    stockInTotalAllPcs = 0;
    stockInTotalPurchaseNet = 0;
    stockInCount = 0;
    stockInList = [];
    widget.transactionListBloc.add(
      GetStockInList(dateTimeRange: getFilterDateRange()),
    );
  }

  void addEventSaleList() {
    receiptTotalAllPcs = 0;
    receiptTotalAllNet = 0;
    receiptsCount = 0;
    saleReceipts = [];
    widget.transactionListBloc.add(
      GetSaleReceipts(dateTimeRange: getFilterDateRange()),
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
            onTap: () {
              setState(() {
                if (dateFilterIndex == 0) {
                  dateFilterIndex = 2;
                } else {
                  dateFilterIndex--;
                }
              });
              showSales ? addEventSaleList() : addEventStockInList();
            },
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
              onTap: () {
                setState(() {
                  if (dateFilterIndex == 2) {
                    dateFilterIndex = 0;
                  } else {
                    dateFilterIndex++;
                  }
                });
                showSales ? addEventSaleList() : addEventStockInList();
              },
              borderRadius: BorderRadius.circular(
                LayoutDimen.dimen_10.w,
              ),
              child: getDateFilterWidget(),
            ),
          ),
          InkWell(
            onTap: () {
              setState(() {
                if (dateFilterIndex == 2) {
                  dateFilterIndex = 0;
                } else {
                  dateFilterIndex++;
                }
              });
              showSales ? addEventSaleList() : addEventStockInList();
            },
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
                  widget.transactionListBloc.add(
                    GetSaleReceipts(
                      dateTimeRange: getFilterDateRange(),
                    ),
                  );
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
                  addEventStockInList();
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
