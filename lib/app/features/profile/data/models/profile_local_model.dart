import 'package:hive_flutter/hive_flutter.dart';

import '../../../../config/networking/response_mapper.dart';
import '../../../../constants/hive_constant.dart';
import '../../domain/entities/profile_entity.dart';
import 'profile_remote_model.dart';

part 'profile_local_model.g.dart';

@HiveType(typeId: HiveEntityCode.profileData)
class ProfileLocalModel implements ResponseMapper<ProfileEntity> {
  @HiveField(0)
  int id;

  @HiveField(1)
  String email;

  @HiveField(2)
  String firstName;

  @HiveField(3)
  String lastName;

  @HiveField(4)
  String avatar;

  ProfileLocalModel({
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

  factory ProfileLocalModel.fromRemote(ProfileRemoteModel model) {
    return ProfileLocalModel(
      id: model.id,
      email: model.email,
      firstName: model.firstName,
      lastName: model.lastName,
      avatar: model.avatar,
    );
  }
}
