import 'dart:async';

import 'package:data_abstraction/entity/product_entity.dart';
import 'package:feature_product/domain/usecase/product_usecase.dart';
import 'package:module_common/presentation/bloc/base_bloc.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends BaseBloc<ProductEvent, ProductState> {
  final ProductUsecase productUsecase;

  List<ProductEntity> products = [];

  ProductBloc(this.productUsecase) : super(ProductInitial()) {
    on<GetProductListEvent>(_onGetProductListEvent);
    on<UpdateProductEvent>(_onUpdateProductEvent);
    on<DeleteProductEvent>(_onDeleteProductEvent);
    on<AddProductEvent>(_onAddProductEvent);
  }

  FutureOr<void> _onGetProductListEvent(
    GetProductListEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductLoading());
    try {
      if (products.isEmpty || event.forceRemote) {
        final productList = await productUsecase.getProductList(
          filterByUnsetPrice: event.filterByUnsetPrice,
        );
        products = productList;
      }

      if (event.filterByUnsetPrice) {
        late final List<ProductEntity> productList;
        if (event.filterValue.isNotEmpty) {
          productList = products
              .where(
                (element) =>
                    element.name
                        .toLowerCase()
                        .contains(event.filterValue.toLowerCase()) ||
                    element.code
                        .toLowerCase()
                        .contains(event.filterValue.toLowerCase()),
              )
              .toList();
        } else {
          productList = products;
        }

        final filteredProducts = productList.where((element) {
          return element.saleNet == null;
        }).toList();

        emit(ProductListLoaded(filteredProducts));
        return;
      }

      if (event.filterValue.isNotEmpty) {
        final filteredProducts = products
            .where(
              (element) =>
                  element.name
                      .toLowerCase()
                      .contains(event.filterValue.toLowerCase()) ||
                  element.code
                      .toLowerCase()
                      .contains(event.filterValue.toLowerCase()),
            )
            .toList();
        emit(ProductListLoaded(filteredProducts));
        return;
      }

      emit(ProductListLoaded(products));
    } catch (e) {
      emit(ProductFailed());
    }
  }

  FutureOr<void> _onUpdateProductEvent(
    UpdateProductEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(UpdateLoading());
    try {
      await productUsecase.updateProduct(event.productEntity);
      emit(UpdateSuccess());
    } catch (e) {
      emit(UpdateFailed());
    }
  }

  FutureOr<void> _onDeleteProductEvent(
    DeleteProductEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(DeleteLoading());
    try {
      await productUsecase.deleteProduct(event.productEntity.id!);
      emit(DeleteSuccess());
    } catch (e) {
      emit(DeleteFailed());
    }
  }

  FutureOr<void> _onAddProductEvent(
    AddProductEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(AddProductLoading());
    try {
      await productUsecase.addProduct(event.product);
      emit(AddProductSuccess());
    } catch (e) {
      emit(AddProductError());
    }
  }
}
