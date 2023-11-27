part of 'user_data_cubit.dart';

@immutable
abstract class UserDataState {}

class UserDataInitial extends UserDataState {}

class UserDataLoading extends UserDataState {}

class UserDataSuccess extends UserDataState {}

class UserDataFailure extends UserDataState {
  final String errorMessage;

  UserDataFailure({required this.errorMessage});
}

class EditLoadingState extends UserDataState {}

class EditSuccessState extends UserDataState {}

// ignore: must_be_immutable
class EditFailureState extends UserDataState {
  String? errorMessage;

  EditFailureState({required this.errorMessage});
}

class LogOutLoadingState extends UserDataState {}

class LogOutSuccessState extends UserDataState {}

// ignore: must_be_immutable
class LogOutFailureState extends UserDataState {
  String? errorMessage;

  LogOutFailureState({required this.errorMessage});
}
