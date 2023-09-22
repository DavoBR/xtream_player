import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xtream_player/models/stream_info.dart';

import 'player_api_provider.dart';

final streamInfoProvider =
    FutureProvider.family<StreamInfo, int>((ref, streamId) async {
  final playerApi = await ref.watch(playerApiProvider.future);
  final response = await playerApi.get('', queryParameters: {
    'action': 'get_vod_info',
    'vod_id': streamId,
  });

  return StreamInfo.fromJson(response.data);
});
