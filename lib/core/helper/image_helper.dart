import 'package:delveria/core/network/api_constants.dart';

class ImageHelper {
  static String getRestaurantImageUrl(String? path) {
    if (path == null || path.isEmpty) return '';

    // 1. Replace backslashes with forward slashes
    String cleanPath = path.replaceAll('\\', '/');

    // 2. Handle specific backend glitch where incorrect domain and path are returned
    if (cleanPath.contains('mongodb.zakmt.com')) {
      // Extract the filename
      final filename = cleanPath.split('/').last;
      // Reconstruct using the correct base URL and upload directory
      return '${ApiConstants.baseUrl}/deliveria_upload/$filename';
    }

    // 3. If it starts with http, return as is (it's a full URL)
    if (cleanPath.startsWith('http')) {
      return cleanPath;
    }

    // 4. Prepend base URL for relative paths
    // Ensure we don't double slash if cleanPath starts with /
    if (cleanPath.startsWith('/')) {
      cleanPath = cleanPath.substring(1);
    }
    
    return '${ApiConstants.baseUrl}/$cleanPath';
  }
}
