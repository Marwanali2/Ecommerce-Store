import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:ecommerce/core/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../../data/models/products_model.dart';

part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit() : super(ProductsInitial());
  final Dio _dio = Dio();
  List<ProductModel> productsModelList = [];

  Future getProducts() async {
    emit(ProductsLoading());
    try{
      Response response = await _dio.get(
        'https://student.valuxapps.com/api/home',
        options: Options(
          headers: {
            'lang': 'en',
            'Authorization': userToken!,
          },
        ),
      );
      var responseBody = response.data;
      if (response.statusCode == 200) {
        productsModelList = [];
        for (var item in responseBody['data']['products']) {
          productsModelList?.add(
            ProductModel.fromJson(
              item,
            ),
          );
        }
        debugPrint('get products response Successfully with status code ${response.statusCode} ');
        emit(ProductsSuccess());
      }
      else{
        debugPrint('get products response Failed with status code ${response.statusCode} ,the response is :$responseBody');
        emit(ProductsFailure(errorMessage: responseBody));
      }
    } on Exception catch(e){
      debugPrint('Failed to get products , The Reason : $e');
      emit(
        ProductsFailure(
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
