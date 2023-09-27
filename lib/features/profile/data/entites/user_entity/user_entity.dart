import 'package:hive/hive.dart';
part 'user_entity.g.dart';
@HiveType(typeId: 2)
class UserEntity {
@HiveField(0)
  final int? id;
 @HiveField(1)
  final String? name;
 @HiveField(2)
  final String? email;
 @HiveField(3)
  final String? phone;
 @HiveField(4)
  final String? image;
 @HiveField(5)
  final String? token;

  UserEntity({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.image,
    this.token,
  });
}
