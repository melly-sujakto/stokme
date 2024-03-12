import 'package:data_abstraction/entity/stock_entity.dart';
import 'package:feature_stock/domain/usecase/stock_usecase.dart';
import 'package:feature_stock/presentation/bloc/stock_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_kit/common/constants/layout_dimen.dart';
import 'package:ui_kit/theme/colors.dart';
import 'package:ui_kit/ui/loading_indicator/circular_progres.dart';
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
  int activeIndex = 0;
  String filterValue = '';
  StockFilterType currentFilterType = StockFilterType.lowestStock;

  @override
  void initState() {
    super.initState();
    addGetStockListEvent();
  }

  void addGetStockListEvent() {
    widget.bloc.add(
      GetStockListEvent(
        pageSize: 10,
        index: 0,
        filterType: currentFilterType,
        filterNameOrCodeValue: filterValue,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.neutral.c98,
      appBar: AppBar(
        title: Text(
          'Stok Produk',
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
                labelText: 'Cari nama/kode',
                onChanged: (value) {
                  filterValue = value;
                  addGetStockListEvent();
                },
                onScan: (value) {
                  filterValue = value;
                  addGetStockListEvent();
                },
              ),
              AppTabBar(
                activeIndex: activeIndex,
                onIndexChanged: (index) {
                  activeIndex = index;
                },
                items: [
                  AppTabBarItem(
                    onTap: () {
                      currentFilterType = StockFilterType.lowestStock;
                      addGetStockListEvent();
                    },
                    title: 'Stok sedikit',
                  ),
                  AppTabBarItem(
                    onTap: () {
                      currentFilterType = StockFilterType.mostStock;
                      addGetStockListEvent();
                    },
                    title: 'Stok terbanyak',
                  ),
                ],
              ),
              BlocBuilder<StockBloc, StockState>(
                builder: (context, state) {
                  if (state is StockLoading) {
                    return const CircularProgress();
                  }
                  if (state is StockLoaded) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: state.stockList.map(stockCard).toList(),
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
              '${stockEntity.totalPcs} pcs',
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
