import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class Cover extends StatelessWidget {
  const Cover(
    this.imageUrl, {
    super.key,
    this.fallbackBuilder,
    this.width,
    this.height,
  });

  final String? imageUrl;
  final Widget Function(BuildContext context)? fallbackBuilder;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    if (imageUrl == null || imageUrl!.isEmpty) {
      if (fallbackBuilder != null) {
        return Center(child: fallbackBuilder!(context));
      } else {
        return const Center(child: Placeholder());
      }
    }

    return FadeInImage.memoryNetwork(
      placeholder: kTransparentImage,
      image: imageUrl!,
      height: height,
      width: width,
      imageErrorBuilder: (context, error, stackTrace) {
        return const Icon(Icons.error);
      },
    );

  }
}
