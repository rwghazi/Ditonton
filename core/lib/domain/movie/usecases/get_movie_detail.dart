import 'package:dartz/dartz.dart';
import 'package:core/domain/movie/entities/movie_detail.dart';
import 'package:core/domain/movie/repositories/movie_repository.dart';
import 'package:core/core.dart';

class GetMovieDetail {
  final MovieRepository repository;

  GetMovieDetail(this.repository);

  Future<Either<Failure, MovieDetail>> execute(int id) {
    return repository.getMovieDetail(id);
  }
}
