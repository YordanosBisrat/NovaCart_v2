import 'package:dio/dio.dart';
import 'api_endpoints.dart';

class DioClient {
  final Dio dio;

  DioClient()
    : dio = Dio(
        BaseOptions(
          baseUrl: ApiEndpoints.baseUrl,
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
          headers: {'Content-Type': 'application/json'},
        ),
      );

  Future<Response> get(String path) => dio.get(path);

  Future<Response> post(String path, dynamic data) =>
      dio.post(path, data: data);

  Future<Response> put(String path, dynamic data) => dio.put(path, data: data);

  Future<Response> delete(String path) => dio.delete(path);
}
