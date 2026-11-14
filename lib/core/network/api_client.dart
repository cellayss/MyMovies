import 'package:dio/dio.dart';

import '../constants/api_constants.dart';
import '../error/exceptions.dart';

class ApiClient {
  ApiClient()
    : _dio = Dio(
        BaseOptions(
          baseUrl: ApiConstants.baseUrl,
          connectTimeout: const Duration(seconds: 15),
          receiveTimeout: const Duration(seconds: 15),
          headers: {
            'Authorization': 'Bearer ${ApiConstants.accessToken}',
            'accept': 'application/json',
          },
        ),
      );

  final Dio _dio;

  Future<Map<String, dynamic>> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        path,
        queryParameters: queryParameters,
      );
      return response.data ?? <String, dynamic>{};
    } on DioException catch (error) {
      print('❌ DIO ERROR type: ${error.type}');
      print('❌ DIO ERROR message: ${error.message}');
      print('❌ DIO ERROR response: ${error.response?.data}');
      print('❌ DIO ERROR status: ${error.response?.statusCode}');
      throw ServerException(
        error.response?.data?['status_message']?.toString() ??
            'Gagal memuat data movie.',
      );
    }
  }
}
