import 'package:core/data/movie/datasources/db/movie_database_helper.dart';
import 'package:core/data/movie/datasources/movie_local_data_source.dart';
import 'package:core/data/movie/datasources/movie_remote_data_source.dart';
import 'package:core/data/movie/repositories/movie_repository_impl.dart';
import 'package:core/domain/movie/repositories/movie_repository.dart';
import 'package:core/domain/movie/usecases/get_movie_detail.dart';
import 'package:core/domain/movie/usecases/get_movie_recommendations.dart';
import 'package:core/domain/movie/usecases/get_now_playing_movies.dart';
import 'package:core/domain/movie/usecases/get_popular_movies.dart';
import 'package:core/domain/movie/usecases/get_top_rated_movies.dart';
import 'package:core/domain/movie/usecases/get_watchlist_movies.dart';
import 'package:core/domain/movie/usecases/get_watchlist_status.dart';
import 'package:core/domain/movie/usecases/remove_watchlist.dart' as rwMovie;
import 'package:core/domain/movie/usecases/save_watchlist.dart' as swMovie;
import 'package:core/domain/tv/usecases/get_on_air_tv.dart';
import 'package:core/domain/tv/usecases/get_popular_tv.dart';
import 'package:core/domain/tv/usecases/get_watchlist_tv.dart';
import 'package:core/presentation/provider/movie/movie_detail_notifier.dart';
import 'package:core/presentation/provider/movie/movie_list_notifier.dart';
import 'package:core/presentation/provider/movie/popular_movies_notifier.dart';
import 'package:core/presentation/provider/movie/top_rated_movies_notifier.dart';
import 'package:core/presentation/provider/movie/watchlist_movie_notifier.dart';
import 'package:core/presentation/provider/tv/on_air_tv_notifier.dart';
import 'package:core/presentation/provider/tv/popular_tv_notifier.dart';
import 'package:core/presentation/provider/tv/top_rated_tv_notifier.dart';
import 'package:core/presentation/provider/tv/tv_detail_notifier.dart';
import 'package:core/presentation/provider/tv/tv_list_notifier.dart';
import 'package:core/presentation/provider/tv/watchlist_tv_notifier.dart';
import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';

import 'package:core/data/tv/datasources/db/tv_database_helper.dart';
import 'package:core/data/tv/datasources/tv_local_data_source.dart';
import 'package:core/data/tv/datasources/tv_remote_data_source.dart';
import 'package:core/data/tv/repositories/tv_repository_impl.dart';
import 'package:core/domain/tv/repositories/tv_repository.dart';
import 'package:core/domain/tv/usecases/get_top_rated_tv.dart';
import 'package:core/domain/tv/usecases/get_tv_detail.dart';
import 'package:core/domain/tv/usecases/get_tv_recommendation.dart';
import 'package:core/domain/tv/usecases/get_watchlist_status.dart';
import 'package:core/domain/tv/usecases/remove_watchlist.dart' as rwTv;
import 'package:core/domain/tv/usecases/save_watchlist.dart' as swTv;
import 'package:search/bloc/movie/search_movie_bloc.dart';
import 'package:search/bloc/tv/search_tv_bloc.dart';
import 'package:search/search.dart';

final locator = GetIt.instance;

void init() {
  // provider
  locator.registerFactory(
    () => MovieListNotifier(
      getNowPlayingMovies: locator(),
      getPopularMovies: locator(),
      getTopRatedMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => TvListNotifier(
      getOnAirTv: locator(),
      getPopularTv: locator(),
      getTopRatedTv: locator(),
    ),
  );
  locator.registerFactory(
    () => MovieDetailNotifier(
      getMovieDetail: locator(),
      getMovieRecommendations: locator(),
      getWatchListStatus: locator(),
      saveWatchlist: locator(),
      removeWatchlist: locator(),
    ),
  );
  locator.registerFactory(
    () => TvDetailNotifier(
      getTvDetail: locator(),
      getTvRecommendations: locator(),
      getWatchListStatus: locator(),
      saveWatchlist: locator(),
      removeWatchlist: locator(),
    ),
  );
  locator.registerFactory(
   () => SearchMovieBloc(
      locator(),
    ),
  );
  locator.registerFactory(
   () => SearchTvBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => PopularMoviesNotifier(
      locator(),
    ),
  );
  locator.registerFactory(
    () => PopularTvNotifier(
      locator(),
    ),
  );
  locator.registerFactory(
    () => OnAirTvNotifier(
      getOnAirTv: locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedMoviesNotifier(
      getTopRatedMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedTvNotifier(
      getTopRatedTv: locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistMovieNotifier(
      getWatchlistMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistTvNotifier(
      getWatchlistTv: locator(),
    ),
  );

  // use case
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => swMovie.SaveWatchlist(locator()));
  locator.registerLazySingleton(() => rwMovie.RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));

  locator.registerLazySingleton(() => GetOnAirTv(locator()));
  locator.registerLazySingleton(() => GetPopularTv(locator()));
  locator.registerLazySingleton(() => GetTopRatedTv(locator()));
  locator.registerLazySingleton(() => GetTvDetail(locator()));
  locator.registerLazySingleton(() => GetTvRecommendations(locator()));
  locator.registerLazySingleton(() => SearchTv(locator()));
  locator.registerLazySingleton(() => GetWatchListTvStatus(locator()));
  locator.registerLazySingleton(() => swTv.SaveWatchlist(locator()));
  locator.registerLazySingleton(() => rwTv.RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistTv(locator()));

  // repository
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );
   locator.registerLazySingleton<TvRepository>(
    () => TvRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  // data sources
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(databaseHelper: locator()));
  locator.registerLazySingleton<TvRemoteDataSource>(
      () => TvRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<TvLocalDataSource>(
      () => TvLocalDataSourceImpl(databaseHelper: locator()));

  // helper
  locator.registerLazySingleton<MovieDatabaseHelper>(() => MovieDatabaseHelper());
  locator.registerLazySingleton<TvDatabaseHelper>(() => TvDatabaseHelper());

  // external
  locator.registerLazySingleton(() => http.Client());
}
