import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xtream_player/models/enums.dart';

import 'player_api_provider.dart';
import '../models/category.dart';

final _categoryActions = {
  StreamType.live: 'get_live_categories',
  StreamType.movie: 'get_vod_categories',
  StreamType.series: 'get_series_categories'
};

final categoriesProvider =
    FutureProvider.family<List<Category>, StreamType>((ref, streamType) async {
  final playerApi = await ref.watch(playerApiProvider.future);
  final action = _categoryActions[streamType];

  if (action == null) {
    throw Exception(
      'categoriesProvider: Invalid stream type ${streamType.name}',
    );
  }

  final response = await playerApi.get('', queryParameters: {
    'action': action,
  });

  return List<Category>.from(response.data!.map((x) => Category.fromJson(x)));
});
