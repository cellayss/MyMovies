import '../constants/api_constants.dart';

class ImageUrlHelper {
  static String poster(String path) {
    if (path.isEmpty) return '';
    return '${ApiConstants.imageBaseUrl}$path';
  }
}
