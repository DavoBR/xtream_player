import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xtream_player/models/enums.dart';
import 'package:xtream_player/providers/recents_provider.dart';

import 'all_streams_provider.dart';
import 'category_provider.dart';
import 'favorites_provider.dart';
import 'filter_provider.dart';
import 'scope_provider.dart';

final streamsProvider =
    FutureProvider.family<List<Map<String, dynamic>>, StreamType>(
        (ref, streamType) async {
  final scope = ref.watch(scopeProvider(streamType));
  final category = ref.watch(categoryProvider(streamType));
  final filter = ref.watch(filterProvider(streamType)).toLowerCase();
  final futureStreams = ref.watch(allStreamsProvider(streamType).future);
  final List<int> ids = [];

  switch (scope) {
    case StreamScope.favorites:
      ids.addAll(await ref.watch(favoritesProvider(streamType).future));
      break;
    case StreamScope.recents:
      ids.addAll(await ref.watch(recentsProvider(streamType).future));
      break;
    default:
  }

  return futureStreams.then((streams) {
    return streams.where((stream) {
      final streamId = stream['stream_type'] == 'series'
          ? int.parse(stream['series_id'].toString())
          : int.parse(stream['stream_id'].toString());

      if (scope == StreamScope.favorites && !ids.contains(streamId)) {
        return false;
      }

      if (scope == StreamScope.recents && !ids.contains(streamId)) {
        return false;
      }

      if (category != null && stream['category_id'] != category.categoryId) {
        return false;
      }

      if (filter.isNotEmpty &&
          !(stream['name'] ?? '').toLowerCase().contains(filter)) {
        return false;
      }

      return true;
    }).toList();
  });
});
