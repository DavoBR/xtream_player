import 'package:flutter/material.dart';
import 'package:media_kit/media_kit.dart';

import '../helpers/stream_helpers.dart';
import 'select_item_button.dart';

class AudioTrackButton extends StatelessWidget {
  const AudioTrackButton(this._player, {super.key});

  final Player _player;

  @override
  Widget build(BuildContext context) {
    return SelectItemButton(
      icon: const Icon(Icons.audiotrack),
      items: _player.state.tracks.audio,
      buildLabel: (track) => translateTrackLanguage(track.language ?? ''),
      checkSelected: (track) => track.id == _player.state.track.audio.id,
      filter: (track) => track.language != null,
      onSelect: (track) => _player.setAudioTrack(track),
    );
  }
}
