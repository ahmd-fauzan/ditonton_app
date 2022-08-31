import 'package:core/domain/entities/tv_entities/tv.dart';
import 'package:core/domain/entities/tv_entities/tv_detail.dart';
import 'package:equatable/equatable.dart';

class TVTable extends Equatable {
  final int id;
  final String? name;
  final String? posterPath;
  final String? overview;

  TVTable({
    required this.id,
    required this.name,
    required this.posterPath,
    required this.overview,
  });

  factory TVTable.fromEntity(TVDetail tv) => TVTable(
        id: tv.id,
        name: tv.name,
        posterPath: tv.posterPath,
        overview: tv.overview,
      );

  factory TVTable.fromMap(Map<String, dynamic> map) => TVTable(
        id: map['tv_id'],
        name: map['name'],
        posterPath: map['tv_posterPath'],
        overview: map['tv_overview'],
      );

  Map<String, dynamic> toJson() => {
        'tv_id': id,
        'name': name,
        'tv_posterPath': posterPath,
        'tv_overview': overview,
      };

  TV toEntity() => TV.watchlist(
        id: id,
        overview: overview,
        posterPath: posterPath,
        name: name,
      );

  @override
  List<Object?> get props => [id, name, posterPath, overview];
}
