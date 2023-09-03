import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/enums.dart';
import 'player_api_provider.dart';

final allStreamsProvider =
    FutureProvider.family<List<Map<String, dynamic>>, StreamType>(
        (ref, streamType) async {
  final playerApi = await ref.watch(playerApiProvider.future);
  String action;
  switch (streamType) {
    case StreamType.live:
      action = 'get_live_streams';
      break;
    case StreamType.movie:
      action = 'get_vod_streams';
      break;
    case StreamType.series:
      action = 'get_series';
      break;
    default:
      throw Exception('allStreamsProvider: Invalid stream type $streamType');
  }
  final response = await playerApi.get('', queryParameters: {
    'action': action,
  });
  return List<Map<String, dynamic>>.from(response.data!).where((stream) {
    final id = stream['stream_type'] == 'series'
        ? stream['series_id']
        : stream['stream_id'];
    return id != null && stream['name'] != null;
  }).toList();
});
