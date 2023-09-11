part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {
  @override
  List<Object> get props => [];
  const AuthState();
}

class AuthInitial extends AuthState {

}


class RegisterLoadingState extends AuthState {}

class RegisterSuccessState extends AuthState {}

class RegisterFailureState extends AuthState {
  String? errorMessage;

  RegisterFailureState({required this.errorMessage});
}

class LoginLoadingState extends AuthState {}

class LoginSuccessState extends AuthState {}

class LoginFailureState extends AuthState {
  String? errorMessage;

  LoginFailureState({required this.errorMessage});
}


class EditLoadingState extends AuthState{}

class EditSuccessState extends AuthState{}

class EditFailureState extends AuthState{
  String? errorMessage;

  EditFailureState({required this.errorMessage});
}