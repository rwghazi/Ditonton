import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:core/domain/tv/entities/tv_detail.dart';
import 'package:core/domain/tv/repositories/tv_repository.dart';

class RemoveWatchlist {
  final TvRepository repository;

  RemoveWatchlist(this.repository);

  Future<Either<Failure, String>> execute(TvDetail movie) {
    return repository.removeWatchlist(movie);
  }
}
