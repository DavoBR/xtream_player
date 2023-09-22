import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/stream_category.dart';
import '../models/enums.dart';

final categoryProvider =
    StateProvider.family<StreamCategory?, StreamType>(
    (ref, streamType) => null);
