import 'dart:async';
import 'dart:developer';

import 'package:easy_debounce/easy_throttle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xtream_player/providers/recents_provider.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:xtream_player/providers/settings_provider.dart';

import '../models/enums.dart';
import '../models/media_info.dart';
import '../providers/player_position_provider.dart';
import '../widgets/audio_track_button.dart';
import '../widgets/subtitle_track_button.dart';

class PlayerPage extends ConsumerStatefulWidget {
  const PlayerPage(this.playlist, this.initialIndex, {super.key});

  final List<MediaInfo> playlist;
  final int initialIndex;

  static MaterialPageRoute route(
    List<MediaInfo> playlist, [
    int initialIndex = 0,
  ]) {
    return MaterialPageRoute(
      builder: (_) => PlayerPage(playlist, initialIndex),
    );
  }

  @override
  ConsumerState<PlayerPage> createState() => _PlayerPageState();
}

class _PlayerPageState extends ConsumerState<PlayerPage> {
  late final _player = Player(
    configuration: const PlayerConfiguration(
      title: 'Xtream Player',
    ),
  );
  late final _videoController = VideoController(_player);

  final List<StreamSubscription> _subscriptions = [];

  late MediaInfo _mediaInfo;

  @override
  void initState() {
    _mediaInfo = widget.playlist[widget.initialIndex];

    _subscriptions.add(_player.stream.position.listen(_onPosition));
    _subscriptions.add(_player.stream.tracks.listen(_onTracks));
    _subscriptions.add(_player.stream.playlist.listen(_onPlaylist));

    scheduleMicrotask(() => _initPlaylist());

    super.initState();
  }

  @override
  void dispose() {
    EasyThrottle.cancelAll();
    for (var suscription in _subscriptions) {
      suscription.cancel();
    }
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: MaterialDesktopVideoControlsTheme(
          normal: _buildVideoControls(),
          fullscreen: _buildVideoControls(),
          child: Video(
            controller: _videoController,
            pauseUponEnteringBackgroundMode: false,
          ),
        ),
      ),
    );
  }

  void _initPlaylist() async {
    final settings = await ref.read(settingsProvider.future);

    _player.open(Playlist(
      widget.playlist.map((e) => Media(e.getUrl(settings))).toList(),
      index: widget.initialIndex,
    ));
  }

  MaterialDesktopVideoControlsThemeData _buildVideoControls() {
    return MaterialDesktopVideoControlsThemeData(
      displaySeekBar: _mediaInfo.type != StreamType.live,
      toggleFullscreenOnDoublePress: true,
      modifyVolumeOnScroll: true,
      topButtonBar: [
        const BackButton(color: Colors.white),
        const Spacer(),
        Text(
          _mediaInfo.title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20.0,
          ),
        ),
        const Spacer(),
      ],
      bottomButtonBar: [
        const MaterialDesktopPlayOrPauseButton(),
        const MaterialDesktopVolumeButton(),
        if (_mediaInfo.type != StreamType.live)
          const MaterialDesktopPositionIndicator(),
        const Spacer(),
        SubtitleTrackButton(_player),
        AudioTrackButton(_player),
        const MaterialDesktopFullscreenButton(),
      ],
    );
  }

  void _restorePosition() async {
    final seconds = await ref.read(
      playerPositionProvider((_mediaInfo.type, _mediaInfo.id)).future,
    );

    if (seconds == 0) return;

    final duration = Duration(seconds: seconds);

    log('Restore position to $duration', name: 'Player');

    _player.seek(duration);
  }

  void _onTracks(Tracks tracks) {
    final audioTrack =
        tracks.audio.where((audio) => audio.language == 'spa').firstOrNull;
    final subTrack =
        tracks.subtitle.where((sub) => sub.language == 'spa').firstOrNull;

    if (audioTrack != null) {
      _player.setAudioTrack(audioTrack);
    }

    if (subTrack != null) {
      _player.setSubtitleTrack(subTrack);
    }
  }

  void _onPosition(Duration duration) {
    if (duration.inSeconds == 0) {
      _restorePosition();
    }

    if (duration.inSeconds < 5) return;

    EasyThrottle.throttle(
      'player-position-state',
      const Duration(milliseconds: 1000),
      () async {
        if (_mediaInfo.type != StreamType.live) {
          ref
              .read(playerPositionProvider((_mediaInfo.type, _mediaInfo.id))
                  .notifier)
              .setSeconds(duration.inSeconds);
        }

        ref
            .read(recentsProvider(_mediaInfo.type).notifier)
            .add(_mediaInfo.parentId ?? _mediaInfo.id);
      },
    );
  }

  void _onPlaylist(Playlist event) {
    setState(() {
      _mediaInfo = widget.playlist[event.index];
    });
  }
}
