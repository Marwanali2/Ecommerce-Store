part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {
  @override
  List<Object> get props => [];
  const AuthState();
}

class AuthInitial extends AuthState {}

class RegisterLoadingState extends AuthState {}

class RegisterSuccessState extends AuthState {}

// ignore: must_be_immutable
class RegisterFailureState extends AuthState {
  String? errorMessage;

  RegisterFailureState({required this.errorMessage});
}

class LoginLoadingState extends AuthState {}

class LoginSuccessState extends AuthState {}

// ignore: must_be_immutable
class LoginFailureState extends AuthState {
  String? errorMessage;

  LoginFailureState({required this.errorMessage});
}
