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

class AddOrDeleteFavoriteWithProductIdInitial extends FavoritesState{}
class AddOrDeleteFavoriteWithProductLoading extends FavoritesState{}
class AddOrDeleteFavoriteWithProductSuccess extends FavoritesState{}
class AddOrDeleteFavoriteWithProductIdFailure extends FavoritesState{
  final String errorMessage;
  AddOrDeleteFavoriteWithProductIdFailure({required this.errorMessage});
}
