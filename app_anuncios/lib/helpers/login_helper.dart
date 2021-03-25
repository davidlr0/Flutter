class LoginHelper {
  String _token;
  static final LoginHelper _instance = LoginHelper.internal();

  factory LoginHelper() => _instance;
  LoginHelper.internal();

  String get token {
    return _token;
  }

  void setToken(String token) {
    this._token = token;
  }

  void removeToken() {
    this._token = "";
  }
}
