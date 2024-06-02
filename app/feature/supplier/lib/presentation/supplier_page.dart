import 'package:data_abstraction/entity/supplier_entity.dart';
import 'package:feature_supplier/presentation/bloc/supplier_bloc.dart';
import 'package:feature_supplier/presentation/widgets/supplier_detail_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_kit/common/constants/layout_dimen.dart';
import 'package:ui_kit/theme/colors.dart';
import 'package:ui_kit/ui/infinite_pagination/infinite_paginantion_widget.dart';
import 'package:ui_kit/ui/input_field/input_basic.dart';
import 'package:ui_kit/ui/loading_indicator/loading_circular.dart';
import 'package:ui_kit/ui/snackbar/snackbar_dialog.dart';
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
  late final SupplierBloc bloc;

  String filterValue = '';
  final pagingController =
      PagingController<int, SupplierEntity>(firstPageKey: 0);
  final limit = 10;
  int index = 0;
  SupplierEntity? lastItem;

  @override
  void initState() {
    super.initState();
    bloc = context.read<SupplierBloc>();
    pagingController.addPageRequestListener(
      (pageKey) {
        addGetSuppliersEvent();
      },
    );
  }

  void addGetSuppliersEvent() {
    bloc.add(
      GetSuppliersEvent(
        pageSize: limit,
        index: index,
        filterNameOrCodeValue: filterValue,
        lastItem: lastItem,
      ),
    );
  }

  void resetFilter() {
    index = 0;
    lastItem = null;
    pagingController.refresh();
  }

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
              InputBasic.search(
                labelText: 'Cari nama',
                onChanged: (value) {
                  filterValue = value;
                  resetFilter();
                },
              ),
              SizedBox(
                height: LayoutDimen.dimen_16.h,
              ),
              BlocConsumer<SupplierBloc, SupplierState>(
                listenWhen: (previous, current) {
                  if (previous is UpdateSupplierLoading ||
                      previous is SetInactiveSupplierLoading) {
                    Navigator.pop(context);
                  }
                  return true;
                },
                listener: (context, state) {
                  if (state is GetSuppliersLoaded) {
                    if (state.isLastPage) {
                      pagingController.appendLastPage(state.suppliers);
                    } else {
                      if (state.suppliers.isNotEmpty) {
                        lastItem = state.suppliers.last;
                      }
                      index++;
                      pagingController.appendPage(state.suppliers, index);
                    }
                  }

                  if (state is UpdateSupplierSuccess ||
                      state is SetInactiveSupplierSuccess) {
                    SnackbarDialog().show(
                      context: context,
                      message: state is UpdateSupplierSuccess
                          ? 'Update supplier berhasil'
                          : 'Supplier berhasil dihapus',
                      type: SnackbarDialogType.success,
                    );
                    resetFilter();
                  }
                  if (state is UpdateSupplierFailed ||
                      state is SetInactiveSupplierFailed) {
                    SnackbarDialog().show(
                      context: context,
                      message: state is UpdateSupplierFailed
                          ? 'Update supplier gagal, silakan coba lagi'
                          : 'Supplier gagal dihapus, silakan coba lagi',
                      type: SnackbarDialogType.failed,
                    );
                  }
                  if (state is UpdateSupplierLoading ||
                      state is SetInactiveSupplierLoading) {
                    Navigator.pop(context);
                    showDialog(
                      context: context,
                      builder: (context) => const LoadingCircular.fullPage(),
                    );
                  }
                },
                builder: (context, state) {
                  return InfinitePaginationWidget(
                    pagingController: pagingController,
                    itemBuilder: (context, item, key) => supplierCard(item),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget supplierCard(SupplierEntity supplier) {
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
            SupplierDetail().showBottomSheet(
              context,
              supplier: supplier,
              mainCallback: (supplier) {
                bloc.add(UpdateSupplierEvent(supplier));
              },
              deleteCallback: () {
                bloc.add(
                  SetInactiveSupplierEvent(supplier),
                );
              },
            );
          },
          child: Container(
            padding: EdgeInsets.all(LayoutDimen.dimen_8.w),
            child: Row(
              children: [
                DummyCircleImage(title: supplier.name),
                Padding(
                  padding: EdgeInsets.all(
                    LayoutDimen.dimen_10.w,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        supplier.name,
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
                        supplier.phone,
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
