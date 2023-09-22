import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'settings_provider.dart';

final playerApiProvider = FutureProvider<Dio>((ref) async {
  final settings = await ref.watch(settingsProvider.future);
  final params = <String, dynamic>{};

  if (settings.username.isNotEmpty) {
    params['username'] = settings.username;
  }

  if (settings.password.isNotEmpty) {
    params['password'] = settings.password;
  }

  return Dio(BaseOptions(
    baseUrl: '${settings.serverUrlOrDefault}/player_api.php',
    queryParameters: params,
  ));
});
