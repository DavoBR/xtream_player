import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:xtream_player/providers/serie_provider.dart';

import '../models/enums.dart';
import '../models/episode.dart';
import '../models/season.dart';
import '../models/serie.dart';
import '../models/serie_details.dart';
import 'cover.dart';
import 'episode_tile.dart';

class SerieDialog extends ConsumerWidget {
  const SerieDialog(this._serie, {super.key});

  final Serie _serie;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final serieAsync = ref.watch(serieProvider(_serie.seriesId));
    return Dialog(
      clipBehavior: Clip.hardEdge,
      child: serieAsync.when(
        data: (serieDetails) {
          return _DataContent(serieDetails);
        },
        error: (error, stackTrace) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(error.toString()),
              const Divider(),
              Text(stackTrace.toString())
            ],
          );
        },
        loading: () {
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class _DataContent extends StatelessWidget {
  const _DataContent(this._serieDetails);

  final SerieDetails _serieDetails;

  List<Season> get _seasons => _serieDetails.seasons
      .where(
        (s) => _serieDetails.episodes.containsKey(
          s.seasonNumber.toString(),
        ),
      )
      .toList();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: _serieDetails.info.backdropPath.isNotEmpty
              ? BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(_serieDetails.info.backdropPath[0]),
                    fit: BoxFit.fitWidth,
                  ),
                )
              : null,
          height: 350,
          child: Container(
            decoration: const BoxDecoration(
              color: Color.fromARGB(142, 0, 0, 0),
            ),
            padding: const EdgeInsets.all(30.0),
            child: DefaultTextStyle(
              style: const TextStyle(color: Colors.white),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Spacer(),
                  Text(_serieDetails.info.name),
                  const SizedBox(height: 10.0),
                  Text(_serieDetails.info.plot),
                  const SizedBox(height: 10.0),
                  Text('Genres: ${_serieDetails.info.genre}'),
                  const SizedBox(height: 10.0),
                  Text('Director: ${_serieDetails.info.director}'),
                  const SizedBox(height: 10.0),
                  Text('Cast: ${_serieDetails.info.cast}'),
                  const SizedBox(height: 10.0),
                  Row(
                    children: [
                      const Text('Rating: '),
                      ...List.generate(5, (index) {
                        return Icon(
                          Icons.star_rate,
                          color: index <= (_serieDetails.info.rating5Based - 1)
                              ? Colors.orange
                              : Colors.grey,
                        );
                      }),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  Text('Year: ${_serieDetails.info.year ?? ''}'),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _seasons.length,
            itemBuilder: (context, index) {
              final season = _seasons[index];
              final episodes =
                  _serieDetails.episodes[(season.seasonNumber).toString()];

              return ExpansionTile(
                initiallyExpanded: index == _seasons.length - 1,
                leading: Cover(
                  season.cover,
                  height: 50,
                  width: 50,
                ),
                title: Text('${season.name} (${season.airDate})'),
                subtitle: Text(season.overview),
                children: (episodes ?? [])
                    .map((episode) => _buildEpisodeTile(context, episode))
                    .toList(),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildEpisodeTile(BuildContext context, Episode episode) {
    return EpisodeTile(
      episode,
      onTap: () => context.go(
        '/${StreamType.series.name}/${episode.id}',
      ),
    );
  }
}
