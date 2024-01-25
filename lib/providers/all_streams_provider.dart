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
  final response = await playerApi.get<List>(
    '',
    queryParameters: {
      'action': action,
    },
  );

  bool filter(Map<String, dynamic> stream) {
    final idKey = stream['stream_type'] == 'series' ? 'series_id' : 'stream_id';
    return stream[idKey] != null && stream['name'] != null;
  }

  return response.data!
      .map((stream) => stream as Map<String, dynamic>)
      .where(filter)
      .toList();
});
