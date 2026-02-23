part of 'products_bloc.dart';
enum ProductStatus { initial, loading, success, failure }

class ProductsState {
  final ProductStatus status;
  final List<ProductEntity> allProducts;
  final List<ProductEntity> filteredProducts;
  final List<CategoryEntity> categories;
  final int selectedCategoryId;
  final String errorMessage;

  ProductsState({
    this.status = ProductStatus.initial,
    this.allProducts = const [],
    this.filteredProducts = const [],
    this.categories = const [],
    this.selectedCategoryId = 0,
    this.errorMessage = '',
  });

  ProductsState copyWith({
    ProductStatus? status,
    List<ProductEntity>? allProducts,
    List<ProductEntity>? filteredProducts,
    List<CategoryEntity>? categories,
    int? selectedCategoryId,
    String? errorMessage,
  }) {
    return ProductsState(
      status: status ?? this.status,
      allProducts: allProducts ?? this.allProducts,
      filteredProducts: filteredProducts ?? this.filteredProducts,
      categories: categories ?? this.categories,
      selectedCategoryId: selectedCategoryId ?? this.selectedCategoryId,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }


}