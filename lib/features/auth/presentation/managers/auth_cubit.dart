import 'package:ecommerce/core/utils/constants.dart';

import 'package:ecommerce/features/auth/presentation/views/login_view.dart';
import 'package:ecommerce/features/profile/presentation/managers/user_data_cubit.dart';
import 'package:ecommerce/features/shared/network/local_network.dart';
import 'package:equatable/equatable.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  final Dio _dio = Dio();

  Future<void> registerUser({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) async {
    emit(RegisterLoadingState());
    try {
      Response response = await _dio.post(
        'https://student.valuxapps.com/api/register',
        options: Options(
          headers: {
            'lang': 'en',
          },
        ),
        data: {
          // like body in http package
          'name': name,
          'email': email,
          'password': password,
          'phone': phone,
          'image': "lol",
        },
      );
      if (response.statusCode == 200) {
        var responseBody = response.data;
        if (responseBody['status'] == true) {
          debugPrint('success response is $responseBody}:');
          emit(RegisterSuccessState());
        } else {
          debugPrint('failure response is $responseBody}:');
          emit(
            RegisterFailureState(
              errorMessage: responseBody['message'],
            ),
          );
        }
      }
    } catch (e) {
      debugPrint('Failed to register , The Reason : $e');
      emit(
        RegisterFailureState(
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> loginUser({
    required String email,
    required String password,
  }) async {
    emit(LoginLoadingState());
    try {
      Response response =
          await _dio.post('https://student.valuxapps.com/api/login',
              options: Options(
                headers: {
                  'lang': 'en',
                },
              ),
              data: {
            'email': email,
            'password': password,
          });
      if (response.statusCode == 200) {
        var responseBody = response.data;
        if (responseBody['status'] == true) {
          debugPrint('success login with response: $responseBody');
          CachedNetwork.insertToCache(
            key: 'token',
            value: responseBody['data']['token'],
          ).then((value) {
            userToken == UserDataCubit().userModel?.token;
          });
          emit(LoginSuccessState());
        } else {
          debugPrint('Failure response: $responseBody');
          emit(LoginFailureState(errorMessage: responseBody.toString()));
        }
      }
    } on Exception catch (e) {
      debugPrint('Failed to login , Reason is : $e');
      emit(
        LoginFailureState(
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
