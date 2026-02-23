import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../domain/entities/category_entity.dart';
import '../../../domain/entities/product_entity.dart';
import '../../../domain/usecases/get_menu_data_use_case.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductBloc extends Bloc<ProductsEvent, ProductsState> {
  final GetMenuDataUseCase getMenuDataUseCase;

  ProductBloc({required this.getMenuDataUseCase}) : super(ProductsState()) {

    on<GetMenuDataEvent>((event, emit) async {
      emit(state.copyWith(status: ProductStatus.loading));
      final result = await getMenuDataUseCase();
      result.fold(
            (failure) => emit(state.copyWith(
            status: ProductStatus.failure,
            errorMessage: 'Failed to load products'
        )),
            (menuData) {
          emit(state.copyWith(
            status: ProductStatus.success,
            allProducts: menuData.products,
            filteredProducts: menuData.products,
            categories: menuData.categories,
          ));
        },
      );
    });

    on<ChangeCategoryEvent>((event, emit) {
      List<ProductEntity> filtered;
      if (event.categoryId == 0) {
        filtered = state.allProducts;
      } else {
        filtered = state.allProducts
            .where((product) => product.categoryId == event.categoryId)
            .toList();
      }

      emit(state.copyWith(
        selectedCategoryId: event.categoryId,
        filteredProducts: filtered,
      ));
    });
  }
}