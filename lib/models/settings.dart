import 'package:flutter/foundation.dart';

class Settings {
  final String serverUrl;
  final String username;
  final String password;

  String get serverUrlOrDefault {
    return serverUrl.isEmpty
        ? kDebugMode
            ? 'http://localhost:3000/api'
            : '/api'
        : serverUrl;
  }

  Settings({
    required this.serverUrl,
    required this.username,
    required this.password,
  });

  
}
