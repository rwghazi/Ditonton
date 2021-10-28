import 'package:cached_network_image/cached_network_image.dart';
import 'package:tv/presentation/bloc/recommendations_bloc.dart';
import 'package:tv/presentation/bloc/watchlist_tv_bloc.dart';
import 'package:tv/tv.dart';
import 'package:tv/domain/entities/genre.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/entities/tv_detail.dart';
import 'package:tv/presentation/bloc/tv_detail_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class TvDetailPage extends StatefulWidget {
  static const ROUTE_NAME = '/detail-tv';

  final int id;
  TvDetailPage({required this.id});

  @override
  _TvDetailPageState createState() => _TvDetailPageState();
}

class _TvDetailPageState extends State<TvDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      BlocProvider.of<TvDetailBloc>(context, listen: false)
        ..add(FetchTvDetail(widget.id));
      BlocProvider.of<WatchlistTvBloc>(context, listen: false)
        ..add(LoadWatchListStatus(widget.id));
      BlocProvider.of<TvRecommendationBloc>(context, listen: false)
        ..add(FetchTvRecomendation(widget.id));
    });
  }

  @override
  Widget build(BuildContext context) {
    TvDetailState tvDetailState = context.watch<TvDetailBloc>().state;
    TvRecomendationState tvRecomendationState =
        context.watch<TvRecommendationBloc>().state;
    bool isAddedToWatchList = context.select<WatchlistTvBloc, bool>(
        (watchlistBloc) => (watchlistBloc.state is WatchlistTvStatus)
            ? (watchlistBloc.state as WatchlistTvStatus).result
            : false);
    return Scaffold(
        body: tvDetailState is TvDetailLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : tvDetailState is TvDetailError
                ? Center(
                    child: Text(tvDetailState.message),
                  )
                : (tvDetailState is TvDetailLoaded)
                    ? SafeArea(
                        child: DetailContent(
                          tvDetailState.result,
                          isAddedToWatchList,
                          tvRecomendationState is TvRecomendationLoaded
                              ? tvRecomendationState.tvs
                              : List.empty(),
                        ),
                      )
                    : const Center(
                        child: Text("Nothing to see here"),
                      ));
  }
}

class DetailContent extends StatelessWidget {
  final TvDetail tv;
  final bool isAddedWatchlist;
  final List<Tv> tvRecommendations;
  
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  DetailContent(this.tv, this.isAddedWatchlist, this.tvRecommendations);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: 'https://image.tmdb.org/t/p/w500${tv.posterPath}',
          width: screenWidth,
          placeholder: (context, url) => Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: kRichBlack,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 16,
                  right: 16,
                ),
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              tv.name,
                              style: kHeading5,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                if (!isAddedWatchlist) {
                                  BlocProvider.of<WatchlistTvBloc>(context)
                                    ..add(AddToWatchList(tv));
                                } else {
                                  BlocProvider.of<WatchlistTvBloc>(context)
                                    ..add(RemoveWatchList(tv));
                                }

                                final message = context
                                    .select<WatchlistTvBloc, String>((bloc) =>
                                        (bloc.state is WatchlistTvStatus)
                                            ? (bloc.state as WatchlistTvStatus)
                                                        .result ==
                                                    false
                                                ? watchlistAddSuccessMessage
                                                : watchlistRemoveSuccessMessage
                                            : '');

                                if (message == watchlistAddSuccessMessage ||
                                    message == watchlistRemoveSuccessMessage) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text(message),
                                    duration: Duration(seconds: 1),
                                  ));
                                } else {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          content: Text(message),
                                        );
                                      });
                                }
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  isAddedWatchlist
                                      ? Icon(Icons.check)
                                      : Icon(Icons.add),
                                  Text('Watchlist'),
                                ],
                              ),
                            ),
                            Text(
                              _showGenres(tv.genres),
                            ),
                            Row(
                              children: [
                                Text(
                                  "Season " +
                                      (tv.numberOfSeasons).toString() +
                                      "   |   ",
                                ),
                                Text(
                                  (tv.numberOfEpisodes).toString() +
                                      " episodes",
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: tv.voteAverage / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${tv.voteAverage}')
                              ],
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(
                              tv.overview,
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Recommendations',
                              style: kHeading6,
                            ),
                            BlocBuilder<TvRecommendationBloc,
                                    TvRecomendationState>(
                                builder: (context, state) {
                              if (state is TvRecomendationLoading) {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else if (state is TvRecomendationLoaded) {
                                return buildRecommendationCard(state.tvs);
                              } else {
                                return Text("");
                              }
                            })
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        color: Colors.white,
                        height: 4,
                        width: 48,
                      ),
                    ),
                  ],
                ),
              );
            },
            // initialChildSize: 0.5,
            minChildSize: 0.25,
            // maxChildSize: 1.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: kRichBlack,
            foregroundColor: Colors.white,
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        )
      ],
    );
  }

  String _showGenres(List<TvGenre> genres) {
    String result = '';
    for (var genre in genres) {
      result += genre.name + ', ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }

  Widget buildRecommendationCard(List<Tv> recommendations) {
    return Container(
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final tv = recommendations[index];
          return Padding(
            padding: const EdgeInsets.all(4.0),
            child: InkWell(
              onTap: () {
                Navigator.pushReplacementNamed(
                  context,
                  TvDetailPage.ROUTE_NAME,
                  arguments: tv.id,
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(
                  Radius.circular(8),
                ),
                child: CachedNetworkImage(
                  imageUrl: 'https://image.tmdb.org/t/p/w500${tv.posterPath}',
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: recommendations.length,
      ),
    );
  }
}
