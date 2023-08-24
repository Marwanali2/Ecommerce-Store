import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:ecommerce/core/utils/constants.dart';
import 'package:flutter/material.dart';

import '../../../../home/data/models/products_model.dart';

part 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  FavoritesCubit() : super(FavoritesInitial());
  final Dio _dio = Dio();
  List<ProductModel> favoritesModelList = [];
  Set<String> favoritesProductsId = {};

  Future<void> getFavorites() async {
    favoritesModelList.clear();
    emit(FavoritesLoading());
    try {
      Response response = await _dio.get(
        'https://student.valuxapps.com/api/favorites',
        options: Options(
          headers: {
            'lang': 'en',
            'Authorization': userToken,
          },
        ),
      );
      var responseBody = response.data;
      if (responseBody['status'] == true) {
        for (var item in responseBody['data']['data']) {
          favoritesModelList.add(ProductModel.fromJson(item['product']));
          favoritesProductsId.add(item['product']['id'].toString());
          debugPrint(
              'get favorites products response Successfully with status code ${response.statusCode} ');
        }
        debugPrint('favorites products number = ${favoritesModelList.length}');
        emit(FavoritesSuccess());
      } else {
        debugPrint(
            'get favorites products response Failed with status code ${response.statusCode} ,the response is :$responseBody');
        emit(FavoritesFailure(errorMessage: responseBody));
      }
    } on Exception catch (e) {
      debugPrint('Failed to get favorite products , The Reason : $e');
      emit(
        FavoritesFailure(
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> addOrRemoveFavorites({required String productId}) async {
    emit(AddOrDeleteFavoriteWithProductLoading());
    try {
      Response response = await _dio.post('https://student.valuxapps.com/api/favorites',
              options: Options(
                headers: {
                  'lang': 'en',
                  'Authorization': userToken,
                },
              ),
              data: {
            'product_id': productId,
          });
      var responseBody = response.data;
      if (responseBody['status'] == true)  {
        if(favoritesProductsId.contains(productId)==true){
          favoritesProductsId.remove(productId);
        }else{
          favoritesProductsId.add(productId);
        }
        debugPrint(
            'addOrRemoveFavorites products response Successfully with status code ${response.statusCode} ');
        await getFavorites();
        emit(AddOrDeleteFavoriteWithProductSuccess());
      } else {
        debugPrint(
            'addOrRemoveFavorites products response failure with status code ${response.statusCode} , Response is $responseBody');
        emit(
          AddOrDeleteFavoriteWithProductIdFailure(
            errorMessage: responseBody,
          ),
        );
      }
    } on Exception catch (e) {
      debugPrint('Failed to addOrRemoveFavorites products , The Reason : $e');
      emit(
        AddOrDeleteFavoriteWithProductIdFailure(
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
