import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

void saveDataToBox({required Iterable cachedData, required String boxName}) {
  var productsBox = Hive.box(boxName);
  productsBox.addAll(cachedData);
}

 bool isArabic() {
  return Intl.getCurrentLocale() == 'ar';
}

bool isEnglish() {
  return Intl.getCurrentLocale() == 'en';
}