part of 'products_bloc.dart';

abstract class ProductsEvent {}

class GetMenuDataEvent extends ProductsEvent {}

class ChangeCategoryEvent extends ProductsEvent {
  final int categoryId;
  ChangeCategoryEvent(this.categoryId);
}
