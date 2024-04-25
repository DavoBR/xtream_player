import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xtream_player/models/enums.dart';
import 'package:xtream_player/models/stream_category.dart';

final streamNameProvider = StateProvider<String>((ref) => '');

final streamTypeProvider = StateProvider<StreamType?>((ref) => null);

final streamCategoryProvider =
    StateProvider.family<StreamCategory?, StreamType>(
        (ref, streamType) => null);
