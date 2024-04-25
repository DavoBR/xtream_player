import 'package:flutter/foundation.dart';

import '../models/enums.dart';
import '../models/settings.dart';

extension SettingsExtensions on Settings {
  String get proxyUrl {
    return kDebugMode ? 'http://localhost:3000/api' : '/api';
  }

  bool get isEmpty {
    return serverUrl.isEmpty && username.isEmpty && password.isEmpty;
  }

  String get playerApiUrl {
    return [
      kIsWeb ? proxyUrl : serverUrl,
      'player_api.php',
      kIsWeb && serverUrl.isNotEmpty ? '?serverUrl=$serverUrl' : '',
    ].where((s) => s.isNotEmpty).join('/');
  }

  String getStreamUrl(StreamType streamType, int streamId, String? extension) {
    if (extension == null) {
      switch (streamType) {
        case StreamType.live:
          extension = 'm3u8'; //ts
          break;
        case StreamType.movie:
        case StreamType.series:
          extension = 'mp4';
          break;
        default:
          throw Exception('Unknown stream type: ${streamType.name}');
      }
    }

    return [
      kIsWeb ? proxyUrl : serverUrl,
      streamType.name,
      username.isEmpty ? 'default' : username,
      password.isEmpty ? 'default' : password,
      '$streamId.$extension',
      kIsWeb && serverUrl.isNotEmpty ? '?serverUrl=$serverUrl' : '',
    ].where((s) => s.isNotEmpty).join('/');
  }
}
