class AuthService {
  final Map<String, String> users = {'test@gmail.com': '123456'};

  bool login(String email, String password) {
    return users[email] == password;
  }

  bool signup(String email, String password) {
    if (users.containsKey(email)) {
      return false;
    }

    users[email] = password;
    return true;
  }
}
