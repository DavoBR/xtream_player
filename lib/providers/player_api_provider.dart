import 'package:dio/dio.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xtream_player/extensions/settings_extensions.dart';

import 'settings_provider.dart';

final playerApiProvider = FutureProvider<Dio>((ref) async {
  final settings = await ref.watch(settingsProvider.future);

  final dio = Dio(BaseOptions(
    baseUrl: settings.playerApiUrl,
    queryParameters: {
      'username': settings.username,
      'password': settings.password,
    },
  ));

  dio.interceptors.add(PrettyDioLogger(
    requestHeader: true,
    requestBody: true,
    responseBody: true,
    responseHeader: false,
    error: true,
    compact: true,
  ));

  dio.interceptors.add(RetryInterceptor(
    dio: dio,
    logPrint: print, // specify log function (optional)
    retries: 3, // retry count (optional)
    retryDelays: const [
      // set delays between retries (optional)
      Duration(seconds: 1), // wait 1 sec before first retry
      Duration(seconds: 2), // wait 2 sec before second retry
      Duration(seconds: 3), // wait 3 sec before third retry
    ],
  ));

  return dio;
});
