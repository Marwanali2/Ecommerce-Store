import 'package:hive/hive.dart';

part 'banner_entity.g.dart';


@HiveType(typeId: 1)
class BannerEntity {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? imageUrl;

  BannerEntity({
    required this.id,
    required this.imageUrl,
  });
}
