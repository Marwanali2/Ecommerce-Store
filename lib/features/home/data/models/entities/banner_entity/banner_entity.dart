import 'package:hive/hive.dart';

part 'banner_entity.g.dart';


@HiveType(typeId: 1)
class ProductEntity {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? imageUrl;

  ProductEntity({
    required this.id,
    required this.imageUrl,
  });
}
