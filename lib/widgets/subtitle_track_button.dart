import 'package:flutter/material.dart';
import 'package:media_kit/media_kit.dart';

import '../helpers/stream_helpers.dart';
import 'select_item_button.dart';

class SubtitleTrackButton extends StatelessWidget {
  const SubtitleTrackButton(this._player, {super.key});

  final Player _player;

  @override
  Widget build(BuildContext context) {
    return SelectItemButton(
      icon: const Icon(Icons.subtitles),
      items: _player.state.tracks.subtitle,
      buildLabel: (track) => translateTrackLanguage(track.language ?? ''),
      checkSelected: (track) => track.id == _player.state.track.subtitle.id,
      filter: (track) => track.language != null,
      onSelect: (track) => _player.setSubtitleTrack(track),
    );
  }
}
