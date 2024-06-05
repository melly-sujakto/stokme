import 'package:data_abstraction/entity/supplier_entity.dart';
import 'package:feature_transaction/presentation/journey/stock_in/bloc/stock_in_bloc.dart';
import 'package:flutter/material.dart';
import 'package:module_common/presentation/bloc/base_bloc.dart';
import 'package:ui_kit/common/constants/layout_dimen.dart';
import 'package:ui_kit/theme/colors.dart';
import 'package:ui_kit/ui/input_field/input_basic.dart';
import 'package:ui_kit/utils/screen_utils.dart';

class SupplierFormContent extends StatefulWidget {
  const SupplierFormContent({super.key});

  @override
  State<SupplierFormContent> createState() => _SupplierFormContentState();
}

class _SupplierFormContentState extends State<SupplierFormContent> {
  late final StockInBloc stockInBloc;

  TextEditingController supplierEditingController = TextEditingController();
  SupplierEntity? supplier;
  List<SupplierEntity> allSuppliers = [];
  List<SupplierEntity> suppliers = [];
  bool addNewSuppier = false;
  bool displaySuppliers = false;

  @override
  void initState() {
    super.initState();
    stockInBloc = context.read<StockInBloc>()..add(GetSuppliersEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<StockInBloc, StockInState>(
      listener: (context, state) {
        if (state is GetSuppliersLoaded) {
          allSuppliers = state.suppliers;
        }
      },
      child: Column(
        children: [
          ...[
            InputBasic(
              controller: supplierEditingController,
              labelText: 'Supplier(opsional)',
              margin: EdgeInsets.zero,
              onChanged: (p0) {
                setState(() {
                  displaySuppliers = true;
                  suppliers = allSuppliers
                      .where(
                        (element) => element.name
                            .toLowerCase()
                            .contains(p0.toLowerCase()),
                      )
                      .toList();
                });
              },
            ),
            if (displaySuppliers && supplierEditingController.text.isNotEmpty)
              Material(
                elevation: 2,
                borderRadius: BorderRadius.circular(
                  LayoutDimen.dimen_10.w,
                ),
                color: CustomColors.white,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: LayoutDimen.dimen_16.h,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                displaySuppliers = false;
                                addNewSuppier = true;
                                supplier = null;
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                vertical: LayoutDimen.dimen_8.h,
                                horizontal: LayoutDimen.dimen_16.w,
                              ),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: CustomColors.neutral.c80,
                                  ),
                                ),
                              ),
                              child: Text(
                                'Tambah Sebagai Supplier Baru',
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: LayoutDimen.dimen_18.minSp,
                                  fontWeight: FontWeight.w900,
                                  color: CustomColors.secondary.c30,
                                ),
                              ),
                            ),
                          ),
                        ] +
                        suppliers
                            .map(
                              (e) => InkWell(
                                onTap: () {
                                  setState(() {
                                    displaySuppliers = false;
                                    addNewSuppier = false;
                                    supplier = e;
                                    supplierEditingController.text = e.name;
                                  });
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    vertical: LayoutDimen.dimen_8.h,
                                    horizontal: LayoutDimen.dimen_16.w,
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: CustomColors.neutral.c80,
                                      ),
                                    ),
                                  ),
                                  child: Text(
                                    e.name,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: LayoutDimen.dimen_18.minSp,
                                      fontWeight: FontWeight.w200,
                                    ),
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                  ),
                ),
              ),
          ],
          if (addNewSuppier && supplier == null)
            InputBasic(
              labelText: 'Nomor HP Supplier',
              keyboardType: TextInputType.number,
              margin: EdgeInsets.zero,
              onChanged: (p0) {},
            ),
          InputBasic(
            labelText: 'PIC Supplier (Opsional)',
            margin: EdgeInsets.zero,
            onChanged: (p0) {},
          ),
        ],
      ),
    );
  }
}
