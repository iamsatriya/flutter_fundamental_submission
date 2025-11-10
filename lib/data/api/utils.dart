import 'package:new_fundamental_submission/data/api/api.dart';

class Utils {
  static String smallImageUrl(String pictureId) =>
      '${Api.baseUrl}/images/small/$pictureId';
  static String mediumImageUrl(String pictureId) =>
      '${Api.baseUrl}/images/medium/$pictureId';
  static String largeImageUrl(String pictureId) =>
      '${Api.baseUrl}/images/large/$pictureId';
}
