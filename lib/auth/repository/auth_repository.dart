import '../../service/api_service.dart';

class AuthRepository {
  final ApiService apiService;

  AuthRepository(this.apiService);

  Future<dynamic> createUser({required Map<String, dynamic> data}) async {
    try {
      final response = await apiService.post(
        '/auth/register',
        data: data,
        requiresAuth: false,
      );

      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> loginUser({required dynamic data}) async {
    try {
      final response = await apiService.post(
        '/auth/login',
        data: data,
        requiresAuth: false,
      );

      return response;
    } catch (e) {
      rethrow;
    }
  }



  Future<dynamic> logoutUser() async {
    try {
      final response = await apiService.get('/auth/logout');

      return response;
    } catch (e) {
      rethrow;
    }
  }
}
