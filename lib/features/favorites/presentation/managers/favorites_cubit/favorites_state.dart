part of 'favorites_cubit.dart';

@immutable
abstract class FavoritesState {}

class FavoritesInitial extends FavoritesState {}
class FavoritesLoading extends FavoritesState {}
class FavoritesSuccess extends FavoritesState {}
class FavoritesFailure extends FavoritesState {
  final String errorMessage;

  FavoritesFailure({required this.errorMessage});
}
