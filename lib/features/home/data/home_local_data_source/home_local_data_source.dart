import 'package:ecommerce/features/home/data/models/banners_model.dart';
import 'package:ecommerce/features/home/data/models/products_model.dart';

abstract class HomeLocalDataSource {
  List<ProductModel> getProductsLocal();

  List<ProductModel> getFilterProductsLocal();

  List<BannerModel> getBannersLocal();
}
