import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/enums.dart';
import '../models/episode.dart';
import '../providers/player_position_provider.dart';
import 'cover.dart';

class EpisodeTile extends StatelessWidget {
  const EpisodeTile(this.episode, {super.key, this.onTap});

  final Episode episode;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          enableFeedback: true,
          leading: Cover(
            episode.info.coverBig ?? episode.info.movieImage,
            width: 100,
            height: 150,
            fallbackBuilder: (_) => const Placeholder(),
          ),
          title: Text(episode.title),
          //subtitle: Text(episode.info.plot),
          onTap: onTap,
        ),
        Consumer(
          child: Text(episode.title),
          builder: (context, ref, child) {
            final lastPositionAsync = ref.watch(playerPositionProvider(
              (StreamType.series, int.parse(episode.id)),
            ));
            final lastSecond = lastPositionAsync.value ?? 0;
            final episodeDuration = episode.info.durationSecs;

            return LinearProgressIndicator(value: lastSecond / episodeDuration);
          },
        ),
      ],
    );
  }
}
