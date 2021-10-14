import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:core/domain/tv/entities/tv.dart';
import 'package:core/domain/tv/repositories/tv_repository.dart';

class GetOnAirTv {
  final TvRepository repository;

  GetOnAirTv(this.repository);

  Future<Either<Failure, List<Tv>>> execute() {
    return repository.getOnAirTv();
  }
}
