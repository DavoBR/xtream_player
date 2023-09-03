import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xtream_player/models/enums.dart';

import '../providers/favorites_provider.dart';

class ToggleFavoriteButton extends ConsumerWidget {
  const ToggleFavoriteButton(this.streamType, this.streamId, {super.key});

  final StreamType streamType;
  final int streamId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isInFavorite = ref.watch(
      favoritesProvider(streamType).select(
        (ids) => (ids.valueOrNull ?? []).contains(streamId),
      ),
    );
    return Tooltip(
      message: isInFavorite ? 'Remove from favorites' : 'Add to favorites',
      child: IconButton(
        icon: Icon(
          isInFavorite ? Icons.favorite : Icons.favorite_outline,
          color: Colors.red,
        ),
        onPressed: () => _onPressed(ref, isInFavorite),
      ),
    );
  }

  void _onPressed(WidgetRef ref, bool isInFavorite) {
    if (isInFavorite) {
      ref.read(favoritesProvider(streamType).notifier).remove(streamId);
    } else {
      ref.read(favoritesProvider(streamType).notifier).add(streamId);
    }
  }
}
