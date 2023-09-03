import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'settings_provider.dart';

final playerApiProvider = FutureProvider<Dio>((ref) async {
  final settings = await ref.watch(settingsProvider.future);
  return Dio(BaseOptions(
    baseUrl: '${settings.serverUrl}/player_api.php',
    queryParameters: {
      'username': settings.username,
      'password': settings.password,
    },
  ));
});
