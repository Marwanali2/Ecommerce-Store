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
