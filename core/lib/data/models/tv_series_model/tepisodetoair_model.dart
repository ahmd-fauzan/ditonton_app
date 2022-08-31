import 'package:core/domain/entities/tv_entities/tepisodetoair.dart';
import 'package:equatable/equatable.dart';

class TEpisodeToAirModel extends Equatable {
  TEpisodeToAirModel({
    required this.airDate,
    required this.episodeNumber,
    required this.id,
    required this.name,
    required this.overview,
    required this.productionCode,
    required this.runtime,
    required this.seasonNumber,
    required this.showId,
    required this.stillPath,
    required this.voteAverage,
    required this.voteCount,
  });

  String airDate;
  int episodeNumber;
  int id;
  String name;
  String overview;
  String productionCode;
  int? runtime;
  int seasonNumber;
  int showId;
  String? stillPath;
  double voteAverage;
  int voteCount;

  factory TEpisodeToAirModel.fromJson(Map<String, dynamic> json) =>
      TEpisodeToAirModel(
        airDate: json["air_date"],
        episodeNumber: json["episode_number"],
        id: json["id"],
        name: json["name"],
        overview: json["overview"],
        productionCode: json["production_code"],
        runtime: json["runtime"] == null ? null : json["runtime"],
        seasonNumber: json["season_number"],
        showId: json["show_id"],
        stillPath: json["still_path"] == null ? '' : json["still_path"],
        voteAverage: json["vote_average"].toDouble(),
        voteCount: json["vote_count"],
      );

  Map<String, dynamic> toJson() => {
        "air_date": airDate,
        "episode_number": episodeNumber,
        "id": id,
        "name": name,
        "overview": overview,
        "production_code": productionCode,
        "runtime": runtime ?? -1,
        "season_number": seasonNumber,
        "show_id": showId,
        "still_path": stillPath ?? '',
        "vote_average": voteAverage,
        "vote_count": voteCount,
      };

  TEpisodeToAir toEntity() {
    return TEpisodeToAir(
      airDate: this.airDate,
      episodeNumber: this.episodeNumber,
      id: this.id,
      name: this.name,
      overview: this.overview,
      productionCode: this.productionCode,
      runtime: this.runtime ?? -1,
      seasonNumber: this.seasonNumber,
      showId: this.showId,
      stillPath: this.stillPath ?? '',
      voteAverage: this.voteAverage,
      voteCount: this.voteCount,
    );
  }

  @override
  List<Object?> get props => [
        airDate,
        episodeNumber,
        id,
        name,
        overview,
        productionCode,
        runtime,
        seasonNumber,
        showId,
        stillPath,
        voteAverage,
        voteAverage,
      ];
}
