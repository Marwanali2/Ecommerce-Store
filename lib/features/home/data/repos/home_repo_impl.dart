import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ecommerce/core/errors/failure.dart';
import 'package:ecommerce/features/home/data/home_local_data_source/home_local_data_source.dart';
import 'package:ecommerce/features/home/data/models/products_model.dart';
import 'package:ecommerce/features/home/data/repos/home_repo.dart';
import 'package:ecommerce/features/home/presentation/managers/products_cubit/products_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeRepoImpl extends HomeRepo {
  late final HomeLocalDataSource homeLocalDataSource;

  @override
  Future<Either<Failure, List<ProductModel>>> getProducts() async {
    try {
      var productsLocal = homeLocalDataSource.getProductsLocal();
      if (productsLocal.isNotEmpty) {
        return right(productsLocal);
      }
      var productsRemote =
          await BlocProvider.of<ProductsCubit>(BuildContext as BuildContext)
              .getProducts();
      return right(productsRemote);
    } on Exception catch (e) {
      if (e is DioException) {
        return Left(
          ServerFailure.fromDioError(
            e,
          ),
        );
      } else {
        return Left(
          ServerFailure(
            errorMessage: e.toString(),
          ),
        );
      }
    }
  }
}
