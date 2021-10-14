import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:core/domain/tv/entities/tv_detail.dart';
import 'package:core/domain/tv/repositories/tv_repository.dart';

class SaveWatchlist {
  final TvRepository repository;

  SaveWatchlist(this.repository);

  Future<Either<Failure, String>> execute(TvDetail movie) {
    return repository.saveWatchlist(movie);
  }
}
