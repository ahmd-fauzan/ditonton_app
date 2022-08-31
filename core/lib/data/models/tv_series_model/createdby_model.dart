import 'package:core/domain/entities/tv_entities/createdby.dart';
import 'package:equatable/equatable.dart';

class CreatedByModel extends Equatable {
  CreatedByModel({
    required this.id,
    required this.creditId,
    required this.name,
    required this.gender,
    required this.profilePath,
  });

  int id;
  String creditId;
  String name;
  int gender;
  String profilePath;

  factory CreatedByModel.fromJson(Map<String, dynamic> json) => CreatedByModel(
        id: json["id"],
        creditId: json["credit_id"],
        name: json["name"],
        gender: json["gender"],
        profilePath: json["profile_path"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "credit_id": creditId,
        "name": name,
        "gender": gender,
        "profile_path": profilePath,
      };

  CreatedBy toEntity() {
    return CreatedBy(
      id: this.id,
      creditId: this.creditId,
      name: this.name,
      gender: this.gender,
      profilePath: this.profilePath,
    );
  }

  @override
  List<Object?> get props => [id, creditId, name, gender, profilePath];
}
