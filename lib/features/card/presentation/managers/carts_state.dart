part of 'carts_cubit.dart';

@immutable
abstract class CartsState {}

class CartsInitial extends CartsState {}
class CartsLoading extends CartsState {}
class CartsSuccess extends CartsState {}
class CartsFailure extends CartsState {
  final String errorMessage;

  CartsFailure({required this.errorMessage});
}


class AddOrRemoveCartInitial extends CartsState {}
class AddOrRemoveCartLoading extends CartsState {}
class AddOrRemoveCartSuccess extends CartsState {}
class AddOrRemoveCartFailure extends CartsState {
  final String errorMessage;
  AddOrRemoveCartFailure({required this.errorMessage});
}
