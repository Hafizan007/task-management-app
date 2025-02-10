import 'package:json_annotation/json_annotation.dart';

import '../../../../config/networking/response_mapper.dart';
import '../../domain/entities/profile_entity.dart';

part 'profile_remote_model.g.dart';

@JsonSerializable()
class ProfileRemoteModel implements ResponseMapper<ProfileEntity> {
  int id;
  String email;

  @JsonKey(name: 'first_name')
  String firstName;

  @JsonKey(name: 'last_name')
  String lastName;
  String avatar;

  ProfileRemoteModel({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.avatar,
  });

  @override
  ProfileEntity toDomain() {
    return ProfileEntity(
      id: id,
      email: email,
      firstName: firstName,
      lastName: lastName,
      avatar: avatar,
    );
  }

  factory ProfileRemoteModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileRemoteModelFromJson(json['data']);

  Map<String, dynamic> toJson() => _$ProfileRemoteModelToJson(this);
}
