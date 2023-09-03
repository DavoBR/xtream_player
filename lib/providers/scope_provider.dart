import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/enums.dart';

final scopeProvider = StateProvider.family<StreamScope, StreamType>(
    (ref, streamType) => StreamScope.all);
