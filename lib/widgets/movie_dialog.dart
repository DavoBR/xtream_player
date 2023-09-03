import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/movie.dart';

class MovieDialog extends ConsumerWidget {
  const MovieDialog(this._movie, {super.key});

  final Movie _movie;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Dialog(
      clipBehavior: Clip.hardEdge,
      child: SizedBox(
        width: MediaQuery.of(context).size.width - 200,
        height: MediaQuery.of(context).size.height - 200,
        child: Container(
          decoration: _movie.streamIcon != null
              ? BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(_movie.streamIcon!),
                    fit: BoxFit.fitWidth,
                  ),
                )
              : null,
          child: Container(
            decoration: const BoxDecoration(
              color: Color.fromARGB(142, 0, 0, 0),
            ),
            padding: const EdgeInsets.all(30.0),
            child: Flexible(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(_movie.name ?? '<Unknown>'),
                    const SizedBox(height: 10.0),
                    Text(_movie.plot ?? ''),
                    const SizedBox(height: 10.0),
                    Text('Genres: ${_movie.genre ?? ''}'),
                    const SizedBox(height: 10.0),
                    Text('Director: ${_movie.director ?? ''}'),
                    const SizedBox(height: 10.0),
                    Text('Cast: ${_movie.cast ?? ''}'),
                    const SizedBox(height: 10.0),
                    Row(
                      children: [
                        const Text('Rating: '),
                        ...List.generate(_movie.rating5Based == null ? 0 : 5,
                            (index) {
                          return Icon(
                            Icons.star_rate,
                            color: index <= (_movie.rating5Based! - 1)
                                ? Colors.orange
                                : Colors.grey,
                          );
                        }),
                      ],
                    ),
                    const SizedBox(height: 10.0),
                    Text('Year: ${_movie.year ?? ''}'),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
