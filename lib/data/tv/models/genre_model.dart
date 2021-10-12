import 'package:ditonton/domain/tv/entities/genre.dart';
import 'package:equatable/equatable.dart';

class TvGenreModel extends Equatable {
  TvGenreModel({
    required this.id,
    required this.name,
  });

  final int id;
  final String name;

  factory TvGenreModel.fromJson(Map<String, dynamic> json) => TvGenreModel(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };

  TvGenre toEntity() {
    return TvGenre(id: this.id, name: this.name);
  }

  @override
  List<Object?> get props => [id, name];
}
