import 'package:dio/dio.dart';
import 'package:ecommerce/features/home/data/models/products_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/constants.dart';

part 'carts_state.dart';

class CartsCubit extends Cubit<CartsState> {
  CartsCubit() : super(CartsInitial());
  final Dio _dio = Dio();
  List<ProductModel> cartsList = [];
  int? total = 0;
  int? subTotal = 0;
  Set<String> cartsProductsId={};


  Future getCarts() async {
    cartsList.clear();
    emit(CartsLoading());
    try {
      Response response = await _dio.get(
        'https://student.valuxapps.com/api/carts',
        options: Options(
          headers: {
            'lang': 'en',
            'Authorization': userToken,
          },
        ),
      );
      var responseBody = response.data;
      total = responseBody['data']['total'].toInt();
      subTotal = responseBody['data']['sub_total'].toInt();
      if (responseBody['status'] == true) {
        for (var item in responseBody['data']['cart_items']) {
          cartsList.add(ProductModel.fromJson(item['product']));
          cartsProductsId.add(item['product']['id'].toString());
        }
        debugPrint(
            'get carts products response Successfully with status code ${response.statusCode} ');
        debugPrint('carts products number = ${cartsList.length}');
        emit(CartsSuccess());
      } else {
        debugPrint(
            'get favorites products response Failed with status code ${response.statusCode} ,the response is :$responseBody');
        emit(CartsFailure(errorMessage: responseBody));
      }
    } on Exception catch (e) {
      debugPrint('Failed to get carts products , The Reason : $e');
      emit(
        CartsFailure(
          errorMessage: e.toString(),
        ),
      );
    }
  }

  addOrRemoveCarts({required String productId}) async {
    emit(AddOrRemoveCartLoading());
    try{
     Response response=await _dio.post(
          'https://student.valuxapps.com/api/carts',
          options: Options(
            headers: {
              'lang': 'en',
              'Authorization': userToken,
            },
          ),
          data: {
            'product_id': productId,
          }
      );
     var responseBody=response.data;
     if(responseBody['status']==true){
       if(cartsProductsId.contains(productId)==true){
         cartsProductsId.remove(productId);
       }else{
         cartsProductsId.add(productId);
       }
       await getCarts();
       debugPrint('AddOrRemoveCart successfully with status code ${response.statusCode}');
       emit(AddOrRemoveCartSuccess());
     }else{
       debugPrint('AddOrRemoveCart Failed with status code ${response.statusCode}, Reason is $responseBody');
       emit(AddOrRemoveCartFailure(errorMessage: responseBody));
     }
    }
        on Exception catch(e){
          debugPrint('Failed to addOrRemoveCarts , The Reason : $e');
          emit(
            AddOrRemoveCartFailure(
              errorMessage: e.toString(),
            ),
          );
        }
  }
}
