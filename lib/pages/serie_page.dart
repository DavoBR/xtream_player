import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:xtream_player/models/enums.dart';
import 'package:xtream_player/models/episode.dart';
import 'package:xtream_player/models/season.dart';
import 'package:xtream_player/models/serie_details.dart';
import 'package:xtream_player/providers/serie_provider.dart';
import 'package:xtream_player/widgets/episode_tile.dart';

final seasonProvider =
    StateProviderFamily<Season?, int>((ref, serieId) => null);

class SeriePage extends StatelessWidget {
  const SeriePage(this._serieId, {super.key});

  final int _serieId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: AppBar(
        leading: const BackButton(),
        backgroundColor: Colors.transparent,
      ),
      body: _BodyContent(_serieId),
    );
  }
}

class _BodyContent extends ConsumerWidget {
  const _BodyContent(this._serieId);

  final int _serieId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final serieAsync = ref.watch(serieProvider(_serieId));
    return serieAsync.when(
      data: (serieDetails) {
        return _DataContent(_serieId, serieDetails);
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
    );
  }
}

class _SeasonDropDown extends ConsumerWidget {
  const _SeasonDropDown(this._serieId, this._seasons);

  final int _serieId;
  final List<Season> _seasons;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DropdownMenu(
      label: const Text('Season'),
      initialSelection: _seasons.isNotEmpty ? _seasons[0] : null,
      dropdownMenuEntries: _seasons.map((season) {
        return DropdownMenuEntry(
          value: season,
          label: '${season.seasonNumber} - ${season.name}',
        );
      }).toList(),
      onSelected: (selected) {
        ref.read(seasonProvider(_serieId).notifier).state = selected;
      },
    );
  }
}

class _DataContent extends StatelessWidget {
  const _DataContent(this._serieId, this._serie);

  final int _serieId;
  final SerieDetails _serie;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: _serie.info.backdropPath.isNotEmpty
          ? BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(_serie.info.backdropPath[0]),
                fit: BoxFit.cover,
              ),
            )
          : null,
      child: Container(
          decoration: const BoxDecoration(
            color: Color.fromARGB(142, 0, 0, 0),
          ),
          child: Row(
            children: [
              //SizedBox(child: _Info(_serie), height: 300.0, width: 300.0),
              //Container(child: _SeasonList(_serieId, _serie)),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: _Info(_serie),
                ),
              ),
              Column(
                children: [
                  SizedBox.fromSize(size: const Size(350.0, 150.0)),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(142, 0, 0, 0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      width: 400.0,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: _SeasonList(_serieId, _serie),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          )),
    );
  }
}

class _Info extends StatelessWidget {
  const _Info(this._serie);

  final SerieDetails _serie;

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: const TextStyle(color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Spacer(),
          Text(
            _serie.info.name,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 10.0),
          Text(_serie.info.plot),
          const SizedBox(height: 10.0),
          Text('Genres: ${_serie.info.genre}'),
          const SizedBox(height: 10.0),
          Text('Director: ${_serie.info.director}'),
          const SizedBox(height: 10.0),
          Text('Cast: ${_serie.info.cast}'),
          const SizedBox(height: 10.0),
          Row(
            children: [
              const Text('Rating: '),
              ...List.generate(5, (index) {
                return Icon(
                  Icons.star_rate,
                  color: index <= (_serie.info.rating5Based - 1)
                      ? Colors.orange
                      : Colors.grey,
                );
              }),
            ],
          ),
          const SizedBox(height: 10.0),
          Text('Year: ${_serie.info.year ?? ''}'),
        ],
      ),
    );
  }
}

class _SeasonList extends StatelessWidget {
  const _SeasonList(this._serieId, this._serie);

  final int _serieId;
  final SerieDetails _serie;

  List<Season> get _seasons => _serie.seasons
      .where(
        (s) => _serie.episodes.containsKey(
          s.seasonNumber.toString(),
        ),
      )
      .toList();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _SeasonDropDown(_serieId, _seasons),
        Flexible(
          child: Consumer(builder: (context, ref, child) {
            final season = ref.watch(seasonProvider(_serieId)) ?? _seasons[0];
            final episodes =
                _serie.episodes[(season.seasonNumber).toString()] ?? [];
            return ListView.builder(
              shrinkWrap: true,
              itemCount: episodes.length,
              itemBuilder: (context, index) {
                return _buildEpisodeTile(context, episodes[index]);
              },
            );
          }),
        ),
      ],
    );
  }

  Widget _buildEpisodeTile(BuildContext context, Episode episode) {
    return EpisodeTile(
      episode,
      onTap: () => context.push(
        '/player/${StreamType.series.name}/${episode.id}',
      ),
    );
  }
}
