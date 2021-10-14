import 'package:dartz/dartz.dart';
import 'package:core/domain/tv/entities/tv.dart';
import 'package:core/domain/tv/repositories/tv_repository.dart';
import 'package:core/core.dart';

class GetWatchlistTv {
  final TvRepository _repository;

  GetWatchlistTv(this._repository);

  Future<Either<Failure, List<Tv>>> execute() {
    return _repository.getWatchlistTv();
  }
}
