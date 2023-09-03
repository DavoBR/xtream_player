import 'package:flutter/material.dart';
import 'package:xtream_player/models/enums.dart';
import 'package:xtream_player/widgets/stream_info_button.dart';
import 'package:xtream_player/widgets/toggle_favorite_button.dart';

import 'cover.dart';

class StreamCard extends StatelessWidget {
  const StreamCard({
    super.key,
    required this.streamType,
    required this.streamId,
    required this.name,
    required this.imageUrl,
    this.imageWidth,
    this.imageHeight,
    required this.onTap,
    this.onInfoTap,
  });

  final StreamType streamType;
  final int streamId;
  final String name;
  final String? imageUrl;
  final double? imageWidth;
  final double? imageHeight;
  final void Function() onTap;
  final void Function()? onInfoTap;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InkWell(
          borderRadius: BorderRadius.circular(8.0),
          onTap: onTap,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Padding(
              padding: EdgeInsets.all(streamType == StreamType.live ? 32.0 : 0),
              child: Cover(
                imageUrl,
                width: imageWidth,
                height: imageHeight,
                fallbackBuilder: (_) => Text(name),
              ),
            ),
          ),
        ),
        Row(children: [
          ToggleFavoriteButton(streamType, streamId),
          if (onInfoTap != null) StreamInfoButton(onInfoTap!),
        ])
      ],
    );
  }
}
