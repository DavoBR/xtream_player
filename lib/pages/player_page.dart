import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xtream_player/providers/stream_info_provider.dart';
import 'package:xtream_player/widgets/stream_player.dart';

import '../models/enums.dart';

class PlayerPage extends ConsumerWidget {
  const PlayerPage({
    super.key,
    required this.streamType,
    required this.streamId,
  });

  final StreamType streamType;
  final int streamId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final streamInfoAsync = ref.watch(
      streamInfoProvider(streamId),
    );
    return Scaffold(
      body: Center(
          child: streamInfoAsync.when(
        data: (streamInfo) => StreamPlayer(
          streamType: streamType,
          streamId: streamId,
          streamInfo: streamInfo,
        ),
        loading: () => const CircularProgressIndicator(),
        error: (error, stackTrace) => Column(
          children: [
            Text(error.toString()),
            const Divider(),
            Text(stackTrace.toString())
          ],
        ),
      )),
    );
  }
}
