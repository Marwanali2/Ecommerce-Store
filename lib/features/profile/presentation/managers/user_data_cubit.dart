import 'package:dio/dio.dart';
import 'package:ecommerce/core/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/user_model/user_model.dart';

part 'user_data_state.dart';

class UserDataCubit extends Cubit<UserDataState> {
  UserDataCubit() : super(UserDataInitial());
  final Dio _dio = Dio();
  UserModel?userModel;
  Future getUserData() async {
    emit(UserDataLoading());
    try {
      Response response = await _dio.get(
        'https://student.valuxapps.com/api/profile',
        options: Options(
          headers: {
            'lang': 'en',
            'Authorization': userToken,
          },
        ),
      );
      if (response.statusCode == 200) {
        var responseBody = response.data;
        if (responseBody['status'] == true) {
          userModel=UserModel.fromJson(responseBody['data']);
          debugPrint('get user data response Success with status code ${response.statusCode} ');
          emit(
            UserDataSuccess(),
          );
        }
        else {
          debugPrint('get user data response failed with status code ${response.statusCode} ,the response is :$responseBody');
          emit(
            UserDataFailure(
              errorMessage: responseBody,
            ),
          );
        }
      }
    } catch (e) {
      debugPrint('Failed to get user data , The Reason : $e');
      emit(
        UserDataFailure(
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> editUser({
    required String?name,
    required String?email,
    required String?password,
    required String?phone,
  }) async {
    emit(EditLoadingState());
    try {
      Response response = await _dio.put(
        'https://student.valuxapps.com/api/update-profile',
        options: Options(
          headers: {
            'lang': 'en',
            'Authorization':userToken,
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
          userModel=UserModel.fromJson(responseBody['data']);
          debugPrint('success edit response is $responseBody}:');
          emit(EditSuccessState());
        } else {
          debugPrint('failure edit response is $responseBody}:');
          emit(
            EditFailureState(
              errorMessage: responseBody['message'],
            ),
          );
        }
      }
    } catch (e) {
      debugPrint('Failed to edit user , The Reason : $e');
      emit(
        EditFailureState(
          errorMessage: e.toString(),
        ),
      );
    }
  }

}
