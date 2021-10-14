import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:core/domain/movie/entities/movie.dart';
import 'package:core/domain/movie/repositories/movie_repository.dart';

class SearchMovies {
  final MovieRepository repository;

  SearchMovies(this.repository);

  Future<Either<Failure, List<Movie>>> execute(String query) {
    return repository.searchMovies(query);
  }
}
