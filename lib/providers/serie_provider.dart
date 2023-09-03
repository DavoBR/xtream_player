import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/serie_details.dart';
import 'player_api_provider.dart';

final serieProvider =
    FutureProvider.family<SerieDetails, int>((ref, serieId) async {
  final playerApi = await ref.watch(playerApiProvider.future);

  final response = await playerApi.get('', queryParameters: {
    'action': 'get_series_info',
    'series_id': serieId,
  });

  return SerieDetails.fromJson(response.data);
});
