import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'all_streams_provider.dart';
import 'filter_provider.dart';

final streamsProvider = FutureProvider<List<Map<String, dynamic>>>((ref) async {
  final streamType = ref.watch(streamTypeProvider);

  if (streamType == null) {
    return [];
  }

  final category = ref.watch(streamCategoryProvider(streamType));
  final name = ref.watch(streamNameProvider).toLowerCase();
  final futureStreams = ref.watch(allStreamsProvider(streamType).future);

  return futureStreams.then((streams) {
    return streams.where((stream) {
      if (category != null && stream['category_id'] != category.categoryId) {
        return false;
      }

      if (name.isNotEmpty &&
          !(stream['name'] ?? '').toLowerCase().contains(name)) {
        return false;
      }

      return true;
    }).toList();
  });
});
