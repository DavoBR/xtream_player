import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/enums.dart';

final filterProvider =
    StateProvider.family<String, StreamType>((ref, streamType) => '');
