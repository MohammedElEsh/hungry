abstract class TokenProvider {
  void setToken(String? token);
  void clearToken();
  String? get token;
}

class TokenProviderImpl implements TokenProvider {
  String? _token;

  @override
  String? get token => _token;

  @override
  void setToken(String? token) {
    _token = token;
  }

  @override
  void clearToken() {
    _token = null;
  }
}
