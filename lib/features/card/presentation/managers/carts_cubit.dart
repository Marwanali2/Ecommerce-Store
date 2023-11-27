import 'package:dio/dio.dart';
import 'package:ecommerce/features/home/data/models/products_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/utils/functions.dart';
import '../../data/models/cart_model.dart';

part 'carts_state.dart';

class CartsCubit extends Cubit<CartsState> {
  CartsCubit() : super(CartsInitial());
  final Dio _dio = Dio();
  List<ProductModel> cartsList = [];
  List<CartModel> cartItems = [];
  static int total = 0;
  int? subTotal = 0;
  // int  quantity=1;
  Set<String> cartsProductsId = {};

  Future getCarts() async {
    cartsList.clear();
    // cartItems.clear();
    emit(CartsLoading());
    try {
      Response response = await _dio.get(
        'https://student.valuxapps.com/api/carts',
        options: Options(
          headers: {
            'lang': isArabic == true ? 'ar' : 'en',
            'Authorization': userToken,
          },
        ),
      );
      var responseBody = response.data;
      total = responseBody['data']['total'].toInt();
      subTotal = responseBody['data']['sub_total'].toInt();
      // quantity=responseBody['data']['cart_items']['quantity'];
      if (responseBody['status'] == true) {
        for (var item in responseBody['data']['cart_items']) {
          // quantity=responseBody['data']['cart_items']['quantity'];
          cartsList.add(ProductModel.fromJson(item['product']));
          cartsProductsId.add(item['product']['id'].toString());
          cartItems.add(CartModel.fromJson(item));
        }
        debugPrint(
            'get carts products response Successfully with status code ${response.statusCode} ');
        debugPrint('carts products number = ${cartsList.length}');
        // saveDataToBox(cachedData: cartsList, boxName: kCartProducts);
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
    try {
      Response response =
          await _dio.post('https://student.valuxapps.com/api/carts',
              options: Options(
                headers: {
                  'lang': isArabic == true ? 'ar' : 'en',
                  'Authorization': userToken,
                },
              ),
              data: {
            'product_id': productId,
          });
      var responseBody = response.data;
      if (responseBody['status'] == true) {
        if (cartsProductsId.contains(productId) == true) {
          cartsProductsId.remove(productId);
        } else {
          cartsProductsId.add(productId);
        }
        await getCarts();
        debugPrint(
            'AddOrRemoveCart successfully with status code ${response.statusCode}');
        emit(AddOrRemoveCartSuccess());
      } else {
        debugPrint(
            'AddOrRemoveCart Failed with status code ${response.statusCode}, Reason is $responseBody');
        emit(AddOrRemoveCartFailure(errorMessage: responseBody));
      }
    } on Exception catch (e) {
      debugPrint('Failed to addOrRemoveCarts , The Reason : $e');
      emit(
        AddOrRemoveCartFailure(
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
