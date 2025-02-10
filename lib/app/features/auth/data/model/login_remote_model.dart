import 'package:json_annotation/json_annotation.dart';

import '../../../../config/networking/response_mapper.dart';
import '../../domain/entities/login_entity.dart';

part 'login_remote_model.g.dart';

@JsonSerializable()
class LoginRemoteModel implements ResponseMapper<LoginEntity> {
  final String token;

  LoginRemoteModel({
    required this.token,
  });

  factory LoginRemoteModel.fromJson(Map<String, dynamic> json) =>
      _$LoginRemoteModelFromJson(json);

  Map<String, dynamic> toJson() => _$LoginRemoteModelToJson(this);

  @override
  LoginEntity toDomain() {
    return LoginEntity(
      token: token,
    );
  }
}
