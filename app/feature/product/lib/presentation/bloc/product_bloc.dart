import 'package:data_abstraction/entity/product_entity.dart';
import 'package:feature_product/domain/usecase/product_usecase.dart';
import 'package:module_common/presentation/bloc/base_bloc.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends BaseBloc<ProductEvent, ProductState> {
  final ProductUsecase productUsecase;

  List<ProductEntity> products = [];

  ProductBloc(this.productUsecase) : super(ProductInitial()) {
    on<GetProductListEvent>((event, emit) async {
      emit(ProductLoading());
      try {
        if (products.isEmpty) {
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
    });
  }
}
