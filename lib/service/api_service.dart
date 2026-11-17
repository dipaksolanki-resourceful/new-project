import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../config/api_url.dart';

class ApiService {
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    ),
  );

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<Options> _getOptions({
    bool requiresAuth = true,
    Options? options,
  }) async {
    final headers = <String, dynamic>{
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      ...?options?.headers,
    };

    if (requiresAuth) {
      final token = await getToken();

      if (token != null && token.isNotEmpty) {
        headers['Authorization'] = 'Bearer $token';
      }
    }

    return (options ?? Options()).copyWith(headers: headers);
  }

  Future<Response<dynamic>> get(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
    bool requiresAuth = true,
    CancelToken? cancelToken,
  }) async {
    return await dio.get(
      endpoint,
      queryParameters: queryParameters,
      options: await _getOptions(requiresAuth: requiresAuth),
      cancelToken: cancelToken,
    );
  }

  // POST
  Future<Response<dynamic>> post(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool requiresAuth = true,
    CancelToken? cancelToken,
  }) async {
    return await dio.post(
      endpoint,
      data: data,
      queryParameters: queryParameters,
      options: await _getOptions(requiresAuth: requiresAuth),
      cancelToken: cancelToken,
    );
  }

  // PUT
  Future<Response<dynamic>> put(
    String endpoint, {
    dynamic data,
    bool requiresAuth = true,
    CancelToken? cancelToken,
  }) async {
    return await dio.put(
      endpoint,
      data: data,
      options: await _getOptions(requiresAuth: requiresAuth),
      cancelToken: cancelToken,
    );
  }

  // PATCH
  Future<Response<dynamic>> patch(
    String endpoint, {
    dynamic data,
    bool requiresAuth = true,
    CancelToken? cancelToken,
  }) async {
    return await dio.patch(
      endpoint,
      data: data,
      options: await _getOptions(requiresAuth: requiresAuth),
      cancelToken: cancelToken,
    );
  }

  // DELETE
  Future<Response<dynamic>> delete(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool requiresAuth = true,
    CancelToken? cancelToken,
  }) async {
    return await dio.delete(
      endpoint,
      data: data,
      queryParameters: queryParameters,
      options: await _getOptions(requiresAuth: requiresAuth),
      cancelToken: cancelToken,
    );
  }

  // FILE UPLOAD
  Future<Response<dynamic>> upload(
    String endpoint, {
    required FormData formData,
    ProgressCallback? onSendProgress,
    CancelToken? cancelToken,
  }) async {
    return await dio.post(
      endpoint,
      data: formData,
      onSendProgress: onSendProgress,
      cancelToken: cancelToken,
    );
  }
}
