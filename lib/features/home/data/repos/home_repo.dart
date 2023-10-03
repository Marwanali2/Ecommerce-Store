import 'package:dartz/dartz.dart';
import 'package:ecommerce/core/errors/failure.dart';
import 'package:ecommerce/features/home/data/models/products_model.dart';

abstract class HomeRepo {
  Future<Either<Failure, List<ProductModel>>> getProducts();
}
