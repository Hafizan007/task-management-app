import '../../domain/params/login_by_email_params.dart';

class LoginRequestModel {
  final String email;
  final String password;

  LoginRequestModel({
    required this.email,
    required this.password,
  });

  factory LoginRequestModel.fromDomain(LoginByEmailParams params) {
    return LoginRequestModel(
      email: params.email,
      password: params.password,
    );
  }

  Map<String, dynamic> toJson() => {
        'email': email,
        'password': password,
      };
}
