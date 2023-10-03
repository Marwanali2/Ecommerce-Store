import 'package:ecommerce/core/utils/constants.dart';
import 'package:ecommerce/features/home/data/models/banners_model.dart';
import 'package:ecommerce/features/home/data/models/products_model.dart';
import 'package:hive/hive.dart';

abstract class HomeLocalDataSource {
 List<ProductModel> getProductsLocal();

 List<ProductModel> getFilterProductsLocal();

 List<BannerModel> getBannersLocal();
}

// class HomeLocalDataSourceImpl extends HomeLocalDataSource {
//   @override
//   List<ProductModel> getProductsLocal() {
//     // var categoriesProductsBox=Hive.box<ProductModel>(kCategoriesProducts);
//     // return categoriesProductsBox.values.toList();
//   }
//
//   @override
//   List<ProductModel> getFilterProductsLocal() {
//     var filteredProductsBox=Hive.box<ProductModel>(kFilteredProducts);
//     return filteredProductsBox.values.toList();
//   }
//
//   @override
//   List<BannerModel> getBannersLocal() {
//     var bannersBox=Hive.box<BannerModel>(kBannersImages);
//     return bannersBox.values.toList();
//   }
// }
