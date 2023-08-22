import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:ecommerce/core/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../../../home/data/models/products_model.dart';

part 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  FavoritesCubit() : super(FavoritesInitial());
  final Dio _dio = Dio();
  List<ProductModel> favoritesModelList = [];

  Future getFavorites() async {
    favoritesModelList.clear();
    emit(FavoritesLoading());
    try{
      Response response = await _dio.get(
        'https://student.valuxapps.com/api/favorites',
        options: Options(
          headers: {
            'lang': 'en',
            'Authorization':userToken,
          },
        ),
      );
     var responseBody=response.data;
      if(response.statusCode==200){
        for(var item in responseBody['data']['data']){
          favoritesModelList.add(ProductModel.fromJson(item['product']));
          debugPrint(
              'get favorites products response Successfully with status code ${response.statusCode} ');
          debugPrint('favorites products number = ${favoritesModelList.length}');
          emit(FavoritesSuccess());
        }
      }else{
        debugPrint(
            'get favorites products response Failed with status code ${response.statusCode} ,the response is :$responseBody');
        emit(FavoritesFailure(errorMessage: responseBody));
      }
    }
        on Exception catch(e){
          debugPrint('Failed to get favorite products , The Reason : $e');
          emit(
            FavoritesFailure(
              errorMessage: e.toString(),
            ),
          );
        }
  }
}
