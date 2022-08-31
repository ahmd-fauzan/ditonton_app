import 'package:core/domain/entities/tv_entities/network.dart';
import 'package:equatable/equatable.dart';

class NetworkModel extends Equatable {
  NetworkModel({
    required this.id,
    required this.name,
    required this.logoPath,
    required this.originCountry,
  });

  int id;
  String name;
  String? logoPath;
  String originCountry;

  factory NetworkModel.fromJson(Map<String, dynamic> json) => NetworkModel(
        id: json["id"],
        name: json["name"],
        logoPath: json["logo_path"] == null ? '' : json["logo_path"],
        originCountry: json["origin_country"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "logo_path": logoPath == null ? '' : logoPath,
        "origin_country": originCountry,
      };

  Network toEntity() {
    return Network(
      id: this.id,
      name: this.name,
      logoPath: this.logoPath!,
      originCountry: this.originCountry,
    );
  }

  @override
  List<Object?> get props => [id, name, logoPath, originCountry];
}
