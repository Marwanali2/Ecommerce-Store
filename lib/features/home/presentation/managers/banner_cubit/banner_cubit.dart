import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:ecommerce/core/utils/constants.dart';
import 'package:ecommerce/features/home/data/models/banners_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';

import '../../../../../core/utils/functions.dart';

part 'banner_state.dart';

class BannerCubit extends Cubit<BannerState> {
  BannerCubit() : super(BannerInitial());
  final Dio _dio = Dio();
  List<BannerModel> bannersList=[];
  Future getBanners() async {

   try{
     Response response = await _dio.get(
       'https://student.valuxapps.com/api/banners',
     );
     var responseBody = response.data;
     if(response.statusCode==200){
        bannersList = [];
       for (var item in responseBody['data']) {
         bannersList?.add(
           BannerModel.fromJson(
             item,
           ),
         );
       }
     //   saveDataToBox(cachedData: bannersList, boxName: kBannersImages);
       debugPrint('get banners response Successfully with status code ${response.statusCode} ');
       emit(BannerSuccess());
     }else{
       debugPrint('get banners response Failed with status code ${response.statusCode} ,the response is :$responseBody');
       emit(BannerFailure(errorMessage: responseBody));
     }
   }on Exception catch(e){
     debugPrint('Failed to get banners , The Reason : $e');
     emit(
       BannerFailure(
         errorMessage: e.toString(),
       ),
     );
   }
  }
}
