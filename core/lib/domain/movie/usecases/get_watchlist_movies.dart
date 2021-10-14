import 'package:dartz/dartz.dart';
import 'package:core/domain/movie/entities/movie.dart';
import 'package:core/domain/movie/repositories/movie_repository.dart';
import 'package:core/core.dart';

class GetWatchlistMovies {
  final MovieRepository _repository;

  GetWatchlistMovies(this._repository);

  Future<Either<Failure, List<Movie>>> execute() {
    return _repository.getWatchlistMovies();
  }
}
