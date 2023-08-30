import 'package:dio/dio.dart';
import 'package:ecommerce/core/utils/constants.dart';
import 'package:ecommerce/features/home/data/models/categories_model.dart';
import 'package:ecommerce/features/home/data/models/products_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  CategoriesCubit() : super(CategoriesInitial());
  final Dio _dio = Dio();
  List<CategoryModel> categoriesList = [];
  List<ProductModel>categoryProductsList=[];
  Future getCategories() async {
    emit(CategoriesLoading());
    try {
      Response response = await _dio.get(
        'https://student.valuxapps.com/api/categories',
        options: Options(
          headers: {
            'lang': 'en',
          },
        ),
      );
      var responseBody = response.data;

      if (response.statusCode == 200) {
        categoriesList=[];
        for (var item in responseBody['data']['data']) {
          categoriesList?.add(
            CategoryModel.fromJson(item),
          );
        }
        debugPrint('get categories response Successfully with status code ${response.statusCode}');
        emit(CategoriesSuccess());
      } else {
        debugPrint(
            'get categories response Failed with status code ${response.statusCode} ,the response is :$responseBody');
        emit(CategoriesFailure(errorMessage: responseBody));
      }
    } on Exception catch (e) {
      debugPrint('Failed to get categories , The Reason : $e');
      emit(
        CategoriesFailure(
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future getCategoryProducts({required int categoryId}) async {
    emit(CategoryProductsInitial());
    try {
      Response response = await _dio.get(
        'https://student.valuxapps.com/api/categories/$categoryId',
        options: Options(
          headers: {
            'lang': 'en',
            'Authorization':userToken,
          },
        ),
      );
      var responseBody = response.data;
      if (responseBody['status']==true) {
        categoryProductsList=[];
        for (var item in responseBody['data']['data']) {
          categoryProductsList.add(
            ProductModel.fromJson(item),
          );
        }
        debugPrint('get category products response Successfully with status code ${response.statusCode}');
        emit(CategoryProductsSuccess());
      } else {
        debugPrint(
            'get category products response Failed with status code ${response.statusCode} ,the response is :$responseBody');
        emit(CategoryProductsFailure(errorMessage: responseBody));
      }
    } on Exception catch (e) {
      debugPrint('Failed to get category products , The Reason : $e');
      emit(
        CategoryProductsFailure(
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
