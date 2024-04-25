import 'dart:async';
import 'dart:developer';

import 'package:easy_debounce/easy_throttle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:xtream_player/extensions/settings_extensions.dart';
import 'package:xtream_player/models/stream_info.dart';
import 'package:xtream_player/providers/recents_provider.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:xtream_player/providers/settings_provider.dart';

import '../models/enums.dart';
import '../providers/player_position_provider.dart';
import '../widgets/audio_track_button.dart';
import '../widgets/subtitle_track_button.dart';

class StreamPlayer extends ConsumerStatefulWidget {
  const StreamPlayer({
    super.key,
    required this.streamType,
    required this.streamId,
    required this.streamInfo,
  });

  final StreamType streamType;
  final int streamId;
  final StreamInfo streamInfo;

  @override
  ConsumerState<StreamPlayer> createState() => _PlayerPageState();
}

class _PlayerPageState extends ConsumerState<StreamPlayer> {
  late final _player = Player(
    configuration: const PlayerConfiguration(
      title: 'Xtream Player',
    ),
  );
  late final _videoController = VideoController(_player);

  final List<StreamSubscription> _subscriptions = [];

  @override
  void initState() {
    _subscriptions.add(_player.stream.position.listen(_onPosition));
    _subscriptions.add(_player.stream.tracks.listen(_onTracks));

    scheduleMicrotask(() => _openMedia());

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

  void _openMedia() async {
    final settings = await ref.read(settingsProvider.future);
    final streamUrl = settings.getStreamUrl(
      widget.streamType,
      widget.streamId,
      widget.streamInfo.movieData?.containerExtension,
    );
    _player.open(Media(streamUrl));
  }

  MaterialDesktopVideoControlsThemeData _buildVideoControls() {
    return MaterialDesktopVideoControlsThemeData(
      displaySeekBar: widget.streamType != StreamType.live,
      toggleFullscreenOnDoublePress: true,
      modifyVolumeOnScroll: true,
      topButtonBar: [
        const BackButton(color: Colors.white),
        const Spacer(),
        Text(
          widget.streamInfo.movieData?.title ?? '<UNKNOWN TITLE>',
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
        if (widget.streamType != StreamType.live)
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
      playerPositionProvider((widget.streamType, widget.streamId)).future,
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
        if (widget.streamType != StreamType.live) {
          final notifier = playerPositionProvider((
            widget.streamType,
            widget.streamId,
          )).notifier;
          ref.read(notifier).setSeconds(duration.inSeconds);
        }

        if (widget.streamType != StreamType.series) {
          final notifier = recentsProvider(widget.streamType).notifier;
          ref.read(notifier).add(widget.streamId);
        }
      },
    );
  }
}
