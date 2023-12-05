import 'package:data_abstraction/entity/product_entity.dart';
import 'package:feature_product/domain/usecase/product_usecase.dart';
import 'package:module_common/presentation/bloc/base_bloc.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends BaseBloc<ProductEvent, ProductState> {
  final ProductUsecase productUsecase;

  ProductBloc(this.productUsecase) : super(ProductInitial()) {
    on<GetProductListEvent>((event, emit) async {
      emit(ProductLoading());
      try {
        final productList = await productUsecase.getProductList();
        emit(ProductListLoaded(productList));
      } catch (e) {
        emit(ProductFailed());
      }
    });
  }
}
