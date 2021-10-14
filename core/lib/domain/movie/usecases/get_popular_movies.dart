import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:core/domain/movie/entities/movie.dart';
import 'package:core/domain/movie/repositories/movie_repository.dart';

class GetPopularMovies {
  final MovieRepository repository;

  GetPopularMovies(this.repository);

  Future<Either<Failure, List<Movie>>> execute() {
    return repository.getPopularMovies();
  }
}
