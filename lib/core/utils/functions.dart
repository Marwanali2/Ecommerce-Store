import 'package:hive/hive.dart';

void saveDataToBox({required Iterable cachedData,required String boxName}) {
  var productsBox=Hive.box(boxName);
  productsBox.addAll(cachedData);
}