import 'package:hive/hive.dart';
part'products_model.g.dart';
@HiveType(typeId: 0)
class ProductModel {
  @HiveField(0)
  int? id;
  @HiveField(1)
  int? price;
  @HiveField(2)
  int? oldPrice;
  @HiveField(3)
  int? discount;
  @HiveField(4)
  String? image;
  @HiveField(5)
  String? name;
  @HiveField(6)
  String? description;
  @HiveField(7)
  List<dynamic>? images;
  @HiveField(8)
  bool? inFavorites;
  @HiveField(9)
  bool? inCart;

  ProductModel(
      {this.id,
        this.price,
        this.oldPrice,
        this.discount,
        this.image,
        this.name,
        this.description,
        this.images,
        this.inFavorites,
        this.inCart});

  ProductModel.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'].toInt();
    price = json['price']?.toInt();
    oldPrice = json['old_price']?.toInt();
    discount = json['discount']?.toInt();
    image = json['image'].toString();
    name = json['name'].toString();
    description = json['description'].toString();
    images = json['images'];
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['price'] = price;
    data['old_price'] = oldPrice;
    data['discount'] = discount;
    data['image'] = image;
    data['name'] = name;
    data['description'] = description;
    data['images'] = images;
    data['in_favorites'] = inFavorites;
    data['in_cart'] = inCart;
    return data;
  }
}
