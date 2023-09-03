class Settings {
  final String serverUrl;
  final String username;
  final String password;

  Settings({
    required this.serverUrl,
    required this.username,
    required this.password,
  });

  bool valid() {
    return serverUrl.isNotEmpty && username.isNotEmpty && password.isNotEmpty;
  }
}
