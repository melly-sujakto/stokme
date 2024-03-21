import 'package:data_abstraction/entity/stock_entity.dart';
import 'package:feature_stock/domain/usecase/stock_usecase.dart';
import 'package:feature_stock/presentation/bloc/stock_bloc.dart';
import 'package:feature_stock/presentation/stock_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:module_common/common/constant/translation_constants.dart';
import 'package:module_common/i18n/i18n_extension.dart';
import 'package:ui_kit/common/constants/layout_dimen.dart';
import 'package:ui_kit/theme/colors.dart';
import 'package:ui_kit/ui/infinite_pagination/infinite_paginantion_widget.dart';
import 'package:ui_kit/ui/scanner/scanner_finder.dart';
import 'package:ui_kit/ui/tab_bar/app_tab_bar.dart';
import 'package:ui_kit/ui/widgets/dummy_circle_image.dart';
import 'package:ui_kit/utils/screen_utils.dart';

class StockPage extends StatefulWidget {
  const StockPage({
    super.key,
    required this.bloc,
  });

  final StockBloc bloc;

  @override
  State<StockPage> createState() => _StockPageState();
}

class _StockPageState extends State<StockPage> {
  int activeTab = 0;
  String filterValue = '';
  StockFilterType currentFilterType = StockFilterType.lowestStock;

  final pagingController = PagingController<int, StockEntity>(firstPageKey: 0);
  final limit = 10;
  int index = 0;
  StockEntity? lastStock;

  @override
  void initState() {
    super.initState();
    pagingController.addPageRequestListener(
      (pageKey) {
        addGetStockListEvent();
      },
    );
  }

  @override
  void dispose() {
    pagingController.dispose();
    super.dispose();
  }

  void addGetStockListEvent() {
    widget.bloc.add(
      GetStockListEvent(
        pageSize: limit,
        index: index,
        filterType: currentFilterType,
        filterNameOrCodeValue: filterValue,
        lastStock: lastStock,
      ),
    );
  }

  void resetFilter() {
    index = 0;
    lastStock = null;
    pagingController.refresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.neutral.c98,
      appBar: AppBar(
        title: Text(
          StockStrings.stockTitle.i18n(context),
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
                labelText: TranslationConstants.scannerLabelText.i18n(context),
                onChanged: (value) {
                  filterValue = value;
                  resetFilter();
                },
                onScan: (value) {
                  filterValue = value;
                  resetFilter();
                },
              ),
              AppTabBar(
                activeIndex: activeTab,
                onIndexChanged: (index) {
                  activeTab = index;
                },
                items: [
                  AppTabBarItem(
                    onTap: () {
                      currentFilterType = StockFilterType.lowestStock;
                      resetFilter();
                    },
                    title: StockStrings.lowerStock.i18n(context),
                  ),
                  AppTabBarItem(
                    onTap: () {
                      currentFilterType = StockFilterType.mostStock;
                      resetFilter();
                    },
                    title: StockStrings.higherStock.i18n(context),
                  ),
                ],
              ),
              BlocListener<StockBloc, StockState>(
                listener: (context, state) {
                  if (state is StockLoaded) {
                    if (state.isLastPage) {
                      pagingController.appendLastPage(state.stockList);
                    } else {
                      if (state.stockList.isNotEmpty) {
                        lastStock = state.stockList.last;
                      }
                      index++;
                      pagingController.appendPage(state.stockList, index);
                    }
                  }
                  if (state is StockFailed) {
                    pagingController.appendLastPage([]);
                  }
                },
                child: InfinitePaginationWidget(
                  pagingController: pagingController,
                  itemBuilder: (context, item, key) => stockCard(item),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget stockCard(StockEntity stockEntity) {
    return Padding(
      padding: EdgeInsets.only(bottom: LayoutDimen.dimen_14.h),
      child: Container(
        padding: EdgeInsets.all(LayoutDimen.dimen_10.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            LayoutDimen.dimen_10.w,
          ),
          color: CustomColors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              children: [
                DummyCircleImage(title: stockEntity.productEntity.name),
                Padding(
                  padding: EdgeInsets.all(
                    LayoutDimen.dimen_10.w,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        stockEntity.productEntity.name,
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
                        stockEntity.productEntity.code,
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
              '${stockEntity.totalPcs} '
              '${TranslationConstants.pcs.i18n(context)}',
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
