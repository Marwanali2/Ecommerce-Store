import 'package:shared_preferences/shared_preferences.dart';

import '../../features/shared/network/local_network.dart';

String userToken = CachedNetwork.getCacheData(key: 'token');
const kCategoriesProducts = 'categories_products';
const kFilteredProducts = 'filtered_products';
const kBannersImages = 'banners_images';
const kFavProducts = 'fav_products';
const kCartProducts = 'cart_products';
const kUserDetails = 'user_details';
bool darkTheme = CachedLocal.insertToCache(key: 'darkThemeKey', value: false);
bool lightTheme = CachedLocal.insertToCache(key: 'lightThemeKey', value: false);
