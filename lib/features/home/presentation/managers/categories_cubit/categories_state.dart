part of 'categories_cubit.dart';

@immutable
abstract class CategoriesState {}
class CategoriesInitial extends CategoriesState {}
class CategoriesSuccess extends CategoriesState {}
class CategoriesLoading extends CategoriesState {}
class CategoriesFailure extends CategoriesState {
  final String errorMessage;

  CategoriesFailure({required this.errorMessage});
}

class CategoryProductsInitial extends CategoriesState {}
class CategoryProductsSuccess extends CategoriesState {}
class CategoryProductsLoading extends CategoriesState {}
class CategoryProductsFailure extends CategoriesState {
  final String errorMessage;

  CategoryProductsFailure({required this.errorMessage});
}
