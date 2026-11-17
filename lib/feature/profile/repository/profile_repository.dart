import '../../../service/api_service.dart';

class ProfileRepository {

  final ApiService apiService;

  ProfileRepository(this.apiService);

  // GET user data
  Future<dynamic> getUser() async {
    try {
      final response = await apiService.get('/users/profile');

      return response;
    } catch (e) {
      rethrow;
    }
  }
}