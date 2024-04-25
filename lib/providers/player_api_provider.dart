import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xtream_player/extensions/settings_extensions.dart';

import 'settings_provider.dart';

final playerApiProvider = FutureProvider<Dio>((ref) async {
  final settings = await ref.watch(settingsProvider.future);

  return Dio(BaseOptions(
    baseUrl: settings.playerApiUrl,
    queryParameters: {
      'username': settings.username,
      'password': settings.password,
    }
  ));
});
