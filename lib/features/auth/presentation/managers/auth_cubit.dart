import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:dio/dio.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._dio) : super(AuthInitial());
  final Dio _dio;

  Future<void> registerUser({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) async {
    emit(RegisterLoadingState());
    Response response = await _dio.post(
      'https://student.valuxapps.com/api/register',
      data: {
        'name':name,
        'email':email,
        'password':password,
        'phone':phone,
      },
    );
    var responseBody=jsonDecode(response.data); // jsonDecode convert json to dart
    if(responseBody['status'] == true){
      emit(RegisterSuccessState());
    }else{
      emit(RegisterFailureState(errorMessage: responseBody['message'],),);
    }
  }
}
