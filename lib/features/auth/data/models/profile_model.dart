import 'package:capestone_test/core/common/entities/profile_entity.dart';

class ProfileModel extends ProfileEntity {
  ProfileModel({
    required super.id,
    required super.name,
    required super.email,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    // must handle null cases... what a pain.. took me 30 minutes to figure out
    return ProfileModel(
      id: json['id'] ?? 'null id',
      name: json['name'] ?? 'null name',
      email: json['email'] ?? 'null email',
    );
  }

  ProfileModel copyWith({
    String? id,
    String? name,
    String? email,
  }) {
    return ProfileModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
    );
  }
}
