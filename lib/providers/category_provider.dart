import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/category.dart';
import '../models/enums.dart';

final categoryProvider =
    StateProvider.family<Category?, StreamType>((ref, streamType) => null);
